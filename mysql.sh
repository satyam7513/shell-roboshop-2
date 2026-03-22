#!/bin/bash

source ./common.sh
app_name=mysql

check_root

echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD

dnf install mysql-server -y &>>LOG_FILE
VALIDATE $? "mysql server installing"

systemctl enable mysqld &>>LOG_FILE
VALIDATE $? "mysqld enabling"

systemctl start mysqld &>>LOG_FILE
VALIDATE $? "starting mysqld"

mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>LOG_FILE
VALIDATE $? "Setting mysql root password"

print_time