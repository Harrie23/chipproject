import coordinates::*;
import angles::*;
import render_parameters::*;
import vga_c::*;

module projx_div(
    input logic signed [CCX+FOCAL_BITS-1:0] a,
    input logic signed [CCX:0] b,
    output logic signed [SCX-1:0] answer
);


logic signed [CCX+FOCAL_BITS-1:0] signanswer;


always_comb begin
    signanswer = a / b;
    if(signanswer < 0) begin
        answer = 0;
    end
    else if(signanswer > SCW)begin
        answer = SCW;
    end
    else begin
        answer = signanswer[SCX-1:0];
    end
end

endmodule

import coordinates::*;
import angles::*;
import render_parameters::*;
import vga_c::*;

module projy_div(
    input logic signed [CCX+FOCAL_BITS-1:0] a,
    input logic signed [CCX:0] b,
    output logic signed [SCY-1:0] answer
);

logic signed [CCX+FOCAL_BITS-1:0] signanswer;

always_comb begin
    signanswer = a / b;
    if(signanswer < 0) begin
        answer = 0;
    end
    else if(signanswer > SCH)begin
        answer = SCH;
    end
    else begin
        answer = signanswer[SCY-1:0];
    end
end

endmodule