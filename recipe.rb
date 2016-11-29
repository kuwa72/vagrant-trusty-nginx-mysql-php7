
execute "apt-get install -y language-pack-en-base"

execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial main restricted universe multiverse'"
execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-updates main restricted universe multiverse'"
execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-backports main restricted universe multiverse'"
execute "apt-add-repository -y 'deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-security main restricted universe multiverse'"

execute "Add Microsoft ODBC Driver repository" do
  command "echo 'deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/mssql-ubuntu-xenial-release/ xenial main' > /etc/apt/sources.list.d/mssqlpreview.list;
  apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893;"
  not_if 'test -f /etc/apt/sources.list.d/mssqlpreview.list'
end

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
package "vim"
package "tig"
package "wget"
package "curl"
package "git"
package "ctags"
package "cscope"
package "global"
package "nginx"
package "php7.0-fpm"
package "php7.0"
package "php-mysql"
package "php-mbstring"
package "php-curl"
package "php-gd"
package "php7.0-opcache"
package "php-all-dev"

$linuxbrew_env = 'source /vagrant/linuxbrew_env;'

execute "Install linuxbrew" do
  command 'yes \n | sudo -u ubuntu ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"'
  not_if 'test -d /home/ubuntu/.linuxbrew'
end

execute "Installing the Microsoft ODBC Driver" do
  command "ACCEPT_EULA=Y apt install -y msodbcsql unixodbc-dev-utf16; apt install unixodbc-dev-utf16"
end

execute 'pecl install sqlsrv-4.0.7 || true'
execute 'pecl install pdo_sqlsrv-4.0.7 || true'

#execute 'sudo -u ubuntu bash -c "'+$linuxbrew_env+'yes|brew install pkg-config cocot jq leiningen lv nkf rbenv ruby-build the_silver_searcher zsh-completions zsh-lovers"'

template '/etc/nginx/nginx.conf'
template '/etc/nginx/sites-available/default'
template '/etc/php/7.0/fpm/pool.d/www.conf'
template '/etc/php/7.0/cli/conf.d/20-pdo_sqlsrv.ini'
template '/etc/php/7.0/fpm/conf.d/20-pdo_sqlsrv.ini'

#service 'apache' do
#  action [:stop, :disable]
#end

service 'nginx' do
  action [:restart, :enable]
end

service 'php7.0-fpm' do
  action [:restart, :enable]
end

