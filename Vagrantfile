# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box     = "precise-server"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"

  config.vm.hostname = "vagrant.hlm.local"

  # Rails app port forwarding
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  # Enable provisioning with Puppet stand alone.
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path     = "provisioning/manifests"
    puppet.manifest_file      = "site.pp"
    puppet.module_path        = "provisioning/modules"
    puppet.synced_folder_type = "nfs"
    puppet.options            = ["--verbose"]
  end

end
