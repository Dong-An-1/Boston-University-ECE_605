`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 00:37:40
// Design Name: 
// Module Name: DaMem
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
module Data_Memory (
    input clk,
    input [15:0] mem_access_addr,  // Address input, shared by read and write port
    input [31:0] mem_write_data,   // 32-bit data to write
    input mem_write_en,            // Write enable signal
    input mem_read,                // Read enable signal
    output reg [31:0] mem_read_data // 32-bit data output for read
);

    // Define a 64 x 32-bit memory array, matching register file size recommendation
    reg [31:0] memory [63:0];

    // Initialize memory to zero
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            memory[i] = 32'd0;
        end
    end

    // Write operation (synchronous with clock edge, similar to Register_File)
    always @(posedge clk) begin
        if (mem_write_en) begin
            memory[mem_access_addr[5:0]] <= mem_write_data;
        end
    end

    // Read operation (asynchronous, similar to Register_File)
    always @(*) begin
        if (mem_read) begin
            mem_read_data = memory[mem_access_addr[5:0]];
        end else begin
            mem_read_data = 32'd0;  // Default output when read is not enabled
        end
    end

endmodule


