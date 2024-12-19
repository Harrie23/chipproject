import coordinates::*;

module minus_coordinates(
    input logic signed [WCX-1:0] a,
    input logic signed [WCX-1:0] b,
    output logic signed [CCX-1:0] answer
);

always_comb begin

   answer = a - b;
       
end
endmodule

import angles::*;

module trig_minus(
    input logic signed [OFFSET_BITS+1:0] a,
    input logic signed [OFFSET_BITS+1:0] b,
    output logic signed [OFFSET_BITS+1:0] answer
);

always_comb begin
    answer = a - b;
end
endmodule