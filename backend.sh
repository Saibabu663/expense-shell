
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
  
  dnf module disable nodejs -y &>>$logfile
  Validate $? "Disabling default nodejs"

  dnf module enable nodejs:20 -y &>>$logfile
  Validate $? "Enabling nodejs:20 version"

  dnf install nodejs -y &>>$logfile
 validate $? "Installing nodejs"


id expense -y &>>$logfile
if [ $? -ne 0]
then 
    useradd expense -y &>>$logfile
    Validate $? "creating expense user"
else
    echo "Expense user already created...$Y SKIPPING $N"
fi