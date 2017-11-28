// tapcntlr.v

module tapcontroller(TCK, TRST, TMS, clockdr, shiftdr, updatedr, clockir,
		     shiftir, updateir, select, bs_en);

   input TCK, TRST, TMS;
   output clockdr, shiftdr, updatedr, clockir,
	  shiftir, updateir, select, bs_en;

   wire   ps3, ps2, ps1, ps0;
   wire   nps3, nps2, nps1, nps0;
   wire   ns3, ns2, ns1, ns0;
   wire   nTMS;
   wire   nTCK;
   
   wire   w30, w31, w32, w33, w34, w35;
   wire   w20, w21, w22, w23;
   wire   w10, w11, w12;
   wire   w00, w01, w02, w03, w04, w05, w06, w07, w08;
   wire   w0, w1, w2, w3;
   wire   sir, clockdreg, bsen;
   
   not NOT_TCK(nTCK, TCK);
   not NOT_TMS(nTMS, TMS);
   not NOT_ps3(nps3, ps3);
   not NOT_ps2(nps2, ps2);
   not NOT_ps1(nps1, ps1);
   not NOT_ps0(nps0, ps0);   
   
   //next state3
   // NS3 = PS3(PS1 + PS0) + TMS(PS3 PS2' + PS2' PS1' PS0)
   dff_r DFF3(ps3, TCK, TRST, ns3);
   or OR2_30(w30, ps1, ps0);
   and AND2_30(w31, ps3, w30);
   and AND2_31(w32, ps3, nps2);
   and AND3_30(w33, nps2, nps1, ps0);
   or OR2_31(w34, w32, w33);
   and AND2_32(w35, TMS, w34);
   or OR2_32(ns3, w31, w35);
   
   //next state2
   // NS2 = PS2 PS1 + TMS(PS1 + PS2 PS0)
   dff_r DFF2(ps2, TCK, TRST, ns2);
   and AND2_20(w20, ps2, ps1);
   and AND2_21(w21, ps2, ps0);
   or OR2_20(w22, w21, ps1);
   and AND2_22(w23, w22, TMS);
   or OR2_21(ns2, w20, w23);

   //next state1
   // NS1 = PS2' PS1 + TMS'(PS0 + PS1)
   dff_r DFF1(ps1, TCK, TRST, ns1);
   and AND2_10(w10, nps2, ps1);
   or OR2_10(w11, ps1, ps0);
   and AND2_12(w12, nTMS, w11);
   or OR3_10(ns1, w10, w12);

   //next state0
   // NS0 = PS2 PS1 PS0 + TMS'(PS2 PS1 + PS2' PS1' PS0) + TMS(PS3' PS2' PS1' + PS2 PS1' PS0')
   dff_r DFF0(ps0, TCK, TRST, ns0);
   and AND3_00(w00, ps2, ps1, ps0);
   and AND3_01(w01, ps2, ps1);
   and AND3_02(w02, nps2, nps1, ps0);
   or OR2_00(w03, w01, w02);
   and AND2_00(w04, w03, nTMS);
   and AND3_03(w05, nps3, nps2, nps1);
   and AND3_04(w06, ps2, nps1, nps0);
   or OR3_00(w07, w05, w06);
   and AND2_01(w08, TMS, w07);
   or OR3_01(ns0, w00, w04, w08);

   //output signal definitions
   // clockdr = 001X
   and AND4_0(clockdreg, nps3, nps2, ps1, nTCK);
   buf BUF_0(clockdr, clockdreg);
  
   // shiftdr = 0010
   and AND4_1(shiftdr, nps3, nps2, ps1, nps0);

   // updatedr = 0100
   and AND5_0(updatedr, nps3, ps2, nps1, nps0, nTCK);
   // clockir = 101X
   and AND4_2(clockir, ps3, nps2, ps1, nTCK);

   // shiftir = 1010
   and AND4_3(sir, ps3, nps2, ps1, nps0);
   dff DFF_5(shiftir, nTCK, sir);
   
   // updateir = 1100
   and AND5_1(updateir, ps3, ps2, nps1, nps0, nTCK);

   // select == 1XXX
   assign select = ps3;

   // bs_en = not 1000
   and AND4_4(w3, ps3, nps2, nps1, nps0);
   not NOT_2(bsen, w3);
   dff DFF_6(bs_en, nTCK, bsen);

endmodule // tapcontroller


		

   
   
