`timescale 1ns/1ps

module tb;

reg clk1 = 0;
reg clk2 = 0;
reg rst = 1;
reg x = 0;

wire q;


always #5 clk1 = ~clk1;   
always #7 clk2 = ~clk2; 


clock_domain uut (
    .clk1(clk1),
    .clk2(clk2),
    .rst(rst),
    .x(x),
    .q(q)
);


initial begin
    $display("TIME\tclk_src\tclk_dst\tpulse_in\tpulse_out");
    $monitor("%0t\t%b\t%b\t%b\t%b",
              $time, clk1, clk2, x, q);
end


always @(posedge clk2) begin
    if (q)
        $display(" Pulse received at time %0t", $time);
end


initial begin
    $dumpfile("cdc.vcd");
    $dumpvars(0, tb);

  
    #20 rst = 0;

    repeat (10) begin
        #50;         
        x = 1;
        #10;         
        x = 0;
    end

    #200 $finish;
end

endmodule
