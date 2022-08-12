#!/bin/bash
red="\e[1;31m"
green="\e[0;32m"
NC="\e[0m"
clear
GitUser="RazVpn"
# VPS Information
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    clear
	  lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
		lan_net="eth0"
    typevps="KVM"
    sleep 1
fi
MYIP=$(wget -qO- icanhazip.com);
echo -e "\e[32mloading...\e[0m"
clear
echo -e ""
echo -e "              \e[0;32m[\e[1;36mSYSTEM STATUS INFORMATION\e[0;32m]\e[0m"
echo -e "             \e[0;34m=============================\e[0m"

echo -e ""
echo -e "\e[1;33mSTATUS XRAY:\e[0m"
echo -e "\e[0;34m-------------\e[0m"
status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vmess Ws Tls       : "$green"running"$NC" ✓"
else
echo -e " Xray Vmess Ws Tls       : "$red"not running (Error)"$NC" "
fi
status="$(systemctl show xray@none.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vmess Ws None Tls  : "$green"running"$NC" ✓"
else
echo -e " Xray Vmess Ws None Tls  : "$red"not running (Error)"$NC" "
fi
status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless Ws Tls       : "$green"running"$NC" ✓"
else
echo -e " Xray Vless Ws Tls       : "$red"not running (Error)"$NC" "
fi
status="$(systemctl show xray@none.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless Ws None Tls  : "$green"running"$NC" ✓"
else
echo -e " Xray Vless Ws None Tls  : "$red"not running (Error)"$NC" "
fi
status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless Tcp Xtls     : "$green"running"$NC" ✓"
else
echo -e " Xray Vless Tcp Xtls     : "$red"not running (Error)"$NC" "
fi
echo -e ""
echo -e "\e[1;33mSTATUS TROJAN GO:\e[0m"
echo -e "\e[0;34m-----------------\e[0m"
status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Trojan Tcp         : "$green"running"$NC" ✓"
else
echo -e " Xray Trojan Tcp         : "$red"not running (Error)"$NC" "
fi
status="$(systemctl show trojan-go.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Trojan Go               : "$green"running"$NC" ✓"
else
echo -e " Trojan Go               : "$red"not running (Error)"$NC" "
fi
echo -e ""
echo -e "\e[1;33mSTATUS NGIX:\e[0m"
echo -e "\e[0;34m--------------------\e[0m"
status="$(systemctl show nginx.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Nginx                   : "$green"running"$NC" ✓"
else
echo -e " Nginx                   : "$red"not running (Error)"$NC" "
fi
echo -e "\e[0;34m-----------------------------------------------------------\e[0m"
echo -e ""
echo -e "${green}JIKA TERDAPAT NOT RUNNING, PLEASE REPORT TO ADMIN FOR FIX$NC"
echo -e "${green}Report to Ichikaa @Ichikaa1$NC"
