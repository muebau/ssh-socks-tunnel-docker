
SSH SOCKS Tunnel Docker Image
=============================

A simple container to make some ports available on a server within some secure container environment like a reverse proxy.

Example usage
-------------

Launch the docker container on your server:

    docker run -d --restart always --name ssh-socks-tunnel -p 12345:22 -v /path/to/some/dir/ssh/:/home/user/.ssh/ muebau/ssh-socks-tunnel-docker
    docker logs ssh-socks-tunnel -f

The directory specified for persistens ('/path/to/some/dir/ssh') will hold the password as a file and the list of authorized keys.
