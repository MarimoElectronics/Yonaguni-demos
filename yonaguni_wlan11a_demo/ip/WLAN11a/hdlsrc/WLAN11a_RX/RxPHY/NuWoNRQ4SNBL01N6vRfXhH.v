`timescale 1 ns / 1 ns module NuWoNRQ4SNBL01N6vRfXhH (l0E5U5ysrwNYFWhaD6aOTT, z2UJNE6Z3dXlstgbJ1NhIFE, DKtuEu8YDlDAVk5CGQsPXB, PKtQs4eZegSgKv8K61K8tF, BLYbhtIn0pQrUk5XotoFZ, LmjEDLrU3PI8Sabg8ngJvE, CrJ9V0NyelnCAici3JFjU, rGd22Aw6N9OCFWLiKKTjp, e1ZDhCOeE2YtwVP3hGKF7m, JBcW7PvN9lfFhg2YtEwCRG); input l0E5U5ysrwNYFWhaD6aOTT; input z2UJNE6Z3dXlstgbJ1NhIFE; input DKtuEu8YDlDAVk5CGQsPXB; input signed [11:0] PKtQs4eZegSgKv8K61K8tF; input signed [11:0] BLYbhtIn0pQrUk5XotoFZ; input LmjEDLrU3PI8Sabg8ngJvE; input CrJ9V0NyelnCAici3JFjU; output signed [11:0] rGd22Aw6N9OCFWLiKKTjp; output signed [11:0] e1ZDhCOeE2YtwVP3hGKF7m; output JBcW7PvN9lfFhg2YtEwCRG; reg [5:0] b6yijfyNmKV5BdUmtGckeCG; reg [5:0] t99BRGvpXnYfW070gFJfuEB; reg [5:0] A0dPc12vvjYXoCQ771n2u; reg [5:0] Y8wotVpNqA2Szjh3yaiJWC; reg [6:0] Xo78iXw7AIXeMqCqxBCGYB; wire [5:0] d6YO2kHtuvDGaPXh4DaE39D; wire [5:0] eNCBiHkV5XNE3tSIUCnifG; wire [5:0] qtc234eIYM3QYpzpPPUA2E; wire [5:0] OsE4gq672L2CGNAXeSEaJB; wire [6:0] GgrfOqRcaxmkrsZXEz2EHB; wire xJ4R8VNqbodTAoJ5qBWakE; wire r1zyq4RK7vjRgTJ1nekNXJC; wire vFz4R6k8JOFdInV6Fb9aRG; wire KiZWj0mahEHHRDPSWd5baF; wire [5:0] Qrg2nUduz0FREGaGYqoZGB; wire [5:0] dRK7KFO0TxLJ819RS3doqC; wire [5:0] ApjbxKFlfrMKN5V1iTtucB; wire BYbZHhGvMX4QR7ycL6rCAC; wire [5:0] vdKPk3yiqxPjQFWdUTebiG; wire h1gzQzZvUT2Yd8pPCgZGRtE; wire [6:0] zsBffc67ft1klACghJqIhC; wire RjxTbzhk008RPVk85SxhxF; wire O2tAPrLViSejJvkbfAH7s; wire hpo9oQMnpSw7bglz4LckXB; reg I6rlzjgqgJLiMBlIfHfhcD; wire signed [11:0] ARAgH3MEVpEgdWSYjPNY8D; wire signed [11:0] hmmK0a8CfdDPDddiriReq; reg signed [11:0] fAzTLE6teFC7ffRCl18D2C; reg signed [11:0] wtmOwKNLFi8YGzK2xo1AKD; wire signed [11:0] pVd5zCxuhom2fpyXqLRGmH; wire signed [11:0] baH36iOB60eviZK0Mg4WhD; wire AtceAeVL1Q5zsmTCSP7qU; always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : RuS1uQIWgOP3NAlCYxye5G if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin b6yijfyNmKV5BdUmtGckeCG <= 6'b000000; t99BRGvpXnYfW070gFJfuEB <= 6'b000001; A0dPc12vvjYXoCQ771n2u <= 6'b000000; Y8wotVpNqA2Szjh3yaiJWC <= 6'b000001; Xo78iXw7AIXeMqCqxBCGYB <= 7'b0000000; end else begin if (DKtuEu8YDlDAVk5CGQsPXB) begin b6yijfyNmKV5BdUmtGckeCG <= d6YO2kHtuvDGaPXh4DaE39D; t99BRGvpXnYfW070gFJfuEB <= eNCBiHkV5XNE3tSIUCnifG; A0dPc12vvjYXoCQ771n2u <= qtc234eIYM3QYpzpPPUA2E; Y8wotVpNqA2Szjh3yaiJWC <= OsE4gq672L2CGNAXeSEaJB; Xo78iXw7AIXeMqCqxBCGYB <= GgrfOqRcaxmkrsZXEz2EHB; end end end assign r1zyq4RK7vjRgTJ1nekNXJC = Xo78iXw7AIXeMqCqxBCGYB == 7'b1000000; assign xJ4R8VNqbodTAoJ5qBWakE = Xo78iXw7AIXeMqCqxBCGYB == 7'b0000000; assign vFz4R6k8JOFdInV6Fb9aRG = LmjEDLrU3PI8Sabg8ngJvE && (CrJ9V0NyelnCAici3JFjU || ( ! r1zyq4RK7vjRgTJ1nekNXJC)); assign KiZWj0mahEHHRDPSWd5baF = CrJ9V0NyelnCAici3JFjU && ( ! xJ4R8VNqbodTAoJ5qBWakE); assign Qrg2nUduz0FREGaGYqoZGB = (KiZWj0mahEHHRDPSWd5baF ? b6yijfyNmKV5BdUmtGckeCG + t99BRGvpXnYfW070gFJfuEB : b6yijfyNmKV5BdUmtGckeCG); assign eNCBiHkV5XNE3tSIUCnifG = (Qrg2nUduz0FREGaGYqoZGB == 6'b111111 ? 6'b000001 : 6'b000001); assign dRK7KFO0TxLJ819RS3doqC = (vFz4R6k8JOFdInV6Fb9aRG ? A0dPc12vvjYXoCQ771n2u + Y8wotVpNqA2Szjh3yaiJWC : A0dPc12vvjYXoCQ771n2u); assign OsE4gq672L2CGNAXeSEaJB = (dRK7KFO0TxLJ819RS3doqC == 6'b111111 ? 6'b000001 : 6'b000001); assign GgrfOqRcaxmkrsZXEz2EHB = (vFz4R6k8JOFdInV6Fb9aRG && ( ! KiZWj0mahEHHRDPSWd5baF) ? Xo78iXw7AIXeMqCqxBCGYB + 7'b0000001 : (( ! vFz4R6k8JOFdInV6Fb9aRG) && KiZWj0mahEHHRDPSWd5baF ? Xo78iXw7AIXeMqCqxBCGYB + 7'b1111111 : Xo78iXw7AIXeMqCqxBCGYB)); assign ApjbxKFlfrMKN5V1iTtucB = A0dPc12vvjYXoCQ771n2u; assign BYbZHhGvMX4QR7ycL6rCAC = vFz4R6k8JOFdInV6Fb9aRG; assign vdKPk3yiqxPjQFWdUTebiG = b6yijfyNmKV5BdUmtGckeCG; assign JBcW7PvN9lfFhg2YtEwCRG = xJ4R8VNqbodTAoJ5qBWakE; assign h1gzQzZvUT2Yd8pPCgZGRtE = r1zyq4RK7vjRgTJ1nekNXJC; assign zsBffc67ft1klACghJqIhC = Xo78iXw7AIXeMqCqxBCGYB; assign d6YO2kHtuvDGaPXh4DaE39D = Qrg2nUduz0FREGaGYqoZGB; assign qtc234eIYM3QYpzpPPUA2E = dRK7KFO0TxLJ819RS3doqC; assign RjxTbzhk008RPVk85SxhxF = zsBffc67ft1klACghJqIhC > 7'b0000000; assign O2tAPrLViSejJvkbfAH7s = 1'b0; assign hpo9oQMnpSw7bglz4LckXB = (RjxTbzhk008RPVk85SxhxF == 1'b0 ? O2tAPrLViSejJvkbfAH7s : CrJ9V0NyelnCAici3JFjU); always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : QE7tI09p0bA5gddUTZcXYF if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin I6rlzjgqgJLiMBlIfHfhcD <= 1'b0; end else begin if (DKtuEu8YDlDAVk5CGQsPXB) begin I6rlzjgqgJLiMBlIfHfhcD <= hpo9oQMnpSw7bglz4LckXB; end end end v1767WBgBisOyzyEOHDTTpH #(.AddrWidth(6), .DataWidth(12) ) vNqugBd2pFsYkdzbABFIv (.l0E5U5ysrwNYFWhaD6aOTT(l0E5U5ysrwNYFWhaD6aOTT), .DKtuEu8YDlDAVk5CGQsPXB(DKtuEu8YDlDAVk5CGQsPXB), .FPMCK36oW1c61jWtg6u10B(PKtQs4eZegSgKv8K61K8tF), .lQDDo3mMxpSArvViIGyPqG(BLYbhtIn0pQrUk5XotoFZ), .l30d1QakAt61ivcMw8sJQE(ApjbxKFlfrMKN5V1iTtucB), .UKo8akspo4h0jsZ6g712NB(BYbZHhGvMX4QR7ycL6rCAC), .EYQG62ys4E6V8lISAdlW1C(vdKPk3yiqxPjQFWdUTebiG), .nBdSW8RKULgPE8G4jdwvNE(ARAgH3MEVpEgdWSYjPNY8D), .wRuHKEftqyvH5AjWcxLn1E(hmmK0a8CfdDPDddiriReq) ); always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : wqvv4XnTmVZoV0S7OjnMfC if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin fAzTLE6teFC7ffRCl18D2C <= 12'sb000000000000; wtmOwKNLFi8YGzK2xo1AKD <= 12'sb000000000000; end else begin if (DKtuEu8YDlDAVk5CGQsPXB && I6rlzjgqgJLiMBlIfHfhcD) begin fAzTLE6teFC7ffRCl18D2C <= ARAgH3MEVpEgdWSYjPNY8D; wtmOwKNLFi8YGzK2xo1AKD <= hmmK0a8CfdDPDddiriReq; end end end assign pVd5zCxuhom2fpyXqLRGmH = (I6rlzjgqgJLiMBlIfHfhcD == 1'b0 ? fAzTLE6teFC7ffRCl18D2C : ARAgH3MEVpEgdWSYjPNY8D); assign baH36iOB60eviZK0Mg4WhD = (I6rlzjgqgJLiMBlIfHfhcD == 1'b0 ? wtmOwKNLFi8YGzK2xo1AKD : hmmK0a8CfdDPDddiriReq); assign rGd22Aw6N9OCFWLiKKTjp = pVd5zCxuhom2fpyXqLRGmH; assign e1ZDhCOeE2YtwVP3hGKF7m = baH36iOB60eviZK0Mg4WhD; endmodule