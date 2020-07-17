module Alu (
    input[7:0] a,
    input[7:0] b,
    input su,
    input out,
    output[7:0] alu_out,
    output ovf,
    output zf
);
    wire[8:0] result;
    reg[7:0] a_buf;
    reg[7:0] b_buf;

    integer i;
    always @(a, b) begin
        for(i = 0; i < 8; i++) begin
            a_buf[i] = (a[i] === 1'bz) ? 1'b0 : a[i];
            b_buf[i] = (b[i] === 1'bz) ? 1'b0 : b[i];
        end
    end

    assign result = su ? (a_buf - b_buf) : (a_buf + b_buf);


    assign alu_out = out ? result : 8'hzz;
    assign ovf = result[8];
    assign zf  = result == 0;
endmodule
