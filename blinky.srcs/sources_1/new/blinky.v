`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NA
// Engineer: akiss
// 
// Create Date: 12/02/2020 07:36:53 PM
// Design Name: blinky
// Module Name: blinky
// Project Name: blinky
// Target Devices: 
// Tool Versions: 
// Description: blinky using one 31-bit circular shift register
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module blinky(
    input clk,
    output led0_g,
    output led1_g,
    output led2_g,
    output led3_g
    );
    reg [25:0] accum = 0;
    wire pps = (accum == 0);  
    reg [30:0] dareg = 31'b0000000000000100000000010000011;
    
    assign led0_g = dareg[0];
    assign led1_g = dareg[1];
    assign led2_g = dareg[7];
    assign led3_g = dareg[17];

    always @(posedge clk) begin
        accum <= (pps ? 50_000_000 : accum) - 1;
        if (pps) begin
            dareg <= {dareg[29:17], dareg[30], dareg[15:7], dareg[16], dareg[5:1], dareg[6], ~dareg[0]};
        end
    end
endmodule