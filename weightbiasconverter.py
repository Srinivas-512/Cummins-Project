# Python script to convert signed float values to fixed_point_t format, then to hexadecimal, and save in a text file

# INTEGER_BITS = 5
# FRACTIONAL_BITS = 4

# def float_to_fixed_point(value):
#     sign = -1 if value < 0 else 1
#     scaled_value = int(abs(value) * (2 ** FRACTIONAL_BITS))
#     clamped_value = max(-(2 ** (INTEGER_BITS + FRACTIONAL_BITS - 1)), min(sign * scaled_value, (2 ** (INTEGER_BITS + FRACTIONAL_BITS - 1)) - 1))
#     return clamped_value

# def convert_and_save(file_name, output_file_name):
#     with open(file_name, 'r') as f:
#         values_float = [float(value) for value in f.read().split(',')]

#     values_fixed_point = [float_to_fixed_point(value) for value in values_float]
#     values_hex = [hex(value & 0xFF)[2:].zfill(2) for value in values_fixed_point]

#     with open(output_file_name, 'w') as f:
#         f.write(','.join(values_hex) + '\n')

# Convert and save weights_hidden1
# convert_and_save('weightsandbiases/weights_hidden1.txt', 'weightsandbiases/weights_hidden1_hex.txt')

# # Convert and save weights_output
# convert_and_save('weightsandbiases/weights_output.txt', 'weightsandbiases/weights_output_hex.txt')

# # Convert and save biases_hidden1
# convert_and_save('weightsandbiases/biases_hidden1.txt', 'weightsandbiases/biases_hidden1_hex.txt')

# # Convert and save biases_output
# convert_and_save('weightsandbiases/biases_output.txt', 'weightsandbiases/biases_output_hex.txt')

input_file = "nn_verilog/biases_output_hex.txt"
output_file = "nn_verilog/texts/biases_output_hex.txt"

# Read CSV file and write to hex file
with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
    for line in infile:
        hex_values = line.strip().split(',')
        for hex_value in hex_values:
            outfile.write(hex_value + '\n')