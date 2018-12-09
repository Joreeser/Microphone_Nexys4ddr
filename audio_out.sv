`timescale 1ns / 1ps

module audio_out(
    //input logic clk,
    input logic power,
    input logic data_in,
    output logic audio_pdm,
    output logic audio_on
    );
    
    assign audio_on = power;
    assign audio_pdm = data_in;
    
endmodule
