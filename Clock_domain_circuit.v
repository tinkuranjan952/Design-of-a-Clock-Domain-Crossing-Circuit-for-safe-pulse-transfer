`timescale 1ns/1ps
module clock_domain(
    input clk1,
    input clk2,
    input rst,
    input x,
    output q);


reg toggle;


reg ff_1,ff_2;


always @(posedge clk1 or posedge rst) begin
    if (rst)
        toggle <= 0;
    else if (x)
        toggle <= ~toggle;   
end


always @(posedge clk2 or posedge rst) begin
    if (rst) begin
        ff_1 <= 0;
        ff_2 <= 0;
    end else begin
        ff_1 <= toggle;
        ff_2 <= ff_1;
    end
end


assign q = ff_1 ^ ff_2;

endmodule
