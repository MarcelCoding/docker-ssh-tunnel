FROM alpine:3.14

EXPOSE 9999
EXPOSE 22

COPY entrypoint.sh /entrypoint.sh

RUN apk --update --no-cache add openssh-server \
  && sed -i 's/GatewayPorts no.*/GatewayPorts\ yes/' /etc/ssh/sshd_config \
  && sed -i 's/#PermitRootLogin prohibit-password*/PermitRootLogin\ no/' /etc/ssh/sshd_config \
  && sed -i 's/#PasswordAuthentication yes*/PasswordAuthentication\ no/' /etc/ssh/sshd_config \
  && sed -i 's/AllowTcpForwarding no*/AllowTcpForwarding\ yes/' /etc/ssh/sshd_config \
  \
  && mkdir -p /etc/ssh/keys/etc/ssh \
  && sed -i 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key*/HostKey\ \/etc\/ssh\/keys\/etc\/ssh\/ssh_host_rsa_key/' /etc/ssh/sshd_config \
  && sed -i 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key*/HostKey\ \/etc\/ssh\/keys\/etc\/ssh\/ssh_host_ecdsa_key/' /etc/ssh/sshd_config \
  && sed -i 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key*/HostKey\ \/etc\/ssh\/keys\/etc\/ssh\/ssh_host_ed25519_key/' /etc/ssh/sshd_config \
  && echo "HostKey /etc/ssh/keys/etc/ssh/ssh_host_dsa_key" >> /etc/ssh/sshd_config \
  \
  && adduser -D -s /bin/false tunnel \
  && passwd -u tunnel \
  && passwd -d root \
  && chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
