# Arquitectura de Computadoras - 2024

## Informe Lab2: Análisis de microarquitecturas

## Integrantes:

- Alumno: Dubois Joaquín
- Alumno: Ramirez Ignacio
- Alumno: Ricci Villarruel Mateo

---

# Introduccion

Presentamos en el siguiente informe los resultados obtenidos de la aplicación del benchmark `daxpy` provista por la catedra, a los procesadores in_order y out_of_order.
La cache de datos de estos procesadores fueron modificados en su tamaño (variando de 8KB a 16KB y 32KB) y cantidad de vías (2, 4 y 8 vías) a lo largo de este ejercicio para realizar métricas sobre sus rendimientos.
Se realizó tambien una optimizacion del benchmark daxpy aplicando tecnicas de mejora de rendimiento como `loop unrolling` de 4 iteraciones, y se aplico a los procesadores in_order y out_of_order de 1 vía y 32KB de cache de datos.

# Ejercicio 1

## Punto A

Se presenta el codigo realizado en assembler ARMv8 en el archivo `daxpy.s` para implementar el benchmark daxpy.

```
daxpy_loop:
        cmp x1, x0    // comparo i con N
        b.ge daxpy_end    // si i >= N

        ldr d1, [x2, x1, LSL #3]
        ldr d2, [x3, x1, LSL #3]    //guardamos X[i] en d1 y Y[i] en d2

        ldr x5, [x10]
        scvtf d0, x5    // convertimos alpha en punto flotante

        fmul d3, d0, d1    // Z[i] = alpha * X[i]
        fadd d3, d3, d2    // Z[i] = Z[i] + Y[i]

        str d3, [x4, x1, LSL #3]    // guardamos Z[i] en x4

        add x1, x1, 1    // sumo 1 a i

        b daxpy_loop
daxpy_end:
```

## Punto B

A continuación proveemos las estadísticas para el procesador in_order de 1 vía con tamaños de cache de 8KB, 16KB y 32KB.

### Estadisticas ejecución para procesador de 1 vía:

`in_order, cache de datos: 32KB Directa (1 vía)`

1. **Número de ciclos(numCycles)**: 239631.0 | 181335.0
2. **Ciclos ociosos(idleCycles)**: 150773.0 | 118586.0
3. **Hits totales en la caché de datos(overallHits)**: 4557.0 | 5494.0
4. **Hits de lectura en la caché de datos(ReadReq.hits)**: 4552.0 | 4305.0

`in_order, cache de datos: 16kb Directa (1 vía)`

1. **Número de ciclos(numCycles)**: 239615.0
2. **Ciclos ociosos(idleCycles)**: 150760.0
3. **Hits totales en la caché de datos(overallHits)**: 4544.0
4. **Hits de lectura en la caché de datos(ReadReq.hits)**: 4539.0

`in_order, cache de datos: 8kb Directa (1 vía)`

1. **Número de ciclos(numCycles)**: 239571.0
2. **Ciclos ociosos(idleCycles)**: 150724.0
3. **Hits totales en la caché de datos(overallHits)**: 4516.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 4511.0

## Punto C

Se proveen las estadísticas para los procesadores in_order con tamaños de cache de 8, 16 y 32KB, de 2, 4 y 8 vías.

## Estadisticas ejecución para procesador de 2 vías:

`in_order, cache de datos: 32KB (2 vías)`

1. **Número de ciclos(numCycles)**: 189022.0
2. **Ciclos ociosos(idleCycles)**: 109520.0
3. **Hits totales en la caché de datos(overallHits)**: 11851.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 10037.0

`in_order, cache de datos: 16kb (2 vías)`

1. **Número de ciclos(numCycles)**: 188742.0
2. **Ciclos ociosos(idleCycles)**: 109125.0
3. **Hits totales en la caché de datos(overallHits)**: 11805.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 9999.0

`in_order, cache de datos: 8kb (2 vías)`

1. **Número de ciclos(numCycles)**: 188835.0
2. **Ciclos ociosos(idleCycles)**: 109053.0
3. **Hits totales en la caché de datos(overallHits)**: 11707.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 9931.0

## Estadisticas ejecución para procesador de 4 vías:

`in_order, cache de datos: 32KB (4 vías)`

1. **Número de ciclos(numCycles)**: 268132.0
2. **Ciclos ociosos(idleCycles)**: 186149.0
3. **Hits totales en la caché de datos(overallHits)**: 14852.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 11781.0

`in_order, cache de datos: 16kb (4 vías)`

1. **Número de ciclos(numCycles)**: 268132.0
2. **Ciclos ociosos(idleCycles)**: 186149.0
3. **Hits totales en la caché de datos(overallHits)**: 14852.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 11781.0

`in_order, cache de datos: 8kb (4 vías)`

