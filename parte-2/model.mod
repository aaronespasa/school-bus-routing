# Scholar buses routing problem

# Data
param NumOfNodes;
param EdgesCost{1..NumOfNodes,1..NumOfNodes};
param MaxNumBuses;
param BusMaxCapacity;
param NumOfStops;
param Stops{1..NumOfStops};
param PriceBus;
param Pricekm;


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
var y{(i,j) in Edges} integer, >=0;
var z{(i,j) in Vary} binary;


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



s.t. max_capacity_in_nodes{j in InternalNodes}: sum{i in NodesNoEnd : i != j} y[i,j] + (sum { i in Students}  z[i,j-1]) - sum{i in NodesNoParking : i != j} y[j,i] = 0;
s.t. max_capacity_in_routes_beginning{j in InternalNodes}: y[1,j] - x[1,j]*BusMaxCapacity <= 0;
s.t. max_capacity_in_routes_ending{i in InternalNodes}: y[i,NumOfNodes] - x[i,NumOfNodes]*BusMaxCapacity <= 0; 
s.t. max_capacity_in_router_internal{i in InternalNodes, j in InternalNodes : i != j}: y[i,j] - x[i,j]*BusMaxCapacity <= 0;

s.t. student_stop{ j in  Students}: sum {i in  MyStops} z[j,i]*PossibleStudentsStops[j,i] = 1;
s.t. one_stop_student{ j in Students}: sum {i in  MyStops} z[j,i] = 1;
s.t. one_stop_family{i in Students, k in Students, m in MyStops, j in NumFamilies}: (1-(Families[i,j]-Families[k,j]))*(1-(z[i,m]-z[k,m])) = 1; 
solve;

/* We need to find a way so stops do not need to go trought them if no students on it  */


# Print the edge 0 1
printf "\n------------ Output: ------------\n";
printf "Total Cost: %d\n", TotalCost;

printf "---------------------------------\n\n";

end;
