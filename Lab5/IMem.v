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
module Instruction_Memory #(
  parameter BITSIZE = 32,      // 指令位宽
  parameter REGSIZE = 32       // 寄存器大小
)(
  input [REGSIZE-1:0] Address,      // 输入地址信号
  output reg [BITSIZE-1:0] ReadData1 // 输出指令数据
);

  // 指令存储器文件
  reg [BITSIZE-1:0] memory_file [0:REGSIZE-1];

  // 根据地址异步读取存储器内容
  always @(Address, memory_file[Address]) begin
    ReadData1 = memory_file[Address];
  end

  // 在initial块外部声明整数变量
  integer i;

  // 指令存储器初始化块
  initial begin
    // 清空存储器内容
    for (i = 0; i < REGSIZE; i = i + 1) begin
      memory_file[i] = 32'b0;
    end

    // 初始化完整的指令集
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
    memory_file[12] = 32'h0041a633; // slt r12, r3, r4 -> 如果 r3 < r4 则 r12 = 1，否则 r12 = 0
    memory_file[13] = 32'h007346b3; // nor r13, r6, r7 -> r13 = ~(r6 | r7)

    // 使用 lui + ori 组合生成32位立即数
    memory_file[14] = 32'h000002b7; // lui r5, 0x2 -> r5 = 0x20000
    memory_file[15] = 32'h00028293; // ori r5, r5, 0x83 -> r5 = 0x20083

    // 测试 andi 和 ori 指令
    memory_file[16] = 32'h4d34f713; // andi r14, r9, 0x4D3 -> r14 = r9 & 0x4D3
    memory_file[17] = 32'h8d35e793; // ori r15, r11, 0x8D3 -> r15 = r11 | 0x8D3

    // 测试 slti 指令
    memory_file[18] = 32'h4d26a813; // slti r16, r13, 0x4D2 -> 如果 r13 < 0x4D2 则 r16 = 1，否则 r16 = 0
    memory_file[19] = 32'h4d244893; // nori r17, r8, 0x4D2 -> r17 = ~(r8 | 0x4D2)
  end

endmodule






