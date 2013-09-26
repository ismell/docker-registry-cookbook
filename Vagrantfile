# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "docker-registry-berkshelf"
  config.vm.box = 'ubuntu'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.network :private_network, ip: "192.168.50.4"


  config.omnibus.chef_version = :latest
  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :shell, inline: <<-EOF
    if [ ! -f /tmp/.apt-get-initial-update ] ; then
      apt-get update
      touch /tmp/.apt-get-initial-update
    fi
  EOF
  config.vm.provision :chef_solo do |chef|
    chef.log_level = ENV['DEBUG'] ? :debug : :info
	
    chef.roles_path = "roles"
    chef.add_role("docker-registry_application_server")
    chef.add_role("docker-registry_load_balancer")
    chef.add_role("docker-registry")
	
    chef.json = {
      'docker-registry' => {
        'owner' => 'dockreg',
        'group' => 'dockreg',
        'secret_key' => 'fksldjriohl2kfsn2lh342kjfdeaslhkhfskjnhalknfk4232snfkldjfsdf3242'
      }
    }
    chef.run_list = [
      "role[docker-registry_application_server]"
    ]
  end
end
