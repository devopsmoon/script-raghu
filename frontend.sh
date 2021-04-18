#!/bin/bash
# Author: Mohammed sayeeduddin
# Date: 18-04-2021
# Description: This script will give the output for nginx server
# Modified Date: 18-04-2021
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
echo -e "\e[1;32m***********************$1************************\e[0m"
}
print1() {
echo -e "\e[1;33m***********************$1*************************\e[0m"
}
status_check() {
case $? in
0)
echo -e "\e[1;32mSUCCESS.....!\e[0m"
;;
*)
echo  -e "\e[1;31mFAILURE......!\e[0m"
exit 3
;;
esac
}
case $1 in
frontend)
print "Installing nginx server"
yum update -y
print1 "Finish......!"
yum install nginx -y
status_check
print "Starting nginx service"
systemctl enable nginx
systemctl start nginx
print1 "Finish.....!"
cd /tmp
print "Download source code"
curl -s -L -o /tmp/frontend.zip "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/db389ddc-b576-4fd9-be14-b373d943d6ee/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
unzip /tmp/frontend.zip /usr/share/nginx/html/
mv static/* .
rmdir static
rm -rf README.MD
print "Restarting nginx server"
systemctl restart nginx
print1 "Finish.....!"
;;
catalogue)
print "Installing nodejs server"
print1 "Finish......"
;;
mongodb)
print "Installing mongodb server"
print1 "Finish......."
;;
*)
echo -e "\e[1;31mInvalidate input provide the validate input\e[0m"
echo -e "\e[1;32mUsage: $0 | frontend | catalogue | mongodb\e[0m"
exit 2
;;
esac