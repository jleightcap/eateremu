module Alu (
    input[7:0] a,
    input[7:0] b,
    input su,
    output[7:0] alu_out,
    output ovf,
    output zf
);
    wire[8:0] result;
    assign result = su ? (a - b) : (a + b);
    assign alu_out = result[7:0];
    assign ovf = result[8];
    assign zf  = result == 0;
endmodule
