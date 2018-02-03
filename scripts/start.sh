#!/bin/bash
# Start supervisord and services
chmod -R 777 /var/vhosts/selphiu/var
exec /usr/bin/supervisord -n -c /etc/supervisord.conf

