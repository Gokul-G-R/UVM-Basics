/*****************************errors need to be solved **************************/



`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver;

`uvm_component_utils(driver)

function new(string name ="driver",uvm_component parent);
  super.new(name,parent);  
endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info("build_phase","build phase in driver",UVM_LOW);
    
  endfunction  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
    `uvm_info("connect_phase","connect phase in driver",UVM_LOW);
  endfunction 
  
    function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    //uvm_top.print_topology();
      `uvm_info("end_of_elaboration_phase","end_of_elaboration_phas_in driver",UVM_LOW);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("run phase","run phase in driver",UVM_LOW);
    
  endtask
  
endclass



class monitor extends uvm_monitor;

`uvm_component_utils(monitor)

function new(string name ="monitor",uvm_component parent);
  super.new(name,parent);
  
endfunction
  
    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
      `uvm_info("build_phase","build phase in monitor",UVM_LOW);
    
  endfunction
  
    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
      `uvm_info("connect_phase","connect phase in monitor",UVM_LOW);
  endfunction
  
    function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
      `uvm_info("end_of_elaboration_phase","end_of_elaboration_phas_in monitor",UVM_LOW);
  endfunction
  
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
     phase.raise_objection(this);
     `uvm_info("run phase","run phase objectioncalled in monitor",UVM_LOW);
     
     #50;
     
     phase.drop_objection(this);
     `uvm_info("run phase","run phase drop objection called in monitor",UVM_LOW);
     
     
     `uvm_info("run phase","run phase in monitor",UVM_LOW); 
     
  endtask
endclass



class agent extends uvm_agent;

  `uvm_component_utils(agent)
  
  driver drv;
  monitor mon;
  

  function new(string name ="agent",uvm_component parent);
     super.new(name,parent);
   endfunction
  
    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
      `uvm_info("build_phase","build phase in agent",UVM_LOW);
      drv=driver::type_id::create("drv",this);
      mon=monitor::type_id::create("mon",this);
    endfunction
  
    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
      `uvm_info("connect_phase","connect phase in agent",UVM_LOW);
  endfunction 
  
    function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
      `uvm_info("end_of_elaboration_phase","end_of_elaboration_phas_in agent",UVM_LOW);
  endfunction
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
     `uvm_info("run phase","run phase in agent",UVM_LOW);
    
  endtask
endclass




class env extends uvm_env;
  `uvm_component_utils(env)
  
  agent agnth;
  

  function new(string name ="env",uvm_component parent);
  super.new(name,parent);
  
endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info("build_phase","build phase in environment",UVM_LOW);
    agnth=agent::type_id::create("agnth",this);
    
  endfunction
  
    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
      `uvm_info("connect_phase","connect phase in env",UVM_LOW);
  endfunction 
  
  
    function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
      `uvm_info("end_of_elaboration_phase","end_of_elaboration_phas_in env",UVM_LOW);
  endfunction
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
     `uvm_info("run phase","run phase in env",UVM_LOW);
    
  endtask
  
endclass




class test extends uvm_test;

  `uvm_component_utils(test)
  env envh;

  function new(string name ="test",uvm_component parent);
  super.new(name,parent);
  
endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info("build_phase","build phase in test",UVM_LOW);
    
  
    envh=env::type_id::create("envh",this);
  endfunction
  
    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
      `uvm_info("connect_phase","connect phase in test",UVM_LOW);
  endfunction 
  
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
    `uvm_info("end_of_elaboration_phase","end_of_elaboration_phas_in test",UVM_LOW);
  endfunction
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
     `uvm_info("run phase","run phase in test",UVM_LOW);
    
  endtask
  
endclass



module top;
  initial begin 
    run_test("test");
    
    /*The run_test() method is required to call from the static part of the testbench. This will trigger up the UVM testbench. It is usually called in the initial block from the top-level testbench module. The run_test() method call to construct the UVM environment root component and then initiates the UVM phasing mechanism.*/
    
  end
endmodule
  
