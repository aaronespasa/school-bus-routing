# Scholar buses routing problem

# Data
param NumOfNodes;
param EdgesCost{1..NumOfNodes,1..NumOfNodes};
param MaxNumBuses;
param BusMaxCapacity;
param NumOfStops;
param Stops{1..NumOfStops};

# Sets
set Nodes := 1..NumOfNodes;
set NodesNoParking := 2..NumOfNodes;
set NodesNoEnd := 1..NumOfNodes-1;
set InternalNodes := 2..NumOfNodes-1;
set Edges := {(i,j) in Nodes cross Nodes : i!=j};

# Decision Variables
var x{(i,j) in Edges} binary;

# Objective Function
minimize TotalCost: 5 * sum{(i,j) in Edges} EdgesCost[i,j]*x[i,j] + 120 * sum{i in InternalNodes} x[1,i];


# Constraints
s.t. starting_buses: sum{i in InternalNodes} x[1,i] <= MaxNumBuses;
s.t. min_one_route_active: sum{i in InternalNodes} x[1,i] >= 1;
s.t. routes_ending: sum{i in InternalNodes} x[1,i] - sum{i in InternalNodes} x[i,NumOfNodes] = 0;
s.t. only_one_route_from_node{i in InternalNodes}: sum{j in NodesNoParking : i != j} x[i,j] <= 1;
s.t. all_nodes_visited{j in InternalNodes}: sum{i in NodesNoEnd : i != j} x[i,j] = 1;
s.t. avoid_returning{i in InternalNodes, j in InternalNodes : i != j}: x[i,j] + x[j,i] <= 1;
s.t. capacity1: x[1, 2] * Stops[1] + x[2, 3] * Stops[2] + x[3, 4] * Stops[3] <= BusMaxCapacity;
s.t. capacity2: x[1, 4] * Stops[3] + x[4, 3] * Stops[2] + x[3, 2] * Stops[1] <= BusMaxCapacity;
s.t. capacity3: x[1, 4] * Stops[3] + x[4, 2] * Stops[1] + x[2, 3] * Stops[2] <= BusMaxCapacity;
s.t. capacity4: x[1, 2] * Stops[1] + x[2, 4] * Stops[3] + x[4, 3] * Stops[2] <= BusMaxCapacity;
s.t. capacity5: x[1, 3] * Stops[2] + x[3, 2] * Stops[1] + x[2, 4] * Stops[3] <= BusMaxCapacity;
s.t. capacity6: x[1, 3] * Stops[2] + x[3, 4] * Stops[3] + x[4, 2] * Stops[1] <= BusMaxCapacity;





# Solve the problem
solve;

# Print the edge 0 1
printf "\n------------ Output: ------------\n";
printf "Total Cost: %d\n", TotalCost;

printf "---------------------------------\n\n";

end;
