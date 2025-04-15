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
echo -e "\t2. Escaneo desde la IP proporcionada hasta 254\n"

# Comprobar si no está vacío
if [ -z "$1" ]; then
    echo -e "\e[38;5;88m[*] Uso: $0 <segmento_ip> (ej: $0 192.168.1)\e[0m"
    exit 1
fi

# Validar formato de segmento de IP
if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    ip_segment=$1
    read -p "> " inputUsuari

    # Opción 1: Escaneo completo
    if [ "$inputUsuari" -eq 1 ]; then
        echo -e "\e[1;35m[*] Buscando hosts activos en $ip_segment.0/24...\e[0m"
        hosts_activos=$(nmap -sn ${ip_segment}.0/24 | grep "Nmap scan report for" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

        for host in $hosts_activos; do
            echo "----------------------------------------"
            echo -e "\e[1;35m[*] Host detectado: $host\e[0m"
            echo -e "\e[1;35m[*] Escaneando puertos más comunes (Top 100)...\e[0m"
            nmap -F $host
            echo -e "----------------------------------------\n"
        done

        echo -e "\e[38;5;82m[*] Escaneo completado.\e[0m"

    # Opción 2: Escaneo desde IP específica
    elif [ "$inputUsuari" -eq 2 ]; then
        read -p "Num de Referencia (ej: 29): " numRef
        echo -e "\e[1;35m[*] Buscando hosts activos en el rango $ip_segment.$numRef-254...\e[0m"

        hosts_activos=$(nmap -sn ${ip_segment}.${numRef}-254 | grep "Nmap scan report for" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

        for host in $hosts_activos; do
            echo "----------------------------------------"
            echo -e "\e[1;35m[*] Host detectado: $host\e[0m"
            echo -e "\e[1;35m[*] Escaneando puertos más comunes (Top 100)...\e[0m"
            nmap -F $host
            echo -e "----------------------------------------\n"
        done

        echo -e "\e[38;5;82m [*] Escaneo completado.\e[0m"

    # ERRORES

    else
        echo -e "\e[38;5;88m[*] Opción no válida (1 o 2).\e[0m"
        exit 1
    fi
else
    echo -e "\e[38;5;88m[*] Segmento de IP no válido. Uso correcto: $0 X.X.X\e[0m"
    exit 1
fi

