import vga_c::*;

module vga(
    input logic clk,
    
    input logic [R-1:0] pixelR,
    input logic [G-1:0] pixelG,
    input logic [B-1:0] pixelB,
    
    input logic [CX-1:0] h_count,
    input logic [CY-1:0] v_count,
    
    output logic [R-1:0]vga_red,
    output logic [G-1:0]vga_green,
    output logic [B-1:0]vga_blue,

    output logic vga_hsync,
    output logic vga_vsync
);
//resolution = 640 by 480, 60hz
//clk is 25 Mhz

always_comb begin 
    
    if((h_count > (640 + FRONT_PORCH_H)) && (h_count <= (654 + FRONT_PORCH_H_AND_SYNC)))begin
        vga_hsync = 0;
    end
    else begin
        vga_hsync = 1;
    end

    if((v_count > (480 + FRONT_PORCH_V)) && (v_count <= (480 + FRONT_PORCH_V_AND_SYNC)))begin
        vga_vsync = 0;
    end
    else begin
        vga_vsync = 1;
    end



    if((h_count >= 0) && (h_count < SCW)&&(v_count >= 0) && (v_count < SCH))begin
        vga_red = pixelR [R-1:0];
        vga_green = pixelG [G-1:0];
        vga_blue = pixelB [B-1:0];
    end
    else begin
        vga_red = 0;
        vga_green = 0;
        vga_blue = 0;
    end
end


endmodule