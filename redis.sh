#!/bin/bash

source ./common.sh

check_root

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disabling deafult redis version"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enabling redis"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "installing redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "Validating remote connection to Redis"

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "redis service enabled"
systemctl start redis &>>$LOG_FILE 
VALIDATE $? "redis service started"

print_total_time