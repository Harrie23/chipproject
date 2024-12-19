import vga_c::*;

module vgacount(
    input logic clk,
    input logic rst,

    output logic [CX-1:0] h_count,
    output logic [CY-1:0] v_count

);

always_ff @(posedge clk)begin
    if(h_count < W) begin
        h_count <= h_count + 1;
    end
    else begin
        h_count <= 0;
        if(v_count < H)begin
            v_count <= v_count + 1;
        end
        else begin
            v_count <= 0;
        end
    end
end

endmodule