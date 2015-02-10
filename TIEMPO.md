
# EVOLUCION DEL TIEMPO DE RESPUESTA DE SIVeL - SJR Colombia 2.0

Tiempos en segundos.

## ESPECIFICACION DE SERVIDORES

SERVIDOR SJR-55r42c1:
* AMD FX-6100 3315MHz, 6 núcleos
* RAM: 8G
* Disco: 2 discos de 1T
* Plataforma: adJ 5.5, PostgreSQL 9.3.5, ruby 2.1.0, RoR 4.2.0.rc1, unicorn 4.8.3
* Cortafuegos con adJ 5.5 
* Conexión a Internet en Bogotá por Claro 12MB fibra óptica. 6M de subida.

SERVIDOR SJR-55r42:
* AMD FX-6100 3315MHz, 6 núcleos
* RAM: 8G
* Disco: 2 discos de 1T
* Plataforma: adJ 5.5, PostgreSQL 9.3.5, ruby 2.1.0, RoR 4.2.0, unicorn 4.8.3
* Cortafuegos con adJ 5.5 
* Conexión a Internet en Bogotá por Claro 12MB fibra óptica. 6M de subida.

## ESPECIFICACION DE CLIENTES

CLIENTE V-1:
* AMD E-450. 1647.97 MHz
* RAM: 4G
* Disco: 500G
* Plataforma: adJ 5.6pre1, chrome 32
* Conexión a Internet por UNE Inalámbrico 2MB

CLIENTE W-1:
* AMD Athlon 64 X2 Dual Core 5600+. 2813Mhz
* RAM: 1G
* Disco: 1T
* Conexión a servidor directa LAN 100G.
* Plataforma: adJ 5.5, chrome 32

CLIENTE V-2:
* AMD E-450. 1647.97 MHz
* RAM: 4G
* Disco: 500G
* Plataforma: adJ 5.6pre2, chrome 36
* Conexión a Internet por UNE Inalámbrico 2MB


## MEDICIONES

### Fecha: 2.Dic.2014. Servidor: SJR-55r42c1. Cliente: V-1
* Autenticar: 6s
* Lista de actividades: 0,7
* Editar una actividad: 0,7
* Lista de casos: 2
* Editar un caso: 4
* Agregar etiqueta y guardar: 2
* Editar de nuevo: 3,3

### Fecha: 10.Feb.2014. Servidor: SJR-55r42. Cliente: V-2
* Autenticar: 3,5
* Lista de actividades: 0,7
* Editar una actividad: 0,8
* Lista de casos: 2,5
* Editar un caso: 3,5
* Agregar etiqueta y guardar: 4,5
* Editar de nuevo: 2,8

