# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :shell, :path => "bootstrap.sh"


  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 8080 on the guest machine.

  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "2000"]
  end

end