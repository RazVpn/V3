#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="RazVpn"

#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )
clear

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# USERNAME
rm -f /usr/bin/user
username=$( curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user

# Order ID
rm -f /usr/bin/ver
user=$( curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | grep $MYIP | awk '{print $3}' )
echo "$user" > /usr/bin/ver

# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e

# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear

# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}(Active)${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"

today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/ipv3/main/ipvps.conf | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
echo -e "\e[32mloading...\e[0m"
clear

# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))

# PROVIDED
creditt=$(cat /root/provided)

# TOTAL ACCOUNT CREATE
c_trx=$(grep -c -E "^#trx " "/usr/local/etc/xray/config.json")
c_trgo=$(grep -c -E "^### " "/etc/trojan-go/akun.conf")
c_vms=$(grep -c -E "^#vms " "/usr/local/etc/xray/config.json")
c_vls=$(grep -c -E "^#vls " "/usr/local/etc/xray/config.json")
c_vxtls=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
total_trojan=$(($c_trx + $c_trgo))
total_xray=$(($c_vms + $c_vls + $c_vxtls))

# Used Ram
uram=$( free -m | awk 'NR==2 {print $3}' )
# Free Ram
fram=$( free -m | awk 'NR==2 {print $4}' )

# CPU INFO
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )

# Download
download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
downloadsize=$(($download/1073741824))
# Upload
upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
uploadsize=$(($upload/1073741824))

# BANNER THEMES
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
echo -e "\e[$banner_colour"
figlet -f $ascii "$banner"
echo -e "\e[$text Server-By-$creditt"
echo -e   " \e[$line═══════════════════════════════════════════════════\e[m"
echo -e   "  \e[30m SERVER INFORMATION\e[30m ]\e[1m                       "
echo -e   " \e[$line═══════════════════════════════════════════════════\e[m"
echo -e "  \e[$text Ip Vps/Address              : $IPVPS"
echo -e "  \e[$text Domain Name                 : $domain\e[0m"
echo -e "  \e[$text System Uptime               : $uptime"
echo -e "  \e[$text Isp/Provider Name           : $ISP"
echo -e "  \e[$text City Location               : $CITY"
echo -e "  \e[$text Download                    :  $downloadsize GB "
echo -e "  \e[$text Cpu Usage                   :  $cpu_usage1 %"
echo -e "  \e[$text Cpu Frequency               : $freq MHz"
echo -e "  \e[$text Total Amount Of Ram         :  $tram MB"
echo -e "  \e[$text Used RAM                    :  $uram MB"
echo -e "  \e[$text Free RAM                    :  $fram MB"
echo -e "  \e[$text Upload                      :  $uploadsize GB "
echo -e "  \e[$text Version Name                : Ichikaa (V1)"
echo -e "  \e[$text Certificate Status          : Expired in $certifacate days"
echo -e   " \e[$line═══════════════════════════════════════════════════\e[m"
echo -e   "  \e[30m CLIENT INFORMATION\e[30m ]\e[1m                     "
echo -e   " \e[$line═══════════════════════════════════════════════════\e[m"
echo -e   "  \e[$text Order ID          : $oid"
echo -e   "  \e[$text Client Name       : $username"
echo -e   "  \e[$text Expired Status    : $exp $sts"
echo -e   " \e[$line═══════════════════════════════════════════════════\e[m"
echo -e   "  \e[30m MAIN MENU\e[30m ]\e[1m                               "
echo -e   " \e[$line═══════════════════════════════════════════════════\e[m"
echo -e   "  \e[$number [•1]\e[m \e[$below MENU XRAY VMESS & VLESS\e[m"     
echo -e   "  \e[$number [•2]\e[m \e[$below MENU TROJAN XRAY & GO\e[m"
echo -e   "  \e[$number [•3]\e[m \e[$below MENU SYSTEM\e[m"
echo -e   "  \e[$number [•4]\e[m \e[$below MENU UPDATE\e[m"
echo -e   "  \e[$number [•5]\e[m \e[$below MENU THEMES\e[m"
echo -e   "  \e[$number [•6]\e[m \e[$below CHECK RUNNING\e[m"
echo -e   "  \e[$number [•7]\e[m \e[$below CLEAR LOG VPS\e[m"
echo -e   "  \e[$number [•8]\e[m \e[$below CHANGE PORT\e[m"
echo -e   "  \e[$number [•9]\e[m \e[$below INFO ALL PORT\e[m" 
echo -e   "  \e[$number [10]\e[m \e[$below REBOOT VPS\e[m"
echo -e   " \e[$line═══════════════════════════════════════════════════\e[m"
echo -e   "  \e[$below [Ctrl + C] For exit from main menu\e[m"
echo -e   "\e[$below "
read -p   "   Select From Options [1-10 or x] :  " menu
echo -e   ""
case $menu in
1)
xraay
;;
2)
trojaan
;;
3)
system
;;
4)
update
;;
5)
themes
;;
6)
check-sc
;;
7)
clear-log
;;
8)
change-port
;;
9)
info
;;
10)
reboot
;;
x)
clear
exit
echo  -e "\e[1;31mPlease Type menu For More Option, Thank You\e[0m"
sleep 1
clear
;;
*)
clear
echo  -e "\e[1;31mPlease enter an correct number\e[0m"
sleep 1
menu
;;
esac
