# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

settings = YAML.load_file 'settings.yml'

Vagrant.configure(2) do |config|
  config.vm.box = "box-cutter/ubuntu1404-docker"

  config.vm.box_check_update = true

  settings["ports"].each do |p|
    config.vm.network "forwarded_port", guest: p["guest"], host: p["host"]
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.10.10"
  config.vm.hostname = "htrc-devenv"

  settings["synced"].each do |s|
    config.vm.synced_folder s["host"], s["guest"]
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "HTRC Development Environment"
    vb.memory = "4096"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end

  # Setting up environment variables required by docker-compose.
  config.vm.provision :shell, inline: "echo 'export HTRC_CONF=/vagrant/HTRC-Configuration' >> /home/vagrant/.bashrc "
  config.vm.provision :shell, inline: "echo 'export PORTAL_VERSION=3.2.0-SNAPSHOT' >> /home/vagrant/.bashrc "
  config.vm.provision :shell, inline: "echo 'export IDP_VERSION=1.1.1-SNAPSHOT' >> /home/vagrant/.bashrc "

end
