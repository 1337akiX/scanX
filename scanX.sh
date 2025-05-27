#!/bin/bash

echo -ne "\e[1;35m[+] Iniciando scanX "
for i in {1..5}; do
  echo -ne "."
  sleep 0.2
done

echo -e "\e[38;5;93m"
echo "                             ____  ___"
echo "  ______ ____ _____    ____ \\   \/  /"
echo " /  ___// ___\\\\__  \\  /    \\ \\     / "
echo " \\___ \\\\  \___ / __ \\|   |  \\/     \\ "
echo "/____  >\\___  >____  /___|  /___/\\  \\"
echo "     \\/     \\/     \\/     \\/      \\_/"
echo -e "\e[38;5;93m"

echo -e "\e[1;35m  	                   	Bienvenido a scanX 👾 \e[0m"
echo -e "\e[1;35m       	            	       	Autor: akiX \e[0m"
echo "------------------------------------------------"

echo -e "\e[38;5;255mMENU: Selecciona qué tipo de escaneo quieres hacer:"
echo -e "\t1. Escaneo de todos los Hosts (0-254)"
echo -e "\t2. Escaneo profundo de una IP (root)"
echo -e "\t3. Escaneo rapido de una IP, ideal para CTF's (root)"
echo -e "\t4. Escaneo sigiloso de una IP en red INTERNA (root)"
echo -e "\t5. Escaneo sigiloso de una IP en red EXTERNA (root)\n"

# Comprobar si no está vacío
if [ -z "$1" ]; then
  echo -e "\e[38;5;88m[*] Uso: $0 <segmento_ip> (ej: $0 192.168.1.1)\e[0m"
  exit 1
fi

# Validar formato de segmento de IP
if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  ip_segment=$1
  read -p "> " inputUsuari

  # Opción 1: Escaneo completo
  if [ "$inputUsuari" -eq 1 ]; then
    ip_base=$(echo "$ip_segment" | cut -d '.' -f 1-3)
    echo -e "\e[1;35m[*] Buscando hosts activos en $ip_base.0/24...\e[0m"
    nmap -sn ${ip_base}.0/24
    echo -e "\e[38;5;82m[*] Escaneo completado.\e[0m"

  # Opción 2: Escaneo profundo de una IP específica TCP
  elif [ "$inputUsuari" -eq 2 ]; then
    echo -e "\e[1;35m[*] Scaneo profundo de $ip_segment...\e[0m"
    sudo nmap -p- -A -sC -Pn -vvv --script "vuln,auth,discovery,http-enum,ftp-anon,ssh-auth-methods" $ip_segment
    echo -e "\e[38;5;82m [*] Escaneo completado.\e[0m"

  # Opción 3: Escaneo rapido para CTF's
  elif [ "$inputUsuari" -eq 3 ]; then
    echo -e "\e[1;35m[*] Scaneo rapido de $ip_segment...\e[0m"
    sudo nmap -p- -A -sC -Pn -n -vvv -T5 -sS --min-rate 5000 --max-retries 1 --host-timeout 30s --script "vuln,auth,discovery,http-enum,ftp-anon,ssh-auth-methods" $ip_segment
    echo -e "\e[38;5;82m [*] Escaneo completado.\e[0m"

    # Opción 4: Escaneo sigiloso de una IP específica INTERNA
  elif [ "$inputUsuari" -eq 4 ]; then
    echo "Para poder realizar este scaneo, necesitas encontrar un host, con poca actividad, puerto 80 abierto(default) y IPID secuencial (actualmente hay pocos que lo usen) "
    read -p "Ip zombie: " ip_zombie
    echo -e "\e[1;35m[*] Scaneo sigiloso red interna de $ip_segment...\e[0m"
    sudo nmap -p 21,22,23,25,53,80,110,139,143,443,445,3306,3389,8000,8080 -O -sCV -Pn -n -v -T3 --source-port 53 -f -D RND:5 --data-length 20 -sI $ip_zombie --script "firewall-bypass,auth,ftp-anon,ssh-auth-methods" $ip_segment
    echo -e "\e[38;5;82m [*] Escaneo completado.\e[0m"

    # Opción 5: Escaneo sigiloso de una IP específica EXTERNA
  elif [ "$inputUsuari" -eq 5 ]; then
    echo "Para poder realizar este scaneo, necesitas proxychains y tor"
    echo -e "\e[1;35m[*] Scaneo sigiloso red externa de $ip_segment...\e[0m"
    sudo proxychains nmap -sT -T2 -Pn -n -p 21,22,23,25,53,80,110,139,143,443,445,587,993,995,3306,3389,8000,8080 $ip_segment
    echo -e "\e[38;5;82m [*] Escaneo completado.\e[0m"

    # ERRORES

  else
    echo -e "\e[38;5;88m[*] Opción no válida (1-4).\e[0m"
    exit 1
  fi
else
  echo -e "\e[38;5;88m[*] Segmento de IP no válido. Uso correcto: $0 X.X.X.X\e[0m"
  exit 1
fi
