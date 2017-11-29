module TB();

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

    //Clock generation
    reg clk;
    initial begin
        forever #50 TCK = ~TCK; //Slower scan clock
        forever #10 clk = ~clk; //Faster system clock
    end

    //Test bench
    initial begin

        $monitor($stime,, "select: %b", select);

        //Reset the FSM
        TMS  = 1;
        TRST = 1;
        #10 TRST = 0;

        #10 TMS = 0;

        $finish;
    end


endmodule
