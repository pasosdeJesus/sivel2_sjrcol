
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

SERVIDOR SJR-60:
* AMD FX-6100 3315MHz, 6 núcleos
* RAM: 32G
* Disco: 2 discos de 250G (SSD) y 4T
* Plataforma: adJ 6.0, PostgreSQL 9.6.1, ruby 2.4.0p0, RoR 5.1.2, unicorn 5.3.0
* Cortafuegos con adJ 6.0 
* Conexión a Internet en Bogotá por Claro 12MB fibra óptica. 6M de subida.


SERVIDOR SJR-60-ETB:
* Como SERVIDOR SJR-60 pero
* Conexión a Internet en Bogotá por fibra empresarial ETB 10MB bajada y en promedio 4MB subida.

SERVIDOR SJR-60-ETB-exp:
* Como SERVIDOR SJR-60-ETB pero
* Refactorizado listado de casos y generación de plantillas

SERVIDOR SJR-64-ETB:
* AMD Ryzen 5-2600 3.4GHz, 6 núcleos, 12 hilos 
* RAM: 16GB DDR4
* Discos: sd0 IDE 4T /var, /home. sd1 SSD 240G /. sd2 IDE 1T. sd3 Externo 4T /mnt/respaldo.
* Plataforma: adJ 6.4, PostgreSQL 11.2, ruby 2.6.1, RoR 5.2.2, unicorn 5.5.0.1.g6836
* Cortafuegos con adJ 6.3
* Conexión a Internet en Bogotá por ETB 30MB fibra óptica bajada 
  y en promedio 10MB de subida.

SERVIDOR SJR-65-ETB:
* AMD Ryzen 5-2600 3.4GHz, 6 núcleos, 12 hilos 
* RAM: 16GB DDR4
* Discos: sd0 IDE 4T /var, /home. sd1 SSD 240G /. sd2 IDE 1T. sd3 Externo 4T /mnt/respaldo.
* Plataforma: adJ 6.5, PostgreSQL 11.5, ruby 2.6.4, RoR 6.0.0, unicorn 5.5.1
* Cortafuegos con adJ 6.5
* Conexión a Internet en Bogotá por ETB 30MB fibra óptica bajada 
  y en promedio 10MB de subida.



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

CLIENTE V-3:
* Intel CoreI7-4700. 1.9GHz.
* RAM: 8G
* Disco: IDE 500G. SSD 16G
* Plataforma: adJ 6.4, chrome 69
* Conexión a Internet por Comcast 50MB

CLIENTE V-4:
* Intel CoreI7-4700. 1.9GHz.
* RAM: 8G
* Disco: IDE 500G. SSD 16G
* Plataforma: adJ 6.5, chrome 75
* Conexión a Internet por ETB 10MB




## MEDICIONES

### Fecha: 2.Dic.2014. Servidor: SJR-55r42c1. Cliente: V-1
* Autenticar: 6s
* Lista de actividades: 0,7
* Editar una actividad: 0,7
* Lista de casos: 2
* Editar un caso: 4
* Agregar etiqueta y guardar: 2
* Editar de nuevo: 3,3

### Fecha: 10.Feb.2015. Servidor: SJR-55r42. Cliente: V-2
* Autenticar: 3,5
* Lista de actividades: 0,7
* Editar una actividad: 0,8
* Lista de casos: 2,5
* Editar un caso: 3,5
* Agregar etiqueta y guardar: 4,5
* Editar de nuevo: 2,8

### Fecha: 17.Jul.2017. Servidor: SJR-60r. Cliente: C-1
* Autenticar: 0,5
* Lista de actividades: 
* Editar una actividad: 
* Lista de casos: 11
* Editar un caso: 6
* Agregar etiqueta y guardar: 4,5
* Sin modificar presionar validar y guardar: 11
* Botón regresar: 13
* Generar plantilla EMHA para 23 casos (recibidos en 1.Ene.2017 y 31.Ene.2017): (no se pudo medir con inspector), con cronometro: 11s
* Editar de nuevo: 2,8

### Fecha: 24.Jul.2017. Servidor: SJR-60r-ETB. Cliente: C-1
* Autenticar: 0.7
* Lista de actividades: 1.8
* Editar una actividad: 0.3
* Lista de casos: 9.7
* Editar un caso: 2.57
* Agregar etiqueta y guardar: 0.8
* En vista show botón Editar: 3.5
* Quitar etiqueta y guardar: 0.9
* Botón regresar: 9.95
* Filtrar casos entre 1.Ene.2017 y 31.Ene.2017: 8.8
* Generar plantilla EMHA con el filtro anterior: 10.9
* Editar de nuevo: 2.2

### Fecha: 24.Jul.2017. SERVIDOR SJR-60-ETB-exp. Cliente: C-1
* Autenticar: 0.9
* Lista de actividades: 2.5
* Editar una actividad: 1.3
* Lista de casos: 1.9
* Editar un caso: 4.3
* Agregar etiqueta y guardar: 4.5
* En vista show botón Editar: 4
* Quitar etiqueta y guardar: 3.5
* Botón regresar: 1.6
* Filtrar casos entre 1.Ene.2017 y 31.Ene.2017: 0.3
* Generar plantilla EMHA con el filtro anterior: 7.4
* Editar de nuevo: 4.2


### Fecha: 27.Mar.2019. SERVIDOR SJR-64-ETB. Cliente: V-3
* Autenticar: 0.75 (mejora 16%)
* Lista de actividades: 1.9 (mejora 24%)
* Editar una actividad: 0.5 (mejora 61%)
* Lista de casos: 1.3 (mejora 31%)
* Editar un caso: 1.8 (mejora 58%)
* Agregar etiqueta y guardar: 5.4 (empera -20%)
* En vista show botón Editar: 1.6 (mejora 60%)
* Quitar etiqueta y guardar: 5.4 (empeora -54%)
* Botón regresar: 1.3 (mejora 18%)
* Filtrar casos entre 1.Ene.2017 y 31.Ene.2017: 1.2 (empeora -300%)
* Aprox. (cron cronometro externo) generar plantilla EMHA con el filtro anterior:  ~15s (empeora -100%)
* Editar de nuevo un caso: 3.14 (mejora 25%)
promedio


### Fecha: 26.Sep.2019. SERVIDOR SJR-66-ETB. Cliente: V-4
Tras agregar 24 indices y 1 llave foranea

* Autenticar:   0,6 (-100% de mejora)
* Lista de actividades:   1,42 (21,1% de mejora)
* Editar una actividad:   0,6 (33,3%)
* Lista de casos:  1,1 (45%)
* Editar un caso:  1,8 (33,3%)
* Agregar etiqueta y guardar:   3,5 (56,8%)
* En vista show botón Editar:   1,8 (43,8%)
* Quitar etiqueta y guardar:   3,7 (54,3%)
* Botón regresar:   1 28,6
* Filtrar casos entre 1.Ene.2017 y 31.Ene.2017:   1,2 (82,9%)
* Generar plantilla EMHA con el filtro anterior:   1 (92,6%)
* Esperar a que se complete generación  10 (97,7%)
* Editar de nuevo  2 

Promedio mejora   40,8%
