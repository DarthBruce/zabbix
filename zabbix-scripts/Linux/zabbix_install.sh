#!/bin/bash

#Reach out to @DarthBruce for any issues.

#Thank you so much @nicol1x for your help

#Enverioments Config 
$ZBX_SRV_HOST=IPv4

# Step 1 = Determines the OS Distribution
# Step 2 = Determines the OS Version ID
# Step 3 = Downloads Zabbix-Agent2 Repository & Installs the Zabbix-Agent2
# Step 4 = Update Zabbix-Agent2 Config, Enable Service to auto start post Boot & Restart Zabbix-Agent2
# Step 5 = Installation Completion Greeting


function editzabbixconf()
{
echo ========================================================================
echo Step 3 = Downloading Zabbix Repository and Installing Zabbix-Agent2
echo !! 3 !! Zabbix-Agent2 Installed
echo ========================================================================

mv /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf.original
cp /etc/zabbix/zabbix_agent2.conf.original /etc/zabbix/zabbix_agent2.conf	
sed -i "s+Server=+Server=$ZBX_SRV_HOST+g" /etc/zabbix/zabbix_agent2.conf
sed -i "s+ServerActive=+ServerActive=$ZBX_SRV_HOST+g" /etc/zabbix/zabbix_agent2.conf
sed -i "s+Hostname=Zabbix server+Hostname=$(hostname -f)+g" /etc/zabbix/zabbix_agent2.conf
sed -i "s+# Timeout=3+Timeout=30+g" /etc/zabbix/zabbix_agent2.conf

echo ========================================================================
echo Step 4 = Working on Zabbix-Agent2 Configuration
echo !! 4 !! Updated Zabbix-Agent2 conf file at /etc/zabbix/zabbix_agent2.conf
echo !! 4 !! Enabled Zabbix-Agent2 Service to Auto Start at Boot Time
echo !! 4 !! Restarted Zabbix-Agent2 post updating conf file
echo ========================================================================
}


function ifexitiszero()
{
if [[ $? == 0 ]];
then editzabbixconf
else echo :-/ Failed at Step 3 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0

fi
}

