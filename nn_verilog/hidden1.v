`include "fixed_point_def.vh"
//`include "TanhLUT.v"
`timescale 1 ns / 1 ps

module Hidden1 (
  input [3:0] inputs [0:6],   // 7 input numbers
  input signed [0:8] weights [0:6][0:127],   // 128 weights
  input signed [0:8] biases [0:127],
  input clk,
  output reg signed [0:8] result [0:127]
);

  reg signed [29:0] partial_sums [0:127];   // 48-bit partial sums
  // Clock cycle 1
  integer i, j;
  always @(posedge clk) begin
    for (i = 0; i < 128; i = i + 1) begin
      partial_sums[i] = 0; // Initialize result for each node
      for (j = 0; j < 7; j = j + 1) begin
        partial_sums[i] = partial_sums[i] + $signed(inputs[j]) * $signed(weights[j][i]);
      end
      partial_sums[i] = partial_sums[i] + $signed(biases[i]);
      result[i] = partial_sums[i] >> (9);
    end
  end

//   // Clock cycle 2
// always @(posedge clk) begin
//   for (i = 42; i < 84; i = i + 1) begin
//     // results[i] <= 0; // Initialize result for each node

//     for (j = 0; j < 7; j = j + 1) begin
//       partial_sums[i] <= partial_sums[i] + $signed(inputs[j]) * $signed(weights[j][i]);
//     end
//     partial_sums[i] <= partial_sums[i] + $signed(biases[i]);
//     result[i] <= partial_sums[i] >> (9);
//   end
// end

//   // Clock cycle 3
// always @(posedge clk) begin
//   for (i = 84; i < 126; i = i + 1) begin
//     // results[i] <= 0; // Initialize result for each node

//     for (j = 0; j < 7; j = j + 1) begin
//       partial_sums[i] <= partial_sums[i] + $signed(inputs[j]) * $signed(weights[j][i]);
//     end
//     partial_sums[i] <= partial_sums[i] + $signed(biases[i]);
//     result[i] <= partial_sums[i] >> (9);
//   end
// end

//   // Clock cycle 4
// always @(posedge clk) begin
//   for (i = 126; i < 128; i = i + 1) begin
//     // results[i] <= 0; // Initialize result for each node

//     for (j = 0; j < 7; j = j + 1) begin
//       partial_sums[i] <= partial_sums[i] + $signed(inputs[j]) * $signed(weights[j][i]);
//     end
//     partial_sums[i] <= partial_sums[i] + $signed(biases[i]);
//     result[i] <= partial_sums[i] >> (9); // 18 - INTEGER_BITS - FRACTIONAL_BITS
//   end
// end
  
endmodule
