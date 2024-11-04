`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/28 20:33:38
// Design Name: 
// Module Name: Register_File
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

module Register_File(ReadSelect1, ReadSelect2, WriteSelect, WriteData, WriteEnable, ReadData1, ReadData2, clk, rst);

    parameter BITSIZE = 32;
    parameter REGSIZE = 32;
    input [$clog2(REGSIZE)-1:0] ReadSelect1, ReadSelect2, WriteSelect; // 读选择1、读选择2和写选择
    input [BITSIZE-1:0] WriteData;                                     // 写入数据
    input WriteEnable;                                                 // 写使能信号
    output reg [BITSIZE-1:0] ReadData1, ReadData2;                     // 输出的读数据1和读数据2
    input clk, rst;                                                    // 时钟和复位信号

    reg [BITSIZE-1:0] reg_file [REGSIZE-1:0];   // 寄存器文件，包含所有寄存器
    
    initial
    begin
        reg_file[0] = 32'b0; // 初始化 x0 为 0
    end
    integer i; // 用于复位所有寄存器

    // 寄存器文件的异步读操作（读取 ReadSelect1 指定的寄存器）
    always @(ReadSelect1, reg_file[ReadSelect1])
        begin
            ReadData1 = reg_file[ReadSelect1];
        end

    // 寄存器文件的异步读操作（读取 ReadSelect2 指定的寄存器）
    always @(ReadSelect2, reg_file[ReadSelect2])
        begin
            ReadData2 = reg_file[ReadSelect2];
        end

    // 在时钟上升沿将数据写回寄存器文件
    always @(posedge clk)
        begin
            if (rst)
                for (i=0; i<REGSIZE; i=i+1) reg_file[i] <= 32'b0; // 复位所有寄存器
            else
            begin
                if (WriteEnable && WriteSelect != 0)
                    reg_file[WriteSelect] <= WriteData; // 如果写使能开启且非零号寄存器，则写入数据
            end
        end

endmodule
