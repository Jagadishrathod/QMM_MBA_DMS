# Define Sets
set Bricks;
set SalesReps;

# Define parameters
param Distance{Bricks, SalesReps}; # Travel distances
param Workload{Bricks};             # Workload index of each brick
param CurrentAllocation{Bricks, SalesReps};  # Current allocation parameter

# Define the binary decision variables
var NewAllocation{Bricks, SalesReps} binary;
var Disruption >= 0;

# Define the objective function
minimize TotalDistance: 
	sum{i in Bricks, j in SalesReps} Distance[i,j]*NewAllocation[i,j];

# Define constraints
s.t. AssignBricks{i in Bricks}: sum{j in SalesReps} NewAllocation[i,j] = 1;
s.t. Workload1{j in SalesReps}: 0.8<=sum{i in Bricks} Workload[i]*NewAllocation[i,j]<=1.2;
s.t. Disruption1: Disruption = ((sum{i in Bricks, j in SalesReps} Workload[i] * (1-CurrentAllocation[i,j])*NewAllocation[i,j])/(sum{i in Bricks} Workload[i]))*100;
