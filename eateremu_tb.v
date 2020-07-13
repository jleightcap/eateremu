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
    wire[3:0] pc_data;
    wire[15:0] ctrl_state;
    wire ovf, zf; /* flags */

    reg clk;
    initial begin
        clk = 0;
        forever #1 clk = !clk;
    end

    cpu eateremu (
        .clk(clk),
        .bus(bus),
        .mem_address_data(mem_address_data),
        .mem_data(mem_data),
        .a_data(a_data),
        .b_data(b_data),
        .alu_data(alu_data),
        .instruction_data(instruction_data),
        .display_data(display_data),
        .pc_data(pc_data),
        .ctrl_state(ctrl_state),
        .ovf(ovf),
        .zf(zf)
    );

    initial begin $monitor("%d: pc=%1x bus=%2x ctrl=%16b mem_addr=%1x", $time, pc_data, bus, ctrl_state, mem_address_data);
        #32 $finish;
    end
endmodule
