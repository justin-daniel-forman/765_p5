// s27_scan.v
//# 4 inputs
//# 1 outputs
//# 3 D-type flipflops
//# 8 (1 ANDs + 1 NANDs + 2 ORs + 4 NORs)

primitive dff(q, clock,  data);
   output q; reg q;
   input  clock, data;
     
   table
      // obtain output on rising edge of clock
      // clock data q q+
      (01) 0 : ? : 0 ;
      (01) 1 : ? : 1 ;
      (0?) 1 : 1 : 1 ;
      (0?) 0 : 0 : 0 ;
      // ignore negative edge of clock
      F ? : ? : - ;
      // ignore data changes on steady clock
      ? (??) : ? : - ;
      
   endtable
endprimitive // dff


module u_mux2(out, in0, in1, sel);
   output out;
   input in0, in1, sel;

   wire  nsel, w1, w0;
   not NOT0(nsel, sel);

   and AND0(w0, nsel, in0);
   and AND1(w1, sel, in1);

   or OR0(out, w1, w0);
endmodule // u_mux2
  

  `celldefine
module scanff(CK, SD, SI, SE, Q);
   input CK, SD, SI, SE;
   output Q;
   wire   a;
   dff  (Q, CK, a);  
   u_mux2  (a, SD, SI, SE);
 
endmodule // scanff
`endcelldefine
  
  
module s27_scan(CK, scan_en, scan_in, G0, G1, G2, G3, scan_out, G17);
   input CK, scan_en, scan_in, G0, G1, G2, G3;
   output scan_out, G17;

   wire   G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15, G16;

   assign scan_out = G7;
   
   
   scanff SFF_0(CK, G10, scan_in, scan_en, G5);
   scanff SFF_1(CK, G11, G5, scan_en, G6);
   scanff SFF_2(CK, G13, G6, scan_en, G7);
   
   not NOT_0(G14, G0);
   not NOT_1(G17, G11);
   and AND2_0(G8, G14, G6);
   or OR2_0(G15, G12, G8);
   or OR2_1(G16, G3, G8);
   nand NAND2_0(G9, G16, G15);
   nor NOR2_0(G10, G14, G11);
   nor NOR2_1(G11, G5, G9);
   nor NOR2_2(G12, G1, G7);
   nor NOR2_3(G13, G2, G12);

endmodule // s27_scan



   
   
  