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
pip install -r requirements.txt
# check for yum
elif [[ "$haveym" = "$yumvar" ]];
then
echo "yum installed"
# allow repos to work using yum epel uses gpg signing but not all gpg signing this fixes yum for that.
sed -i s/repo_gpgcheck\=1/repo_gpgcheck\=0/g /etc/yum.conf 
# install rpms using yum
sudo yum -y update
sudo yum -y groupinstall "Development Tools" 
yum -y install epel-release wget
sudo yum -y install libffi-devel python-pip python-devel kernel-devel 
#make sure pip is updated to the latest version
wget -O /usr/local/src/setuptools-36.5.0.zip  https://pypi.python.org/packages/a4/c8/9a7a47f683d54d83f648d37c3e180317f80dc126a304c45dc6663246233a/setuptools-36.5.0.zip
unzip /usr/local/src/setuptools-36.5.0.zip -d /usr/local/src/
yes | pip uninstall setuptools
pip install --upgrade pip
python /usr/local/src/setuptools-36.5.0/easy_install.py -U setuptools
pip install --upgrade pip
pip install -r python-freez2.txt
pip install -r requirements.txt
else
# if neither apt or yum are installed, or there is some other error that doesnt print properly, print the output of the variables. 
echo "neither apt or yum are being used"
echo "apt is $haveapt"
echo "yum is $haveyum"
# finish
fi
