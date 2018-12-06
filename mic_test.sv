`timescale 1ns / 1ps


module mic_test(
    input logic clk,
    input logic reset,
    input logic M_DATA,
    output logic M_CLK,
    output logic M_LRSEL,
    output logic audio_pdm,
    output logic audio_on);
    
    logic [3:0] mic_clk_counter;
    logic pwm_val_reg;
    
    always_ff @(posedge clk)
    begin
        mic_clk_counter <= mic_clk_counter + 1;
        
        if (mic_clk_counter == 4'b1111)
            pwm_val_reg <= M_DATA;
    end   
        
    assign M_CLK = mic_clk_counter[4];
    assign M_LRSEL = 0;
    assign audio_pdm = pwm_val_reg;
    assign audio_on = 1;
        
endmodule
