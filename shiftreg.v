

module shiftreg(data_out,ld_data,s_in,clk,ld,rst,sft);   //SIPO

input [15:0] ld_data;
input clk,rst,ld,s_in,sft;
output reg [15:0]data_out;

always@(posedge clk)
 begin
    if(rst)
	    data_out <= 0;
	else if(ld)
        data_out <= ld_data;
    else if(sft)
        data_out <= {s_in,data_out[15:1]};	
 end
 
 endmodule

 