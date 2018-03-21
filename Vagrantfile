# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "centos/7"
	config.vm.network "forwarded_port", guest: 8888, host: 8888
	config.vm.synced_folder ".", "/vagrant", type:"virtualbox"

	config.vm.provision "file", source: "jupyter.service", destination: "/tmp/jupyter.service"
	config.vm.provision "shell", privileged:true, inline: "cp /tmp/jupyter.service /etc/systemd/system/"

	config.vm.provision "ansible_local" do |ansible|
		ansible.playbook = "ansible_docker_install.yml"
		ansible.install = true
	end

end
