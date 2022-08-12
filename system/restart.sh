#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="RazVpn"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)

# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
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
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
echo -e "\e[32mloading...\e[0m"
clear
echo -e ""
echo -e "======================================"
echo -e "         \e[0;32mRESTART VPN SERVICE\e[0m"
echo -e "======================================"
echo -e "  \e[0;32m[•1]\e[0m Restart Nginx"
echo -e "  \e[0;32m[•2]\e[0m Restart Xray Core"
echo -e "  \e[0;32m[•3]\e[0m Restart Trojan Go"
echo -e "======================================"
echo -e "   \e[0;32m[x]\e[0m     \e[1;31mMain Menu\e[0m"
echo -e ""
read -p "    Select From Options [1-14 or x] :" Restart
echo -e ""
echo -e "======================================"
sleep 1
clear
case $Restart in
                1)
                clear
                /etc/init.d/nginx restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mNginx Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
                exit
                ;;
				2)
                clear
				systemctl restart xray
				systemctl restart xray@none
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mXray Service Restart\e[0m         "
                echo -e ""
                echo -e "======================================"
                exit
                ;;
				3)
				clear
				systemctl restart trojan-go
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      \e[0;32mAll Trojan Service Restart\e[0m      "
                echo -e ""
                echo -e "======================================"
                exit
                ;;
