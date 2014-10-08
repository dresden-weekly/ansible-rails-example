# -*- mode: ruby -*-
# vi: set ft=ruby :

provision_target = ENV['PROVISION_TARGET'] || 'vagrant' # valid: staging, production
provision_action = ENV['PROVISION_ACTION'] || 'provision' # valid: deploy, app_restart

Vagrant.configure('2') do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.provision :shell, inline: <<-SHELL_END
    export REPO_USER=#{ENV['REPO_USER']}
    export REPO_PASSWORD=#{ENV['REPO_PASSWORD']}
    export SECRET_KEY_BASE=#{ENV['SECRET_KEY_BASE']}
    export PROVISION_ARGS=#{ENV['PROVISION_ARGS']}
    export ANSIBLE_HOST_KEY_CHECKING=False
    exec /vagrant/ansible/run.sh #{provision_target} #{provision_action}
  SHELL_END

  config.vm.network "forwarded_port", guest: 80, host: 8080 # webserver
  config.vm.network "forwarded_port", guest: 5672, host: 5672 # rabbitmq
  config.vm.network "private_network", type: "dhcp"
  config.ssh.forward_agent = true


  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
end
