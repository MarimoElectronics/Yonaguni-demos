`timescale 1 ns / 1 ns module NQeTLVlz7Pa6HvUDYj7PgG (p0E5U5ysrwNYFWhaD6aOTT, c2UJNE6Z3dXlstgbJ1NhIFE, DKtuEu8YDlDAVk5CGQsPXB, b0jiS996wETUVtiIvaIugJC, pDjD7yLefkZ7GVdB8AIA5, GKmfRGTjf4Yss2ry5l6ipD); input p0E5U5ysrwNYFWhaD6aOTT; input c2UJNE6Z3dXlstgbJ1NhIFE; input DKtuEu8YDlDAVk5CGQsPXB; input b0jiS996wETUVtiIvaIugJC; input pDjD7yLefkZ7GVdB8AIA5; output GKmfRGTjf4Yss2ry5l6ipD; wire iNfN3X4JAtng4OPupKsBYE; wire DecO5kKJfISFwZNMkx2PkH; wire fUAV0UeQC38srPnChMc1cC; reg a8sCiwhNiGam8xq7gzpz2jD; wire y1JGbAWvjOg07yLr4iV61YD; wire xDASy8fqkEIflvLRC4kNz; assign iNfN3X4JAtng4OPupKsBYE = b0jiS996wETUVtiIvaIugJC | pDjD7yLefkZ7GVdB8AIA5; assign DecO5kKJfISFwZNMkx2PkH = ~ pDjD7yLefkZ7GVdB8AIA5; assign fUAV0UeQC38srPnChMc1cC = b0jiS996wETUVtiIvaIugJC & DecO5kKJfISFwZNMkx2PkH; assign y1JGbAWvjOg07yLr4iV61YD = (iNfN3X4JAtng4OPupKsBYE == 1'b0 ? a8sCiwhNiGam8xq7gzpz2jD : fUAV0UeQC38srPnChMc1cC); always @(posedge p0E5U5ysrwNYFWhaD6aOTT) begin : a6s3sMu3T94zPOWUS4Ksm4D if (c2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin a8sCiwhNiGam8xq7gzpz2jD <= 1'b0; end else begin if (DKtuEu8YDlDAVk5CGQsPXB) begin a8sCiwhNiGam8xq7gzpz2jD <= y1JGbAWvjOg07yLr4iV61YD; end end end assign GKmfRGTjf4Yss2ry5l6ipD = a8sCiwhNiGam8xq7gzpz2jD; endmodule