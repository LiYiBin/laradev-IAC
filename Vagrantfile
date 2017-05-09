# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

# get env
current_dir = File.dirname(File.expand_path(__FILE__))
env_file = YAML.load_file("#{current_dir}/.env.yml")
env = env_file["vm"]

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.memory = env["memory"]
  end

  config.vm.define "laradev" do |app|
    app.vm.network :private_network, ip: env["ip"]

    app.vm.synced_folder ".", "/home/vagrant/shared"
    app.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
  end
end
