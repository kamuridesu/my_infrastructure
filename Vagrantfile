# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/buster64"
  config.vm.box_check_update = false
  config.vm.network "private_network", ip: "192.168.56.100"
  #
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4000"
    vb.cpus = "4"
  end
  config.vm.provision "shell", path: "configs/shell/provision.sh"
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: [".git/", "data/", "data/*", "data/**", "data/postgres"]
end
