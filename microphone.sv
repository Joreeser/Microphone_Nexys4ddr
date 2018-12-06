`timescale 1ns / 1ps

module microphone(
    input logic clk,
    input logic reset,
    input logic M_DATA,
    output logic M_CLK,
    output logic M_LRSEL,
    output logic tick,
    output logic [6:0] data
    );
    
    logic [6:0] data, data_next, data_count, data_hold, clk_count;
    logic [6:0] data_hold_next = 0;
    logic count_reset = 0;
    logic [6:0] next_clk_count = 0;
    
    typedef enum{READ_DATA, SEND_DATA} microphone_states;
    microphone_states state, next_state;
    
    always_ff @(posedge clk, posedge reset)
        if (reset)
        begin
            state <= READ_DATA;
            data <= 0;
            data_count <= 0;
            data_hold <= 0;
        end
        else
        begin
            state <= next_state;
            data <= data_next;
        end
        
    always_ff @(posedge M_CLK)
        data_hold <= data_hold_next;
    
        
    always_comb
    begin
        case (state)
        READ_DATA:
        begin
            tick = 0;
            count_reset = 0;
            data_hold_next <= data_hold_next + {6'b000000, M_DATA};
            
            if (data_count == 127)
            begin
                next_state = SEND_DATA;
                count_reset = 1;
                tick = 1;
            end
            else
                next_state = READ_DATA;        
        end
        
        SEND_DATA:
        begin
            tick = 0;
            count_reset = 0;
            data_next = data_hold;
            data_hold = 0;
            data_hold_next = 0;
            
            if (data_count == 127)
            begin
                next_state = READ_DATA;
                count_reset = 1;
                tick = 1;
            end
            else
                next_state = SEND_DATA; 
        end
        endcase
    end
    
        
    // ~2.4 MHz clk generator for microphone
    mod_m_counter#(.M(42)) microphone_clk(.clk(clk), .reset(reset), .max_tick(M_CLK), .q()); 
    
    // Count for number of samples taken
    counter#(.SIZE(7)) sample_count(.clk(M_CLK), .reset(reset | data_hold), .count(data_count));
        
    // Sample microphone data at posedge clk   
    assign M_LRSEL = 0;
    
endmodule
