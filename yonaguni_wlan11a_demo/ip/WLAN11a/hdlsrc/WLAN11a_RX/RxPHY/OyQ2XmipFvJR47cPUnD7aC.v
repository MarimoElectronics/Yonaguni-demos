`timescale 1 ns / 1 ns module OyQ2XmipFvJR47cPUnD7aC (l0E5U5ysrwNYFWhaD6aOTT, z2UJNE6Z3dXlstgbJ1NhIFE, DKtuEu8YDlDAVk5CGQsPXB, EQen1uPbgSJA8J6nEVg0ND, xj2txhdk3kH1ioK0rKOVrG, DAzsalMUs20cyxmbNzLeZC, JM1PWrdw4CsiaxhIFEj0FG, a624UH0hlmasds9DQmmpATB, p1uIcoV7v9bK8G4sjK7BUqC); input l0E5U5ysrwNYFWhaD6aOTT; input z2UJNE6Z3dXlstgbJ1NhIFE; input DKtuEu8YDlDAVk5CGQsPXB; input signed [11:0] EQen1uPbgSJA8J6nEVg0ND; input xj2txhdk3kH1ioK0rKOVrG; input DAzsalMUs20cyxmbNzLeZC; input [1:0] JM1PWrdw4CsiaxhIFEj0FG; output signed [11:0] a624UH0hlmasds9DQmmpATB; output signed [11:0] p1uIcoV7v9bK8G4sjK7BUqC; reg signed [11:0] tm6bEjtYn1HWVVuKhHadZB; reg signed [11:0] CcKGANvODMusIMYJ88xU0; reg signed [11:0] ovPvd9ibRoIsW59K4LZZhD; reg signed [11:0] qvTOr3mCdUnMTsGpjGWr7D; wire signed [11:0] jJn2pjvfKLRmpQA0UcTs5F; reg signed [11:0] oHNC5J2SzXKy4dtfzs4NNC; wire pHbbRhMg72YZp0KsD2fBKC; always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : WyTpyE1y453nTJapXODonG if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin tm6bEjtYn1HWVVuKhHadZB <= 12'sb000000000000; end else begin if (DKtuEu8YDlDAVk5CGQsPXB && xj2txhdk3kH1ioK0rKOVrG) begin tm6bEjtYn1HWVVuKhHadZB <= EQen1uPbgSJA8J6nEVg0ND; end end end always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : HgyVFZtlhxQUuRmln7pGTE if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin CcKGANvODMusIMYJ88xU0 <= 12'sb000000000000; end else begin if (DKtuEu8YDlDAVk5CGQsPXB && DAzsalMUs20cyxmbNzLeZC) begin CcKGANvODMusIMYJ88xU0 <= tm6bEjtYn1HWVVuKhHadZB; end end end always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : m9r58ngfLr61sGHIoAuCTgF if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin ovPvd9ibRoIsW59K4LZZhD <= 12'sb000000000000; end else begin if (DKtuEu8YDlDAVk5CGQsPXB && DAzsalMUs20cyxmbNzLeZC) begin ovPvd9ibRoIsW59K4LZZhD <= CcKGANvODMusIMYJ88xU0; end end end always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : ozskOk6vETADjBp5LRWFiH if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin qvTOr3mCdUnMTsGpjGWr7D <= 12'sb000000000000; end else begin if (DKtuEu8YDlDAVk5CGQsPXB && DAzsalMUs20cyxmbNzLeZC) begin qvTOr3mCdUnMTsGpjGWr7D <= ovPvd9ibRoIsW59K4LZZhD; end end end assign a624UH0hlmasds9DQmmpATB = qvTOr3mCdUnMTsGpjGWr7D; assign jJn2pjvfKLRmpQA0UcTs5F = (JM1PWrdw4CsiaxhIFEj0FG == 2'b00 ? tm6bEjtYn1HWVVuKhHadZB : (JM1PWrdw4CsiaxhIFEj0FG == 2'b01 ? CcKGANvODMusIMYJ88xU0 : (JM1PWrdw4CsiaxhIFEj0FG == 2'b10 ? ovPvd9ibRoIsW59K4LZZhD : qvTOr3mCdUnMTsGpjGWr7D))); always @(posedge l0E5U5ysrwNYFWhaD6aOTT) begin : vqqEKF4A2uy3lVSFXaewtF if (z2UJNE6Z3dXlstgbJ1NhIFE == 1'b1) begin oHNC5J2SzXKy4dtfzs4NNC <= 12'sb000000000000; end else begin if (DKtuEu8YDlDAVk5CGQsPXB) begin oHNC5J2SzXKy4dtfzs4NNC <= jJn2pjvfKLRmpQA0UcTs5F; end end end assign p1uIcoV7v9bK8G4sjK7BUqC = oHNC5J2SzXKy4dtfzs4NNC; endmodule