module IR_TB();

    reg   TCLK;
    reg   TRST;
    reg   TMS;
    wire  clockdr;
    wire  shiftdr;
    wire  updatedr;
    wire  clockir;
    wire  shiftir;
    wire  updateir;
    wire  select;
    wire  bs_en;

    reg         TDI;
    wire        TDO;
    wire [1:0]  inst;

    tapcontroller tc(
        TCLK,
        TRST,
        TMS,
        clockdr,
        shiftdr,
        updatedr,
        clockir,
        shiftir,
        updateir,
        select,
        bs_en
    );

    IR ir(
        shiftir,
        updateir,
        TDI,
        inst,
        TDO
    );

    //Clock generation
    reg clk;
    initial begin
        TCLK = 0;
        clk = 0;
        forever #50 TCLK = ~TCLK; //Slower scan clock
        forever #10 clk = ~clk; //Faster system clock
    end

    //Test bench
    initial begin

        $monitor($stime,,
            "state:    %b\n",
            {tc.ps3, tc.ps2, tc.ps1, tc.ps0}
        );

        reset_fsm();
        shift_into_ir({1'b0, 1'b1});
        $display("My instruction should be 11, and is: %b\n\n", inst);

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

endmodule
