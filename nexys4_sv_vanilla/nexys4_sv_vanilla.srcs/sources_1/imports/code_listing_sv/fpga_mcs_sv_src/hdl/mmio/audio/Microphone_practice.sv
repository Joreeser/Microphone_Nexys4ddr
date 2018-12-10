`timescale 1ns / 1ps

module Microphone_practice(
    input logic clk,
    input logic reset,
    input logic M_DATA,
    output logic M_CLK,
    output logic M_LRSEL,
    output logic audio_pdm,
    output logic audio_on
    );
    
    logic data;
   
    mic_test microphone_dut(.clk(clk), .reset(reset), .M_DATA(M_DATA), .M_CLK(M_CLK), .M_LRSEL(M_LRSEL), .data_out(data));
    audio_out audio_dut( .power(1), .data_in(data), .audio_pdm(audio_pdm), .audio_on(audio_on));  
    
    
    
endmodule
