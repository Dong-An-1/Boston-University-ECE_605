`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 01:03:42
// Design Name: 
// Module Name: ALU
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


`timescale 1ns / 1ps

module ALU (
    input [3:0] opcode,           // 4-bit operation code
    input [31:0] A, B,            // 32-bit inputs
    output reg [31:0] result,     // 32-bit ALU result
    output Zero                   // Zero flag
);

    // Assign Zero flag based on the result
    assign Zero = (result == 32'd0) ? 1'b1 : 1'b0;

    // ALU operations based on opcode
    always @(*) begin
        case (opcode)
            4'b0000: result = A & B;                  // AND
            4'b0001: result = A | B;                  // OR
            4'b0010: result = A ^ B;                  // XOR
            4'b0011: result = $signed(A) >>> B;       // Arithmetic shift right
            4'b0100: result = A << B;                 // Logical shift left
            4'b0101: result = A - B;                  // Subtract
            4'b0110: result = A + B;                  // Add
            4'b0111: result = (A < B) ? 32'd1 : 32'd0; // Set less than (SLT)
            default: result = 32'd0;                  // Default case: result is 0
        endcase
    end

endmodule
