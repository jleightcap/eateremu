`include "alu.v"
`include "register4.v"
`include "register8.v"
`include "buffer4.v"
`include "buffer8.v"
`include "programcounter.v"
`include "ram.v"
`include "control.v"

module cpu (
    input clk,
    output[7:0] bus,
    output[3:0] mem_address_data,
    output[7:0] mem_data,
    inout[7:0] a_data,
    inout[7:0] b_data,
    output[7:0] alu_data,
    inout[7:0] instruction_data,
    output[7:0] display_data,
    output[3:0] pc_data,
    output [15:0] ctrl_state,
    output ovf, zf /* flags */
);
    wire cpu_clk;

    /* control signals */
    wire hlt, mi, ri, ro, io, ii, ai, ao, so, su, bi, oi, ce, co, j, fi;

    assign cpu_clk = (clk & ~hlt);
    assign ctrl_state = { hlt, mi, ri, ro, io, ii, ai, ao, so, su, bi, oi, ce, co, j, fi };

    /* A register */
    register8 A (
        .clk(cpu_clk),
        .write(ai),
        .data_i(a_data),
        .data_o(bus)
    );
    buffer8 buf_A (
        .oe(ao),
        .data_i(a_data),
        .data_o(bus)
    );

    /* B register */
    register8 B (
        .clk(cpu_clk),
        .write(bi),
        .data_i(b_data),
        .data_o(bus)
    );

    /* instruction register */
    register8 instr (
        .clk(cpu_clk),
        .write(ii),
        .data_i(instruction_data),
        .data_o(bus)
    );
    buffer8 buf_instr (
        .oe(io),
        .data_i(instruction_data),
        .data_o(bus)
    );

    /* output register */
    register8 out (
        .clk(cpu_clk),
        .write(oi),
        .data_i(bus),
        .data_o(display_data)
    );

    /* ALU */
    Alu alu (
        .a(a_data),
        .b(b_data),
        .su(su),
        .alu_out(alu_data),
        .ovf(ovf),
        .zf(zf)
    );
    buffer8 buf_alu (
        .oe(so),
        .data_i(alu_data),
        .data_o(bus)
    );

    /* program counter */
    program_counter pc (
        .clk(cpu_clk),
        .ce(ce),
        .jmp(j),
        .jmp_data(bus[3:0]),
        .pc(pc_data)
    );
    buffer4 buf_pc (
        .oe(co),
        .data_i(pc_data),
        .data_o(bus[3:0])
    );

    /* memory address register */
    register4 mem_address (
        .clk(cpu_clk),
        .write(mi),
        .data_i(bus[3:0]),
        .data_o(mem_address_data)
    );

    /* RAM */
    ram mem (
        .clk(cpu_clk),
        .mem_address(mem_address_data),
        .ri(ri),
        .ro(ro),
        .data(bus)
    );


    /* control logic */
    control ctrl (
        .clk(cpu_clk),
        .instruction(instruction_data[7:4]),
        .ctrl_data({hlt, mi, ri, ro, io, ii, ai, ao, so, su, bi, oi, ce, co, j, fi})
    );
endmodule
