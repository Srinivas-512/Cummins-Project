`include "fixed_point_def.vh"
//`include "TanhLUT.v" 
`include "hidden1.v" 
`include "output_layer.v"
`include "read.v"

`timescale 1 ns / 1 ps
module Testbench;

  // Inputs
  reg clk;
  reg rst;  
  reg start;
  reg [3:0] inputs [0:6];
  // Outputs
  wire signed [0:8] outputs [0:2];
  
  wire signed [0:8] weights_h1 [0:6][0:127];
  wire signed [0:8] biases_h1 [0:127];
  wire signed [0:8] weights_o [0:127][0:2];
  wire signed [0:8] biases_o [0:2];
  wire signed [0:8] hidden1_outputs [0:127];
  wire signed [0:8] final_outputs [0:2];
  
  WeightBiasLoader uut_weight_bias_loader (
  .start(start),
  .weights_h1(weights_h1),
  .biases_h1(biases_h1),
  .weights_o(weights_o),
  .biases_o(biases_o)
);
  
  initial begin
    start = 0;
    #5 start = 1;
    #100;
  end
  
  Hidden1 uut_hidden1 (
    .inputs(inputs),
    .weights(weights_h1),
    .biases(biases_h1),
    .clk(clk),
    .result(hidden1_outputs)
  );
  
  initial begin 
  	clk = 0;
  	#5 clk = 1;
  	# 1000;
  end
  
  Output uut_output (
    .inputs(hidden1_outputs),
    .weights(weights_o),
    .biases(biases_o),
    .clk(clk),
    .outputs(final_outputs)
  );

  // Initial stimulus
  integer i, j;
  initial begin
  	  start = 0;
  	  #5 start = 1;
  	  clk = 0;
	  for (i = 0; i <= 6; i = i + 1) begin
	    for (j = 0; j <= 3; j = j + 1) begin
	      inputs[i][j] = 4'b1010;  // Assign the desired 4-bit value here
	    end
	  end
	  #1000;
    		  $display("mem[%0d] = %h", 0, final_outputs[0]);
	  $finish;
  end

  // Clock generation
  always
  	#5 clk = !clk;

endmodule

