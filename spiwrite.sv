import spi_con::*;
import synchronize::*;
module spiwrite(
    input logic clk,
    input logic rst,

    input logic [COUNTBIT-1:0]count
    input logic [CX-1:0] h_count,
    input logic [CY-1:0] v_count,

    input logic [ADDRESSBITS-1:0] address;


    output logic cs,

    output logic si,
);
//IS62WVS5128GALL-30NLI Datasheet (PDF) based on

assign logic [7:0] read = 8'b00000011;
assign logic [7:0] write = 8'b00000010;


logic reset;




typedef enum logic [3:0] {
    NEXT        = 4'b0000,

    WRITE1RAM   = 4'b0001,

    READRAM     = 4'b0010,

    ADDRESSRAM  = 4'b0011,

    WRITE2RAM   = 4'b0100
} state_t;

state_t state, new_state;

always_ff @(posedge inverse_clk) begin
    if(rst)begin
        state <= 0;
    end
    else begin
        state <= new_state;
    end
end

always_comb begin
    inverse_clk = !clk;

    case(state)
        NEXT: 
        	cs = 1;
            reset = 1;
            si = 0;
            if(v_count > START_HWRITE)begin
                new_state = WRITE1RAM;
            end
            else begin
                new_state = NEXT;
            end
        
        WRITE1RAM:
            cs = 0;
            reset = 0;
            si = write[count];
            if(h_count > OPCODEBITS)begin
                new_state = ADDRESSRAM;
            end
            else begin
                new_state = WRITE1RAM;
            end

        ADDRESSRAM:
            cs = 0;
            reset = 0;
            if(h_count > (OPCODEBITS + ADDRESSBITS))begin
                new_state = ADDRESSRAM;
            end
            else begin
                new_state = WRITERAM;
            end
        
        WRITE1RAM:
            cs = 0;
            reset = 0;
            si = write[count];
            if(h_count > OPCODEBITS)begin
                new_state = ADDRESSRAM;
            end
            else begin
                new_state = WRITE1RAM;
            end
            


    
        default: 
            new_state = 0;
            cs = 1;
    endcase
end



endmodule