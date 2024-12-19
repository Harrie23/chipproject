import vga_c::*;
import coordinates::*;

module surface(
    input logic clk,

    input logic [SCX-1:0] pointax,
    input logic [SCY-1:0] pointay,

    input logic [SCX-1:0] pointbx,
    input logic [SCY-1:0] pointby,

    input logic [SCX-1:0] pointcx,
    input logic [SCY-1:0] pointcy,

    input logic [SCX-1:0] pointdx,
    input logic [SCY-1:0] pointdy,


    input logic [CX-1:0] h_count,
    input logic [CY-1:0] v_count,
    input logic [TOTAL_LED-1:0] block,
    output logic [TOTAL_LED-1:0] pixel
);

    
    logic signed [SCX-1:0] x1, x2, x3, x4;
    logic signed [SCY-1:SCX] y1, y2, y3, y4;
    
    logic side1, side2, side3, side4;

    //counterclockwise calculation and offcourse inverted y because of vga
    always_comb begin

        /*side1 = ((((point[1][SCX-1:0] - point[0][SCX-1:0])*(point[0][SCY-1:SCX] - v_count)) - ((point[0][SCY-1:SCX] - point[1][SCY-1:SCX])*(h_count - point[0][SCX-1:0]))) > 0);
        side2 = ((((point[2][SCX-1:0] - point[1][SCX-1:0])*(point[1][SCY-1:SCX] - v_count)) - ((point[1][SCY-1:SCX] - point[2][SCY-1:SCX])*(h_count - point[1][SCX-1:0]))) > 0);
        side3 = ((((point[3][SCX-1:0] - point[2][SCX-1:0])*(point[2][SCY-1:SCX] - v_count)) - ((point[2][SCY-1:SCX] - point[3][SCY-1:SCX])*(h_count - point[2][SCX-1:0]))) > 0);
        side4 = ((((point[0][SCX-1:0] - point[3][SCX-1:0])*(point[3][SCY-1:SCX] - v_count)) - ((point[3][SCY-1:SCX] - point[0][SCY-1:SCX])*(h_count - point[3][SCX-1:0]))) > 0);*/

        x1 = $signed(pointax[SCX-1:0]);
        y1 = $signed(pointay[SCY-1:0]);
        x2 = $signed(pointbx[SCX-1:0]);
        y2 = $signed(pointby[SCY-1:0]);
        x3 = $signed(pointcx[SCX-1:0]);
        y3 = $signed(pointcy[SCY-1:0]);
        x4 = $signed(pointdx[SCX-1:0]);
        y4 = $signed(pointdy[SCY-1:0]);

        side1 = (((x2 - x1) * (y1 - v_count)) - ((y2 - y1) * (h_count - x1))) > 0;
        side2 = (((x3 - x2) * (y2 - v_count)) - ((y3 - y2) * (h_count - x2))) > 0;
        side3 = (((x4 - x3) * (y3 - v_count)) - ((y4 - y3) * (h_count - x3))) > 0;
        side4 = (((x1 - x4) * (y4 - v_count)) - ((y1 - y4) * (h_count - x4))) > 0;

        if(side1 && side2 && side3 && side4)begin
            pixel = block;
        end
        else begin
            pixel = 0;
        end

    end


endmodule