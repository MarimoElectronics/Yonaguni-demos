`timescale 1 ns / 1 ns module dSUopG1uPnW9WpGfuJP3PC (l0E5U5ysrwNYFWhaD6aOTT, z2UJNE6Z3dXlstgbJ1NhIFE, DKtuEu8YDlDAVk5CGQsPXB, h0jiS996wETUVtiIvaIugJC, pDjD7yLefkZ7GVdB8AIA5, GKmfRGTjf4Yss2ry5l6ipD); input l0E5U5ysrwNYFWhaD6aOTT; input z2UJNE6Z3dXlstgbJ1NhIFE; input DKtuEu8YDlDAVk5CGQsPXB; input h0jiS996wETUVtiIvaIugJC; input pDjD7yLefkZ7GVdB8AIA5; output GKmfRGTjf4Yss2ry5l6ipD; wire iNfN3X4JAtng4OPupKsBYE; wire DecO5kKJfISFwZNMkx2PkH; wire fUAV0UeQC38srPnChMc1cC; reg g8sCiwhNiGam8xq7gzpz2jD; wire v1JGbAWvjOg07yLr4iV61YD; wire Ua5IlvsaHB5Y6Dfu5JhfuD; assign iNfN3X4JAtng4OPupKsBYE = h0jiS996wETUVtiIvaIugJC | pDjD7yLefkZ7GVdB8AIA5; assign DecO5kKJfISFwZNMkx2PkH = ~ pDjD7yLefkZ7GVdB8AIA5; assign fUAV0UeQC38srPnChMc1cC = h0jiS996wETUVtiIvaIugJC & DecO5kKJfISFwZNMkx2PkH; assign v1JGbAWvjOg07yLr4iV61YD = (iNfN3X4JAtng4OPupKsBYE == 1'b0 ? g8sCiwhNiGam8xq7gzpz2jD : fUAV0UeQC38srPnChMc1cC); always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : i6s3sMu3T94zPOWUS4Ksm4D if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin g8sCiwhNiGam8xq7gzpz2jD <= 1'b0; end else begin if (DKtuEu8YDlDAVk5CGQsPXB) begin g8sCiwhNiGam8xq7gzpz2jD <= v1JGbAWvjOg07yLr4iV61YD; end end end assign GKmfRGTjf4Yss2ry5l6ipD = g8sCiwhNiGam8xq7gzpz2jD; endmodule