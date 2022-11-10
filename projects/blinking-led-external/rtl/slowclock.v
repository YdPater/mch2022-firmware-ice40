module slowclock #(parameter FREQ=1) (
    input clk_in,
    output clk_slow
);

reg [24:0] counter;

always @(posedge clk_in) begin
      counter <= counter + 1;
      if (counter == 6_000_000/FREQ) begin
          counter <= 0;
          clk_slow <= ~clk_slow;
      end
  end

endmodule