
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
* Conexión a Internet en Bogotá por fibra empresarial ETB 10MB simétrico

SERVIDOR SJR-60-ETB-exp:
* Como SERVIDOR SJR-60-ETB pero
* Refactorizado listado de casos y generación de plantillas



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




