# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

RESOURCE_DIR        = ".sources"
DC_SRC              = "HTRC-DataCapsules"
DC_REPO             = "git@github.com:htrc/HTRC-DataCapsules.git"
LDAP_SRC            = "openLDAP"
LDAP_REPO           = "git@github.com:htrc/openLDAP.git"
CASS_SRC            = "HTRC-DevEnvCassandra"
CASS_REPO           = "git@github.com:htrc/HTRC-DevEnvCassandra.git"
EMAIL_SRC           = "Email-Validator"
EMAIL_REPO          = "git@github.com:htrc/Email-Validator.git"
ANALYTICS_SRC       = "Analytics-Gateway"
ANALYTICS_REPO      = "git@github.com:htrc/Analytics-Gateway.git"
DEVOPS_SRC          = "HTRC-DevOps"
DEVOPS_REPO         = "git@github.com:htrc/HTRC-DevOps.git"
DOWNLOADS_DIR       = ".devenv_downloads"
WSO2IS_ZIP          = "wso2is-5.3.0.zip"
USERMANAGER_ZIP     = "htrc-user-manager-2.1.0.zip"
HTRC_FILES          = "https://analytics.hathitrust.org/files"
PROVISION_CASSANDRA = false

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.box_check_update = false
  config.vm.network "private_network", type: "dhcp"
  config.vm.hostname = "idp.vagrant.vm"

  config.vm.synced_folder RESOURCE_DIR, "/devenv_sources"
  config.vm.synced_folder DOWNLOADS_DIR, "/devenv_downloads"
  config.vm.synced_folder "configurations", "/devenv_configurations"
  config.vm.synced_folder "certs", "/devenv_certs"
  config.vm.synced_folder "data" , "/devenv_data"

  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      if vm.id
        `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
      end
    end

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.hostmanager.aliases = ["ag.vagrant.vm","idp.vagrant.vm", "dc.vagrant.vm", "agent.vagrant.vm", "registry.vagrant.vm", "rights.vagrant.vm", "email.vagrant.vm", "dc-tls.vagrant.vm", "agent-tls.vagrant.vm", "registry-tls.vagrant.vm", "rights-tls.vagrant.vm", "email-tls.vagrant.vm" ]
  else
    puts 'vagrant-hostmanager plugin required. To install simply run `vagrant plugin install vagrant-hostmanager`'
    abort
  end

  config.trigger.before :up do
    # Create a directory in home directory to hold downloads
    devenv_downloads_dir = File.join(File.dirname(__FILE__), DOWNLOADS_DIR)
    unless File.exists?(devenv_downloads_dir)
      FileUtils.mkdir_p(devenv_downloads_dir)
    end

    # Download WSO2 IS ZIP
    wso2is_zip = File.join(devenv_downloads_dir, WSO2IS_ZIP)
    unless File.exists?(wso2is_zip)
      info "Downloading #{WSO2IS_ZIP}..."
      system "bash", "-c", "curl -L -o #{wso2is_zip} #{HTRC_FILES}/#{WSO2IS_ZIP}"
    end

    # Download User Manager ZIP
    usermanager_zip = File.join(devenv_downloads_dir, USERMANAGER_ZIP)
    unless File.exists?(usermanager_zip)
      info "Downloading #{USERMANAGER_ZIP}..."
      system "bash", "-c", "curl -L -o #{usermanager_zip} #{HTRC_FILES}/#{USERMANAGER_ZIP}"
    end

    # Create a directory to hold HTRC git repos
    resources_dir = File.join(File.dirname(__FILE__), RESOURCE_DIR)
    unless File.exists?(resources_dir)
      FileUtils.mkdir_p(resources_dir)
    else
      info "#{RESOURCE_DIR} directory is already there."
    end

    clone_update_repo(resources_dir, DC_REPO, DC_SRC)
    clone_update_repo(resources_dir, EMAIL_REPO, EMAIL_SRC)
    clone_update_repo(resources_dir, LDAP_REPO, LDAP_SRC)
    clone_update_repo(resources_dir, CASS_REPO, CASS_SRC)
    clone_update_repo(resources_dir, ANALYTICS_REPO, ANALYTICS_SRC)
    clone_update_repo(resources_dir, DEVOPS_REPO, DEVOPS_SRC)
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

    confirm = nil
    until ["Y", "y", "N", "n"].include?(confirm)
      confirm = ask "Would you really like to delete #{DOWNLOADS_DIR}? (Y/N) "
    end
    unless confirm.upcase == "N"
        info "Deleting #{DOWNLOADS_DIR} directory..."
        FileUtils.rm_rf(DOWNLOADS_DIR)
    end
  end

  # VM configurations
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "3096"
    vb.cpus = 2
  end

   config.vm.provision "shell", path: "scripts/install-prerequisites.sh"
   config.vm.provision "shell", path: "scripts/setup-certs.sh"
   config.vm.provision "shell", path: "scripts/mysql.sh"
   config.vm.provision "shell", path: "scripts/dcapi.sh"
   config.vm.provision "shell", path: "scripts/email-validator.sh"
   config.vm.provision "shell", path: "scripts/wso2is.sh"
   config.vm.provision "shell", path: "scripts/nginx.sh"
   config.vm.provision "shell", path: "scripts/agent.sh"
   config.vm.provision "shell", path: "scripts/rights.sh"
   config.vm.provision "shell", path: "scripts/analytics.sh"
   config.vm.provision "shell", path: "scripts/usermanager.sh"
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
