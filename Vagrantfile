# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

RESOURCE_DIR = ".sources"
DC_SRC = "HTRC-DataCapsules"
DC_GIT_REPO = "https://github.com/htrc/HTRC-DataCapsules.git"
LDAP_SRC      = "openLDAP"
LDAP_REPO     = "https://github.com/htrc/openLDAP.git"
CASS_SRC      = "HTRC-DevEnvCassandra"
CASS_REPO     = "https://jimlambrt@github.com/htrc/HTRC-DevEnvCassandra.git"
DOWNLOADS_DIR = ".devenv_downloads"
WSO2IS_ZIP = "wso2is-5.3.0.zip"
HTRC_FILES = "https://analytics.hathitrust.org/files"
PRIVATE_IP = "192.168.100.100"
PROVISION_CASSANDRA = false

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.box_check_update = false
  config.vm.network "private_network", ip: PRIVATE_IP
  config.vm.hostname = "devenv"
  config.hostsupdater.aliases = ["devenv-is", "devenv-dc", "devenv-agent", "devenv-regx", "devenv-rights", "devenv-auth", "devenv-notls-is", "devenv-notls-dc", "devenv-notls-agent", "devenv-notls-regx", "devenv-notls-rights", "devenv-openldap" ]

  config.vm.synced_folder RESOURCE_DIR, "/devenv_sources"
  config.vm.synced_folder "configurations", "/devenv_configurations"
  config.vm.synced_folder "certs", "/devenv_certs"
  config.vm.synced_folder "data" , "/devenv_data"
  config.vm.synced_folder "~/#{DOWNLOADS_DIR}", "/devenv_downloads"

  config.trigger.before :up do
    # Create a directory in home directory to hold downloads
    devenv_downloads_dir = File.join(File.expand_path('~'), DOWNLOADS_DIR)
    unless File.exists?(devenv_downloads_dir)
      FileUtils.mkdir_p(devenv_downloads_dir)
    end

    # Download WSO2 IS ZIP
    wso2is_zip = File.join(devenv_downloads_dir, WSO2IS_ZIP)
    unless File.exists?(wso2is_zip)
      info "Downloading #{WSO2IS_ZIP}..."
      system "bash", "-c", "wget -O #{wso2is_zip} #{HTRC_FILES}/#{WSO2IS_ZIP}"
    end

    # Create a directory to hold HTRC git repos
    resources_dir = File.join(File.dirname(__FILE__), RESOURCE_DIR)
    unless File.exists?(resources_dir)
      FileUtils.mkdir_p(resources_dir)
    else
      info "#{RESOURCE_DIR} directory is already there."
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

    clone_update_repo(resources_dir, LDAP_REPO, LDAP_SRC)
    clone_update_repo(resources_dir, CASS_REPO, CASS_SRC)
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
   config.vm.provision "shell", path: "scripts/dcapi.sh"
   config.vm.provision "shell", path: "scripts/wso2is.sh"
   config.vm.provision "shell", path: "scripts/nginx.sh"
   config.vm.provision "shell", path: "scripts/agent.sh"
   config.vm.provision "shell", path: "scripts/rights.sh"
   config.vm.provision "shell", inline: "timedatectl set-timezone America/Indiana/Indianapolis"
   config.vm.provision "shell", inline: "timedatectl set-ntp yes"
   provision_ansible(config)
   provision_ldap(config)
   config.vm.provision "shell", path: "scripts/start-services.sh"
   
   if PROVISION_CASSANDRA
     provision_cassandra(config)
   end
end

def provision_ansible(config)
   config.vm.provision "shell", inline: <<-SHELL
      sudo yum -y install openssl-devel
      sudo yum -y install python-setuptools
      sudo yum -y install python-devel
      sudo easy_install pip
      sudo pip install ansible
   SHELL
end

def provision_ldap(config)
   config.vm.provision "shell", inline: <<-SHELL
      ansible-playbook /devenv_sources/openLDAP/vagrant/scripts/prereqs.yml
      ansible-playbook /devenv_sources/openLDAP/vagrant/scripts/ldap.yml
    SHELL
end

def provision_cassandra(config)
    config.vm.provision "shell", path: "scripts/download-pairtree.sh"
    config.vm.provision "shell", inline: <<-SHELL
      ansible-playbook /devenv_sources/#{CASS_SRC}/scripts/cassandra.yml
  SHELL
end

def clone_update_repo(resources_dir, url_repo, source_name)
  unless File.exists?(resources_dir)
    FileUtils.mkdir_p(resources_dir)
  else
    print "#{resources_dir} directory is already there.\n"
  end

  src_dir = File.join(resources_dir, source_name)
  unless File.exists?(src_dir)
    print "Cloning #{source_name}..."
    system "bash", "-c", "pwd"
    git_cmd = <<-SHELL
      git clone #{url_repo};
    SHELL
    system "bash", "-c", "cd #{resources_dir} && #{git_cmd}"

    if $?.exitstatus > 0
        print "Failed to clone: "  + source_name
        exit 1
    end
  else
    system "bash", "-c", "cd #{src_dir} && git pull"
    if $?.exitstatus > 0
      print "Failed to pull updates from source repo: " + url_repo
      exit 1
    end
  end
end
