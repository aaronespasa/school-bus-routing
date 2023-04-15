# Programación Lineal: Resolución del problema de enrutamiento de buses escolares 🚌👨‍🏫

Este proyecto pretende cumplir dos retos divididos en dos secciones: la Parte 1 y la Parte 2.

### Parte 1 (Calc): 
El primer problema que se plantea es la generación de las rutas que los autobuses deben seguir para recoger a los alumnos en sus paradas y llevarlos al colegio. La figura muestra el problema a resolver. Los autobuses que realizan las rutas salen todas las mañanas del parking. Cada uno de ellos recoge a los alumnos de las paradas correspondientes y los lleva al colegio.
![image](https://user-images.githubusercontent.com/99278460/232197127-842d8818-39e3-4dce-8e53-5832d687506e.png)



La Figura se corresponde con un grafo dirigido bidireccional, donde cada vértice representa una localización diferente: el parking (vértice con autobuses), el colegio (vértice con el edificio) y las distintas paradas. En este caso, hay tres paradas (S1, S2 y S3). El número que se indica en verde en cada parada representa la cantidad de alumnos que cogen el autobús en esa parada. Así, en la parada S1 cogen el autobús 15 alumnos, en la parada S2 lo cogen 5 alumnos, y en la parada S3 lo cogen 10 alumnos.

Los arcos del grafo representan los tramos para llegar de una localización a otra. En ellos se muestran las distancias en km entre las distintas localizaciones. Así, la distancia entre las paradas S2 y S3 es 5 km, la distancia entre la parada S3 y el colegio es 4 km, etc. En la figura solo se muestran los tramos que pueden formar parte de una ruta. Por otro lado, para realizar las rutas se dispone de un máximo de 3 autobuses (en general, el máximo número de autobuses que se puede utilizar es el número de paradas). Todos los autobuses tienen la misma capacidad, que es de 20 personas.

En la Figura 1 también se muestra una posible solución al problema. En esta solución hay dos rutas, representadas por las líneas roja y azul. Una de las rutas (roja) es parking-S3, S3-S2 y S2-colegio; y la otra ruta (azul) es parking-S1, S1-colegio. Cada una de las rutas se realiza por un autobús diferente.

Cualquier solución debe cumplir siempre las siguientes condiciones:

1. A cada parada llega una única ruta.
2. De cada parada sale una única ruta.
3. El número de rutas no puede superar el número de autobuses disponibles.
4. Todas las rutas salen del parking y llegan al colegio. Así, el número de rutas que salen del parking debe coincidir con el número de rutas que llegan al colegio. En el ejemplo, salen dos rutas del parking y estas dos rutas acaban en el colegio.
5. El flujo de alumnos desde la localización X hasta la localización Y (número de alumnos que van desde X hasta Y) no puede superar la capacidad del autobús en caso de que haya una ruta que va de X a Y. Si entre dos localizaciones no hay ruta, el flujo de alumnos entre ellas es cero.
6. El flujo de alumnos que sale de una parada debe ser exactamente el flujo de alumnos que entra en esa parada más el número de alumnos que esperan en ella.

#### El *objetivo* de esta parte será el siguiente: 

La administración del colegio está interesada en determinar las rutas de forma que se minimice el coste que le supone cada día el transporte escolar. Por cada autobús que se utiliza hay un coste fijo de 120 €. Además, a este coste hay que sumarle el coste del kilometraje, que es de 5 €/km. Así, considerando la solución que muestra la Figura 1 (rutas roja y azul) el coste total sería 120 x 2+5 x (8 + 6 + 10 + 5 + 7) = 420 €. Estas rutas representan una solución que no es necesariamente óptima.
#### Nota: La modelización a esta parte podrá encontrarse en el archivo "memoria".

### Parte 2 (Modelo avanzado en GLPK): 

La administración del colegio está considerando redistribuir los alumnos en las paradas para reducir aún más el costo del transporte escolar. Para ello, han determinado las diferentes paradas a las que cada alumno puede acudir, teniendo en cuenta que la distancia entre su casa y la parada asignada no puede ser mayor que un valor específico. De este modo, las restricciones adicionaes son las siguientes: 

1. Los alumnos deben ser distribuidos en paradas de manera que se reduzca el coste.
2. La distancia entre la casa del alumno y la parada a la que va no puede ser mayor que una determinada.
3. La capacidad del autobús es de 4 personas.
4. Los alumnos hermanos deben ir siempre a la misma parada.
5. El número de alumnos en una parada no puede superar la capacidad del autobús.
![image_6483441](https://user-images.githubusercontent.com/99278460/232198787-a2794239-c130-49eb-8fce-f43a0ecd5193.JPG)

#### El *objetivo* de esta parte será el siguiente:
Se mantiene el objetivo de la parte 1 

#### Nota : 
De esta parte resultan dos modelos en Mathprog

## 𝌞 Overview
Este trabajo se compone de tres tareas:
1. LibreOffice Calc: Modelizar un caso concreto y resolverlo en una hoja de cálculo -> ver directorio [parte-1](https://github.com/aaronespasa/school-bus-routing/tree/main/parte-1).
2. GLPK: Modelizar un caso más general y resolverlo utilizando GLPK y Mathprog como lenguaje -> ver directorio [parte-2](https://github.com/aaronespasa/school-bus-routing/tree/main/parte-2).
3. Interpretación de los resultados -> ver archivo **[memoria.pdf](https://github.com/aaronespasa/school-bus-routing/blob/main/memoria.pdf)**.

## 🛠 Getting Started
Clonamos el proyecto utilizando HTTPS y navegamos dentro de este proyecto una vez se clone:
```sh
$ https://github.com/aaronespasa/school-bus-routing.git
$ cd school-bus-routing
```

Tras esto, si queremos ejecutar el código de glpk, podemos utilizar:
```sh
$ glpsol -m parte-1/model.mod -d parte-1/data.dat
```

## Made by Alejandra Galán & Aarón Espasandín
