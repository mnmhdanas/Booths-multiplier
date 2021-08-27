module boothmultiplier_tb();
  reg [15:0] data_in;
  reg clk,start;
  wire [31:0] result;
  
  boothmultiplier dut(data_in,clk,start,result);
  
  initial
     begin
       clk = 0;
       forever #5 clk = ~clk;
     end
  
   
    
  initial
      begin
        
       
        @(negedge clk) start = 1;
        @(negedge clk) data_in = 10;
        @(negedge clk) data_in = 13;
   
        #500 $finish;
     end
  
    initial
      begin
        $dumpfile("boothmultiplier_tb.vcd");
        $dumpvars;
      
      end
  
endmodule