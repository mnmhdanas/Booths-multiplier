
module boothmultiplier(data_in,clk,start,result);
	
  wire ldA,clrA,sftA,ldQ,clrQ,sftQ,done;
  wire ldM,clrFF,addsub,decr,ldcount;
  input signed [15:0]data_in;
  input start,clk;
  wire qm1,eqz;
    output signed [31:0]result;
  wire [4:0] countdata;
  wire signed [15:0] A,M,Q,Z;   //A->Acc , M->Multiplicand , Q->Multiplier, Z->(A-M,A+M) 
  assign eqz = ~| (countdata);
    assign result = {A,Q};

  shiftreg Acc_A(.data_out(A),
                 .ld_data(Z),
				 .s_in(A[15]),
				 .clk(clk),
				 .ld(ldA),
				 .rst(clrA),
				 .sft(sftA));
  
  
  
  shiftreg Mlpr_Q(.data_out(Q),
                .ld_data(data_in),
				.s_in(A[0]),
				.clk(clk),
				.ld(ldQ),
				.rst(clrQ),
				.sft(sftQ));
				
				
   dflipflop d_ff(.data_in(Q[0]),
                  .clk(clk),
				  .rst(clrFF),
				  .data_out(qm1));
				  
	
    PIPO Mlcd_M(.data_out(M),
                .data_in(data_in),
				.clk(clk),
				.ld(ldM));
				
	ALU  Adsub(.out(Z),
	           .in1(A),
			   .in2(M),
               .addsub(addsub));			
				
    bitcounter counter(.countdata(countdata),
	                   .decr(decr),
					   .ldcount(ldcount),
					   .clk(clk));
    
	controller fsm(.ldA(ldA),
	               .clrA(clrA),
				   .sftA(sftA),
				   .ldQ(ldQ),
				   .clrQ(clrQ),
				   .sftQ(sftQ),
				   .ldM(ldM),
				   .clrFF(clrFF),
                   .addsub(addsub),
				   .start(start),
				   .decr(decr),
				   .ldcount(ldcount),
				   .done(done),
				   .clk(clk),
				   .q0(Q[0]),
				   .qm1(qm1),
				   .eqz(eqz)); 

    endmodule
	