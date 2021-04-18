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
  print "Installing nodejs server"
  print1 "Finish......!"
  ;;
mongodb)
  print "Installing mongodb server"
  print1 "Finish.......!"
  ;;
*)
  print -e "\e[1;33mInvalidate input provide the correct input\e[0m"
  print1 -e "\e[1;34mUsage: $0 | frontend | catalogue | mongodb\e[0m"
  exit 2
  ;;
esac
