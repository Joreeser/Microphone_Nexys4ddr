`timescale 1ns / 1ps

module microphone(
    input logic clk,
    input logic reset,
    input logic M_DATA,
    output logic M_CLK,
    output logic M_LRSEL,
    output logic data_out
    );
    
    logic pwm_val_reg;
    
    always_ff @(posedge M_CLK)
        pwm_val_reg <= M_DATA;
        
    assign data_out = pwm_val_reg;
        
    // ~2.4 MHz clk generator for microphone
    mod_m_counter#(.M(42)) microphone_clk(.clk(clk), .reset(reset), .max_tick(M_CLK), .q()); 
        
    // Sample microphone data at posedge clk   
    assign M_LRSEL = 0;
    
endmodule
