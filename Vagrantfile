# -*- mode: ruby -*-
# vi: set ft=ruby :


# http://stackoverflow.com/questions/19492738/demand-a-vagrant-plugin-within-the-vagrantfile
# not using 'vagrant-vbguest' vagrant plugin because now using bento images which has vbguestadditions preinstalled.
required_plugins = %w( vagrant-hosts vagrant-share vagrant-vbox-snapshot vagrant-host-shell vagrant-triggers vagrant-reload )
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end



Vagrant.configure(2) do |config|
  config.vm.define "webserver-box" do |webserver_config|
    webserver_config.vm.box = "bento/centos-7.4"
    webserver_config.vm.hostname = "webserver.local"
    # https://www.vagrantup.com/docs/virtualbox/networking.html
    webserver_config.vm.network "private_network", ip: "10.0.5.10", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    webserver_config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.name = "centos7_webserver"
    end

    webserver_config.vm.provision "shell", path: "scripts/install-rpms.sh", privileged: true
  end


  config.vm.define "box1" do |box1_config|
    box1_config.vm.box = "bento/centos-7.4"
    box1_config.vm.hostname = "box1.local"
    box1_config.vm.network "private_network", ip: "10.0.5.11", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    box1_config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 2
      vb.name = "centos7_box1"
    end

    box1_config.vm.provision "shell", path: "scripts/install-rpms.sh", privileged: true
  end
end