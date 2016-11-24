
execute "apt-get install -y language-pack-en-base"

execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial main restricted universe multiverse'"
execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-updates main restricted universe multiverse'"
execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-backports main restricted universe multiverse'"
execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-security main restricted universe multiverse'"

#execute "apt-add-repository -y ppa:ondrej/php-7.0"
#execute "apt-add-repository -y ppa:ondrej/php"
execute "add-apt-repository -y ppa:ubuntu-lxc/lxd-stable"
execute "apt-get update && apt-get -y upgrade"

package "build-essential"
package "curl"
package "git"
package "m4"
package "ruby"
package "texinfo"
package "libbz2-dev"
package "libcurl4-openssl-dev"
package "libexpat-dev"
package "libncurses-dev"
package "zlib1g-dev"
package "libx11-dev"
package "gettext"
package "zsh"
package "fish"
package "vim"
package "tig"
package "wget"
package "curl"
package "git"
package "ctags"
package "cscope"
package "global"
package "ocaml"
package "haskell-platform"
package "nginx"
package "php7.0-fpm"
package "php7.0"
package "php-mysql"
package "php-curl"
package "php-gd"
package "php7.0-opcache"
package "golang"

$linuxbrew_env = 'source /vagrant/linuxbrew_env;'

execute "Install linuxbrew" do
  command 'yes \n | sudo -u ubuntu ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"'
  not_if 'test -d /home/ubuntu/.linuxbrew'
end

execute 'sudo -u ubuntu bash -c "'+$linuxbrew_env+'yes|brew install pkg-config cocot jq leiningen lv nkf rbenv ruby-build the_silver_searcher zsh-completions zsh-lovers"'

template '/etc/nginx/sites-available/default'

#service 'apache' do
#  action [:stop, :disable]
#end

service 'nginx' do
  action [:start, :enable]
end

