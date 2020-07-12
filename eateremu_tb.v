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
    wire ovf, zf; /* flags */

    reg clk;
    initial begin
        clk = 0;
        forever 
            #1 clk = !clk;
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
        .ovf(ovf),
        .zf(zf)
    );

    initial begin $monitor("%d: bus=%08x", $time, bus);
        #100000 $finish;
    end
endmodule
