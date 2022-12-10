# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'pathname'

DEFAULT_IMAGE = "debian/buster64"

if ENV['INV_FILE'] != nil then
  file = Pathname.new(ENV['INV_FILE'])
  if ! file.exist? then
    abort "ERROR: file \"#{file}\" does not exists!"
  end
else
  abort "ERROR: Expecting a configuration file!"
end

INVENTORY = YAML.load_file(File.join(File.dirname(__FILE__), ENV['INV_FILE']))

["NAME", "CPU", "MEMORY", "IP", "TYPE"].each do |key|
    INVENTORY.each_with_index do |config, idx|
        if (!config.has_key?(key)) && (!config.has_key?(key.to_sym))
            abort "ERROR: Missing parameter \"#{key}\" on the machine number #{idx + 1} of the inventory file!"
        end
    end
end


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
