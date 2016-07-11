FROM dockerfile:ssh
COPY nginx-1.10.0-1.el6.ngx.x86_64.rpm /root/nginx-1.10.0-1.el6.ngx.x86_64.rpm
RUN rpm -ivh  /root/nginx-1.10.0-1.el6.ngx.x86_64.rpm 
RUN sed -i '4adaemon off;\n' /etc/nginx/nginx.conf
ADD run.sh /run.sh
RUN chmod +x /run.sh
ADD sample/ /usr/share/nginx/html/
RUN rm -fr /root/nginx-1.10.0-1.el6.ngx.x86_64.rpm
EXPOSE 80
CMD ["/run.sh"]
