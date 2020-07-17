module program_counter (
    input clk,
    input clr,
    input ce,
    input jmp,
    input out,
    inout[3:0] bus
);
    reg[3:0] count;
    initial count <= 4'b0000;

    always @(posedge clk, posedge clr) begin
        if (clr) begin
            count <= 4'b0000;
        end
        if (jmp) begin
            count <= bus;
        end
        if (ce) begin
            count++;
        end
    end

    assign bus = out ? count : 4'bzzzz;
endmodule
