module Alu (
    input clk,
    input[7:0] a,
    input[7:0] b,
    input su,
    input out,
    output[7:0] alu_out,
    output ovf,
    output zf
);
    wire[8:0] result;

    assign result = su ? (a - b) : (a + b);

    assign alu_out = out ? result : 8'hzz;
    assign ovf = result[8];
    assign zf  = result == 0;
endmodule
