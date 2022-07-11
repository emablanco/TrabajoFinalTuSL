#!/bin/bash
#---------------LIMPIAR TODAS LAS REGLAS---------------------
iptables -F
iptables -X
iptables -Z
iptables -t nat -F
#---------------POLITICA POR DEFECTO---------------------------
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP 
#--------------PERMITIR RESPUESTA A TODAS LAS SESIONES ESTABLECIDAS------
#PAQUETES QUE LLEGAN AL FIREWALL ESTABLISHED
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
#PAQUES QUE SALEN ESTABLISHED
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
#---------PERMITIR SSH AL FIREWALL -------
iptables -A INPUT -s 192.168.1.4 -p tcp --dport 2222 -j ACCEPT #MI PC
#------------PERMITO SALIDAS DEL FIREWALL POR LOS PUERTOS-------------------
iptables -A OUTPUT -o enp2s0 -p tcp --dport 80 -j ACCEPT #HTTP
iptables -A OUTPUT -o enp2s0 -p tcp --dport 443 -j ACCEPT #HTTPS
iptables -A OUTPUT -o enp2s0 -p tcp --dport 53 -j ACCEPT #DNS
#-----------PERMITO QUE LA RED LAN USE EL SERVIDOR NEXTCLOUD Y EMBY ---------------
iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 8096 -j ACCEPT
