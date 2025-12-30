`timescale 1ns / 1ps

module fsm(
    input logic reset,
    input logic clk,
    input logic [2:0] etaj_cerut,
    input logic [2:0] etaj_curent,
    input logic [1:0] door_cnt_val,
    output logic door_cnt_en,
    output logic sus,
    output logic jos,
    output logic door_status
    );
  
localparam idle = 3'b000;
localparam door_close = 3'b001;
localparam move_down = 3'b010;
localparam move_up = 3'b011;
localparam door_open = 3'b111;

logic [2:0] state, nextstate;
 
always_ff @(posedge clk,  posedge reset) begin
    if(reset) begin
        state <= idle;
    end
    
    else begin
        state <= nextstate;
        $display("state = %b", state);
    end
end

always_comb begin
    nextstate = state;
    
    case(state)
        idle: begin
            if(etaj_curent != etaj_cerut) begin
                nextstate = door_close;
            end
        end
        door_close: begin
            $display("etaj_curent: %0d, etaj_cerut: %0d", etaj_curent, etaj_cerut);
            $display("door_cnt_val = %0d", door_cnt_val);

        if (door_cnt_val == 3) begin
            if (etaj_curent > etaj_cerut) begin
                nextstate = move_down;
                $display("Merg jos");
            end
            else begin
                nextstate = move_up;
                $display("Merg sus");
            end
        end
        end
        move_down: begin
            if(etaj_cerut == etaj_curent - 1) begin
                nextstate = door_open;
            end
        end
        
        move_up: begin
            if(etaj_cerut == etaj_curent + 1) begin
                nextstate = door_open;
            end
        end 
        
        door_open: begin
            if(door_cnt_val == 3) begin
                nextstate = idle;
            end
        end
        
        default:
            nextstate = state;
       
    endcase
    $display("nextstate = %b", nextstate);
end

always_comb begin
    // default values
    door_cnt_en = 0;
    door_status = 0;
    sus = 0;
    jos = 0;
    
    case(state)
        idle: begin
            door_cnt_en = 0;
            sus = 0;
            jos = 0;
        end
        door_close: begin
            door_cnt_en = 1;
            door_status = 0;
        end
        move_down: begin
            jos = 1;
        end
        move_up: begin
            sus = 1;
        end
        door_open: begin
            door_cnt_en = 1;
            door_status = 1;
        end
    endcase
end

endmodule
