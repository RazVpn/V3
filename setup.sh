#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="RazVpn"
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear

# Version sc
VERSIONSC () {
    VCODE=V3
    IZINVERSION=$(curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | grep $MYIP | awk '{print $6}')
    if [ $VCODE = $IZINVERSION ]; then
    echo -e "\e[32mReady for script installation version 1 (websocket)..\e[0m"
    else
    echo -e "\e[31mYou do not have permission to install script version 3 (websocket)!\e[0m"
    exit 0
fi
}

# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
	VERSIONSC
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
clear
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
rm -f setup.sh
exit 0
fi
clear
echo -e "\e[32mloading...\e[0m"
clear
mkdir /var/lib/premium-script;
default_email=$( curl https://raw.githubusercontent.com/${GitUser}/email/main/default.conf )
clear

#Nama penyedia script
echo -e "\e[1;32m════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   \e[1;32mPlease enter the name of Provider for Script."
read -p "   Name : " nm
echo $nm > /root/provided
echo ""

#Email domain
echo -e "\e[1;32m════════════════════════════════════════════════════════════\e[0m"
echo -e ""
echo -e "   \e[1;32mPlease enter your email Domain/Cloudflare."
echo -e "   \e[1;31m(Press ENTER for default email)\e[0m"
read -p "   Email : " email
default=${default_email}
new_email=$email
if [[ $email == "" ]]; then
sts=$default_email
else
sts=$new_email
fi

# email
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email
echo ""
echo -e "\e[1;32m════════════════════════════════════════════════════════════\e[0m"
echo -e ""
echo -e "   \e[1;32mPlease enter your subdomain "
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/premium-script/ip.conf
echo $host1 > /root/domain
clear
echo -e "\e[0;32mREADY FOR INSTALLATION SCRIPT...\e[0m"
sleep 2

#install ssh ovpn
echo -e "\e[0;32mINSTALLING SSH & OVPN...\e[0m"
sleep 1
wget https://raw.githubusercontent.com/${GitUser}/V3/main/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
echo -e "\e[0;32mDONE INSTALLING SSH & OVPN\e[0m"
clear

#install Xray
echo -e "\e[0;32mINSTALLING XRAY CORE...\e[0m"
sleep 1
wget https://raw.githubusercontent.com/${GitUser}/V3/main/install/ins-xray.sh && chmod +x ins-xray.sh && screen -S ins-xray ./ins-xray.sh
echo -e "\e[0;32mDONE INSTALLING XRAY CORE\e[0m"
clear

#install Trojan GO
echo -e "\e[0;32mINSTALLING TROJAN GO...\e[0m"
sleep 1
wget https://raw.githubusercontent.com/${GitUser}/V3/main/install/trojan-go.sh && chmod +x trojan-go.sh && screen -S trojan-go ./trojan-go.sh
echo -e "\e[0;32mDONE INSTALLING TROJAN GO\e[0m"
clear

#install SET-BR
echo -e "\e[0;32mINSTALLING SET-BR...\e[0m"
sleep 1
wget https://raw.githubusercontent.com/${GitUser}/V3/main/install/set-br.sh && chmod +x set-br.sh && ./set-br.sh
echo -e "\e[0;32mDONE INSTALLING SET-BR...\e[0m"
clear

#install websocket
echo -e "\e[0;32mINSTALLING WEBSOCKET PORT...\e[0m"
wget https://raw.githubusercontent.com/${GitUser}/V3/main/websocket-python/websocket.sh && chmod +x websocket.sh && screen -S websocket.sh ./websocket.sh
echo -e "\e[0;32mDONE INSTALLING WEBSOCKET PORT\e[0m"
clear

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# install clouflare JQ
apt install jq curl -y

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/${GitUser}/V3/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/${GitUser}/V3/main/vps.conf"
/etc/init.d/nginx restart

#finish
rm -f /root/ssh-vpn.sh
rm -f /root/ins-xray.sh
rm -f /root/trojan-go.sh
rm -f /root/set-br.sh
rm -f /root/ohp.sh
rm -f /root/ohp-dropbear.sh
rm -f /root/ohp-ssh.sh
rm -f /root/websocket.sh

# Colour Default
echo "1;33m" > /etc/banner
echo "30m" > /etc/box
echo "1;33m" > /etc/line
echo "1;34m" > /etc/text
echo "1;36m" > /etc/below
echo "47m" > /etc/back
echo "1;37m" > /etc/number
echo 3d > /usr/bin/test

# Version
ver=$( curl https://raw.githubusercontent.com/${GitUser}/version-m/main/ver2.conf )
history -c
echo "$ver" > /home/ver
clear
echo " "
echo "Installation has been completed!!"
echo " "
echo "=========================[ RAZVPN AUTOSCRIPT V1 ]========================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [ INFO PORT ]" | tee -a log-install.txt
echo "    -------------------------" | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - Xray Trojan Tcp Tls     : 443"  | tee -a log-install.txt
echo "   - Xray Vmess Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vless Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vless Tcp Xtls     : 443"  | tee -a log-install.txt
echo "   - Xray Vmess Ws None Tls  : 80"  | tee -a log-install.txt
echo "   - Xray Vless Ws None Tls  : 8080"  | tee -a log-install.txt
echo "   - Trojan Go               : 2083"  | tee -a log-install.txt
echo "   --------------------------"  | tee -a log-install.txt
echo "   [ INFO CLASH FOR ANDROID ( YAML ) ]"  | tee -a log-install.txt
echo "   --------------------------"  | tee -a log-install.txt
echo "   - Xray Vmess Ws Yaml      : Yes"  | tee -a log-install.txt
echo "   --------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Kuala_Lumpur (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +8" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo "-------------------------SCRIPT BY ICHIKAA-----------------------" | tee -a log-install.txt
clear
echo ""
echo ""
echo -e "    \e[1;32m.------------------------------------------.\e[0m"
echo -e "    \e[1;32m|     SUCCESFULLY INSTALLED THE SCRIPT     |\e[0m"
echo -e "    \e[1;32m'------------------------------------------'\e[0m"
echo ""
echo ""
sleep 1
rm -rf setup.sh
read -n 1 -r -s $'Press any key to reboot...\n';reboot
