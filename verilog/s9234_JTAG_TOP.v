//`include "./*"

module s9234_JTAG_TOP(CK,g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,
  g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
  g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
  g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
  g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
  g639,g6728,g702,g705,g89,g94,g98,TMS,SI_TDI,TRST,SO_TDI);

  input CK,g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
  g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
  g41,g22,g44,g23,SI_TDI,TMS,TRST;

  output g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,
  g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,
  g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,
  g4104,g4107,g4098,SO_TDI;

  wire TDI;
  wire TDO;

  assign TDI = SI_TDI;
  assign SO_TDI = TDO;

  // intermediary wires
  wire clockdr, shiftdr, updatedr, clockir, shiftir, updateir, select, bs_en;
  wire [1:0] inst, sel;
  wire TDO_BSR, TDO_IR, TDO_BYR;
  wire TDO_scan,TDO_interm, TDO_buff;
  wire shift_dr_bs, shift_dr_is;
  wire update_dr_bs, update_dr_is;
  wire clock_dr_bs, clock_dr_is;
  wire nsel1;

  not NOT0(nsel1, sel[1]);
  and AND0(shiftdr_is, shiftdr, sel[1]);
  and AND1(shiftdr_bs, shiftdr, nsel1);
  and AND2(updatedr_is, updatedr, sel[1]);
  and AND3(updatedr_bs, updatedr, nsel1);
  and AND4(clockdr_is, clockdr, sel[1]);
  and AND5(clockdr_bs, clockdr, nsel1);

  // instantiating TAP controller
  tapcontroller tapcontroller(CK, TRST, TMS, clockdr, shiftdr, updatedr, clockir,
    shiftir, updateir, select, bs_en);

  // instantiating BSR
  s9234_JTAG_BSR BSR(CK,g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,
  g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
  g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
  g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
  g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
  g639,g6728,g702,g705,g89,g94,g98,clockdr_is,updatedr_is,shiftdr_is,clockdr_bs,
  updatedr_bs,shiftdr_bs,TMS,TDI,TDO_BSR,TDO_ISR,TRST,CK,sel);

  // instantiating instruction registers
  IR inst_regs(clockir, shiftir, updateir, TDI, inst, TDO_IR);

  // instantiating instruction decode
  ID inst_decode(inst, sel);

  // instantiating bypass register
  dff dff_bypass(TDO_BYR, clockdr, TDI);

  // muxing/buffering TDO; CHECK CODES
  u_mux2 mux0(TDO_scan, TDO_BSR, TDO_ISR, sel[1]);
  u_mux2 mux1(TDO_interm, TDO_scan, TDO_BYR, sel[0]);
  u_mux2 mux2(TDO_buff, TDO_interm, TDO_IR, select);

  and and0(TDO, TDO_buff, bs_en);

endmodule
