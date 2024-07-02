`timescale 1 ns / 1 ns module v1767WBgBisOyzyEOHDTTpH (l0E5U5ysrwNYFWhaD6aOTT, DKtuEu8YDlDAVk5CGQsPXB, FPMCK36oW1c61jWtg6u10B, lQDDo3mMxpSArvViIGyPqG, l30d1QakAt61ivcMw8sJQE, UKo8akspo4h0jsZ6g712NB, EYQG62ys4E6V8lISAdlW1C, nBdSW8RKULgPE8G4jdwvNE, wRuHKEftqyvH5AjWcxLn1E); parameter integer AddrWidth = 1; parameter integer DataWidth = 1; input l0E5U5ysrwNYFWhaD6aOTT; input DKtuEu8YDlDAVk5CGQsPXB; input signed [DataWidth - 1:0] FPMCK36oW1c61jWtg6u10B; input signed [DataWidth - 1:0] lQDDo3mMxpSArvViIGyPqG; input [AddrWidth - 1:0] l30d1QakAt61ivcMw8sJQE; input UKo8akspo4h0jsZ6g712NB; input [AddrWidth - 1:0] EYQG62ys4E6V8lISAdlW1C; output signed [DataWidth - 1:0] nBdSW8RKULgPE8G4jdwvNE; output signed [DataWidth - 1:0] wRuHKEftqyvH5AjWcxLn1E; reg [DataWidth*2 - 1:0] ram [2**AddrWidth - 1:0]; reg [DataWidth*2 - 1:0] data_int; integer i; initial begin for (i=0; i<=2**AddrWidth - 1; i=i+1) begin ram[i] = 0; end data_int = 0; end wire tE8M6G7tmcyybQE5lZ7dHD; always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : PxGtD8RdpEuqNR1OqCny8D_process if (DKtuEu8YDlDAVk5CGQsPXB == 1'b1) begin if (UKo8akspo4h0jsZ6g712NB == 1'b1) begin ram[l30d1QakAt61ivcMw8sJQE] <= {FPMCK36oW1c61jWtg6u10B, lQDDo3mMxpSArvViIGyPqG}; end data_int <= ram[EYQG62ys4E6V8lISAdlW1C]; end end assign nBdSW8RKULgPE8G4jdwvNE = data_int[DataWidth*2-1:DataWidth]; assign wRuHKEftqyvH5AjWcxLn1E = data_int[DataWidth-1:0]; endmodule