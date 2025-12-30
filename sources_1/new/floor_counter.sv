`timescale 1ns / 1ps

module floor_counter(
    input logic clk,
    input logic reset,
    input logic sus,
    input logic jos,
    output logic [2:0] etaj_curent
    );
    
always_ff @(posedge clk, posedge reset) begin 
    if(reset) begin
        etaj_curent <= 0;    
    end
    else begin
        if(sus) begin
            etaj_curent <= etaj_curent + 1;
        end
        else begin
            if(jos) begin
                etaj_curent <= etaj_curent - 1;
            end
        end
    end
    
end

endmodule
