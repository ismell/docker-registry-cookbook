# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "docker-registry-berkshelf"
  config.vm.box = 'ubuntu'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.network :private_network, ip: "192.168.50.4"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.

  # config.vm.network :public_network

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.omnibus.chef_version = :latest

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
        'create_user_and_group' => true
      }
    }
    chef.run_list = [
      "role[docker-registry_application_server]"
    ]
  end
end
