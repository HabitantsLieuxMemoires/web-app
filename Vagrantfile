# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box      = "ubuntu/trusty64"
  config.vm.hostname = "vagrant.hlm.local"

  # Rails app port forwarding
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "private_network", ip: "192.168.50.4"

  # NFS
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = 1024
     vb.cpus   = 1
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook        = "provisioning/playbook.yml"
    ansible.skip_tags       = "common_user"
    ansible.extra_vars      = {
      app_user: 'vagrant',
      app_user_home: '/home/vagrant'
    }
  end

  config.ssh.forward_agent = true

end
