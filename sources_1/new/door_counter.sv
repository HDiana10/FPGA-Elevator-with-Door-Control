`timescale 1ns / 1ps

module door_counter(
    input logic en,
    input logic reset,
    input logic clk,
    output logic [1:0]out
    );

always_ff @(posedge clk, posedge reset) begin
    if(reset) begin
        out <= 0;
    end
    
    else begin
        if(en) begin
            out <= out+1;
        end
        else begin
            out <= 0;
        end
    end
end

endmodule
