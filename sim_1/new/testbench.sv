`timescale 1ns / 1ps

module testbench();


logic [2:0]etaj_cerut;
logic reset, clk_100MHz;
logic [7:0]out;

top top_inst(.*);

initial begin
    clk_100MHz = 0;
    forever
        #1 clk_100MHz = ~clk_100MHz;
end

initial begin
    reset = 1;
    
    #2
    reset = 0;
    etaj_cerut = 3;
    #100
    etaj_cerut = 7;
    #200
    etaj_cerut = 0;
     
end

endmodule
