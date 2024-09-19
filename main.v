/** main.v for A7_LITE FPGA Board  ArchLab Institute of Science Tokyo / Tokyo Tech **/
/************************************************************************************/
`default_nettype none

`define UART_TX_WCNT 50  // UART TX wait count, 50MHz / 50 = 1Mbaud
/************************************************************************************/
module m_uart_tx (
    input wire w_clk           , // clock signal
    input wire w_we            , // write enable
    input wire [7:0] w_data_in , // data input
    output reg r_tx = 1        , // uart tx
    output reg r_ready = 1       // uart tx ready
);

    reg [3:0] r_cnt  = 0;
    reg [8:0] r_cmd  = 9'h1ff;
    reg [9:0] r_wait = 0;
    always @(posedge w_clk) begin
        if( r_ready ) begin
            r_tx   <= 1;
            r_wait <= 0;
            if( w_we )begin
                r_ready <= 0;
                r_cmd   <= {w_data_in, 1'b0};
                r_cnt   <= 10;
            end
        end else if( r_wait >= `UART_TX_WCNT ) begin
            r_tx    <= r_cmd[0];
            r_ready <= (r_cnt == 1);
            r_cmd   <= {1'b1, r_cmd[8:1]};
            r_wait  <= 1;
            r_cnt   <= r_cnt - 1;
        end else begin
            r_wait  <= r_wait + 1;
        end
    end
endmodule

/************************************************************************************/
module m_main (
    input  wire  w_clk       ,  // 50MHz clock signal
    output wire  w_uart_tx   ,  // UART tx 
    output wire  [1:0] w_led    // LED
);

    reg [31:0] r_cnt = 0;
    always @(posedge w_clk) r_cnt <= r_cnt + 1;
    assign w_led = r_cnt[24:23];
    
    reg r_we = 0;
    always @(posedge w_clk) r_we <= (r_cnt[23:0]==0);
    wire w_uart_ready; 
    m_uart_tx m0 (w_clk, r_we, 8'h61, w_uart_tx, w_uart_ready); // 8'h61 for 'a'
endmodule
/************************************************************************************/
