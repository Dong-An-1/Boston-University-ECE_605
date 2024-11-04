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
    input [15:0] mem_access_addr,  // 地址输入，读写操作共用
    input [31:0] mem_write_data,   // 32位写入数据
    input mem_write_en,            // 写使能信号
    input mem_read,                // 读使能信号
    output reg [31:0] mem_read_data // 32位读出数据
);

    // 定义一个64 x 32位的存储器数组，与寄存器文件的建议大小相匹配
    reg [31:0] memory [63:0];

    // 初始化存储器为零
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            memory[i] = 32'd0;
        end
    end

    // 写操作（与时钟沿同步，类似于Register_File）
    always @(posedge clk) begin
        if (mem_write_en) begin
            memory[mem_access_addr[5:0]] <= mem_write_data;
        end
    end

    // 读操作（异步，类似于Register_File）
    always @(*) begin
        if (mem_read) begin
            mem_read_data = memory[mem_access_addr[5:0]];
        end else begin
            mem_read_data = 32'd0;  // 当读未使能时，默认输出0
        end
    end

endmodule



