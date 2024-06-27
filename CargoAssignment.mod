

int NoOfCompt = ...;

range Compartments = 1..NoOfCompt;
float WeightCapacity[Compartments] = ...;
float SpaceCapacity[Compartments] = ...;

int NoOfCargo = ...;

range Cargos = 1..NoOfCargo;
float Weight[Cargos] = ...;
float Volume[Cargos] = ...;
float Profit[Cargos] = ...;

// Xij : portion of the weight of cargo i assigned to compartment j
dvar float+ x[Cargos][Compartments];

//objective function
// it is the sum of the portions of a cargo distributed to each of the compartments * profit from per units of material of that cargo
// get the profit from each of the cargos and sum all
dexpr float z = sum(i in Cargos) (sum(j in Compartments) x[i][j])*Profit[i];
maximize z;

subject to{
  /* 
  from cargo i, the total amount of weight distributed to each of the compartments is less than equal to the weight of the cargo i                                         */
  c1 : forall(i in Cargos){
    		sum(j in Compartments) x[i][j] <= Weight[i];
  }
  
  c2 : forall(j in Compartments){  
  /* 
  			sum total weightage going to compartment j from each of the cargos should be less than equal to WeightCapacity of compartment j                  */
       		sum(i in Cargos) x[i][j] <= WeightCapacity[j];    		
  /*
  			sum total volume accuired by each of the cargo portions for a compartment j is less than equal to Space Capacity of compartment j                            */
       		sum(i in Cargos) x[i][j]*Volume[i] <= SpaceCapacity[j];
  }
}