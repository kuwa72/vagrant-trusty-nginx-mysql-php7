# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 18080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "4096"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  config.cache.scope = :box

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "itamae" do |config|
    config.sudo = true

    config.recipes = [ "./recipe.rb" ]
    config.json = './node.json'
  end
=begin
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    whoami
    
    echo "Update repository to closest server"
    sudo apt-add-repository 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse'
    sudo apt-add-repository 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse'
    sudo apt-add-repository 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse'
    sudo apt-add-repository 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse'

    echo "Update packages"
    sudo apt-get update && sudo apt-get -y upgrade
    sudo apt-get -y install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev libx11-dev gettext

    if [ -x "$(which brew)" ];then
        :
    else
        echo "Install linuxbrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
        cat /vagrant/linuxbrew_env > ~/.bash_profile
        source ~/.bash_profile
    fi

    if [ -x "$(which brew)" ];then
        echo "Install linuxbrew packages"
        yes | brew install pkg-config cocot ctags curl wget fish zsh git global jq leiningen lv nkf ocaml rbenv ruby-build tig the_silver_searcher vim zsh zsh-completions zsh-lovers npm
    fi

    sudo add-apt-repository -y 'ppa:ondrej/php-7.0'
    sudo add-apt-repository -y 'ppa:evarlast/golang1.5'
    sudo apt-get update && sudo apt-get -y upgrade
    sudo apt-get -y install nginx php7.0 php7.0-fpm php-mysql php-curl php-gd php-json php-opcache golang

    sudo rm /etc/nginx/sites-enabled/default
    sudo cp -f /vagrant/nginx_vhost /etc/nginx/sites-available/
    sudo ln -f -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/default

    sudo update-rc.d apache stop
    sudo service nginx restart

    SHELL
=end
end
