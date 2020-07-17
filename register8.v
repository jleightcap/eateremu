module register8 (
    input clk,
    input clr,
    input in,
    input out,
    input[7:0] data_i,
    output reg[7:0] mem,
    output [7:0] data_o
);
    /* for data registers, a high Z value should be interpreted as a logical 0 */
    reg[7:0] data_buf;
    integer i;
    always @(data_i) begin
        for(i = 0; i < 8; i++) begin
            data_buf[i] = (data_i[i] === 1'bz) ? 1'b0 : data_i[i];
        end
    end

    always @(posedge clk, posedge clr) begin
        if (clr) begin
            mem <= 8'hzz;
        end
        if (in) begin
            mem <= data_buf;
        end
    end

    assign data_o = out ? mem : 8'hzz;
endmodule
