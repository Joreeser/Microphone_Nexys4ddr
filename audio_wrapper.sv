`timescale 1ns / 1ps

module audio_wrapper(
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
    output logic audio_pdm,
    output logic audio_on
   );
   
    logic [31:0] buf_reg0, buf_reg1; // buf_reg0 for speaker data, buf_reg1 for power
    logic wr_en;
    
    // Input buffer register
    always_ff @(posedge clk, posedge reset)
        if (reset)
        begin
            buf_reg0 <= 0;
            buf_reg1 <= 0;
        end
        else if (wr_en && (addr == 0))
            buf_reg0[0] <= rd_data[0];
        else if (wr_en && (addr == 1))
            buf_reg1[0] <= rd_data[0];
                
    // decoding logic 
    assign wr_en = cs && write;
    
    // slot read interface
    assign rd_data = 0;
    
    // external input
    audio_out audio(.power(buf_reg1[0]), .data_in(buf_reg0[0]), .audio_pdm(audio_pdm), .audio_on(audio_on));

endmodule
