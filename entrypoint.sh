#! /bin/sh

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    /usr/bin/ssh-keygen -A

    if [ ! -f /home/user/.ssh/password ]; then
        dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 | head -c 32 > /home/user/.ssh/password 
    fi
    PASSWORD=$(cat /home/user/.ssh/password)

    echo "user:$PASSWORD" | chpasswd
    echo "Generating password for user: $PASSWORD"
    echo "$USER_SSH_ALLOWED" > /home/user/.ssh/authorized_keys
fi

echo "" >> /etc/ssh/sshd_config
echo "GatewayPorts yes" >> /etc/ssh/sshd_config

chown user:user -R /home/user/.ssh/
chmod g-w /home/user
chmod 700 /home/user/.ssh
chmod 600 /home/user/.ssh/authorized_keys

echo "State of /home/user/.ssh/authorized_keys :"
cat /home/user/.ssh/authorized_keys

exec /usr/sbin/sshd -D -e
