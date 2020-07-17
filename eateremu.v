`include "alu.v"
`include "mem_register.v"
`include "register8.v"
`include "programcounter.v"
`include "ram.v"
`include "control.v"

module cpu (
    input clk,
    input clr,
    output[7:0] bus,
    output[3:0] mem_address_data,
    output[7:0] mem_data,
    output[7:0] a_data,
    output[7:0] b_data,
    output[7:0] alu_data,
    output[7:0] instruction_data,
    output[7:0] display_data,
    output [15:0] ctrl_state,
    output ovf, zf /* flags */
);
    /* control signals */
    wire hlt, mi, ri, ro, io, ii, ai, ao, so, su, bi, oi, ce, co, j, fi;
    assign ctrl_state = { hlt, mi, ri, ro, io, ii, ai, ao, so, su, bi, oi, ce, co, j, fi };

    wire cpu_clk = (clk & !hlt);

    /* A register */
    register8 A (
        .clk(cpu_clk),
        .clr(clr),
        .in(ai),
        .out(ao),
        .data_i(bus),
        .mem(a_data),
        .data_o(bus)
    );

    /* B register */
    register8 B (
        .clk(cpu_clk),
        .clr(clr),
        .in(bi),
        .out(),
        .data_i(bus),
        .mem(b_data),
        .data_o(bus)
    );

    /* instruction register */
    wire[3:0] buffer; // place to dump high nibble...
    register8 instr (
        .clk(cpu_clk),
        .clr(clr),
        .in(ii),
        .out(io),
        .data_i(bus),
        .mem(instruction_data),
        .data_o({buffer, bus[3:0]})
    );

    /* output register */
    /*
    register8 out (
        .clk(cpu_clk),
        .clr(clr),
        .write(oi),
        .data_i(bus),
        .data_o(display_data)
    );
    */

    /* ALU */
    /*
    Alu alu (
        .a(a_data),
        .b(b_data),
        .su(su),
        .out(so)
        .alu_out(alu_data),
        .ovf(ovf),
        .zf(zf)
    );
    */

    /* program counter */
    program_counter pc (
        .clk(cpu_clk),
        .clr(clr),
        .ce(ce),
        .jmp(j),
        .out(co),
        .bus(bus[3:0])
    );

    /* memory address register */
    mem_register mem_address (
        .clk(cpu_clk),
        .clr(clr),
        .in(mi),
        .out(),
        .data_i(bus[3:0]),
        .mem(mem_address_data),
        .data_o()
    );

    /* RAM */
    ram mem (
        .clk(cpu_clk),
        .mem_address(mem_address_data),
        .ri(ri),
        .ro(ro),
        .data_i(bus),
        .data_o(bus)
    );

    /* control logic */
    control ctrl (
        .clk(!cpu_clk),
        .instruction(instruction_data[7:4]),
        .ctrl_data({hlt, mi, ri, ro, io, ii, ai, ao, so, su, bi, oi, ce, co, j, fi})
    );
endmodule
