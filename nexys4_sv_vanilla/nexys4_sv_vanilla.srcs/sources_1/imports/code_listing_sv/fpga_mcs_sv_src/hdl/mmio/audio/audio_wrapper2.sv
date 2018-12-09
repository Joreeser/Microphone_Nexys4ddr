`timescale 1ns / 1ps

module audio_wrapper2(
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
    output logic M_CLK,
    output logic audio_pdm,
    output logic audio_on
    );
   
    logic [31:0] buf_reg0;
    logic wr_en;
    logic data;
    
    // Input buffer register
    always_ff @(posedge clk, posedge reset)
          if (reset)
          begin
             buf_reg0 <= 0;
          end
          else   
             if (wr_en && (addr == 0))
                buf_reg0[0] <= data;
                
    // decoding logic 
    assign read_en = cs && read;
    
    // slot write interface
    assign wr_data =  0;
    
    // external input
    Microphone_practice audio_slot14(.clk(clk), .reset(reset), .M_CLK(M_CLK), .M_DATA(M_DATA), .M_LRSEL(M_LRSEL), .audio_pdm(audio_pdm), .audio_on());
    );
endmodule
