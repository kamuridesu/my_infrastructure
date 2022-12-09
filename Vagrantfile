# -*- mode: ruby -*-
# vi: set ft=ruby :

DEFAULT_IMAGE = "debian/buster64"

MASTER = {
  "CPU" => "4",
  "MEMORY" => "6000",
  "IP" => "10.0.1.100",
  "TYPE" => "master",
  "NAME" => "master01",
}

WORKER = {
  "CPU" => "2",
  "MEMORY" => "2000",
  "IP" => "10.0.1.101",
  "TYPE" => "worker",
  "NAME" => "worker01"
}


INVENTORY = [MASTER, WORKER]

Vagrant.configure("2") do |config|

  config.vm.box = DEFAULT_IMAGE
  INVENTORY.each do |virtualmachines|
    config.vm.define virtualmachines["NAME"] do |box|

      box.vm.box_check_update = false
      box.vm.network "private_network", ip: virtualmachines["IP"]
      box.vm.hostname = virtualmachines["NAME"]

      box.vm.synced_folder ".", "/vagrant", type: "rsync",
        rsync__exclude: [".git/", "data/", "data/*", "data/**", "data/postgres"]

      box.vm.provider "virtualbox" do |vb|
        vb.memory = virtualmachines["MEMORY"]
        vb.cpus = virtualmachines["CPU"]
      end

      if virtualmachines["TYPE"] == "master" then
        box.vm.provision "shell", path: "configs/shell/provision_master.sh"
      elsif virtualmachines["TYPE"] == "worker" then
        box.vm.provision "shell", path: "configs/shell/provision_worker.sh"
      end

    end
  end
end
