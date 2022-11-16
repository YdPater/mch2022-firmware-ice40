module top(
  input clk_in,
  output [7:0] pmod,
  output [2:0] rgb
  );

  reg [25:0] counter = 0;
  wire clk_1hz;

  slowclock #(.FREQ(1)) clk1 (
    .clk_in(clk_in),
    .clk_slow(clk_1hz)
  );

  wire red, green, blue;

  assign blue = clk_1hz;
  assign {red, green} = 1'b0;
  
  SB_RGBA_DRV #(
      .CURRENT_MODE("0b1"),       // half current
      .RGB0_CURRENT("0b000011"),  // 4 mA
      .RGB1_CURRENT("0b000011"),  // 4 mA
      .RGB2_CURRENT("0b000011")   // 4 mA
  ) RGBA_DRIVER (
      .CURREN(1'b1),
      .RGBLEDEN(1'b1),
      .RGB1PWM(red),
      .RGB2PWM(blue),
      .RGB0PWM(green),
      .RGB0(rgb[0]),
      .RGB1(rgb[1]),
      .RGB2(rgb[2])
  );

  assign pmod[0] = clk_1hz;

endmodule
