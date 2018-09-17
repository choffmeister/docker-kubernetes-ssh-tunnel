FROM alpine:3.6

RUN apk add --update --no-cache openssh bash
RUN sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
RUN sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config && \
    sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config && \
    sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config && \
    sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config && \
    sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_key

RUN sed -ie 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -ie 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -ie 's/#PermitRootLogin prohibit-password/PermitRootLogin without-password/g' /etc/ssh/sshd_config && \
    echo "RSAAuthentication yes" >> /etc/ssh/sshd_config

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

RUN mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && \
    chown -R root:root /root/.ssh
# RUN adduser -D -g "" tunnel
# RUN mkdir /home/tunnel/.ssh && \
#     chmod 700 /home/tunnel/.ssh && \
#     touch /home/tunnel/.ssh/authorized_keys && \
#     chmod 600 /home/tunnel/.ssh/authorized_keys && \
#     chown -R tunnel:tunnel /home/tunnel/.ssh
# USER tunnel:tunnel

EXPOSE 22
