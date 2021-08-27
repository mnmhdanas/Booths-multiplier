module dflipflop(data_in,clk,rst,data_out);

input data_in,clk,rst;
output reg data_out;

always@(posedge clk)
   begin
        if(rst)
		   data_out <= 0;
		else 
		   data_out <= data_in;
   end
   
endmodule   