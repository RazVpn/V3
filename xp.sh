#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="RazVpn"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear

# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/ipv2/main/ip.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/ipv2/main/ip.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi

# XRAY VMESS WS
data=( `cat /usr/local/etc/xray/config.json | grep '^#vms' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vms $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#vms $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
sed -i "/^#vms $user $exp/,/^},{/d" /usr/local/etc/xray/none.json
systemctl disable xray@$user-tls.service
systemctl stop xray@$user-tls.service
systemctl disable xray@$user-none.service
systemctl stop xray@$user-none.service
rm -f "/usr/local/etc/xray/$user-tls.json"
rm -f "/usr/local/etc/xray/$user-none.json"
rm -f "/usr/local/etc/xray/$user-clash-for-android.yaml"
rm -f "/home/vps/public_html/$user-clash-for-android.yaml"
fi
done
systemctl restart xray
systemctl restart xray@none

# XRAY VLESS WS
data=( `cat /usr/local/etc/xray/config.json | grep '^#vls' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vls $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#vls $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
sed -i "/^#vls $user $exp/,/^},{/d" /usr/local/etc/xray/none.json
fi
done
systemctl restart xray
systemctl restart xray@none

# XRAY TROJAN TCP TLS
data=( `cat /usr/local/etc/xray/akunxtr.conf | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/usr/local/etc/xray/akunxtr.conf" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#trx $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
sed -i "/^### $user $exp/d" "/usr/local/etc/xray/akunxtr.conf"
fi
done
systemctl restart xray

# XRAY VLESS XTLS DIRECT
data=( `cat /usr/local/etc/xray/config.json | grep '^#vxtls' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vxtls $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#vxtls $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
fi
done
systemctl restart xray

# TROJAN GO
data=( `cat /etc/trojan-go/akun.conf | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/trojan-go/akun.conf" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i '/^,"'"$user"'"$/d' /etc/trojan-go/config.json
sed -i "/^### $user $exp/d" "/etc/trojan-go/akun.conf"
fi
done
systemctl restart trojan-go
echo -e " "
read -n 1 -s -r -p " Press any key to back on menu"