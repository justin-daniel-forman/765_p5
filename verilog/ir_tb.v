module IR_TB();

    reg   TCK;
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
        TCK,
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
        TCK = 0;
        clk = 0;
        forever #50 TCK = ~TCK; //Slower scan clock
        forever #10 clk = ~clk; //Faster system clock
    end

    //Test bench
    initial begin

        //Observe the state of the machine
//        $monitor($stime,, "\n\
//            state:    %b\n\
//            clockdr:  %b\n\
//            shiftdr:  %b\n\
//            updatedr: %b\n\
//            clockir:  %b\n\
//            shiftir:  %b\n\
//            select:   %b\n\
//            bs_en:    %b\n",
//            {tc.ps3, tc.ps2, tc.ps1, tc.ps0},
//            clockdr, shiftdr, updatedr, clockir, shiftir, select, bs_en
//        );

        $monitor($stime,,
            "state:    %b\n",
            {tc.ps3, tc.ps2, tc.ps1, tc.ps0}
        );

        //FIXME: The reset state doesn't match the diagram depicted in the
        //       lecture notes.
        //Reset the FSM to "Run Test or Idle"
        TMS  = 1;
        TRST = 0;
        TDI  = 0;
        @(posedge TCK);
        @(posedge TCK);
        @(posedge TCK);
        @(posedge TCK);

        TRST = 1;
        TMS  = 1;
        @(posedge TCK); //Advance to Select DR Scan
        @(posedge TCK); //Advance to Select IR Scan
        @(posedge TCK); //Advance to Test Logic

        TMS = 0;
        @(posedge TCK); //Advance to Run Test

        TMS = 1;
        @(posedge TCK); //Advance to Select DR Scan
        @(posedge TCK); //Advance to Select IR Scan

        TMS = 0;
        @(posedge TCK); //Advance to Capture IR
        @(posedge TCK); //Advance to Shift IR

        //FIXME: Do we need to go through an entire loop to shift in one bit?
        //       shiftir stays high from TAP, so using that value as a clock
        //       wont allow us to shift in multiple bits in this state.
        TDI = 1;
        @(posedge TCK); //Shift in 1

        TDI = 0;
        TMS = 1;
        @(posedge TCK); //Advance to Exit IR
        @(posedge TCK); //Advance to Update IR

        TMS = 0;
        @(posedge TCK); //Advance to run test
        @(posedge TCK); //Advance to run test

        $display("My instruction should be 11, and is: %b\n\n", inst);

        $finish;
    end

endmodule
