module ram (
    input clk,
    input[3:0] mem_address,
    input ri, /* write */
    input ro, /* read */
    inout[7:0] data
);
    reg[7:0] memory[15:0];
    reg[8:0] mem_data;

    initial begin
        memory[0] <= 8'b0001_1010;
        memory[1] <= 8'b0010_1011;
        memory[2] <= 8'b0100_0110;
        memory[3] <= 8'b0011_1100;
        memory[4] <= 8'b0010_1101;
        memory[5] <= 8'b1110_0000;
        memory[6] <= 8'b0001_1110;
        memory[7] <= 8'b0010_1111;
        memory[8] <= 8'b1110_0000;
        memory[9] <= 8'b1111_0000;
        memory[10] <= 8'b0000_0011;
        memory[11] <= 8'b0000_0010;
        memory[12] <= 8'b0000_0001;
        memory[13] <= 8'b0000_0101;
        memory[14] <= 8'b0000_1010;
        memory[15] <= 8'b0000_1011;
    end

    always @(posedge clk) begin
        /* the precedence here is arbitrary, simultaneous read/writes undefined */
        if (ri) memory[mem_address] <= data;
        if (ro) mem_data <= memory[mem_address];
    end

    assign data = ro ? mem_data : 8'bzzzzzzzz;
endmodule
