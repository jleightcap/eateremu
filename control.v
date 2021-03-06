module control (
    input clk,
    input ovf,
    input zf,
    input[3:0] instruction,
    output reg[15:0] ctrl_data
);
    parameter HLT = 16'b1000000000000000; // Halt clock
    parameter MI  = 16'b0100000000000000; // Memory address register in
    parameter RI  = 16'b0010000000000000; // RAM data in
    parameter RO  = 16'b0001000000000000; // RAM data out
    parameter IO  = 16'b0000100000000000; // Instruction register out
    parameter II  = 16'b0000010000000000; // Instruction register in
    parameter AI  = 16'b0000001000000000; // A register in
    parameter AO  = 16'b0000000100000000; // A register out
    parameter EO  = 16'b0000000010000000; // ALU out
    parameter SU  = 16'b0000000001000000; // ALU subtract
    parameter BI  = 16'b0000000000100000; // B register in
    parameter OI  = 16'b0000000000010000; // Output register in
    parameter CE  = 16'b0000000000001000; // Program counter enable
    parameter CO  = 16'b0000000000000100; // Program counter out
    parameter J   = 16'b0000000000000010; // Jump (program counter in)
    parameter FI  = 16'b0000000000000001; // Flags in

    reg[2:0] count;
    
    initial count <= 3'b000;
    initial ctrl_data <= 16'b0000000000000000;

    `ifdef VERBOSE integer instruction_num = 0; `endif

    always @(posedge clk) begin
        case (count)
            3'b000: begin
                `ifdef VERBOSE $display(instruction_num); instruction_num++; `endif
                ctrl_data = MI | CO;
            end
            3'b001: begin
                ctrl_data = RO | II | CE;
            end
            3'b010: begin
                begin case (instruction)
                    4'b0000: /* NOP 2 */ ctrl_data = 0;
                    4'b0001: /* LDA 2 */ ctrl_data = IO | MI;
                    4'b0010: /* ADD 2 */ ctrl_data = IO | MI;
                    4'b0011: /* SUB 2 */ ctrl_data = IO | MI;
                    4'b0100: /* STA 2 */ ctrl_data = IO | MI;
                    4'b0101: /* LDI 2 */ ctrl_data = IO | AI;
                    4'b0110: /* JMP 2 */ ctrl_data = IO | J;
                    4'b0111: /* JC  2 */
                        begin
                            if (ovf) ctrl_data = IO | J;
                            else ctrl_data = 0;
                        end
                    4'b1000: /* JZ  2 */
                        begin
                            if (zf) ctrl_data = IO | J;
                            else ctrl_data = 0;
                        end
                    4'b1110: /* OUT 2 */ ctrl_data = AO | OI;
                    4'b1111: /* HLT 2 */ ctrl_data = HLT;
                    default: ctrl_data = 0;
                endcase end
            end
            3'b011: begin case (instruction)
                4'b0000: /* NOP 3 */ ctrl_data = 0;
                4'b0001: /* LDA 3 */ ctrl_data = RO | AI;
                4'b0010: /* ADD 3 */ ctrl_data = RO | BI;
                4'b0011: /* SUB 3 */ ctrl_data = RO | BI;
                4'b0100: /* STA 3 */ ctrl_data = AO | RI;
                4'b0101: /* LDI 3 */ ctrl_data = 0;
                4'b0110: /* JMP 3 */ ctrl_data = 0;
                4'b0111: /* JC  3 */ ctrl_data = 0;
                4'b1000: /* JZ  3 */ ctrl_data = 0;
                4'b1110: /* OUT 3 */ ctrl_data = 0;
                4'b1111: /* HLT 3 */ ctrl_data = 0;
                default: ctrl_data = 0;
            endcase end
            3'b100: begin case (instruction)
                4'b0000: /* NOP 4 */ ctrl_data = 0;
                4'b0001: /* LDA 4 */ ctrl_data = 0;
                4'b0010: /* ADD 4 */ ctrl_data = EO | AI | FI;
                4'b0011: /* SUB 4 */ ctrl_data = EO | AI | SU | FI;
                4'b0100: /* STA 4 */ ctrl_data = 0;
                4'b0101: /* LDI 4 */ ctrl_data = 0;
                4'b0110: /* JMP 4 */ ctrl_data = 0;
                4'b0111: /* JC  4 */ ctrl_data = 0;
                4'b1000: /* JZ  4 */ ctrl_data = 0;
                4'b1110: /* OUT 4 */ ctrl_data = 0;
                4'b1111: /* HLT 4 */ ctrl_data = 0;
                default: ctrl_data = 0;
            endcase end
            default:
                ctrl_data = 0;
        endcase
        count++;
    end
endmodule
