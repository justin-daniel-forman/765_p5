// s27_comb.v
//# 4 inputs
//# 1 outputs
//# 3 D-type flipflops
//# 8 (1 ANDs + 1 NANDs + 2 ORs + 4 NORs)

module s27_comb(G0, G1, G2, G3, G5, G6, G7, G17, G10, G11, G13);
   input G0, G1, G2, G3, G5, G6, G7;
   output G17, G10, G11, G13;

   wire   G8, G9, G12, G14, G15, G16;

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

endmodule // s27_comb
