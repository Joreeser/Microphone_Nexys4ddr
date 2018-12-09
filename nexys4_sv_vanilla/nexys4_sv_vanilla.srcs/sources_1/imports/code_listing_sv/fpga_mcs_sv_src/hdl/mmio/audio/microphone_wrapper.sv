`timescale 1ns / 1ps

module microphone_wrapper
   (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port    
    input logic M_DATA,
    output logic M_LRSEL,
    output logic M_CLK
   );
   
    logic [31:0] buf_reg0;
    logic read_en;
    
    // Input buffer register
    always_ff @(posedge clk, posedge reset)
          if (reset)
          begin
             buf_reg0 <= 0;
          end
          else   
             if (read_en && (addr == 0))
                read_data[0] <= buf_reg[0];
                
    // decoding logic 
    assign read_en = cs && read;
    
    // slot write interface
    assign wr_data =  0;
    
    // external input
    mic_test microphone(.clk(clk), .reset(reset), .M_DATA(M_DATA), .M_CLK(M_CLK), .M_LRSEL(M_LRSEL), .data_out(buf_reg0[0]));
    
endmodule
