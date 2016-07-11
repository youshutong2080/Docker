#Docker
========================================
##安装基础镜像 CentOS 6.x
>从[OpenVZ](http://download.openvz.org/template/precreated/centos-6-x86_64.tar.gz)下载模版
>导入 Docker <br>
```bash
# cat centos-6-x86_64.tar.gz | docker import - centos
```

##制作 SSH 镜像
>配置 Dockerfile
```bash
# mkdir SSH
# cd SSH
# touch Dockerfile run.sh
# cat ~/.ssh/id_rsa.pub > authorized_keys
# cp /etc/ssh/sshd_config .
```
>主要需要修改的参数:<br>
RSAAuthentication yes<br>
PubkeyAuthentication yes<br>
AuthorizedKeysFile	.ssh/authorized_keys<br>
PasswordAuthentication no<br>
UsePAM no<br>

>构建并运行 SSH 镜像
```bash
# docker build -t dockerfile:ssh .
# docker run --name ssh -d -p 11022:22 dockerfile:ssh
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                   NAMES
98b4d5593325        dockerfile:ssh      "/run.sh"           19 seconds ago      Up 17 seconds       0.0.0.0:11022->22/tcp   ssh
# ssh localhost -p11022
The authenticity of host '[localhost]:11022 ([::1]:11022)' can't be established.
RSA key fingerprint is d4:80:79:0e:88:92:22:b0:d1:9a:4e:47:c8:15:4b:5e.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[localhost]:11022' (RSA) to the list of known hosts.
[root@98b4d5593325 ~]#
```


##制作 Apache 镜像
>配置 Dockerfile
```bash
# mkdir Apache
# cd Apache
# touch Dockerfile run.sh
```
>构建并运行 Apache 镜像
```bash
# docker build -t dockerfile:apache .
# docker run --name apache -d -p 11023:22 -p 11080:80 dockerfile:apache
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS                                          NAMES
9f89bcb18703        dockerfile:apache   "/run.sh"           4 seconds ago       Up 3 seconds                0.0.0.0:11023->22/tcp, 0.0.0.0:11080->80/tcp   apache
98b4d5593325        dockerfile:ssh      "/run.sh"           29 minutes ago      Up 29 minutes               0.0.0.0:11022->22/tcp                          ssh
# curl -I http://localhost:11080
HTTP/1.1 200 OK
Date: Mon, 11 Jul 2016 15:11:40 GMT
Server: Apache/2.2.15 (CentOS)
Last-Modified: Mon, 11 Jul 2016 15:01:43 GMT
ETag: "62af3-1a4-5375d6e25a3c0"
Accept-Ranges: bytes
Content-Length: 420
Connection: close
Content-Type: text/html; charset=UTF-8
# ssh localhost -p 11023
The authenticity of host '[localhost]:11023 ([::1]:11023)' can't be established.
RSA key fingerprint is d4:80:79:0e:88:92:22:b0:d1:9a:4e:47:c8:15:4b:5e.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[localhost]:11023' (RSA) to the list of known hosts.
[root@9f89bcb18703 ~]#
```

##制作 Nginx 镜像
>配置 Dockerfile
```bash
# mkdir Nginx
# cd Nginx
# touch Dockerfile run.sh
```
>构建并运行 Apache 镜像
```bash
# docker build -t dockerfile:nginx .
# docker run --name nginx -d -p 11024:22 -p 11081:80 dockerfile:nginx
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                                          NAMES
e26a26efd57a        dockerfile:nginx    "/run.sh"           3 seconds ago       Up 2 seconds        0.0.0.0:11024->22/tcp, 0.0.0.0:11081->80/tcp   nginx
9f89bcb18703        dockerfile:apache   "/run.sh"           13 minutes ago      Up 13 minutes       0.0.0.0:11023->22/tcp, 0.0.0.0:11080->80/tcp   apache
98b4d5593325        dockerfile:ssh      "/run.sh"           42 minutes ago      Up 42 minutes       0.0.0.0:11022->22/tcp                          ssh
# curl -I http://localhost:11081
HTTP/1.1 200 OK
Server: nginx/1.10.0
Date: Mon, 11 Jul 2016 15:25:59 GMT
Content-Type: text/html
Content-Length: 418
Last-Modified: Mon, 11 Jul 2016 15:19:16 GMT
Connection: keep-alive
ETag: "5783b8f4-1a2"
Accept-Ranges: bytes
# ssh localhost -p 11024
The authenticity of host '[localhost]:11024 ([::1]:11024)' can't be established.
RSA key fingerprint is d4:80:79:0e:88:92:22:b0:d1:9a:4e:47:c8:15:4b:5e.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[localhost]:11024' (RSA) to the list of known hosts.
[root@e26a26efd57a ~]#
```

##制作 MySQL 镜像
>配置 Dockerfile
```bash
# mkdir MySQL
# cd MySQL
# touch Dockerfile run.sh
```

>构建并运行 MySQL 镜像
```bash
# docker build -t dockerfile:mysql .
# docker run --name mysqld -d -p 11025:22 -p 13306:3306 -e MYSQL_PASS="asdasd" dockerfile:mysql
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                                            NAMES
922c3383dece        dockerfile:mysql    "/run.sh"           21 seconds ago      Up 20 seconds       0.0.0.0:11025->22/tcp, 0.0.0.0:13306->3306/tcp   mysqld
e26a26efd57a        dockerfile:nginx    "/run.sh"           30 minutes ago      Up 30 minutes       0.0.0.0:11024->22/tcp, 0.0.0.0:11081->80/tcp     nginx
9f89bcb18703        dockerfile:apache   "/run.sh"           43 minutes ago      Up 43 minutes       0.0.0.0:11023->22/tcp, 0.0.0.0:11080->80/tcp     apache
98b4d5593325        dockerfile:ssh      "/run.sh"           About an hour ago   Up About an hour    0.0.0.0:11022->22/tcp                            ssh
# mysql -uadmin -h127.0.0.1 -P13306 -pasdasd
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1
Server version: 5.1.73 Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

>MySQL主从
```
# docker run --name mysql -d -e REPLICATION_MASTER=true -e MYSQL_PASS="asdasd" -p 11026:22 -p 13307:3306 dockerfile:mysql
# docker run --name slave -d -e REPLICATION_SLAVE=true -e MYSQL_PASS="asdasd" -p 11027:22 -p 13308:3306 --link mysql:mysql dockerfile:mysql
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS                                            NAMES
0d962314f8a8        dockerfile:mysql    "/run.sh"           42 seconds ago       Up 41 seconds       0.0.0.0:11027->22/tcp, 0.0.0.0:13308->3306/tcp   slave
6e35be013a1f        dockerfile:mysql    "/run.sh"           About a minute ago   Up About a minute   0.0.0.0:11026->22/tcp, 0.0.0.0:13307->3306/tcp   mysql
922c3383dece        dockerfile:mysql    "/run.sh"           5 minutes ago        Up 5 minutes        0.0.0.0:11025->22/tcp, 0.0.0.0:13306->3306/tcp   mysqld
e26a26efd57a        dockerfile:nginx    "/run.sh"           35 minutes ago       Up 35 minutes       0.0.0.0:11024->22/tcp, 0.0.0.0:11081->80/tcp     nginx
9f89bcb18703        dockerfile:apache   "/run.sh"           48 minutes ago       Up 48 minutes       0.0.0.0:11023->22/tcp, 0.0.0.0:11080->80/tcp     apache
98b4d5593325        dockerfile:ssh      "/run.sh"           About an hour ago    Up About an hour    0.0.0.0:11022->22/tcp                            ssh

# mysql -uadmin -h127.0.0.1 -P13308 -pasdasd
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.1.73-log Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show slave status\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 172.17.0.32
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 30
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 106
               Relay_Log_File: mysqld-relay-bin.000004
                Relay_Log_Pos: 251
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 106
              Relay_Log_Space: 773
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
1 row in set (0.00 sec)

mysql>

```



