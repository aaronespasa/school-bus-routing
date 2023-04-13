# Programación Lineal: Resolución del problema de enrutamiento de buses escolares 🚌👨‍🏫
Esta es la primera práctica de la asignatura de Heurística y Optimización de la universidad Carlos III de Madrid.

## 𝌞 Overview
Este trabajo se compone de tres tareas:
1. LibreOffice Calc: Modelizar un caso concreto y resolverlo en una hoja de cálculo -> ver directorio **parte-1**.
2. GLPK: Modelizar un caso más general y resolverlo utilizando GLPK y Mathprog como lenguaje -> ver directorio **parte-2**.
3. Interpretación de los resultados -> ver archivo **memoria.pdf".

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

## Hecho con ❤️ y ☕️ por Aarón Espasandín y Alejandra Galán
