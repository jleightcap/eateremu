module control (
    input clk,
    input[3:0] instruction,
    output reg[15:0] ctrl_data
);
    reg[2:0] count;
    
    initial count <= 3'b111; /* pre-incremented in loop, initialized with overflow to 0 */

    always @(posedge clk) begin
        count++;
        case (count)
            3'b000: ctrl_data = 15'b010000000000010;
            3'b001: ctrl_data = 15'b000101000000100;
            3'b010: begin case(instruction)
                4'b0001: ctrl_data = 15'b010010000000000; // LDA
                4'b0010: ctrl_data = 15'b010010000000000; // ADD
                4'b0011: ctrl_data = 15'b010010000000000; // SUB
                4'b1110: ctrl_data = 15'b000000010001000; // OUT
                4'b0100: ctrl_data = 15'b000010000000001; // JMP
                4'b1111: ctrl_data = 15'b100000000000000; // HLT
                default: ctrl_data = 15'b000000000000000;
            endcase end
            3'b011: begin case(instruction)
                4'b0001: ctrl_data = 15'b000100100000000; // LDA
                4'b0010: ctrl_data = 15'b000100000010000; // ADD
                4'b0011: ctrl_data = 15'b000100000010000; // SUB
                4'b1110: ctrl_data = 15'b000000000000000; // OUT
                4'b0100: ctrl_data = 15'b000000000000000; // JMP
                4'b1111: ctrl_data = 15'b000000000000000; // HLT
                default: ctrl_data = 15'b000000000000000;
            endcase end
            3'b100: begin case(instruction)
                4'b0001: ctrl_data = 15'b000000000000000; // LDA
                4'b0010: ctrl_data = 15'b000000101000000; // ADD
                4'b0011: ctrl_data = 15'b000000101100000; // SUB
                4'b1110: ctrl_data = 15'b000000000000000; // OUT
                4'b0100: ctrl_data = 15'b000000000000000; // JMP
                4'b1111: ctrl_data = 15'b000000000000000; // HLT
                default: ctrl_data = 15'b000000000000000;
            endcase end
            default: ctrl_data = 15'b000000000000000;
        endcase
    end
endmodule
