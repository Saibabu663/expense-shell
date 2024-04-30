
validate(){
   if [ $1 -ne 0 ]
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
  
  dnf module disable nodejs -y &>>$LOGFILE
  VALIDATE $? "Disabling default nodejs"

  dnf module enable nodejs:20 -y &>>$LOGFILE
  VALIDATE $? "Enabling nodejs:20 version"

  dnf install nodejs -y &>>$LOGFILE
  VALIDATE $? "Installing nodejs"

 id expense  &>>$LOGFILE
 if [ $? -ne 0 ]
 then
    useradd expense  &>>$LOGFILE
    Validate $? "creating expense user"
else
    echo -e "Expense user already created...$Y SKIPPING $N"
fi 