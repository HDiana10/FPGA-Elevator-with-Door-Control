`timescale 1ns / 1ps

module decodor_1_hot(
    input logic [2:0]in,
    output logic [7:0]out
    );
    
assign out = 1 << in;
endmodule
