import angles::*;

module trig_add(
    input logic signed [OFFSET_BITS+1:0] a,
    input logic signed [OFFSET_BITS+1:0] b,
    output logic signed [OFFSET_BITS+2:0] answer
);

always_comb begin
    answer = a + b;
end
endmodule