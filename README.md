# vagrant-trusty-nginx-mysql-php7

Personal php7 development environment.

Require [vagrant-itamae](https://github.com/chiastolite/vagrant-itamae) plugin for provisioning.

## Includes

* Ubuntu xenial64
* Nginx
* PHP7(with sqlsrv extension)

## for developer

In this environment, Nginx and php-fpm processes running under 'ubuntu' user.
Vagrant is mount a project root directory to /vagrant, user ubuntu:ubuntu.
You can develop application in host machine but application running on vagrant vm.

It's usual for Microsoft Azure developing.
PHP7 with sqlsrv/pdo_sqlserv connectable to azure sql database.
