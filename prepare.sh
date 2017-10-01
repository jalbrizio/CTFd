#!/bin/bash
# Set the variables to check for apt or yum
aptvar="apt"
export aptvar
yumvat="yum"
export yumvar
haveapt=`which apt 2>/dev/null| egrep -v "no\ such|no\ apt" | awk -F\/ '{print $(NF)}'`
export haveapt
haveyum=`which yum 2>/dev/null| egrep -v "no\ such|no\ yum" | awk -F\/ '{print $(NF)}'`
export haveym
# check for apt
if [[ "$haveapt" = "$aptvar" ]];
then
echo "apt installed"
sudo apt-get update
sudo apt-get install build-essential python-dev python-pip libffi-dev -y
# check for yum
elif [[ "$haveym" = "$yumvar" ]];
then
echo "yum installed"
sudo yum -y update && sudo yum groupinstall "Development Tools" && sudo yum -y install libffi-devel python-pip python-devel  
pip install -r requirements.txt
else
# if neither apt or yum are installed, or there is some other error that doesnt print properly, print the output of the variables. 
echo "neither apt or yum are being used"
echo "apt is $haveapt"
echo "yum is $haveyum"
# finish
fi
