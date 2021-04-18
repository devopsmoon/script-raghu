#!/bin/bash
# Author: Mohammed sayeeduddin
# Date: 19-04-2021
# Description: this script will provide the output for catalogue server
# Modified Date: 19-04-2021
user_id=$(id -u)
case $user_id in
0)
  ;;
*)
  echo -e "\e[1;31mYou should be root user to perform this script\e[0m"
  exit 1
  ;;
esac
print() {
  echo -e "\e[1;32m************************$1**************************\e[0m"
}
print1() {
  echo -e "\e[1;33m************************$1**************************\e[0m"
}
status_check() {
  case $? in
  0)
    echo -e "\e[1;32mSUCCESS.......!\e[0m"
    ;;
    *)
      echo -e "\e[1;31mFAILURE......!\e[0m"
      exit 3
      ;;
    esac
}
case $1 in
frontend)
  print "Installing nginx server"
  print1 "Finish......!"
  ;;
catalogue)
  print "Installing updates"
  yum update -y
  status_check
  print "Installing nodejs server"
  yum install nodejs make gcc-c++ -y
  status_check
  useradd -d /home/roboshop -m -s /bin/bash roboshop
  su - roboshop
  mkdir catalogue
  cd catalogue
  print "Download source code"
  curl -s -L -o /tmp/catalogue.zip "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/558568c8-174a-4076-af6c-51bf129e93bb/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
  unzip /tmp/catalogue.zip
  npm install
  sed -i 's/localhost/172.31.51.250/' /home/roboshop/catalogue/server.nodejs
  sed -i 's/MONGO_ENDPOINT/172.31.51.250/' /home/roboshop/catalogue/systemd.service
  exit
  mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
  systemctl enable catalogue
  systemctl start catalogue
  print1 "Finish......!"
  ;;
mongodb)
  print "Installing mongodb server"
  print1 "Finish.......!"
  ;;
*)
  echo -e "\e[1;33mInvalidate input provide the correct input\e[0m"
  echo -e "\e[1;34mUsage: $0 | frontend | catalogue | mongodb\e[0m"
  exit 2
  ;;
esac
