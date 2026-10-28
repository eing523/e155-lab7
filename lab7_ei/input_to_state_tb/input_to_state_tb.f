-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/eing/Documents/GitHub/e155-lab7/lab07/workshop/ex1_state_array/input_to_state_tb.sv" 
"C:/Users/eing/Documents/GitHub/e155-lab7/lab07/workshop/ex2_shiftrows/input_to_state.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top input_to_state_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run -all"
