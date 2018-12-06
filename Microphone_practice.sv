`timescale 1ns / 1ps

module Microphone_practice(
    input logic clk,
    input logic reset,
    input logic M_DATA,
    output logic M_CLK,
    output logic M_LRSEL,
    output logic [6:0] led
    );
    
    logic tick;
    logic hold = 0;
    logic count = 0;
    logic [6:0] data, next_data, data_in;
    
    always_ff @(posedge clk, posedge reset)
        if (reset)
            data <= 0;
        else 
            data <= next_data;
            
    always_comb
    begin
        if (count == 20)
        begin
            next_data = data_in;
            hold = 1;
        end    
        else 
            next_data = next_data;
    end
    
    assign led = data;
            
    
    microphone microphone_dut(.clk(clk), .reset(reset), .M_DATA(M_DATA), .M_CLK(M_CLK), .M_LRSEL(M_LRSEL), .data(data_in), .tick(tick));
    counter#(.SIZE(4)) loop_count(.clk(tick), .reset(reset | hold), .count(count));
    
    
    
endmodule
