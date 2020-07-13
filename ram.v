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
        memory[0]  <= 8'b0000_0000;
        memory[1]  <= 8'b0000_0000;
        memory[2]  <= 8'b0000_0000;
        memory[3]  <= 8'b0000_0000;
        memory[4]  <= 8'b0000_0000;
        memory[5]  <= 8'b0000_0000;
        memory[6]  <= 8'b0000_0000;
        memory[7]  <= 8'b0000_0000;
        memory[8]  <= 8'b0000_0000;
        memory[9]  <= 8'b0000_0000;
        memory[10] <= 8'b0000_0000;
        memory[11] <= 8'b0000_0000;
        memory[12] <= 8'b0000_0000;
        memory[13] <= 8'b0000_0000;
        memory[14] <= 8'b0000_0000;
        memory[15] <= 8'b0000_0000;
    end

    always @(posedge clk) begin
        if (ri) memory[mem_address] <= data;
    end

    assign data = ro ? memory[mem_address] : 8'bzzzzzzzz;
endmodule
