VAGRANTFILE_API_VERSION = "2"

# before "vagrant up" you need install hostsupdater plugin.
# "vagrant plugin install vagrant-hostsupdater"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "vcentos65"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"

  # Set the VirtualBox Configration
  COMMON_DOMAIN = ".vagrant"

  config.vm.define "basic-app" do |node|
    node.vm.hostname = "basic-app" + COMMON_DOMAIN
    node.vm.network :private_network, ip: "192.168.33.10"
    node.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh"
    node.vm.provider :virtualbox do |vb|
      vb.name = "basic-app"
      vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "2", "--ioapic", "on"]
    end
  end

  # Install chef
  config.vm.provision :shell, inline: <<-EOS
    if [ -n "`rpm -q chefdk | grep 'not installed'`" ]; then
      sudo rpm -ivh https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.6.2-1.el6.x86_64.rpm
    fi
  EOS

  # Setting berkshelf
  config.vm.provision :shell, inline: <<-EOS
    cd /vagrant
    berks vendor ./chef/cookbooks
  EOS

  # Run chef-solo
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks", "chef/site-cookbooks"]
    chef.roles_path = "chef/roles"
    chef.add_role("app")
  end

  # Stop iptables, Always run.
  config.vm.provision :shell, run: "always", inline: <<-EOS
    service iptables stop
  EOS

end
