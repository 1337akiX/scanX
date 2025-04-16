# **scanX v.01**

![image](https://github.com/user-attachments/assets/25785869-5bea-4d7d-a65d-c36cb7e020b6)


**ScanX** es una herramienta ligera y automatizada diseñada para facilitar el reconocimiento de red en las primeras fases de análisis. Su propósito es identificar hosts activos dentro de una red y realizar un escaneo rápido de sus 100 puertos más utilizados, dando una visión general del estado de exposición de cada objetivo que se encuentra en la red.

Actualmente, scanX ofrece las siguientes funcionalidades:

- 2 opciones de escaneo diferentes para descubrir los hosts activos en una red.

- Escaneo rápido de los top 100 puertos TCP más comunes.

- Salida limpia y legible para una revisión rápida de resultados.

Esta es solo la versión inicial, pero se planea integrar más características en futuras versiones, como detección de servicios, soporte para rangos personalizados, exportación de resultados y más.

## Instalacion 
Clonar repositorio
``` bash
git clone https://github.com/1337akiX/scanX.git
```
Moverse a la carpeta de scanX
``` bash
cd scanX
```
Darle permiso de ejecucion (si no tiene)
``` bash
chmod +x scanX.sh
```
Ejecutar de manera correcta el script
``` bash
./scanX.sh X.X.X
```
