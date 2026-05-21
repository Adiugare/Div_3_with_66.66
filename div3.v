`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2026 22:04:24
// Design Name: 
// Module Name: div3
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

module div3_66 (
    input  clk,
    input  rst,
    output reg clk_out
);

reg [1:0] cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        cnt     <= 0;
        clk_out <= 0;
    end
    else begin

        // Counter
        if (cnt == 2)
            cnt <= 0;
        else
            cnt <= cnt + 1;

        // HIGH for 2 cycles
        if (cnt == 0 || cnt == 1)
            clk_out <= 1'b1;
        else
            clk_out <= 1'b0;
    end
end

endmodule