module(
    input logic clk,
    input logic rst,
    output logic simclk
);


always_ff @(posedge clk)begin
    if(rst)begin
        simclk <= 1'b0;
    end 
    else begin
        simclk <= !simclk;
    end
end


endmodule