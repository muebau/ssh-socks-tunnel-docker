* **1.0.0**, **latest**: [Dockerfile](https://github.com/nicolas-van/ssh-socks-tunnel-docker/blob/master/Dockerfile)

This image contains a simple openssh configuration over alpine. The goal is have a straightforward way to setup a simple ssh server in order to create a SOCKS proxy. The purpose is, once again, to defeat those damn enterprise proxies that basically disallow you anything aside connecting to the crappy enterprise website.

Example usage on your server:

    docker run -d -p 443:22 -e "USER_SSH_ALLOWED=*paste your ssh key here*" nicolasvan/ssh-socks-tunnel

In the above example we redirect the 22 port to 443 (HTTPS port) on our host. The reason is that the hellish entreprise proxies we try to work around will always disallow connections to all ports except that HTTPS port. We also add some ssh key(s) to allow a safe connexion to our SSH server.

Then, on your local machine, you must first setup [corkscrew](http://agroman.net/corkscrew/) to forward ssh connections through the nightmare proxy. Here is an example configuration to add to your ~/.ssh/config file (assuming you don't have credentials to add, which you will):

    ProxyCommand /usr/local/bin/corkscrew proxy.work.com 80 %h %p

Then create the SOCKS proxy:

    ssh -D 1234 -p 443 -N user@*your server url*

The only thing remaining to do is to configure your browser to connect to the localhost:1234 SOCKS proxy. You can now, finally, do your job.