1. **Número de ciclos(numCycles)**: 268048.0
2. **Ciclos ociosos(idleCycles)**: 186068.0
3. **Hits totales en la caché de datos(overallHits)**: 14852.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 11781.0

## Estadisticas ejecución para procesador de 8 vías:

`in_order, cache de datos: 32KB (8 vías)`

1. **Número de ciclos(numCycles)**: 268132.0
2. **Ciclos ociosos(idleCycles)**: 186149.0
3. **Hits totales en la caché de datos(overallHits)**: 14852.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 11781.0

`in_order, cache de datos: 16kb (8 vías)`

1. **Número de ciclos(numCycles)**: 268132.0
2. **Ciclos ociosos(idleCycles)**: 186149.0
3. **Hits totales en la caché de datos(overallHits)**: 14852.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 11781.0

`in_order, cache de datos: 8kb (8 vías)`

1. **Número de ciclos(numCycles)**: 268084.0
2. **Ciclos ociosos(idleCycles)**: 186104.0
3. **Hits totales en la caché de datos(overallHits)**: 14852.0
4. **Hits de lectura en la caché de datos (ReadReq.hits)**: 11781.0

---

## Punto D

### Ahora con estos datos podemos hacer los siguientes analisis:

#### Misma cantidad de vías, distinta capacidad

**1 vía**

`Ciclos cache directa`

![Grafico ciclos cache 1 vía](<./graficos/CACHE DIRECTA 1 VIA (ciclos).png>)

No existe ninguna diferencia con respecto a la cantidad de ciclos a medida se agranda el tamaño de la cache.

`Hits cache directa`

![Grafico hits cache 1 vía](<./graficos/CACHE DIRECTA 1 VIA (hits).png>)

No existe ninguna diferencia notable con respecto a la cantidad de hits a medida se agranda el tamaño de la cache.

**2 vías**

`Ciclos cache 2 vías`

![Grafico ciclos cache 2 vías](<./graficos/CACHE INDIRECTA 2 VIAS (ciclos).png>)

No existe ninguna diferencia con respecto a la cantidad de ciclos a medida que se agranda el tamaño de la cache.

`Hits cache 2 vías`

![Grafico hits cache 2 vías](<./graficos/CACHE INDIRECTA 2 VIAS (hits).png>)

No existe ninguna diferencia notable con respecto a la cantidad de hits a medida que se agranda el tamaño de la cache.

**4 vías**

`Ciclos cache 4 vías`

![Grafico ciclos cache 4 vías](<./graficos/CACHE INDIRECTA 4 VIAS (ciclos).png>)

No existe ninguna diferencia con respecto a la cantidad de ciclos a medida que se agranda el tamaño de la cache.

`Hits cache 4 vías`

![Graficos hits cache 4 vías](<./graficos/CACHE INDIRECTA 4 VIAS (hits).png>)

No existe ninguna diferencia notable con respecto a la cantidad de hits a medida que se agranda el tamaño de la cache.

#### Conclusion

Como puede observarse, no se notan diferencias en los ciclos ni en los hits que ocurren en nuestra cache a medida que vamos duplicando su tamaño, suponemos que esto ocurre debido a que como 8KB es memoria suficiente para la ejecucion que le estamos dando a nuestra cache, no tenemos ningun impacto al ir agregando memoria a la dcache.

XXX No es del todo cierto.... 96KB es lo que el programa necesita para nunca tener reemplazos de pagina...  deberian analizar el codigo

_Continuamos con otra vista de los datos_

#### Misma capacidad, distinta cantidad de vías

`Ciclos de cache 32Kb`

![alt text](<./graficos/Memoria cache 32Kb (ciclos).png>)

El comportamiento observado, donde los resultados mejoran con 2 vías pero vuelven a empeorar con 4 y 8 vías, puede deberse al equilibrio entre la disminución de conflictos en la caché y el aumento de la complejidad de acceso.
El uso de 2 vías parece ser un punto balanceado, ya que reduce los conflictos sin añadir latencia en el acceso a la cache.
Al utilizar mas de dos vías en la cache, no obtenemos mejora en el rendimiento, debido a que la complejidad y la latencia empiezan a afectar negativamente.

![alt text](<./graficos/Memoria cache 32Kb (hits).png>)

En este grafico podemos ver, que a medida que la cantidad de vías aumenta, tambien aumenta la cantidad de hits, esto se debe a que cuando se quiere almacenar una address y esta ya existia escribe, en cambio al tener mas vías disponibles, esta se almacena en la siguiente vía disponible, aumentando asi la cantidad de hits.

Esto se puede ver notablemente en el cambio de 1 a 2 vías, sin embargo el cambio de 2 a 4 es menor y de 4 a 8 es nulo. Esto se debe a la cantidad de veces que se usa el mismo address con distinto tag durante la ejecucion de nuestro programa.

#### Conclusion

