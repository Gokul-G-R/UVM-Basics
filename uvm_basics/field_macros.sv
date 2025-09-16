`include "uvm_macros.svh"
import uvm_pkg::*;

class packet extends uvm_object;
  rand int data;
  rand reg [3:0] addr;
  rand logic en;
  
  `uvm_object_utils_begin(packet)
  
  `uvm_field_int(data,UVM_ALL_ON)
  `uvm_field_int(addr,UVM_NOCOPY)//doesnot allow to copy the addr
  `uvm_field_int(en,UVM_NOCOMPARE)
  
  `uvm_object_utils_end
  
  function new(string name ="packet");
    super.new(name);
  endfunction
  
  
     function void display(string handle);
       $display("%s the value of data is %d and addr is %d",data,addr,en);
     endfunction
  endclass

module tb ;
  packet p1,p2;
  
  initial 
    begin 
      p1=packet::type_id::create("p1");
      p2=packet::type_id::create("p2");
      
      p1.randomize();
      
      p2.copy(p1);
      
      p1.display("p1");
      p2.display("p2");
      
   
        
    end
endmodule
