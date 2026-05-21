`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2026 22:05:05
// Design Name: 
// Module Name: div_3_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module div3_66_tb;

reg clk;
reg rst;
wire clk_out;

//
// DUT
//
div3_66 dut (
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

//
// Clock Generation
//
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//
// Stimulus
//
initial begin

    rst = 1;

    #20;
    rst = 0;

    #150;

    $finish;
end

//
// Monitor
//
initial begin
    $monitor("TIME=%0t rst=%b clk=%b cnt=%0d clk_out=%b",
              $time, rst, clk, dut.cnt, clk_out);
end

//
// Dump
//
initial begin
    $dumpfile("div3_66.vcd");
    $dumpvars(0, div3_66_tb);
end

endmodule