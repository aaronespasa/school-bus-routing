# Scholar buses routing problem

# Data
param NumOfNodes;
param EdgesCost{1..NumOfNodes,1..NumOfNodes};
param MaxNumBuses;
param BusMaxCapacity;
param NumOfStops;
param PriceBus;
param Pricekm;

set Brothers;
set GetBrothers{Brothers};
param PossibleFamilyStops{Brothers,1..NumOfStops};

# Sets
set Nodes := 1..NumOfNodes;
set NodesNoParking := 2..NumOfNodes;
set NodesNoEnd := 1..NumOfNodes-1;
set InternalNodes := 2..NumOfNodes-1;
set Edges := {(i,j) in Nodes cross Nodes : i!=j};

set MyStops := 1..NumOfStops;
set Vary := {(i,j) in Brothers cross MyStops };

# Decision Variables
var x{(i,j) in Edges} binary;
var y{(i,j) in Edges} integer, >= 0;
var z{(i,j) in Vary} binary;

# Objective Function
minimize TotalCost: Pricekm * sum{(i,j) in Edges} EdgesCost[i,j]*x[i,j] + PriceBus * sum{i in InternalNodes} x[1,i];

# Constraints
/* s.t. starting_buses: sum{i in InternalNodes} x[1,i] <= MaxNumBuses; */
/* s.t. routes_ending: sum{i in InternalNodes} x[1,i] - sum{i in InternalNodes} x[i,NumOfNodes] = 0; */
s.t. only_one_route_from_node{i in InternalNodes}: sum{j in NodesNoParking : i != j} x[i,j] <= 1;
s.t. all_nodes_visited{j in InternalNodes}: sum{i in NodesNoEnd : i != j} x[i,j] = 1;
/* s.t. avoid_returning{i in InternalNodes, j in InternalNodes : i != j}: x[i,j] + x[j,i] <= 1; */
/* s.t. max_capacity_in_routes_beginning{j in InternalNodes}: y[1,j] - x[1,j]*BusMaxCapacity <= 0; */
s.t. max_capacity_in_routes_ending{i in InternalNodes}: y[i,NumOfNodes] - x[i,NumOfNodes]*BusMaxCapacity <= 0; 
s.t. max_capacity_in_router_internal{i in InternalNodes, j in InternalNodes : i != j}: y[i,j] - x[i,j]*BusMaxCapacity <= 0;

# Constraints taking into account brothers
s.t. max_capacity_in_nodes{j in InternalNodes}: sum{i in NodesNoEnd : i != j} y[i,j] + sum{ i in Brothers} z[i, j-1] * card(GetBrothers[i]) - sum{i in NodesNoParking : i != j} y[j,i] = 0;

s.t. student_stop{j in Brothers}: sum {i in MyStops} z[j, i] * PossibleFamilyStops[j, i] = 1;
s.t. one_stop_student{ j in Brothers}: sum {i in  MyStops} z[j,i] = 1;

# Solve the problem
solve;

printf "\n------------ Output: ------------\n";
printf "Total Cost: %d\n", TotalCost;
printf "Buses used: %d\n", sum{i in InternalNodes} x[1,i];
printf "Kms: %d\n", sum{(i,j) in Edges} EdgesCost[i,j]*x[i,j];

printf "\nDistribution of brothers accross the stops: \n";
for {i in MyStops} {
    printf "Stop %d: ", i;
    for {j in Brothers} {
        printf (if z[j,i] = 1 then j else ""), 1;
        printf (if z[j,i] = 1 then " " else ""), 1;
    }
    printf "\n";
}

printf "\nEdges used: \n";
for {(i,j) in Edges : x[i,j] = 1} {
    printf "Edge ";
    printf (if i = 1 then "Pk -> " else ""), 1;
    printf (if i = 2 then "S1 -> " else ""), 1;
    printf (if i = 3 then "S2 -> " else ""), 1;
    printf (if i = 4 then "S3 -> " else ""), 1;
    printf (if i = 5 then "Cl -> " else ""), 1;
    printf (if j = 1 then "Pk " else ""), 1;
    printf (if j = 2 then "S1 " else ""), 1;
    printf (if j = 3 then "S2 " else ""), 1;
    printf (if j = 4 then "S3 " else ""), 1;
    printf (if j = 5 then "Cl " else ""), 1;
    printf "\n";
}

printf "---------------------------------\n\n";

end;
