
`include "uvm_macros.svh"
import uvm_pkg::*;

class base_packet extends uvm_object;
  `uvm_object_utils(base_packet)
  int a,b;
  function new(string name ="base_packet " );
    super.new(name);
  endfunction
  
  function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    base_packet bph;
    
    if(!($cast(bph,rhs)))
      return 0;
    
    return (this.a==bph.a && this.b==bph.b);//propertie we nee d to compare
    //return (this.a==bph.a && this.b==bph.b);   
    /*if we comment it it will return 0 -->make comparision fail */
  endfunction
    
endclass

module top;
  base_packet bph1,bph2;
  
  initial begin 
  bph1=base_packet::type_id::create("bph1");
  bph2=base_packet::type_id::create("bph2");
  
  bph1.a=10;
  bph1.b=20;
    
    
    bph2.a=10;
    bph2.b=30;//fails here
    
    
    if(bph1.compare(bph2))
      $display("comparision success");
    else
      $display("comparision failed");
  end
endmodule
