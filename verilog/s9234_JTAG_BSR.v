//`include "./*"

module s9234_JTAG_BSR(CK,g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,
  g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
  g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
  g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
  g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
  g639,g6728,g702,g705,g89,g94,g98,clockdr_is,updatedr_is,shiftdr_is,clockdr_bs,
  updatedr_bs,shiftdr_bs,TMS,TDI,TDO_BSR,TDO_ISR,TRST,TCLK,inst);

  input CK,g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
  g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
  g41,g22,g44,g23,clockdr_is,updatedr_is,shiftdr_is,clockdr_bs,updatedr_bs,
  shiftdr_bs,TMS,TDI,TRST,TCLK;

  input [1:0] inst;

  output g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,
  g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,
  g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,
  g4104,g4107,g4098,TDO_BSR,TDO_ISR;

  // intermediary wires
  wire tdi_g89,tdi_g94,tdi_g98,tdi_g102,tdi_g107,tdi_g301,tdi_g306,tdi_g310,
  tdi_g314,tdi_g319,tdi_g557,tdi_g558,tdi_g559,tdi_g560,tdi_g561,tdi_g562,
  tdi_g563,tdi_g564,tdi_g705,tdi_g639,tdi_g567,tdi_g45,tdi_g42,tdi_g39,
  tdi_g702,tdi_g32,tdi_g38,tdi_g46,tdi_g36,tdi_g47,tdi_g40,tdi_g37,tdi_g41,
  tdi_g22,tdi_g44,tdi_g23,tdi_g2584,tdi_g3222,tdi_g3600,tdi_g4307,tdi_g4321,
  tdi_g4422,tdi_g4809,tdi_g5137,tdi_g5468,tdi_g5469,tdi_g5692,tdi_g6282,
  tdi_g6284,tdi_g6360,tdi_g6362,tdi_g6364,tdi_g6366,tdi_g6368,tdi_g6370,
  tdi_g6372,tdi_g6374,tdi_g6728,tdi_g1290,tdi_g4121,tdi_g4108,tdi_g4106,
  tdi_g4103,tdi_g1293,tdi_g4099,tdi_g4102,tdi_g4109,tdi_g4100,tdi_g4112,
  tdi_g4105,tdi_g4101,tdi_g4110,tdi_g4104,tdi_g4107,tdi_g4098;

  // to and from s9234
  wire cut_g102,cut_g107,cut_g1290,cut_g1293,cut_g22,cut_g23,cut_g2584,
  cut_g301,cut_g306,cut_g310,cut_g314,cut_g319,cut_g32,cut_g3222,cut_g36,
  cut_g3600,cut_g37,cut_g38,cut_g39,cut_g40,cut_g4098,cut_g4099,cut_g41,
  cut_g4100,cut_g4101,cut_g4102,cut_g4103,cut_g4104,cut_g4105,cut_g4106,
  cut_g4107,cut_g4108,cut_g4109,cut_g4110,cut_g4112,cut_g4121,cut_g42,
  cut_g4307,cut_g4321,cut_g44,cut_g4422,cut_g45,cut_g46,cut_g47,cut_g4809,
  cut_g5137,cut_g5468,cut_g5469,cut_g557,cut_g558,cut_g559,cut_g560,cut_g561,
  cut_g562,cut_g563,cut_g564,cut_g567,cut_g5692,cut_g6282,cut_g6284,cut_g6360,
  cut_g6362,cut_g6364,cut_g6366,cut_g6368,cut_g6370,cut_g6372,cut_g6374,
  cut_g639,cut_g6728,cut_g702,cut_g705,cut_g89,cut_g94,cut_g98;

  // instantiating s9234 as CUT
  //Internal scan chain enabled when normal mode is off && instruction is 2'b11
  wire int_hold;
  assign int_hold = (~(TMS & ~TRST) & (inst == 2'b11));

  s9234_inscan s9234_IS(CK,cut_g102,cut_g107,cut_g1290,cut_g1293,cut_g22,cut_g23,
  cut_g2584,cut_g301,cut_g306,cut_g310,cut_g314,cut_g319,cut_g32,cut_g3222,
  cut_g36,cut_g3600,cut_g37,cut_g38,cut_g39,cut_g40,cut_g4098,cut_g4099,cut_g41,
  cut_g4100,cut_g4101,cut_g4102,cut_g4103,cut_g4104,cut_g4105,cut_g4106,
  cut_g4107,cut_g4108,cut_g4109,cut_g4110,cut_g4112,cut_g4121,cut_g42,
  cut_g4307,cut_g4321,cut_g44,cut_g4422,cut_g45,cut_g46,cut_g47,cut_g4809,
  cut_g5137,cut_g5468,cut_g5469,cut_g557,cut_g558,cut_g559,cut_g560,cut_g561,
  cut_g562,cut_g563,cut_g564,cut_g567,cut_g5692,cut_g6282,cut_g6284,cut_g6360,
  cut_g6362,cut_g6364,cut_g6366,cut_g6368,cut_g6370,cut_g6372,cut_g6374,
  cut_g639,cut_g6728,cut_g702,cut_g705,cut_g89,cut_g94,cut_g98,clockdr_is,updatedr_is,
  shiftdr_is,TDI,TDO_ISR,int_hold);

  // input scan registers
  //External scan chain enabled when normal mode is off && instruction is 2'b00
  wire ext_hold;
  assign ext_hold = (~(TMS & ~TRST) & (inst == 2'b00));

  SFF sff_g89(TDI,      ext_hold,g89, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g94,cut_g89);
  SFF sff_g94(tdi_g94,  ext_hold,g94, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g98,cut_g94);
  SFF sff_g98(tdi_g98,  ext_hold,g98, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g102,cut_g98);
  SFF sff_g102(tdi_g102,ext_hold,g102,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g107,cut_g102);
  SFF sff_g107(tdi_g107,ext_hold,g107,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g301,cut_g107);
  SFF sff_g301(tdi_g301,ext_hold,g301,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g306,cut_g301);
  SFF sff_g306(tdi_g306,ext_hold,g306,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g310,cut_g306);
  SFF sff_g310(tdi_g310,ext_hold,g310,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g314,cut_g310);
  SFF sff_g314(tdi_g314,ext_hold,g314,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g319,cut_g314);
  SFF sff_g319(tdi_g319,ext_hold,g319,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g557,cut_g319);
  SFF sff_g557(tdi_g557,ext_hold,g557,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g558,cut_g557);
  SFF sff_g558(tdi_g558,ext_hold,g558,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g559,cut_g558);
  SFF sff_g559(tdi_g559,ext_hold,g559,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g560,cut_g559);
  SFF sff_g560(tdi_g560,ext_hold,g560,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g561,cut_g560);
  SFF sff_g561(tdi_g561,ext_hold,g561,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g562,cut_g561);
  SFF sff_g562(tdi_g562,ext_hold,g562,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g563,cut_g562);
  SFF sff_g563(tdi_g563,ext_hold,g563,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g564,cut_g563);
  SFF sff_g564(tdi_g564,ext_hold,g564,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g705,cut_g564);
  SFF sff_g705(tdi_g705,ext_hold,g705,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g639,cut_g705);
  SFF sff_g639(tdi_g639,ext_hold,g639,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g567,cut_g639);
  SFF sff_g567(tdi_g567,ext_hold,g567,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g45,cut_g567);
  SFF sff_g45(tdi_g45,  ext_hold,g45, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g42,cut_g45);
  SFF sff_g42(tdi_g42,  ext_hold,g42, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g39,cut_g42);
  SFF sff_g39(tdi_g39,  ext_hold,g39, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g702,cut_g39);
  SFF sff_g702(tdi_g702,ext_hold,g702,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g32,cut_g702);
  SFF sff_g32(tdi_g32,  ext_hold,g32, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g38,cut_g32);
  SFF sff_g38(tdi_g38,  ext_hold,g38, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g46,cut_g38);
  SFF sff_g46(tdi_g46,  ext_hold,g46, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g36,cut_g46);
  SFF sff_g36(tdi_g36,  ext_hold,g36, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g47,cut_g36);
  SFF sff_g47(tdi_g47,  ext_hold,g47, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g40,cut_g47);
  SFF sff_g40(tdi_g40,  ext_hold,g40, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g37,cut_g40);
  SFF sff_g37(tdi_g37,  ext_hold,g37, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g41,cut_g37);
  SFF sff_g41(tdi_g41,  ext_hold,g41, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g22,cut_g41);
  SFF sff_g22(tdi_g22,  ext_hold,g22, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g44,cut_g22);
  SFF sff_g44(tdi_g44,  ext_hold,g44, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g23,cut_g44);
  SFF sff_g23(tdi_g23,  ext_hold,g23, clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g2584,cut_g23);

  // output scan registers
  SFF sff_g2584(tdi_g2584,ext_hold,cut_g2584,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g3222,g2584);
  SFF sff_g3222(tdi_g3222,ext_hold,cut_g3222,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g3600,g3222);
  SFF sff_g3600(tdi_g3600,ext_hold,cut_g3600,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4307,g3600);
  SFF sff_g4307(tdi_g4307,ext_hold,cut_g4307,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4321,g4307);
  SFF sff_g4321(tdi_g4321,ext_hold,cut_g4321,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4422,g4321);
  SFF sff_g4422(tdi_g4422,ext_hold,cut_g4422,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4809,g4422);
  SFF sff_g4809(tdi_g4809,ext_hold,cut_g4809,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g5137,g4809);
  SFF sff_g5137(tdi_g5137,ext_hold,cut_g5137,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g5468,g5137);
  SFF sff_g5468(tdi_g5468,ext_hold,cut_g5468,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g5469,g5468);
  SFF sff_g5469(tdi_g5469,ext_hold,cut_g5469,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g5692,g5469);
  SFF sff_g5692(tdi_g5692,ext_hold,cut_g5692,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6282,g5692);
  SFF sff_g6282(tdi_g6282,ext_hold,cut_g6282,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6284,g6282);
  SFF sff_g6284(tdi_g6284,ext_hold,cut_g6284,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6360,g6284);
  SFF sff_g6360(tdi_g6360,ext_hold,cut_g6360,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6362,g6360);
  SFF sff_g6362(tdi_g6362,ext_hold,cut_g6362,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6364,g6362);
  SFF sff_g6364(tdi_g6364,ext_hold,cut_g6364,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6366,g6364);
  SFF sff_g6366(tdi_g6366,ext_hold,cut_g6366,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6368,g6366);
  SFF sff_g6368(tdi_g6368,ext_hold,cut_g6368,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6370,g6368);
  SFF sff_g6370(tdi_g6370,ext_hold,cut_g6370,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6372,g6370);
  SFF sff_g6372(tdi_g6372,ext_hold,cut_g6372,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6374,g6372);
  SFF sff_g6374(tdi_g6374,ext_hold,cut_g6374,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g6728,g6374);
  SFF sff_g6728(tdi_g6728,ext_hold,cut_g6728,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g1290,g6728);
  SFF sff_g1290(tdi_g1290,ext_hold,cut_g1290,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4121,g1290);
  SFF sff_g4121(tdi_g4121,ext_hold,cut_g4121,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4108,g4121);
  SFF sff_g4108(tdi_g4108,ext_hold,cut_g4108,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4106,g4108);
  SFF sff_g4106(tdi_g4106,ext_hold,cut_g4106,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4103,g4106);
  SFF sff_g4103(tdi_g4103,ext_hold,cut_g4103,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g1293,g4103);
  SFF sff_g1293(tdi_g1293,ext_hold,cut_g1293,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4099,g1293);
  SFF sff_g4099(tdi_g4099,ext_hold,cut_g4099,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4102,g4099);
  SFF sff_g4102(tdi_g4102,ext_hold,cut_g4102,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4109,g4102);
  SFF sff_g4109(tdi_g4109,ext_hold,cut_g4109,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4100,g4109);
  SFF sff_g4100(tdi_g4100,ext_hold,cut_g4100,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4112,g4100);
  SFF sff_g4112(tdi_g4112,ext_hold,cut_g4112,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4105,g4112);
  SFF sff_g4105(tdi_g4105,ext_hold,cut_g4105,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4101,g4105);
  SFF sff_g4101(tdi_g4101,ext_hold,cut_g4101,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4110,g4101);
  SFF sff_g4110(tdi_g4110,ext_hold,cut_g4110,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4104,g4110);
  SFF sff_g4104(tdi_g4104,ext_hold,cut_g4104,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4107,g4104);
  SFF sff_g4107(tdi_g4107,ext_hold,cut_g4107,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,tdi_g4098,g4107);
  SFF sff_g4098(tdi_g4098,ext_hold,cut_g4098,clockdr_bs,updatedr_bs,shiftdr_bs,TMS,TDO_BSR,g4098);

endmodule;
