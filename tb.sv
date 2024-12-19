module pong_tb;

  `timescale 1ns / 100ps

  // Declare logics
  logic forward;
  logic clk;
  logic rst;
  logic [3:0]vga_red;
  logic [3:0]vga_green;
  logic [3:0]vga_blue;
  logic vga_hsync;
  logic vga_vsync;

  // Test stimulus
  initial begin
    clk = 0;
    rst = 0;
    forward = 0;
    #60 rst = 1;
    #1000 rst = 0;
  end


  // Instantiate the DUT
  testing poging (
    clk,
    rst,
    forward,
    vga_red[3:0],
    vga_green[3:0],
    vga_blue[3:0],
    vga_hsync,
    vga_vsync
    );

  // Clock generation: 50 MHz clock (20 ns period)
  always #10 clk = ~clk;




endmodule
