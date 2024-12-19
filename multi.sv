import coordinates::*;
import angles::*;
import render_parameters::*;

module trig_multi(
    input logic signed [OFFSET_BITS+1:0] a,
    input logic signed [OFFSET_BITS+1:0] b,
    output logic signed [OFFSET_BITS+1:0] answer
);

logic signed [OFFSET_BITS_TWO+1:0] round;

always_comb begin
    round[OFFSET_BITS_TWO+1:0] = a[OFFSET_BITS+1:0] * b[OFFSET_BITS+1:0];
    answer[OFFSET_BITS+1:0] = round[OFFSET_BITS_TWO+1:OFFSET_BITS+1];
end

endmodule


module scale_multi(
    input logic signed [CCX-1:0] a,
    input logic signed [OFFSET_BITS+2:0] b,
    output logic signed [CCX:0] answer
);

logic signed [CCX+OFFSET_BITS:0] shift;

always_comb begin
    shift[CCX+OFFSET_BITS+2:0] = a[CCX-1:0] * b[OFFSET_BITS+2:0];
    
    answer[CCX:0] = shift[CCX+OFFSET_BITS+2:OFFSET_BITS+2];

end

endmodule


module focal_multi(
    input logic signed [CCX:0] a,
    output logic signed [CCX+FOCAL_BITS-1:0] answer
);


always_comb begin
    answer = a * FOCAL;
end

endmodule