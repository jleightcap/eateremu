BIN  := eateremu_tb

$(BIN):
	iverilog $(BIN).v -o $(BIN)

test: $(BIN)
	vvp $(BIN)

clean:
	rm -f $(BIN) $(BIN).vcd
