`timescale 1ns / 1ps

module new_mic(
    input logic clk,
    input logic reset,
    output logic mic_clk,
    output logic mic_lrsel,
    input logic mic_data,
    output logic [6:0] data,
    output logic tick
    );
    
    logic [3:0] clk_reg;
    
    assign mic_lrsel = 0;
    
    // Generate clock for Microphone
    always_ff @(posedge clk, posedge reset)
    if (reset)
    begin
        clk_reg <= 0;
        data <= 0;
    end
    else 
        clk_reg <= clk_reg + 1;
        
    assign mic_clk = clk_reg[4];
    
    // Read data from microphone
    always_ff @(posedge clk)
    if (clk_reg == 4'b0111)
    begin
        data <= data + {6'd0, mic_data};
        tick <= 1;
    end
    else
        tick <= 0;
    
    
        
    
endmodule
