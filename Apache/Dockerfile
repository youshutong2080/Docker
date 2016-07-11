FROM dockerfile:ssh
MAINTAINER from Webb.Wang(右书僮)
RUN rm -fr /etc/yum.repos.d/*
COPY yum_repos/ /etc/yum.repos.d/
#RUN yum install httpd -y
RUN sed -i 's/#ServerName www.example.com:80/ServerName localhost:80/' /etc/httpd/conf/httpd.conf
COPY sample/ /var/www/html/
ADD run.sh /run.sh
RUN chmod +x /run.sh
EXPOSE 80
CMD ["/run.sh"]

