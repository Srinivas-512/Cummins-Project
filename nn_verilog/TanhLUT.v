`include "fixed_point_def.vh"

module TanhLUT (
  input signed [0:8] inputs,
  output reg signed [0:8] tanh_output
);

  reg [8:0] tanh_table [0:255]; // 256 entries

  // Initialize the tanh lookup table
  integer i;
  initial begin
    for (i = 0; i < 256; i = i + 1) begin
      // Scale to [-4, 4] (adjust based on your specific range)
      tanh_table[i] = $signed($rtoi($tanh($itor((i - 128) * 16) / 64.0)));
    end
  end

  // Assign tanh value based on the input
  always @*
    tanh_output = tanh_table[$rtoi(inputs) + 128];

endmodule

