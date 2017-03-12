# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

RESOURCE_DIR = ".sources"
DC_SRC = "HTRC-DataCapsules"
DC_GIT_REPO = "https://github.com/htrc/HTRC-DataCapsules.git"

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.box_check_update = false
  config.vm.network "private_network", ip: "192.168.100.100"

  config.vm.synced_folder RESOURCE_DIR, "/devenv_sources"
  config.vm.synced_folder "configurations", "/devenv_configurations"
  config.vm.synced_folder "certs", "/devenv_certs"

  config.trigger.before :up do
    # Create a directory to hold HTRC git repos
    resources_dir = File.join(File.dirname(__FILE__), RESOURCE_DIR)
    unless File.exists?(resources_dir)
      FileUtils.mkdir_p(resources_dir)
    else
      info ".resources directory is already there."
    end

    # Cloning/updating HTRC-DataCapsules source
    dc_src = File.join(resources_dir, DC_SRC)
    unless File.exists?(dc_src)
      info "Cloning #{DC_SRC}..."
      system "bash", "-c", "pwd"
      system "bash", "-c", "cd #{RESOURCE_DIR} && git clone #{DC_GIT_REPO}"
      if $?.exitstatus > 0
        error "Failed to clone data capsules source!"
        exit 1
      end
    else
        system "bash", "-c", "cd #{RESOURCE_DIR}/#{DC_SRC} && git pull"
        if $?.exitstatus > 0
          error "Failed to pull updates from data capsules source repo!"
          exit 1
        end
    end
  end

  config.trigger.after :destroy do
    confirm = nil
    until ["Y", "y", "N", "n"].include?(confirm)
      confirm = ask "Would you really like to delete #{RESOURCE_DIR}? (Y/N) "
    end
    unless confirm.upcase == "N"
        info "Deleting #{RESOURCE_DIR} directory..."
        FileUtils.rm_rf(RESOURCE_DIR)
    end
  end

  # VM configurations
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
  end

   config.vm.provision "shell", path: "scripts/install-prerequisites.sh"
end