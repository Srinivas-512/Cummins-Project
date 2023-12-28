`include "fixed_point_def.vh"
`include "TanhLUT.v"
`timescale 1 ns / 1 ps

module Output (
 // 7 input numbers
  input signed [0:8] inputs [0:127],   // 128 weights
  input clk,
  input signed [0:8] weights [0:127][0:2],
  input signed [0:8] biases [0:2],
  output reg signed [0:8] outputs [0:2]
);

  reg signed [29:0] partial_sums [0:2];   // 48-bit partial sums

  // Clock cycle 1
    integer i, j;
always @(posedge clk) begin
  for (i = 0; i < 3; i = i + 1) begin
    partial_sums[i] <= 0; // Initialize result for each node

    for (j = 0; j < 128; j = j + 1) begin
      partial_sums[i] = partial_sums[i] + $signed(inputs[j]) * $signed(weights[j][i]);
    end
    partial_sums[i] = partial_sums[i] + $signed(biases[i]);
    outputs[i] = partial_sums[i] >> (9);
  end
end

//   // Clock cycle 2
// always @(posedge clk) begin
//   for (i = 2; i < 3; i = i + 1) begin
//     // results[i] <= 0; // Initialize result for each node

//     for (j = 0; j < 128; j = j + 1) begin
//       partial_sums[i] <= partial_sums[i] + $signed(inputs[j]) * $signed(weights[j][i]);
//     end
//     partial_sums[i] <= partial_sums[i] + $signed(biases[i]);
//     outputs[i] <= partial_sums[i] >> (9); // 18 - INTEGER_BITS - FRACTIONAL_BITS
//   end
// end

endmodule
