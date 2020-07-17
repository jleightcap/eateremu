`include "eateremu.v"

module eateremu_tb;
    wire[7:0] bus;
    wire[3:0] mem_address_data;
    wire[7:0] mem_data;
    wire[7:0] a_data;
    wire[7:0] b_data;
    wire[7:0] alu_data;
    wire[7:0] instruction_data;
    wire[7:0] display_data;
    wire[15:0] ctrl_state;
    reg clr;
    wire ovf, zf; /* flags */

    reg clk;
    initial begin
        #0 clk = 1; clr = 1;
        #1 clk = 0; clr = 0;
        forever #1 clk = !clk;
    end

    cpu eateremu (
        .clk(clk),
        .clr(clr),
        .bus(bus),
        .mem_address_data(mem_address_data),
        .mem_data(mem_data),
        .a_data(a_data),
        .b_data(b_data),
        .alu_data(alu_data),
        .instruction_data(instruction_data),
        .display_data(display_data),
        .ctrl_state(ctrl_state),
        .ovf(ovf),
        .zf(zf)
    );

`ifdef VERBOSE
    initial begin $monitor("%d: bus=%8b ctrl=%16b mem_addr=%1x a=%2x b=%2x o=%2x",
        $time, bus, ctrl_state, mem_address_data, a_data, b_data, display_data
    );
        #100 $finish;
    end
`else
    initial begin $monitor("%2x", display_data);
        #32 $finish;
    end
`endif
endmodule
