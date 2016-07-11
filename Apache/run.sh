#!/bin/bash
/usr/sbin/sshd &
/usr/sbin/apachectl -D FOREGROUND