function rhel9()
{
rpm -Uvh http://repo.zabbix.com/zabbix/6.2/rhel/9/x86_64/zabbix-release-6.2-2.el9.noarch.rpm
yum clean all
yum install zabbix-agent -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function rhel8()
{
rpm -Uvh http://repo.zabbix.com/zabbix/6.2/rhel/8/x86_64/zabbix-release-6.2-1.el8.noarch.rpm
yum clean all
yum install zabbix-agent -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function rhel7()
{
rpm -Uvh http://repo.zabbix.com/zabbix/6.2/rhel/7/x86_64/zabbix-release-6.2-1.el7.noarch.rpm
yum clean all
yum install zabbix-agent -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function rhel6()
{
rpm -Uvh http://repo.zabbix.com/zabbix/6.2/rhel/6/x86_64/zabbix-release-6.2-1.el6.noarch.rpm
yum clean all
yum install zabbix-agent -y
ifexitiszero
chkconfig zabbix-agent2 on
service zabbix-agent2 restart
}

function rhel5()
{
rpm -Uvh http://repo.zabbix.com/zabbix/6.2/rhel/5/x86_64/zabbix-release-6.2-1.el5.noarch.rpm
ifexitiszero
chkconfig zabbix-agent2 on
service zabbix-agent2 restart
}

function ubuntu22()
{
wget http://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bubuntu22.04_all.deb
dpkg -i zabbix-release_6.2-1+ubuntu22.04_all.deb 
apt update
apt install zabbix-agent2 -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function ubuntu20()
{
wget http://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bubuntu20.04_all.deb
dpkg -i zabbix-release_6.2-1+ubuntu20.04_all.deb 
apt update
apt install zabbix-agent2 -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function ubuntu18()
{
wget http://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bubuntu18.04_all.deb
dpkg -i zabbix-release_6.2-1+ubuntu18.04_all.deb
apt update
apt install zabbix-agent2 -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function ubuntu16()
{
wget http://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bubuntu16.04_all.deb
dpkg -i zabbix-release_6.2-1+ubuntu16.04_all.deb
apt update
apt install zabbix-agent2 -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}


function ubuntu14()
{
wget http://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bubuntu14.04_all.deb
dpkg -i zabbix-release_6.2-1+ubuntu14.04_all.deb
apt update
apt install zabbix-agent2 -y
ifexitiszero
update-rc.d zabbix-agent2 enable
service zabbix-agent2 restart
}

function debian10()
{
wget http://repo.zabbix.com/zabbix/6.2/debian/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bdebian10_all.deb
dpkg -i zabbix-release_6.2-1+debian10_all.deb
apt update
apt install zabbix-agent2 -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function debian9()
{
wget http://repo.zabbix.com/zabbix/6.2/debian/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bdebian9_all.deb
dpkg -i zabbix-release_6.2-1+debian9_all.deb
apt update
apt install zabbix-agent2 -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function debian11()
{
wget http://repo.zabbix.com/zabbix/6.2/debian/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bdebian11_all.deb
dpkg -i zabbix-release_6.2-1+debian11_all.deb
apt update
apt install zabbix-agent2 -y
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function suse15()
{
rpm -Uvh --nosignature http://repo.zabbix.com/zabbix/6.2/sles/15/x86_64/zabbix-release-6.2-1.sles15.noarch.rpm
zypper --gpg-auto-import-keys refresh 'Zabbix Official Repository'
zypper -n install zabbix-agent2
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

function suse12()
{
rpm -Uvh --nosignature http://repo.zabbix.com/zabbix/6.2/sles/12/x86_64/zabbix-release-6.2-1.sles12.noarch.rpm
zypper --gpg-auto-import-keys refresh 'Zabbix Official Repository'
zypper -n install zabbix-agent2
ifexitiszero
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2
}

#VERSION ID FUNCTION'S LISTED BELOW

function version_id_red()
{
r=$(cat /etc/redhat-release)
echo  !! 2 !! OS Version determined as $r

if [[ $r == *"9."* ]];     then rhel9
elif [[ $r == *"8."* ]];   then rhel8
elif [[ $r == *"7."* ]];   then rhel7
elif [[ $r == *"6."* ]];   then rhel6
elif [[ $r == *"5."* ]];   then rhel5
else echo :-/ Failed at Step 2 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0
fi
}


function version_id_centos()
{
c1=$(cat /etc/redhat-release)
echo !! 2 !! OS Version determined as $c1

if [[ $c1 == *"9."* ]];     then rhel9
elif [[ $c1 == *"8."* ]];   then rhel8
elif [[ $c1 == *"7."* ]];   then rhel7
elif [[ $c1 == *"6."* ]];   then rhel6
elif [[ $c1 == *"5."* ]];   then rhel5
else echo :-/ Failed at Step 2 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0
fi
}

function version_id_ubuntu()
{
u1=$(cat /etc/*release* | grep VERSION_ID=)
echo !! 2 !! OS Version determined as $u1  #prints os version id like this : VERSION_ID="8.4"

u2=$(echo $u1 | cut -c13- | rev | cut -c2- |rev)
#echo $u2        #prints os version id like this : 8.4

u3=$(echo $u2 | awk '{print int($1)}')
#echo $u3       #prints os version id like this : 8

if [[ $u3 -eq 22 ]];      then ubuntu22
elif [[ $u3 -eq 20 ]];    then ubuntu20
elif [[ $u3 -eq 18 ]];    then ubuntu18
elif [[ $u3 -eq 16 ]];    then ubuntu16
elif [[ $u3 -eq 14 ]];    then ubuntu14
else echo :-/ Failed at Step 2 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0
fi
}


function version_id_debian()
{
d1=$(cat /etc/*release* | grep VERSION_ID=)
echo !! 2 !! OS Version determined as $d1  #prints os version id like this : VERSION_ID="8.4"

d2=$(echo $d1 | cut -c13- | rev | cut -c2- |rev)
#echo $d2        #prints os version id like this : 8.4

d3=$(echo $d2 | awk '{print int($1)}')
#echo $d3       #prints os version id like this : 8

if [[ $d3 -eq 11 ]];     then debian11
elif [[ $d3 -eq 10 ]];    then debian10
elif [[ $d3 -eq 9 ]];    then debian9
else echo :-/ Failed at Step 2 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0
fi
}



function version_id_suse()
{
d1=$(cat /etc/*release* | grep VERSION_ID=)
echo !! 2 !! OS Version determined as $d1  #prints os version id like this : VERSION_ID="8.4"

d2=$(echo $d1 | cut -c13- | rev | cut -c2- |rev)
#echo $d2        #prints os version id like this : 8.4

d3=$(echo $d2 | awk '{print int($1)}')
#echo $d3       #prints os version id like this : 8

if [[ $d3 -eq 15 ]];     then suse15
elif [[ $d3 -eq 12 ]];   then suse12
else echo :-/ Failed at Step 2 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0
fi
}

function version_id_amazon()
{
d1=$(cat /etc/*release* | grep VERSION_ID=)
echo !! 2 !! OS Version determined as $d1  #prints os version id like this : VERSION_ID="8.4"

d2=$(echo $d1 | cut -c13- | rev | cut -c2- |rev)
#echo $d2        #prints os version id like this : 8.4

d3=$(echo $d2 | awk '{print int($1)}')
#echo $d3       #prints os version id like this : 8

if [[ $d3 -eq 2 ]];     then rhel8

else echo :-/ Failed at Step 2 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0
fi
}


#STEP 1 - SCRIPT RUNS FROM BELOW


echo Starting Zabbix-Agent2 Installation Script
echo ========================================================================
echo Step 1 = Determining OS Distribution Type

if [[ $(cat /etc/redhat-release) == *"Red Hat"* ]];
then 	echo !! 1 !!  OS Distribution determined as Red Hat Enterprise Linux
	echo Step 2 = Determining OS Version ID now
	version_id_red

elif [[ $(cat /etc/redhat-release) == *"CentOS"*  ]]
	then echo !! 1 !!  OS Distribution determined as CentOS Linux
	echo Step 2 = Determining OS Version ID now
	version_id_centos

elif [[ $(cat /etc/*release*) == *"Amazon Linux"*  ]]
        then echo !! 1 !!  OS Distribution determined as Amazon Linux
        echo Step 2 = Determining OS Version ID now
        version_id_amazon

elif [[ $(cat /etc/*release*) == *"ubuntu"* ]];
	then echo !! 1 !! OS Distribution determined as Ubuntu Linux
	echo Step 2 = Determining OS Version ID now
        version_id_ubuntu

elif [[ $(cat /etc/*release*) == *"debian"* ]];
	then echo !! 1 !! OS Distribution determined as Debian Linux
	echo Step 2 = Determining OS Version ID now
        version_id_debian

elif [[ $(cat /etc/*release*) == *"SUSE"* ]];
	then echo !! 1 !! OS Distribution determined as SUSE Linux
	echo Step 2 = Determining OS Version ID now
	version_id_suse

else echo :-/ Failed at Step 1 : We"'"re Sorry. This script cannot be used for zabbix-agent2 installation on this machine && exit 0
fi

#STEP 5
echo ========================================================================
echo Congrats. Zabbix-Agent2 Installion is completed successfully.
echo Zabbix-Agent2 is installed, started and enabled to be up post reboot on this machine.
echo You can now add the host $(hostname -f) with IP $(hostname -i) on the Zabbix-Server Front End.
echo Thanks for using DarthBruce zabbix-agent2 installation script.
echo ========================================================================
echo To check zabbix-agent service status, you may run : service zabbix-agent2 status
echo To check zabbix-agent config, you may run : egrep -v '"^#|^$"' /etc/zabbix/zabbix_agent2.conf
echo To check zabbix-agent logs, you may run : tail -f /var/log/zabbix/zabbix_agent2.log
echo ========================================================================
