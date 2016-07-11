FROM dockerfile:ssh
MAINTAINER Webb.Wang(右书僮) 343306138@qq.com
ENV DEBIAN_FRONTEND noninteractive
RUN rm -fr /etc/yum.repos.d/*
ADD yum.repos.d/ /etc/yum.repos.d/
RUN yum install mysql-server -y
RUN yum install pwgen -y
ADD my.cnf /etc/my.cnf
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV MYSQL_USER admin
ENV MYSQL_PASS **Random**

ENV REPLICATION_MASTER **False**
ENV REPLICATION_SLAVE **False**
ENV REPLICATION_USER repl
ENV REPLICATION_PASS repl

EXPOSE 3306
CMD ["/run.sh"]
