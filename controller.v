module controller(ldA,clrA,sftA,ldQ,clrQ,sftQ,ldM,clrFF,addsub,start,decr,
                     ldcount,done,clk,q0,qm1,eqz);
					 
    input clk,q0,qm1,start,eqz;
	output  ldA,clrA,sftA,ldQ,clrQ,sftQ,ldM,clrFF,addsub,decr,
                     ldcount,done;

	reg [2:0] state;
    parameter [2:0] S0 = 3'b000,
                    S1 = 3'b001,
					S2 = 3'b010,
					S3 = 3'b011,
					S4 = 3'b100,
					S5 = 3'b101,
					S6 = 3'b110;
					
	always@(posedge clk)
       begin
	        case(state)
			   S0 :  state = start?S1:S0;
			   S1 :  state = S2;
			   S2 :  begin
                     #1
			         if({q0,qm1}==2'b01)
					    state =  S3;
				     else if({q0,qm1}==2'b10)
					    state =  S4;
				     else if(({q0,qm1}==2'b00)||({q0,qm1}==2'b11))	
                        state =  S5;					 
                     end
					 
				S3 :  state =  S5;
				S4 :  state =  S5;
				S5 :  begin
                         #1 
				          if(({q0,qm1}==2'b01) && !eqz)
					         state =  S3;
				          else if(({q0,qm1}==2'b10) && !eqz)
							 state =  S4;
						  else if(eqz)
						     state = S6;    
				      end
				S6 :  state = S6;
				default : state <= S0;
			endcase	
		end	   
				
 
  
    assign ldA     = ((state == S3)||(state == S4))?1:0;
    assign clrA    =  (state == S0)?1:0;
	assign sftA    =  (state == S5)?1:0;
    assign ldQ     =  (state == S2)?1:0;
    assign clrQ    =  (state == S0)?1:0;
	assign sftQ    =  (state == S5)?1:0;
    assign ldM     =  (state == S1)?1:0;
    assign clrFF   =  (state == S0)?1:0;
	assign addsub     =  (state == S3)?1:0;
    
	assign decr    =  (state == S5)?1:0;
	assign ldcount =  (state == S1)?1:0; 
	assign done    =  (state == S6)?1:0;	
    
 
  endmodule
  