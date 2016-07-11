FROM centos
MAINTAINER from webb.wang(右书僮)
RUN mkdir /root/.ssh
ADD authorized_keys /root/.ssh/authorized_keys
RUN sed -i "s/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/" /etc/pam.d/sshd
ADD sshd_config /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
ADD run.sh /run.sh
RUN chmod +x /run.sh
EXPOSE 22
CMD ["/run.sh"]
