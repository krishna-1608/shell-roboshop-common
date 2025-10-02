#!/bin/bash

source ./common.sh

check_root

dnf install mysql-server -y &>>$LOG_FILE 
VALIDATE $? "Installing MySql server"
systemctl enable mysqld &>>$LOG_FILE 
VALIDATE $? "Enabling MySql server"
systemctl start mysqld &>>$LOG_FILE 
VALIDATE $? "starting MySql server" 
mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE 
VALIDATE $? "setting up root password"

print_total_time