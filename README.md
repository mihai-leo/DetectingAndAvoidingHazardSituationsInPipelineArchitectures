1 Context 
The pipeline design of the MIPS comes with a lot of advantages such as 
instruction level parallelism which increases the throughput, but due to its architecture  
Structural, Data and Control hazards might  appear. 
The purpose  of this unit is to detect and avoid them, resulting in a more reliable 
CPU unit. 
2 Objectives 
The main objective of this project is the VHDL implementation of the unit, as well 
as the creation of a testbench  where the unit will be integrated with the already existing 
MIPS pipeline. 
The hazards that need to be tackled are: 
1 .Structural Hazards: -  
resource dependency -  - 
two instructions need to use the same resource at the same time 
solved by  stealing or implementing asynchronous reads 
1 .Data Hazards: -  
data dependency - - 
an instruction needs data that is not yet available  
solved by  forwarding 
1 .Control Hazards: -  
flow control -  - 
The program control flow is decided before the new target address is 
calculated, mainly in jump and branch instructions  
solved by  branch prediction
