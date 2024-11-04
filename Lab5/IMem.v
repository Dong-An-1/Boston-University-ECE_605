`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/26 17:12:25
// Design Name: 
// Module Name: IMem
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
`timescale 1ns / 1ns
module Instruction_Memory #(
  parameter BITSIZE = 32,      // Instruction bit width
  parameter REGSIZE = 32       // Register size
)(
  input [REGSIZE-1:0] Address,      // Input address signal
  output reg [BITSIZE-1:0] ReadData1 // Output instruction
);
  
  reg [BITSIZE-1:0] memory_file [0:REGSIZE-1]; // Instruction memory file
  
  // Asynchronous read from memory based on address
  always @(Address, memory_file[Address]) begin
    ReadData1 = memory_file[Address];
  end

  // Declare the integer outside the initial block
  integer i;

  // Instruction memory initialization block
  initial begin
    // Clear the memory
    for (i = 0; i < REGSIZE; i = i + 1) begin
      memory_file[i] = 32'b0;
    end

    // Full instruction set initialization
    memory_file[0]  = 32'h00007033; // and r0, r0, r0 -> r0 = 0
    memory_file[1]  = 32'h00100093; // addi r1, r0, 1 -> r1 = 1
    memory_file[2]  = 32'h00200113; // addi r2, r0, 2 -> r2 = 2
    memory_file[3]  = 32'h00308193; // addi r3, r1, 3 -> r3 = 4
    memory_file[4]  = 32'h00408213; // addi r4, r1, 4 -> r4 = 5
    memory_file[5]  = 32'h00510293; // addi r5, r2, 5 -> r5 = 7
    memory_file[6]  = 32'h00610313; // addi r6, r2, 6 -> r6 = 8
    memory_file[7]  = 32'h00718393; // addi r7, r3, 7 -> r7 = 11
    memory_file[8]  = 32'h00208433; // add r8, r1, r2 -> r8 = 3
    memory_file[9]  = 32'h404404b3; // sub r9, r8, r4 -> r9 = -2
    memory_file[10] = 32'h00317533; // and r10, r2, r3 -> r10 = 0
    memory_file[11] = 32'h0041e5b3; // or r11, r3, r4 -> r11 = 5
    memory_file[12] = 32'h0041a633; // slt r12, r3, r4 -> if r3 < r4 then r12 = 1, else r12 = 0
    memory_file[13] = 32'h007346b3; // nor r13, r6, r7 -> r13 = ~(r6 | r7)
    
    // Using lui + ori to create a 32-bit immediate
    memory_file[14] = 32'h000002b7; // lui r5, 0x2 -> r5 = 0x20000
    memory_file[15] = 32'h00028293; // ori r5, r5, 0x83 -> r5 = 0x20083

    // Test andi and ori instructions
    memory_file[16] = 32'h4d34f713; // andi r14, r9, 0x4D3 -> r14 = r9 & 0x4D3
    memory_file[17] = 32'h8d35e793; // ori r15, r11, 0x8D3 -> r15 = r11 | 0x8D3

    // Test slti instruction
    memory_file[18] = 32'h4d26a813; // slti r16, r13, 0x4D2 -> if r13 < 0x4D2 then r16 = 1, else r16 = 0
    memory_file[19] = 32'h4d244893; // nori r17, r8, 0x4D2 -> r17 = ~(r8 | 0x4D2)
  end

endmodule






