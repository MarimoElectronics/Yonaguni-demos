`timescale 1 ns / 1 ns module kQCfAfjcOud3KrIc730QTB (u8cUe2DkyoOkAR5eawtqIBF, b2cJ9T12ssQ0rnoz4HsvwC, l9Uq2DcdltO2vnVoNB81YD, dRDBQjO1p1bo54I09zXw4G, DOkhr6Vn0VKmAgjqXOXOID, Kk4eYyUFcnv4uELwBh7bpG); input [9:0] u8cUe2DkyoOkAR5eawtqIBF; input [9:0] b2cJ9T12ssQ0rnoz4HsvwC; input [9:0] l9Uq2DcdltO2vnVoNB81YD; input [9:0] dRDBQjO1p1bo54I09zXw4G; output DOkhr6Vn0VKmAgjqXOXOID; output [9:0] Kk4eYyUFcnv4uELwBh7bpG; wire [9:0] dvAtbe3iWkA5HKErl0GSmB; wire [9:0] JyGfGoSmisQ1VI1GyxMiUE; wire igWwj37zoLbvMLlrefWxbF; wire mbauXhPHVy9GLdY3qsrY1E; assign dvAtbe3iWkA5HKErl0GSmB = u8cUe2DkyoOkAR5eawtqIBF + l9Uq2DcdltO2vnVoNB81YD; assign JyGfGoSmisQ1VI1GyxMiUE = b2cJ9T12ssQ0rnoz4HsvwC + dRDBQjO1p1bo54I09zXw4G; assign igWwj37zoLbvMLlrefWxbF = dvAtbe3iWkA5HKErl0GSmB > JyGfGoSmisQ1VI1GyxMiUE; assign DOkhr6Vn0VKmAgjqXOXOID = igWwj37zoLbvMLlrefWxbF; assign Kk4eYyUFcnv4uELwBh7bpG = (igWwj37zoLbvMLlrefWxbF == 1'b0 ? dvAtbe3iWkA5HKErl0GSmB : JyGfGoSmisQ1VI1GyxMiUE); endmodule