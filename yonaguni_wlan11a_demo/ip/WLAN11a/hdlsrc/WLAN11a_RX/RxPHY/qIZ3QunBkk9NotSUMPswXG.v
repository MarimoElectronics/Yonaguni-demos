`timescale 1 ns / 1 ns module qIZ3QunBkk9NotSUMPswXG (l0E5U5ysrwNYFWhaD6aOTT, z2UJNE6Z3dXlstgbJ1NhIFE, rTuZ5V8eNhP7SOBVsxm9PB, h0jiS996wETUVtiIvaIugJC, pDjD7yLefkZ7GVdB8AIA5, GKmfRGTjf4Yss2ry5l6ipD); input l0E5U5ysrwNYFWhaD6aOTT; input z2UJNE6Z3dXlstgbJ1NhIFE; input rTuZ5V8eNhP7SOBVsxm9PB; input h0jiS996wETUVtiIvaIugJC; input pDjD7yLefkZ7GVdB8AIA5; output GKmfRGTjf4Yss2ry5l6ipD; wire iNfN3X4JAtng4OPupKsBYE; wire DecO5kKJfISFwZNMkx2PkH; wire fUAV0UeQC38srPnChMc1cC; reg DlrxXZ2W1L3juZfojzimiB; wire PD23ms8bowGPdA42eVdFhB; wire purjKtG5BpMMEBHTHcZOTH; assign iNfN3X4JAtng4OPupKsBYE = h0jiS996wETUVtiIvaIugJC | pDjD7yLefkZ7GVdB8AIA5; assign DecO5kKJfISFwZNMkx2PkH = ~ pDjD7yLefkZ7GVdB8AIA5; assign fUAV0UeQC38srPnChMc1cC = h0jiS996wETUVtiIvaIugJC & DecO5kKJfISFwZNMkx2PkH; assign PD23ms8bowGPdA42eVdFhB = (iNfN3X4JAtng4OPupKsBYE == 1'b0 ? DlrxXZ2W1L3juZfojzimiB : fUAV0UeQC38srPnChMc1cC); always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : pNN7KhJJrtcpPA2BOsMUVE if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin DlrxXZ2W1L3juZfojzimiB <= 1'b0; end else begin if (rTuZ5V8eNhP7SOBVsxm9PB) begin DlrxXZ2W1L3juZfojzimiB <= PD23ms8bowGPdA42eVdFhB; end end end assign GKmfRGTjf4Yss2ry5l6ipD = DlrxXZ2W1L3juZfojzimiB; endmodule