-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/eing/Documents/GitHub/e155-lab7/lab07/workshop/ex2_shiftrows/input_to_state.sv" 
"C:/Users/eing/Documents/GitHub/e155-lab7/lab07/workshop/ex2_shiftrows/shiftrows.sv" 
"C:/Users/eing/Documents/GitHub/e155-lab7/lab07/workshop/ex2_shiftrows/shiftrows_tb.sv" 
"C:/Users/eing/Documents/GitHub/e155-lab7/lab07/workshop/ex2_shiftrows/state_to_output.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top shiftrows_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run -all"
