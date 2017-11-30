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
        forever #50 TCLK = ~TCLK; //Slower scan clock
    end

    initial begin
        CK = 0;
        forever #10 CK = ~CK;
    end

    //Begin Test bench
    integer jj;
    reg [38:0] r;
    initial begin

        //$monitor($stime,, "TRST: %b, TDI: %b, TMS: %b", TRST, TDI, TMS);

        reset_fsm();
        shift_into_ir(2'b00);
        shift_into_dr(35'h0);
        //shift_into_dr(35'h0deadbeef);

        //Run the test
        jj = 0;
        while(jj < 100) begin
            @(posedge CK);
            @(posedge TCLK);
            jj = jj + 1;
        end

        shift_out_data(r);

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
    task shift_into_dr(input [34:0] v);
        integer ii;
        begin
            TDI = 0;
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture DR
            @(posedge TCLK); //Advance to Shift DR

            ii = 0;
            while(ii < 35) begin

                TDI = v[ii];
                @(posedge TCLK); //Shift in test vector bit

                // Return back to the initial state if we aren't done
                if(ii == 34) begin

                    TMS = 1;
                    @(posedge TCLK); //Advance to Exit1 DR
                    @(posedge TCLK); //Advance to Update DR

                    TMS = 0;
                    @(posedge TCLK); //Advance to Run Test
                    @(posedge TCLK);

                end
                ii = ii + 1;
            end

            $display("DR contains: %h", {
                DUT.BSR.cut_g89,
                DUT.BSR.cut_g94,
                DUT.BSR.cut_g98,
                DUT.BSR.cut_g102,
                DUT.BSR.cut_g107,
                DUT.BSR.cut_g301,
                DUT.BSR.cut_g306,
                DUT.BSR.cut_g310,
                DUT.BSR.cut_g314,
                DUT.BSR.cut_g319,
                DUT.BSR.cut_g557,
                DUT.BSR.cut_g558,
                DUT.BSR.cut_g559,
                DUT.BSR.cut_g560,
                DUT.BSR.cut_g561,
                DUT.BSR.cut_g562,
                DUT.BSR.cut_g563,
                DUT.BSR.cut_g564,
                DUT.BSR.cut_g705,
                DUT.BSR.cut_g639,
                DUT.BSR.cut_g567,
                DUT.BSR.cut_g45,
                DUT.BSR.cut_g42,
                DUT.BSR.cut_g39,
                DUT.BSR.cut_g702,
                DUT.BSR.cut_g32,
                DUT.BSR.cut_g38,
                DUT.BSR.cut_g46,
                DUT.BSR.cut_g36,
                DUT.BSR.cut_g47,
                DUT.BSR.cut_g40,
                DUT.BSR.cut_g37,
                DUT.BSR.cut_g41,
                DUT.BSR.cut_g22,
                DUT.BSR.cut_g44,
                DUT.BSR.cut_g23}
            );
        end
    endtask


    //TODO: Runs some test
    task run_test();

        //FIXME: Implement this
        reset_fsm();

    endtask

    //Outputs the vector that is obtained from running the test
    task shift_out_data(output reg[38:0] result);
        integer ii;
        begin
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture DR
            @(posedge TCLK);

            ii = 0;
            result = 0;
            while(ii < 39) begin
                result = result | (TDO << ii);
                @(posedge TCLK);
                ii = ii + 1;
            end

            TMS = 1;
            @(posedge TCLK); //Advance to Exit1DR
            @(posedge TCLK); //Advance to UpdateDR

            TMS = 0;
            @(posedge TCLK); //Advance to IDLE

            $display("Result: %h", result);
         end
    endtask;


    //Starts in the Run Test state and ends in the Run Test state
    task shift_into_ir (input [0:1] v);

       integer ii;
       begin

            TDI = 0;
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan
            @(posedge TCLK); //Advance to Select IR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture IR
            @(posedge TCLK); //Advance to Shift IR

            ii = 0;
            while(ii < 2) begin
                //FIXME: THE TIMING HERE IS WEIRD. shiftir and the input are
                //off by one cycle
                @(posedge TCLK); //Shift in test vector bit
                TDI = v[ii];

                // Return back to the initial state if we aren't done
                if(ii == 1) begin

                    TMS = 1;
                    @(posedge TCLK); //Advance to Exit1 IR
                    @(posedge TCLK); //Advance to Update IR

                    TMS = 0;
                    @(posedge TCLK); //Advance to Run Test
                    @(posedge TCLK);

                end
                ii = ii + 1;
            end

            $display("IR contains: %b", DUT.inst_regs.inst);

        end

    endtask

endmodule //TOP_TB
