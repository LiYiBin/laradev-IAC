# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

# get env
current_dir = File.dirname(File.expand_path(__FILE__))
env = YAML.load_file("#{current_dir}/.env.yml")

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
    virtualbox.memory = env["vm"]["memory"]
  end

  config.vm.define "dev" do |app|
    app.vm.network :private_network, ip: env["vm"]["ip"]

    app.vm.synced_folder ".", env["docker_compose_path"]
    # app.vm.synced_folder "~/shared/mysql", "/home/vagrant/shared/mysql", id: "mysql",
    #   owner: 999, group: 999, # owner: "mysql", group: "mysql",
    #   mount_options: ["dmode=775,fmode=664"]
    env["folders"].each do |folder|
      app.vm.synced_folder folder["map"], folder["to"],
        owner: "vagrant",
        group: "www-data",
        mount_options: ["dmode=775,fmode=664"]
    end

    env["sites"].each do |site|
      app.vm.provision "shell", path: "apache2/create_conf.sh",
        args: [env["iac_path"] + "/apache2/", site["map"], site["to"]]
    end

    app.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
  end
end
