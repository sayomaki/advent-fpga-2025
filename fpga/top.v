module top (
    input        clk_ext,
    input  [4:0] btn,
    output [7:0] led,
    inout  [7:0] interconnect
);
    // ------------------------------------------------------------------------
    // Internal oscillator + clock setup
    // ------------------------------------------------------------------------
    wire clk_int;
    defparam OSCI1.DIV = "3";
    OSCG OSCI1 (.OSC(clk_int));

    wire clk = clk_int;
    wire reset = ~btn[2] | interconnect[2];

    // ------------------------------------------------------------------------
    // ¨UART code from greybadge25 (credits to @Hackin7 for implementation)
    // ------------------------------------------------------------------------
    parameter DBITS = 8;
    parameter UART_FRAME_SIZE = 8; // 8*8 = 64-bit payload/frame size

    wire uart_rx = interconnect[0];
    wire uart_tx = interconnect[1];

    wire [UART_FRAME_SIZE*DBITS-1:0] uart_rx_out;
    wire [UART_FRAME_SIZE*DBITS-1:0] uart_tx_out;
    wire uart_tx_controller_send;
    wire uart_rx_received;
    wire uart_rx_full, uart_rx_empty;

    uart_top #(
        .FIFO_IN_SIZE(UART_FRAME_SIZE),
        .FIFO_OUT_SIZE(UART_FRAME_SIZE),
        .FIFO_OUT_SIZE_EXP(32)
    ) UART_UNIT (
        .clk_100MHz       (clk),
        .reset            (reset),
        .rx               (uart_rx),
        .tx               (uart_tx),
        .rx_char_received (uart_rx_received),
        .rx_full          (uart_rx_full),
        .rx_empty         (uart_rx_empty),
        .rx_out           (uart_rx_out),
        .tx_trigger       (uart_tx_controller_send),
        .tx_in            (uart_tx_out)
    );


    // ------------------------------------------------------------------------
    // UART processing (receive + transmit)
    // ------------------------------------------------------------------------
    reg [7:0]  rx_char_count = 0;
    reg [63:0] uart_frame_data = 0;
    reg        uart_new_frame = 0;
    reg        frame_complete = 0;

    always @(posedge clk) begin
        if (reset) begin
            rx_char_count   <= 0;
            uart_frame_data <= 0;
            uart_new_frame  <= 0;
            frame_complete  <= 0;
        end else begin
            uart_new_frame <= 0;
            
            // there is a delay of 1 cycle for data to be ready when
            // frame_complete is asserted, so we need to delay and check
            if (uart_rx_received) begin
                if (rx_char_count == UART_FRAME_SIZE-1) begin
                    rx_char_count  <= 0;
                    frame_complete <= 1; // indicate that frame is ready but not data
                end else begin
                    rx_char_count <= rx_char_count + 1;
                end
            end
            
            // read data one cycle after frame_complete asserted
            if (frame_complete && rx_char_count == 0) begin
                uart_frame_data <= uart_rx_out;
                uart_new_frame  <= 1;
                frame_complete  <= 0;
            end
        end
    end

    // UART transmit on result valid
    reg [63:0] tx_buffer = 0;
    reg        tx_valid = 0;
    reg        aoc_result_valid_last = 0;

    assign uart_tx_out = tx_buffer;
    assign uart_tx_controller_send = tx_valid;

    always @(posedge clk) begin
        if (reset) begin
            tx_buffer <= 0;
            tx_valid  <= 0;
            aoc_result_valid_last <= 0;
        end else begin
            if (aoc_result_valid && !aoc_result_valid_last) begin
                tx_buffer   <= aoc_result_value;
                tx_valid    <= 1;
            end else begin
                tx_valid <= 0;
            end

            aoc_result_valid_last <= aoc_result_valid;
        end
    end

    // ------------------------------------------------------------------------
    // AoC section (verilog <-> hardcaml)
    // ------------------------------------------------------------------------
    wire        aoc_data_ready;
    reg         aoc_data_valid = 0;
    reg  [63:0] aoc_data = 0;
    wire        aoc_result_valid;
    wire [63:0] aoc_result_value;
    wire [1:0]  aoc_debug;

    aoc_top aoc (
        .clock        (clk),
        .reset        (reset),
        .puzzle       (5'b00100), // set to day 2 part 1
        .data$value   (aoc_data),
        .data$valid   (aoc_data_valid),
        .data_ready   (aoc_data_ready),
        .result$valid (aoc_result_valid),
        .result$value (aoc_result_value),
        .debug        (aoc_debug)
    );

    always @(posedge clk) begin
        if (reset) begin
            aoc_data_valid <= 0;
            aoc_data       <= 0;
        end else begin
            if (uart_new_frame && aoc_data_ready && !aoc_data_valid) begin
                aoc_data       <= uart_frame_data;
                aoc_data_valid <= 1;
            end

            if (aoc_data_valid && aoc_data_ready)
                aoc_data_valid <= 0;
        end
    end

    // ------------------------------------------------------------------------
    // LEDs (visuals + debugging)
    // ------------------------------------------------------------------------
    assign led = {
        reset,
        aoc_data_ready,
        1'b0,
        1'b0,
        aoc_debug == 2,
        aoc_debug == 1,
        aoc_debug == 0,
        aoc_result_valid
    };


endmodule
