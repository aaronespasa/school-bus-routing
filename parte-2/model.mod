# Scholar buses routing problem

# Data
param NumOfNodes;
param EdgesCost{1..NumOfNodes,1..NumOfNodes};
param MaxNumBuses;
param BusMaxCapacity;
param NumOfStops;



param NumOfStudents;
param NumOfFamilies; 
param PossibleStudentsStops {1..NumOfStudents,1..NumOfStops};
param Families {1..NumOfStudents,1..NumOfFamilies};


# Sets
set Nodes := 1..NumOfNodes;
set NodesNoParking := 2..NumOfNodes;
set NodesNoEnd := 1..NumOfNodes-1;
set InternalNodes := 2..NumOfNodes-1;
set Edges := {(i,j) in Nodes cross Nodes : i!=j};


set Students := 1..NumOfStudents;
set MyStops := 1..NumOfStops;
set NumFamilies := 1..NumOfFamilies;
set Vary := {(i,j) in Students cross MyStops };



# Decision Variables
var x{(i,j) in Edges} binary;
var y{(i,j) in Vary} binary;


# Objective Function
minimize TotalCost: 5 * sum{(i,j) in Edges} EdgesCost[i,j]*x[i,j] + 120 * sum{i in InternalNodes} x[1,i];

# Constraints
s.t. starting_buses: sum{i in InternalNodes} x[1,i] <= MaxNumBuses;
s.t. min_one_route_active: sum{i in InternalNodes} x[1,i] >= 1;
s.t. routes_ending: sum{i in InternalNodes} x[1,i] - sum{i in InternalNodes} x[i,NumOfNodes] = 0;
s.t. only_one_route_from_node{i in InternalNodes}: sum{j in NodesNoParking : i != j} x[i,j] <= 1;

/* We only want the nodes with students on them to be visited */

s.t. all_nodes_visited{j in InternalNodes}: sum{i in NodesNoEnd : i != j} x[i,j] = 1;


s.t. avoid_returning{i in InternalNodes, j in InternalNodes : i != j}: x[i,j] + x[j,i] <= 1;

/* TWe need to find a way to make things linear, we can not multiply decision variables */
s.t. capacity1: x[1, 2] * (sum{i in Students} y[i,1]) + x[2, 3] * (sum{i in Students} y[i,2]) + x[3, 4] * (sum{i in Students} y[i,3]) <= BusMaxCapacity;
s.t. capacity2: x[1, 4] * (sum{i in Students} y[i,3]) + x[4, 3] * (sum{i in Students} y[i,2]) + x[3, 2] * (sum{i in Students} y[i,1]) <= BusMaxCapacity;
s.t. capacity3: x[1, 4] * (sum{i in Students} y[i,3]) + x[4, 2] * (sum{i in Students} y[i,1]) + x[2, 3] * (sum{i in Students} y[i,2]) <= BusMaxCapacity;
s.t. capacity4: x[1, 2] * (sum{i in Students} y[i,1]) + x[2, 4] * (sum{i in Students} y[i,3]) + x[4, 3] * (sum{i in Students} y[i,2]) <= BusMaxCapacity;
s.t. capacity5: x[1, 3] * (sum{i in Students} y[i,2]) + x[3, 2] * (sum{i in Students} y[i,1]) + x[2, 4] * (sum{i in Students} y[i,3]) <= BusMaxCapacity;
s.t. capacity6: x[1, 3] * (sum{i in Students} y[i,2]) + x[3, 4] * (sum{i in Students} y[i,3]) + x[4, 2] * (sum{i in Students} y[i,1]) <= BusMaxCapacity;


s.t. student_stop{ j in  Students}: sum {i in  MyStops} y[j,i]*PossibleStudentsStops[j,i] = 1;
s.t. one_stop_student{ j in Students}: sum {i in  MyStops} y[j,i] = 1;
s.t. one_stop_family{i in Students, k in Students, m in MyStops, j in NumFamilies}: (1-(Families[i,j]-Families[k,j]))*(1-(y[i,m]-y[k,m])) = 1; 
solve;

/* We need to find a way so stops do not need to go trought them if no students on it  */


# Print the edge 0 1
printf "\n------------ Output: ------------\n";
printf "Total Cost: %d\n", TotalCost;

printf "---------------------------------\n\n";

end;
