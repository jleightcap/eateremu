module buffer4 (
    input oe,
    input[3:0] data_i,
    output[3:0] data_o
);
    assign data_o = oe ? data_i : 4'bzzzz;
endmodule
