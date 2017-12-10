module dff_test(q, clock, data);

    output wire q;
    input wire clock;
    input wire data;

    assign q = 0;

endmodule


module REF_TB();

    //Inputs
    reg CK,g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
    g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
    g41,g22,g44,g23;

    //Outputs
    wire g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,
    g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,
    g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,
    g4104,g4107,g4098;


    s9234_test DUT(CK,g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,
        g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
        g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
        g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
        g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
        g639,g6728,g702,g705,g89,g94,g98);


    initial begin
        CK = 0;
        forever #10 CK = ~CK;
    end

    //Begin Test bench
    integer ii;
    initial begin

        assign {g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
        g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
        g41,g22,g44,g23} = 0;

        $monitor($stime,, "%h", {g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,
            g5468,g5469,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,
            g6374,g6728,g1290,g4121,g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,
            g4112,g4105,g4101,g4110,g4104,g4107,g4098});


        for(ii = 0; ii < 100; ii = ii+1) begin
            @(posedge CK);
        end

        $finish;
    end

endmodule //REF_TB
