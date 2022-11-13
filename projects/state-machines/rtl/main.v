module top(
    input clk_in,
    input [7:0] pmod, // pmod[0] connected with pulldown resistor, default HIGH
    output [2:0]rgb
);

wire clk_1hz;
wire red, green, blue;

slowclock #(.FREQ(1)) clk1 (
    .clk_in(clk_in),
    .clk_slow(clk_1hz)
);

reg [1:0] cs, ns;
reg [2:0] temp, leds;


always @* begin
    temp[0] <= (~cs[1] && ~cs[0] && pmod[0]) || (~cs[1] && cs[0] && ~pmod[0]);
    temp[1] <= (~cs[1] && cs[0] && pmod[0]) || (cs[1] && ~cs[0] && ~pmod[0]);
    temp[2] <= (cs[1] && ~cs[0] && pmod[0]) || (cs[1] && cs[0] && ~pmod[0]);
    ns[1] <= (~cs[1] && cs[0] && pmod[0]) || (cs[1] && ~cs[0]) || (cs[1] && ~pmod[0]);
    ns[0] <= (~cs[0] && pmod[0]) || (cs[0] && ~pmod[0]);
end


always @(posedge clk_1hz) begin
    leds <= temp;
    cs <= ns;
end

assign {red, green, blue} = leds;
  
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

endmodule