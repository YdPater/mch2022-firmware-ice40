module top(
  input clk_in,
  output [7:0] pmod
  );

  reg [25:0] counter = 0;
  wire clk_1hz;

  slowclock #(.FREQ(1)) clk1 (
    .clk_in(clk_in),
    .clk_slow(clk_1hz)
  );
  

  assign pmod[0] = clk_1hz;

endmodule
