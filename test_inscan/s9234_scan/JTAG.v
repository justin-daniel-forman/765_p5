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
    wire capture_out;
    wire update_out;

    u_mux2 sl(sl_mux, din, TDI, shiftdr);

    udff capture_ff (capture_out, clockdr, sl_mux);
    assign TDO = capture_out;

    udff update_ff  (update_out, updatedr, capture_out);
    u_mux2 tn_mux(dout, din, update_out, hold);

endmodule //SFF

module int_SFF(
    input   wire tdi,       //local shift input from prev scan stage
    input   wire hold,      //determines normal vs test operation output
    input   wire din,       //local data in from normal ff
    input   wire ck,        //Normal system clock
    input   wire clockdr,   //Clock used for scanchain flops
    input   wire updatedr,  //captures current value of din
    input   wire shiftdr,   //propagates tdo from prev stage
    output  wire tdo,       //local shift output from curr scan stage
    output  wire dout       //local data out from normal ff
);

    wire normal_out;
    wire scan_in;
    wire scan_out;

    //Normal execution occurs in normal FF regardless of control signals
    udff normal_ff(normal_out, ck, din);

    //FIXME: Do we even need to use update_out?
    udff cap_ff  (cap_out, updatedr, din);
    u_mux2 scan_sel(scan_in, cap_out, tdi, shiftdr);
    udff scan_ff  (scan_out, clockdr, scan_in);

    //Output is muxed btwn scanout and normal_out, but select line can
    //never be unknown else normal operation will be broken
    assign tdo = scan_out;
    u_mux2 data_sel(dout, normal_out, tdo, hold);

endmodule //int_SFF

//module int_SFF(
//    input   wire TDI,       //Scan chain input
//    input   wire hold,      //Hold the dout=din when asserted
//    input   wire din,       //System data in
//    input   wire clockdr,   //Clock for capture ff
//    input   wire updatedr,  //Clock for update ff
//    input   wire shiftdr,   //Selects between system data and scan chain input
//    input   wire TMS,       //Selects between scanchain and test for output
//    input   wire TMS_delay, //Used to hold the output of the update reg
//    output  wire TDO,       //Scan chain output
//    output  wire dout       //System data out
//);
//
//    wire sl_mux; //shift-load
//    wire tn_mux; //test-normal
//    wire capture_out;
//    wire update_out;
//
//    //Hold can't even be reset because we can't set reset to 0 during shift
//    //operation, otherwise the TAP controller would never advance. So reset
//    //cannot be used to gate these transitions.
//    assign sl_mux = (shiftdr & ~hold) ? TDI : din;
//
//    udff capture_ff (capture_out, clockdr, sl_mux);
//    assign TDO = capture_out;
//
//    udff update_ff  (update_out, updatedr, capture_out);
//
//    //We need a way similar to the regular SFF to make sure that we can hold
//    //the values of scan on the output when TMS is cycling. Normal operation
//    //should be achieved when TMS=TDI=1. I don't see a reason why this can't
//    //be the same as the previous step.
//    assign tn_mux  = (TMS & TMS_delay) ? capture_out : update_out;
//    assign dout    = tn_mux;
//
//endmodule //int_SFF

//TODO: Create SFF LSFR module to double as LSFR
//This will be used for BIST

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


//FIXME: This should just be an addition to the SFF module w/ an xor gate
//LSFR register implementation
module LSFR(
    input  wire         sin,
    output wire [245:0] pout
);


endmodule //LSFR
