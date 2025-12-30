`timescale 1ns / 1ps

module top(
    input logic [2:0]etaj_cerut,
    input logic reset,
    input logic clk_100MHz,
    output logic [7:0]out
    );
    
logic clk;
logic sus, jos, door_cnt_en, door_status;
logic [1:0]door_cnt_val;
logic [2:0] etaj_curent;

freq_div freq_div_inst(
    .reset(reset),
    .clk_100MHz(clk_100MHz),
    .clk_2Hz(clk)
);


door_counter door_counter_inst(
    .en(door_cnt_en),
    .reset(reset),
    .clk(clk),
    .out(door_cnt_val)
);

fsm fsm_inst(.*);
floor_counter floor_counter_inst(.*);
decodor_1_hot decodor_1_hot_inst(
    .in(etaj_curent),
    .out(out)
);

endmodule
