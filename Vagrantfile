# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["fmode=666"]
  config.ssh.insert_key = false

  # use vagrant-hostmanager plugin
  #   vagrant plugin install vagrant-hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

  config.vm.define "itedd-vm" do |itedd|
    itedd.vm.hostname = "itedd-vm"

    # disable shared folder
    itedd.vm.synced_folder ".", "/vagrant", disabled: true

    # make machine faster
    itedd.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
  end

  config.vm.define "db-vm" do |db|
    db.vm.hostname = "db-vm"

    # disable shared folder
    db.vm.synced_folder ".", "/vagrant", disabled: true
  end

  config.vm.define "web-vm" do |web|
    web.vm.hostname = "web-vm"

    # forwarded ports
    web.vm.network "forwarded_port", guest: 80, host: 8081 # http

    # disable shared folder
    web.vm.synced_folder ".", "/vagrant", disabled: true
  end

  config.vm.define "ansible-vm", primary: true do |ansible|
    ansible.vm.hostname = "ansible-vm"
    ansible.ssh.forward_agent = true
  end
end
