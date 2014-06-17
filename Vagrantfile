# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :private_network, ip: "10.10.10.174"
  config.vm.provision :shell,
    # add an admin user with SSH access
    :inline => "sudo useradd -m -g admin -s /bin/bash admin && echo \"admin:admin\" | sudo chpasswd ; sudo mkdir -m 700 /home/admin/.ssh ; sudo cp /home/vagrant/.ssh/authorized_keys /home/admin/.ssh/ ; sudo chown -R admin /home/admin/.ssh ; sudo chmod 600 /home/admin/.ssh/authorized_keys"
end
