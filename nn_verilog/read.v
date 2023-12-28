`include "fixed_point_def.vh"

module WeightBiasLoader(
  input wire start,
  output reg signed [0:8] weights_h1 [0:6][0:127],
  output reg signed [0:8] biases_h1 [0:127],
  output reg signed [0:8] weights_o [0:127][0:2],
  output reg signed [0:8] biases_o [0:2]
);
  reg signed [8:0] weights_h1_flat [0:7*128-1]; // Flatten the 2D array
  reg signed [8:0] biases_h1_old [0:127];
  reg signed [8:0] weights_o_flat [0:128*3-1]; // Flatten the 2D array
  reg signed [8:0] biases_o_old [0:2];

  reg signed [8:0] weights_h1_old [0:6][0:127]; // Original 2D array
  reg signed [8:0] weights_o_old [0:127][0:2];   // Original 2D array

  integer i, j;
  always @(posedge start) begin
    // Load fixed-point weights from file for weights_h1
    $readmemh("texts/weights_hidden1_hex.txt", weights_h1_flat);

    // Flatten the 2D array to a 1D array
    for (i = 0; i < 7; i = i + 1) begin
      for (j = 0; j < 128; j = j + 1) begin
        weights_h1_old[i][j] = weights_h1_flat[i * 128 + j];
      end
    end

    //Reverse the scaling and convert back to [0:8] format for weights_h1
    for (i = 0; i < 7; i = i + 1) begin
      for (j = 0; j < 128; j = j + 1) begin
        weights_h1[i][j] = weights_h1_old[i][j] << 4; // Shift left by FRACTIONAL_BITS
      end
    end

    // Load fixed-point weights from file for weights_o
    $readmemh("texts/weights_output_hex.txt", weights_o_flat);

    // Flatten the 2D array to a 1D array
    for (i = 0; i < 128; i = i + 1) begin
      for (j = 0; j < 3; j = j + 1) begin
        weights_o_old[i][j] = weights_o_flat[i * 3 + j];
      end
    end

    // Reverse the scaling and convert back to [0:8] format for weights_o
   for (i = 0; i < 128; i = i + 1) begin
      for (j = 0; j < 3; j = j + 1) begin
        weights_o[i][j] = weights_o_old[i][j] << 4; // Shift left by FRACTIONAL_BITS
      end
    end

    // Load fixed-point biases from file for biases_h1
    $readmemh("texts/biases_hidden1_hex.txt", biases_h1_old);

    // Reverse the scaling and convert back to [0:8] format for biases_h1
    for (i = 0; i < 128; i = i + 1) begin
      biases_h1[i] = biases_h1_old[i] << 4; // Shift left by FRACTIONAL_BITS
    end

    // Load fixed-point biases from file for biases_o
    $readmemh("texts/biases_output_hex.txt", biases_o_old);

    // Reverse the scaling and convert back to [0:8] format for biases_o
    for (i = 0; i < 3; i = i + 1) begin
      biases_o[i] = biases_o_old[i] << 4; // Shift left by FRACTIONAL_BITS
    end
  end
endmodule

