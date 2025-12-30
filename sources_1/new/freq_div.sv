`timescale 1ns / 1ps

module freq_div(
    input logic reset,
    input logic clk_100MHz,
    output logic clk_2Hz
    );

logic [31:0] count, count_max;
assign count_max = 25000000;
// assign count_max = 2; for testbench

always_ff @(posedge clk_100MHz, posedge reset) begin
    if(reset == 1) begin
        clk_2Hz <= 0;
        count <= 0;
    end
    
    else begin
            if(count == count_max - 1) begin
                count <= 0;
                clk_2Hz <= ~clk_2Hz;
            end
        else begin
            count <= count+1;
        end
    end
    
end
endmodule