Como conclusion de todas las muestras tomadas, podemos decir que resulta beneficioso agregar una mayor cantidad de vías antes de agregarle espacio a la memoria cache, particularmente para el caso de nuestro programa, por lo que podemos deducir que durante la ejecucion se hacen acceso sobre una misma direccion pero con distinto tag, es por esto que el beneficio se ve cuando agregamos vías, sin embargo esta mejora tiene un limite y seguir agregando vías seria desperdiciar recursos.
En cambio si nuestro codigo necesitara una mayor cantidad de adress entonces veriamos el beneficio al agregar capacidad a la memoria.

## Punto E

El siguiente codigo corresponde al daxpy optimizado mediante la aplicacion de loop unrolling de 4 iteraciones, pero manteniendo el mismo funcionamiento previo.

```
daxpy_loop:
        cmp x1, x0              // comparo i con N
        b.ge daxpy_end

        // hacemos loop unrolling de 4 indices
        mov x6, x1              // i
        add x7, x1, #1          // i + 1
        add x8, x1, #2          // i + 2
        add x9, x1, #3          // i + 3

        // cargamos X[i], X[i+1], X[i+2], X[i+3]
        ldr d1, [x2, x6, LSL #3]
        ldr d5, [x2, x7, LSL #3]
        ldr d9, [x2, x8, LSL #3]
        ldr d13, [x2, x9, LSL #3]

        // cargamos Y[i], Y[i+1], Y[i+2], Y[i+3]
        ldr d2, [x3, x6, LSL #3]
        ldr d6, [x3, x7, LSL #3]
        ldr d10, [x3, x8, LSL #3]
        ldr d14, [x3, x9, LSL #3]

        ldr x5, [x10]
        scvtf d0, x5// convertimo alpha a punto flotante una vez

        fmul d3, d0, d1// Z[i] = alpha * X[i+1]
        fadd d3, d3, d2// Z[i] = Z[i] + Y[i+1]
        str d3, [x4, x6, LSL #3]// guardamos Z[i] en x4

        fmul d7, d0, d5
        fadd d7, d7, d6
        str d7, [x4, x7, LSL #3]    // guardamos Z[i+1] en x4

        fmul d11, d0, d9
        fadd d11, d11, d10
        str d11, [x4, x8, LSL #3]   // guardamos Z[i+2]

        fmul d15, d0, d13
        fadd d15, d15, d14
        str d15, [x4, x9, LSL #3]   // guardamos Z[i+3]

        add x1, x1, #4              // sumo 4 a i
        b daxpy_loop
daxpy_end:
```

Decidimos utilizar un loop unroling de 4 iteraciones ya que la cantidad de iteraciones a realizar es una potencia de 2 (N=4096)

XXX Falta simular este codigo y un analisis de los resultados

## Punto F

## Analisis de codigo mejorado

#### 1 vía 32Kb

`Comparacion in order con out of order`

### Estadisticas ejecución para procesador:

`in_order, cache de datos: 32KB Directa (1 vía) daxpy optimizado`

1. **Número de ciclos(numCycles)**: 239631.0 -> 181335.0
2. **Ciclos ociosos(idleCycles)**: 150773.0 -> 118586.0
3. **Hits totales en la caché de datos(overallHits)**: 4557.0 -> 5494.0
4. **Hits de lectura en la caché de datos(ReadReq.hits)**: 4552.0 -> 4305.0

`out_of_order, cache de datos: 32KB Directa (1 vía) daxpy optimizado`

1. **Número de ciclos(numCycles)**: 39778.0
2. **Ciclos ociosos(idleCycles)**: 220.0
3. **Hits totales en la caché de datos(overallHits)**: 5912.0
4. **Hits de lectura en la caché de datos(ReadReq.hits)**: 4271.0

![alt text](<./graficos/Comparacion codigo mejorado.png>)

Podemos observar el claro beneficio de utilizar un procesador `out of order` el cual decide el orden de ejecución segun la conveniencia.
A diferencia del procesador `in order` que ejecuta las instrucciones en el orden dado

- **Ciclos totales:** Se reducen la cantidad de ciclos hasta 4 veces.
  Al reordenar las instrucciones, el procesador puede ejecutar aquellas que no tienen dependencias inmediatas, incluso si algunas instrucciones anteriores están bloqueadas esperando datos.
- **Ciclos ociosos:** Los ciclos ociosos son practicamente inexistentes en comparacion al procesador `in order`
  El procesador utiliza sus unidades funcionales de manera más eficiente. Siempre hay instrucciones ejecutándose, lo que minimiza los ciclos en los que el procesador está inactivo.
- **Hits:** Los hits se mantienen casi constantes.
  Aunque el out-of-order es más eficiente en la ejecución, no altera la forma en que los datos son almacenados o accedidos en la memoria caché. Por eso entendemos que el número de hits en la caché no cambia significativamente entre los distintos tipos de procesadores.
