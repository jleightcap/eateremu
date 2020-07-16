module register8 (
    input clk,
    input clr,
    input in,
    input out,
    input[7:0] data_i,
    output reg[7:0] mem,
    output [7:0] data_o
);
    always @(posedge clk, posedge clr) begin
        if (clr) begin
            mem <= 8'hzz;
        end
        if (in) begin
            mem <= data_i;
        end
    end

    assign data_o = out ? mem : 8'hzz;
endmodule
