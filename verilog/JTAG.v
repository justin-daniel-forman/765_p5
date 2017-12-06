// Basic unit for boundary scan register. Units can be daisy-chained
// to form a larger scan chain.
module SFF(
    input   wire TDI,       //Scan chain input
    input   wire hold,      //Hold the dout=din when asserted
    input   wire din,       //System data in
    input   wire clockdr,   //Clock for capture ff
    input   wire updatedr,  //Clock for update ff
    input   wire shiftdr,   //Selects between system data and scan chain input
    input   wire TMS,       //Selects between scanchain and test for output
    output  wire TDO,       //Scan chain output
    output  wire dout       //System data out
);

    wire sl_mux; //shift-load
    wire tn_mux; //test-normal
    wire capture_out;
    wire update_out;

    assign sl_mux = (shiftdr) ? TDI : din;

    udff capture_ff (capture_out, clockdr, sl_mux);
    assign TDO = capture_out;

    udff update_ff  (update_out, updatedr, capture_out);

    //To get normal mode, TMS=global_TDI=1
    //To hold values of scan, keep global TDI=0 while performing test
    assign tn_mux  = (TMS & hold) ? din : update_out;
    assign dout    = tn_mux;

endmodule //SFF


// Chain of ffs to store the JTAG instruction
module IR (
    input   wire        clockir,
    input   wire        shiftir,
    input   wire        updateir,
    input   wire        TDI,
    output  wire [1:0]  inst,
    output  wire        TDO
);

    wire s0_out;
    wire s1_out;

    //Create 2 muxes with enable
    dff s0 (s0_out, clockir, (shiftir) ? TDI : 1'bx);
    dff s1 (s1_out, clockir, (shiftir) ? s0_out : s1_out);
    assign TDO = s1_out;

    wire u0_out;
    wire u1_out;

    dff u0 (u0_out, updateir, s0_out);
    dff u1 (u1_out, updateir, s1_out);
    assign inst = {u1_out, u0_out};

endmodule //IR


// Combinational logic to interpret the JTAG instruction into control signals
module ID (
    input  wire [1:0]  inst,
    output wire [1:0]  sel
);

    assign sel = inst;

endmodule //ID
