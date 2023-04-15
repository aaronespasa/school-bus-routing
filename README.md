# Linear Programming: Solving the school bus routing problem 🚌👨‍🏫

This project aims to meet two challenges divided into two sections: Part 1 and Part 2.

### Parte 1 (Calc): 
The first problem to be solved is the generation of the routes that buses must follow to pick up students at their stops and take them to school. The figure shows the problem to be solved. The buses that perform the routes leave the parking lot every morning. Each one of them picks up the students from the corresponding stops and takes them to school.
![image](https://user-images.githubusercontent.com/99278460/232197127-842d8818-39e3-4dce-8e53-5832d687506e.png)



The figure corresponds to a bidirectional directed graph, where each vertex represents a different location: the parking lot (vertex with buses), the school (vertex with the building) and the different stops. In this case, there are three stops (S1, S2, and S3). The number shown in green at each stop represents the number of students who take the bus at that stop. Thus, at stop S1, 15 students take the bus, at stop S2, 5 students take it, and at stop S3, 10 students take it.

The arcs of the graph represent the stretches to get from one location to another. The distances in km between the different locations are shown. Thus, the distance between stops S2 and S3 is 5 km, the distance between stop S3 and the school is 4 km, etc. The figure only shows the stretches that can be part of a route. On the other hand, to make the routes, a maximum of 3 buses is available (in general, the maximum number of buses that can be used is the number of stops). All buses have the same capacity, which is 20 people.

Figure 1 also shows a possible solution to the problem. In this solution, there are two routes, represented by the red and blue lines. One of the routes (red) is parking-S3, S3-S2, and S2-school; and the other route (blue) is parking-S1, S1-school. Each route is performed by a different bus.

Any solution must always meet the following conditions:

1. Each stop is reached by a single route.
2. A single route leaves each stop.
3. The number of routes cannot exceed the number of available buses.
4. All routes leave the parking lot and reach the school. Thus, the number of routes that leave the parking lot must match the number of routes that reach the school. In the example, two routes leave the parking lot and these two routes end at the school.
5. The flow of students from location X to location Y (number of students going from X to Y) cannot exceed the capacity of the bus if there is a route going from X to Y. If there is no route between two locations, the flow of students between them is zero.
6. The flow of students leaving a stop must be exactly the flow of students entering that stop plus the number of students waiting there.

#### The objective of this part will be the following:

The school administration is interested in determining routes that minimize the cost of school transportation each day. For each bus used, there is a fixed cost of 120€. In addition, the cost per kilometer is 5€/km. Therefore, considering the solution shown in Figure 1 (red and blue routes), the total cost would be 120 x 2+5 x (8 + 6 + 10 + 5 + 7) = 420€. These routes represent a solution that is not necessarily optimal.

#### Note: The model for this part can be found in the "memoria" file.

### Part 2 (Advanced GLPK Model):

The school administration is considering redistributing students at stops to further reduce the cost of school transportation. To do so, they have determined the different stops that each student can attend, taking into account that the distance between their home and the assigned stop cannot be greater than a specific value. Thus, the additional constraints are as follows:

1. Students must be distributed at stops to reduce the cost.
2. The distance between the student's home and the stop they attend cannot be greater than a certain distance.
3. The bus capacity is 4 people.
4. Siblings must always go to the same stop.
5. The number of students at a stop cannot exceed the bus capacity.
![image_6483441](https://user-images.githubusercontent.com/99278460/232198787-a2794239-c130-49eb-8fce-f43a0ecd5193.JPG)

#### The objective of this part will be the following:
The objective of Part 1 is maintained.

#### Note : 
This part results in two models in Mathprog.

## 𝌞 Overview
Este trabajo se compone de tres tareas:
1. LibreOffice Calc: Model a specific case and solve it in a spreadsheet -> see directory [parte-1].(https://github.com/aaronespasa/school-bus-routing/tree/main/parte-1).
2. GLPK: Model a more general case and solve it using GLPK and Mathprog as the language -> see directory [parte-2].(https://github.com/aaronespasa/school-bus-routing/tree/main/parte-2).
3. Interpretation of results -> see file **[memoria.pdf.](https://github.com/aaronespasa/school-bus-routing/blob/main/memoria.pdf)**.

## 🛠 Getting Started
Clone the project using HTTPS and navigate to the project directory once it is cloned:
```sh
$ https://github.com/aaronespasa/school-bus-routing.git
$ cd school-bus-routing
```

After this, if we want to run the glpk code, we can use:
```sh
$ glpsol -m parte-1/model.mod -d parte-1/data.dat
```

## Made by Alejandra Galán & Aarón Espasandín
