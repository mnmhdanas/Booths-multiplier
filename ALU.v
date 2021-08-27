
module ALU (out,in1,in2,addsub);

  input addsub ;  // addsub = 1 then addition else subtraction
  input signed[15:0] in1,in2;
  output reg signed[15:0] out;
  
  always@(*)
    begin
      if(addsub)
	      out  = in1 + in2;
      else if(!addsub)
	      out  = in1 - in2;
	end
	
endmodule
	