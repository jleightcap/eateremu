module mem_register (
    input clk,
    input clr,
    input in,
    input out,
    input[3:0] data_i,
    output reg[3:0] mem,
    output[3:0] data_o
);
    always @(posedge clk, posedge clr) begin
        if (clr) begin
            mem <= 4'h0;
        end
        if (in) begin
            mem <= data_i;
        end
    end

    assign data_o = out ? mem : 4'hz;
endmodule
