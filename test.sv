import test_var::*;
import render_parameters::*;
import vga_c::*;
import coordinates::*;
import angles::*;
module testing(
    input logic clk,
    input logic rst,
    input logic forward,

    output logic [R-1:0]vga_red,
    output logic [G-1:0]vga_green,
    output logic [B-1:0]vga_blue,

    output logic vga_hsync,
    output logic vga_vsync
);

logic[10:0] count;
logic[10:0] angle;


logic[ANGLEX-1:0] xangle;
logic[ANGLEY-1:ANGLEX] yangle;

logic[CX-1:0] h_count;
logic[CY-1:0] v_count;

logic [TOTAL_LED-1:0] pixel;


always_ff @(posedge clk)begin
    if(rst) begin
        count <= 0;
        xangle <= 0;
    end
    else if(count > 1000000)begin
        count <= 0;
        if(xangle < 180) begin
            xangle <= xangle + 1;
        end
        else begin
            xangle <= 0;
        end
    end
    else begin 
        count <= count + 1;
        xangle <= xangle;
    end

    if(rst)begin
        yangle <= 0;
    end
    else if(xangle == 179)begin
        if(yangle < 271)begin
            yangle <= yangle + 90;
        end
        else begin
            yangle <= 0;
        end
    end
    else begin
        yangle <= yangle;
    end
end



pointrender t1 (POINTA, CAMERA, angle, point[0][TOTAL_SC-1:0]);
pointrender t2 (POINTB, CAMERA, angle, point[1][TOTAL_SC-1:0]);
pointrender t3 (POINTC, CAMERA, angle, point[2][TOTAL_SC-1:0]);
pointrender t4 (POINTD, CAMERA, angle, point[3][TOTAL_SC-1:0]);

surface t5 (clk, point[1:0][TOTAL_SC-1:0], h_count[CX-1:0], v_count[CY-1:0], 12'b111111111111, pixel[TOTAL_LED-1:0]);

vga t6 (clk, pixel[TOTAL_LED-1:0], h_count[CX-1:0], v_count[CY-1:0], vga_red[R-1:0], vga_green[G-1:0], vga_blue[B-1:0], vga_hsync, vga_vsync);


endmodule