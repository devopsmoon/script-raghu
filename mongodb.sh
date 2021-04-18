#!/bin/bash
# Author: Mohammed sayeeduddin
# Date: 19-04-2021
# Description: This script will provide the out for mongodb
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
  echo -e "\e[1;34m***************************$1**********************\e[0m"
}
print1() {
  echo -e "\e[1;35m****************************$1*********************\e[0m"
}
status_check() {
  case $? in
  0)
  echo -e "\e[1;32mSUCCESS.....!\e[0m"
  ;;
*)
  echo -e "\e[1;31mFAILURE.......!\e[0m"
  exit 3
  ;;
esac
}
case $1 in
frontend)
print "Installing nginx server"
print1 "Finish......"
;;
catalogue)
  print "Installing nodejs server"
  print1 "Finish....."
  ;;
mongodb)
  print "Updating system"
  yum update -y
  status_check
  print "Installing mongodb server"
  echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
yum install mongodb-org -y
sed -i 's/127.0.0.1/0.0.0.0/'   /etc/mongod.conf
systemctl enable mongod
systemctl start mongod
print "Download the source code"
curl -s -L -o /tmp/mongodb.zip "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/e9218aed-a297-4945-9ddc-94156bd81427/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
cd /tmp
unzip /tmp/mongodb.zip
mongo < catalogue.js
mongo < users.js
status_check
print "Restarting mongod service"
systemctl restart mongod
  print1 "Finish......"
  ;;
*)
  echo -e "\e[1;31mInvalidate input provide the validate\e[0m"
  echo -e "\e[1;32mUsage: $0 | frontend | catalogue | mongodb\e[0m"
  exit 2
  ;;
esac

