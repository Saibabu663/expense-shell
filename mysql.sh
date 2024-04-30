#!/bin/bash

userid=$(id -u)
TIMESTAMP=$(date +%f-%h-%m-%s)
script_name=$(echo $0 |cut -d "." -f1)                                                                                                            -f1
logfile=/temp/$script_name-$timestamp.log
R="\e[31m"
G="\e[32m"
y="\e[33m"
N="\e[0m"
echo "Please enter DB password:"
read -s mysql_root_password

validate(){
   if [ $1 -ne 0]
   then
        echo -e "$2...$r failuru $n"
        exit 1
    else
        echo -e "$2...$g success $n"
    fi
}

if [ $userid -ne 0 ] 
then     
    echo "please run this script with root access."
    exit 1 # manually exit if error comes.
    else
        echo "you are super user."
fi
  
  dnf install mysql-server -y &>>$logfile
  validate $? "installing mysql server"

  systemctl enable mysqld &>>$logfile
  validate $? "enabling mysql server"

 systemctl start mysqld  &>>$logfile
  validate $? "starting mysql server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$logfile
#  validate $? "setting up root password"

#Below code will be useful for idempotent nature
mysql -h db.daws-78s.online -uroot -pExpenseApp@1 -e 'show databases;'
if [ $? -ne 0]
then
    mysql_secure_installation --set-root-pass ExpenseApp@1
    validate $? "Mysql Root password Setup"
else
    echo -e "Mysql Root password is already setup..$Y SKIPPING $N"
fi

