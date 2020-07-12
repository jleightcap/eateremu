module buffer8 (
    input oe,
    input[7:0] data_i,
    output[7:0] data_o
);
    assign data_o = oe ? data_i : 8'bzzzzzzzz;
endmodule
