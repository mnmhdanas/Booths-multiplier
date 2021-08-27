
module bitcounter(countdata,decr,ldcount,clk);
     input decr,ldcount,clk;
	 output reg [4:0] countdata;
	 
	 always@(posedge clk)
	   begin
	       if(ldcount)
		      countdata <= 16; //since datain is of 16 bits width
		   else if(decr)
              countdata <= countdata - 1;			
	   end
	   
endmodule
	 