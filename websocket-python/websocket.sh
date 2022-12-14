#!/bin/bash
#websocket
clear
echo Installing Websocket-SSH Python
sleep 1
echo Sila Tunggu Sebentar...
sleep 0.5
cd

#Buat name user github dan nama folder
GitUser="RazVpn"
namafolder="websocket-python"
#wget https://github.com/${GitUser}/main/${namafolder}/

#System Websocket
cd

#System Websocket-Dropbear Service
cd /etc/systemd/system/
wget -O /etc/systemd/system/cdn-dropbear.service https://raw.githubusercontent.com/${GitUser}/V3/main/${namafolder}/cdn-dropbear.service

#Instal WS-SSL
wget -q -O /usr/local/bin/cdn-ssl https://raw.githubusercontent.com/${GitUser}/V3/main/${namafolder}/cdn-ssl.py
chmod +x /usr/local/bin/cdn-ssl

#Install WS-Dropbear
wget -q -O /usr/local/bin/cdn-dropbear https://raw.githubusercontent.com/${GitUser}/V3/main/${namafolder}/cdn-dropbear.py
chmod +x /usr/local/bin/cdn-dropbear

#Enable & Start & Restart ws-stunnel service
systemctl daemon-reload
systemctl enable cdn-ssl
systemctl start cdn-ssl
systemctl restart cdn-ssl

#Enable & Start & Restart ws-ovpn service
systemctl daemon-reload
systemctl enable cdn-ovpn
systemctl start cdn-ovpn
systemctl restart cdn-ovpn

#Enable & Start & Restart ws-dropbear service
systemctl daemon-reload
systemctl enable cdn-dropbear
systemctl start cdn-dropbear
systemctl restart cdn-dropbear
