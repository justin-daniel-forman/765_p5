module TOP_TB();

    //Inputs
    reg CK,g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
    g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
    g41,g22,g44,g23,TDI,TMS,TCLK,TRST;

    //Outputs
    wire g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,
    g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,
    g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,
    g4104,g4107,g4098,TDO;

    s9234_JTAG_TOP DUT(TMS,CK,g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,
        g32,g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
        g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
        g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
        g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
        g639,g6728,g702,g705,g89,g94,g98,TDI,TCLK,TRST,TDO);


    //Clock generation
    initial begin
        TCLK = 0;
        CK  = 0;
        forever #50 TCLK = ~TCLK; //Slower scan clock
        forever #10 CK  = ~CK; //Faster system clock
    end

    //Begin Test bench
    initial begin

        reset_fsm();
        shift_into_ir({1'b1, 1'b0});
        shift_into_dr(36'h2_ffff_fff1);

        //$display("My instruction should be 11, and is: %b\n\n", inst);

        $finish;
    end

    //Brings us into the Run Test State
    task reset_fsm ();
        begin
            //FIXME: The reset state doesn't match the diagram depicted in the
            //       lecture notes.
            //Reset the FSM to "Run Test or Idle"
            TMS  = 1;
            TRST = 0;
            TDI  = 0;
            @(posedge TCLK);
            @(posedge TCLK);
            @(posedge TCLK);
            @(posedge TCLK);

            TRST = 1;
            TMS  = 1;
            @(posedge TCLK); //Advance to Select DR Scan
            @(posedge TCLK); //Advance to Select IR Scan
            @(posedge TCLK); //Advance to Test Logic

            TMS = 0;
            @(posedge TCLK); //Advance to Run Test
        end
    endtask


    //Starts in the Run Test State and ends in the Run Test State
    //Shifts the vector v into the BSR
    task shift_into_dr(input [35:0] v);
        integer ii;
        begin
            TDI = 0;
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture DR
            @(posedge TCLK); //Advance to Shift DR

            ii = 0;
            while(ii < 36) begin
                TDI = v[ii];
                @(posedge TCLK); //Shift in test vector bit

                TMS = 1;
                @(posedge TCLK); //Advance to Exit1 DR

                // Return back to the initial state if we aren't done
                if(ii == 35) begin
                    @(posedge TCLK); //Advance to Update DR
                    TMS = 0;
                    @(posedge TCLK); //Advance to Run Test

                // Loop back and keep shifting
                end else begin
                    TMS = 0;
                    @(posedge TCLK); //Advance to Pause DR

                    TMS = 1;
                    TDI = v[1];
                    @(posedge TCLK); //Advance to Exit2 DR

                    TMS = 0;
                    @(posedge TCLK); //Advance to Shift IR
                end

                ii = ii + 1;
            end

            $display("DR contains: %h", {
                DUT.BSR.tdi_g94,
                DUT.BSR.tdi_g98,
                DUT.BSR.tdi_g102,
                DUT.BSR.tdi_g107,
                DUT.BSR.tdi_g301,
                DUT.BSR.tdi_g306,
                DUT.BSR.tdi_g310,
                DUT.BSR.tdi_g314,
                DUT.BSR.tdi_g319,
                DUT.BSR.tdi_g557,
                DUT.BSR.tdi_g558,
                DUT.BSR.tdi_g559,
                DUT.BSR.tdi_g560,
                DUT.BSR.tdi_g561,
                DUT.BSR.tdi_g562,
                DUT.BSR.tdi_g563,
                DUT.BSR.tdi_g564,
                DUT.BSR.tdi_g705,
                DUT.BSR.tdi_g639,
                DUT.BSR.tdi_g567,
                DUT.BSR.tdi_g45,
                DUT.BSR.tdi_g42,
                DUT.BSR.tdi_g39,
                DUT.BSR.tdi_g702,
                DUT.BSR.tdi_g32,
                DUT.BSR.tdi_g38,
                DUT.BSR.tdi_g46,
                DUT.BSR.tdi_g36,
                DUT.BSR.tdi_g47,
                DUT.BSR.tdi_g40,
                DUT.BSR.tdi_g37,
                DUT.BSR.tdi_g41,
                DUT.BSR.tdi_g22,
                DUT.BSR.tdi_g44,
                DUT.BSR.tdi_g23,
                DUT.BSR.tdi_g2584 }
            );
        end
    endtask


    //Starts in the Run Test state and ends in the Run Test state
    task shift_into_ir (input [1:0] v);
        begin
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan
            @(posedge TCLK); //Advance to Select IR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture IR
            @(posedge TCLK); //Advance to Shift IR

            //FIXME: Do we need to go through an entire loop to shift in one bit?
            //       shiftir stays high from TAP, so using that value as a clock
            //       wont allow us to shift in multiple bits in this state.
            TDI = v[0];
            @(posedge TCLK); //Shift in 1

            TMS = 1;
            @(posedge TCLK); //Advance to Exit IR

            TMS = 0;
            @(posedge TCLK); //Advance to Pause IR

            TMS = 1;
            TDI = v[1];
            @(posedge TCLK); //Advance to Exit2 IR

            TMS = 0;
            @(posedge TCLK); //Advance to Shift IR

            TMS = 1;
            @(posedge TCLK); //Advance to Exit1 IR
            @(posedge TCLK); //Advance to Update IR

            TMS = 0;
            @(posedge TCLK); //Advance to Run Test
        end
    endtask

endmodule //TOP_TB
