#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)                                                                                                            -f1
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
y="\e[33m"
N="\e[0m"


VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$g SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ] 
then     
    echo "please run this script with root access."
    exit 1 # manually exit if error comes.
    else
        echo "you are super user."
fi
  
  dnf install mysql-server -y &>>$LOGFILE
  VALIDATE $? "Installing MYSQL Server"

  systemctl enable mysqld &>>$LOGFILE
  VALIDATE $? "Enabling MYSQL Server"

 systemctl start mysqld  &>>$LOGFILE
  VALIDATE $? "Starting MYSQL Server"

#  mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$logfile
#  VALIDATE $? "etting up root password"


#Below code will be useful for idempotent nature
 mysql -h db.daws-78s.online -uroot -pExpenseApp@1 -e 'SHOW  DATABASES
 if [ $? -ne 0 ]
 then
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
    VALIDATE $? "MYSQL Root password Setup"
else
    echo -e "MYSQL Root password is already setup...$Y SKIPPING $N"
fi