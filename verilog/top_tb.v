module TOP_TB();

    //Inputs
    reg CK,g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
    g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
    g41,g22,g44,g23,TDI,TMS,TRST;

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
        g639,g6728,g702,g705,g89,g94,g98,TDI,TRST,TDO);


    wire [35:0]  ins;
    wire [38:0]  outs;
    wire [210:0] internal_outs;

    assign ins =  {
      DUT.BSR.s9234_IS.g89,
      DUT.BSR.s9234_IS.g94,
      DUT.BSR.s9234_IS.g98,
      DUT.BSR.s9234_IS.g102,
      DUT.BSR.s9234_IS.g107,
      DUT.BSR.s9234_IS.g301,
      DUT.BSR.s9234_IS.g306,
      DUT.BSR.s9234_IS.g310,
      DUT.BSR.s9234_IS.g314,
      DUT.BSR.s9234_IS.g319,
      DUT.BSR.s9234_IS.g557,
      DUT.BSR.s9234_IS.g558,
      DUT.BSR.s9234_IS.g559,
      DUT.BSR.s9234_IS.g560,
      DUT.BSR.s9234_IS.g561,
      DUT.BSR.s9234_IS.g562,
      DUT.BSR.s9234_IS.g563,
      DUT.BSR.s9234_IS.g564,
      DUT.BSR.s9234_IS.g705,
      DUT.BSR.s9234_IS.g639,
      DUT.BSR.s9234_IS.g567,
      DUT.BSR.s9234_IS.g45,
      DUT.BSR.s9234_IS.g42,
      DUT.BSR.s9234_IS.g39,
      DUT.BSR.s9234_IS.g702,
      DUT.BSR.s9234_IS.g32,
      DUT.BSR.s9234_IS.g38,
      DUT.BSR.s9234_IS.g46,
      DUT.BSR.s9234_IS.g36,
      DUT.BSR.s9234_IS.g47,
      DUT.BSR.s9234_IS.g40,
      DUT.BSR.s9234_IS.g37,
      DUT.BSR.s9234_IS.g41,
      DUT.BSR.s9234_IS.g22,
      DUT.BSR.s9234_IS.g44,
      DUT.BSR.s9234_IS.g23
    };

    assign outs = {
      DUT.BSR.cut_g2584, //0
      DUT.BSR.cut_g3222, //1
      DUT.BSR.cut_g3600, //2
      DUT.BSR.cut_g4307, //3
      DUT.BSR.cut_g4321, //4
      DUT.BSR.cut_g4422, //5
      DUT.BSR.cut_g4809, //6
      DUT.BSR.cut_g5137, //7
      DUT.BSR.cut_g5468, //8
      DUT.BSR.cut_g5469, //9
      DUT.BSR.cut_g5692, //10
      DUT.BSR.cut_g6282, //11
      DUT.BSR.cut_g6284, //12
      DUT.BSR.cut_g6360, //13
      DUT.BSR.cut_g6362, //bad
      DUT.BSR.cut_g6364,
      DUT.BSR.cut_g6366,
      DUT.BSR.cut_g6368,
      DUT.BSR.cut_g6370,
      DUT.BSR.cut_g6372,
      DUT.BSR.cut_g6374,
      DUT.BSR.cut_g6728,
      DUT.BSR.cut_g1290,
      DUT.BSR.cut_g4121,
      DUT.BSR.cut_g4108,
      DUT.BSR.cut_g4106,
      DUT.BSR.cut_g4103,
      DUT.BSR.cut_g1293,
      DUT.BSR.cut_g4099,
      DUT.BSR.cut_g4102,
      DUT.BSR.cut_g4109,
      DUT.BSR.cut_g4100,
      DUT.BSR.cut_g4112,
      DUT.BSR.cut_g4105,
      DUT.BSR.cut_g4101,
      DUT.BSR.cut_g4110,
      DUT.BSR.cut_g4104,
      DUT.BSR.cut_g4107,
      DUT.BSR.cut_g4098
    };

    assign internal_outs = {
      DUT.BSR.s9234_IS.SFF_0.dout,
      DUT.BSR.s9234_IS.SFF_1.dout,
      DUT.BSR.s9234_IS.SFF_2.dout,
      DUT.BSR.s9234_IS.SFF_3.dout,
      DUT.BSR.s9234_IS.SFF_4.dout,
      DUT.BSR.s9234_IS.SFF_5.dout,
      DUT.BSR.s9234_IS.SFF_6.dout,
      DUT.BSR.s9234_IS.SFF_7.dout,
      DUT.BSR.s9234_IS.SFF_8.dout,
      DUT.BSR.s9234_IS.SFF_9.dout,
      DUT.BSR.s9234_IS.SFF_10.dout,
      DUT.BSR.s9234_IS.SFF_11.dout,
      DUT.BSR.s9234_IS.SFF_12.dout,
      DUT.BSR.s9234_IS.SFF_13.dout,
      DUT.BSR.s9234_IS.SFF_14.dout,
      DUT.BSR.s9234_IS.SFF_15.dout,
      DUT.BSR.s9234_IS.SFF_16.dout,
      DUT.BSR.s9234_IS.SFF_17.dout,
      DUT.BSR.s9234_IS.SFF_18.dout,
      DUT.BSR.s9234_IS.SFF_19.dout,
      DUT.BSR.s9234_IS.SFF_20.dout,
      DUT.BSR.s9234_IS.SFF_21.dout,
      DUT.BSR.s9234_IS.SFF_22.dout,
      DUT.BSR.s9234_IS.SFF_23.dout,
      DUT.BSR.s9234_IS.SFF_24.dout,
      DUT.BSR.s9234_IS.SFF_25.dout,
      DUT.BSR.s9234_IS.SFF_26.dout,
      DUT.BSR.s9234_IS.SFF_27.dout,
      DUT.BSR.s9234_IS.SFF_28.dout,
      DUT.BSR.s9234_IS.SFF_29.dout,
      DUT.BSR.s9234_IS.SFF_30.dout,
      DUT.BSR.s9234_IS.SFF_31.dout,
      DUT.BSR.s9234_IS.SFF_32.dout,
      DUT.BSR.s9234_IS.SFF_33.dout,
      DUT.BSR.s9234_IS.SFF_34.dout,
      DUT.BSR.s9234_IS.SFF_35.dout,
      DUT.BSR.s9234_IS.SFF_36.dout,
      DUT.BSR.s9234_IS.SFF_37.dout,
      DUT.BSR.s9234_IS.SFF_38.dout,
      DUT.BSR.s9234_IS.SFF_39.dout,
      DUT.BSR.s9234_IS.SFF_40.dout,
      DUT.BSR.s9234_IS.SFF_41.dout,
      DUT.BSR.s9234_IS.SFF_42.dout,
      DUT.BSR.s9234_IS.SFF_43.dout,
      DUT.BSR.s9234_IS.SFF_44.dout,
      DUT.BSR.s9234_IS.SFF_45.dout,
      DUT.BSR.s9234_IS.SFF_46.dout,
      DUT.BSR.s9234_IS.SFF_47.dout,
      DUT.BSR.s9234_IS.SFF_48.dout,
      DUT.BSR.s9234_IS.SFF_49.dout,
      DUT.BSR.s9234_IS.SFF_50.dout,
      DUT.BSR.s9234_IS.SFF_51.dout,
      DUT.BSR.s9234_IS.SFF_52.dout,
      DUT.BSR.s9234_IS.SFF_53.dout,
      DUT.BSR.s9234_IS.SFF_54.dout,
      DUT.BSR.s9234_IS.SFF_55.dout,
      DUT.BSR.s9234_IS.SFF_56.dout,
      DUT.BSR.s9234_IS.SFF_57.dout,
      DUT.BSR.s9234_IS.SFF_58.dout,
      DUT.BSR.s9234_IS.SFF_59.dout,
      DUT.BSR.s9234_IS.SFF_60.dout,
      DUT.BSR.s9234_IS.SFF_61.dout,
      DUT.BSR.s9234_IS.SFF_62.dout,
      DUT.BSR.s9234_IS.SFF_63.dout,
      DUT.BSR.s9234_IS.SFF_64.dout,
      DUT.BSR.s9234_IS.SFF_65.dout,
      DUT.BSR.s9234_IS.SFF_66.dout,
      DUT.BSR.s9234_IS.SFF_67.dout,
      DUT.BSR.s9234_IS.SFF_68.dout,
      DUT.BSR.s9234_IS.SFF_69.dout,
      DUT.BSR.s9234_IS.SFF_70.dout,
      DUT.BSR.s9234_IS.SFF_71.dout,
      DUT.BSR.s9234_IS.SFF_72.dout,
      DUT.BSR.s9234_IS.SFF_73.dout,
      DUT.BSR.s9234_IS.SFF_74.dout,
      DUT.BSR.s9234_IS.SFF_75.dout,
      DUT.BSR.s9234_IS.SFF_76.dout,
      DUT.BSR.s9234_IS.SFF_77.dout,
      DUT.BSR.s9234_IS.SFF_78.dout,
      DUT.BSR.s9234_IS.SFF_79.dout,
      DUT.BSR.s9234_IS.SFF_80.dout,
      DUT.BSR.s9234_IS.SFF_81.dout,
      DUT.BSR.s9234_IS.SFF_82.dout,
      DUT.BSR.s9234_IS.SFF_83.dout,
      DUT.BSR.s9234_IS.SFF_84.dout,
      DUT.BSR.s9234_IS.SFF_85.dout,
      DUT.BSR.s9234_IS.SFF_86.dout,
      DUT.BSR.s9234_IS.SFF_87.dout,
      DUT.BSR.s9234_IS.SFF_88.dout,
      DUT.BSR.s9234_IS.SFF_89.dout,
      DUT.BSR.s9234_IS.SFF_90.dout,
      DUT.BSR.s9234_IS.SFF_91.dout,
      DUT.BSR.s9234_IS.SFF_92.dout,
      DUT.BSR.s9234_IS.SFF_93.dout,
      DUT.BSR.s9234_IS.SFF_94.dout,
      DUT.BSR.s9234_IS.SFF_95.dout,
      DUT.BSR.s9234_IS.SFF_96.dout,
      DUT.BSR.s9234_IS.SFF_97.dout,
      DUT.BSR.s9234_IS.SFF_98.dout,
      DUT.BSR.s9234_IS.SFF_99.dout,
      DUT.BSR.s9234_IS.SFF_100.dout,
      DUT.BSR.s9234_IS.SFF_101.dout,
      DUT.BSR.s9234_IS.SFF_102.dout,
      DUT.BSR.s9234_IS.SFF_103.dout,
      DUT.BSR.s9234_IS.SFF_104.dout,
      DUT.BSR.s9234_IS.SFF_105.dout,
      DUT.BSR.s9234_IS.SFF_106.dout,
      DUT.BSR.s9234_IS.SFF_107.dout,
      DUT.BSR.s9234_IS.SFF_108.dout,
      DUT.BSR.s9234_IS.SFF_109.dout,
      DUT.BSR.s9234_IS.SFF_110.dout,
      DUT.BSR.s9234_IS.SFF_111.dout,
      DUT.BSR.s9234_IS.SFF_112.dout,
      DUT.BSR.s9234_IS.SFF_113.dout,
      DUT.BSR.s9234_IS.SFF_114.dout,
      DUT.BSR.s9234_IS.SFF_115.dout,
      DUT.BSR.s9234_IS.SFF_116.dout,
      DUT.BSR.s9234_IS.SFF_117.dout,
      DUT.BSR.s9234_IS.SFF_118.dout,
      DUT.BSR.s9234_IS.SFF_119.dout,
      DUT.BSR.s9234_IS.SFF_120.dout,
      DUT.BSR.s9234_IS.SFF_121.dout,
      DUT.BSR.s9234_IS.SFF_122.dout,
      DUT.BSR.s9234_IS.SFF_123.dout,
      DUT.BSR.s9234_IS.SFF_124.dout,
      DUT.BSR.s9234_IS.SFF_125.dout,
      DUT.BSR.s9234_IS.SFF_126.dout,
      DUT.BSR.s9234_IS.SFF_127.dout,
      DUT.BSR.s9234_IS.SFF_128.dout,
      DUT.BSR.s9234_IS.SFF_129.dout,
      DUT.BSR.s9234_IS.SFF_130.dout,
      DUT.BSR.s9234_IS.SFF_131.dout,
      DUT.BSR.s9234_IS.SFF_132.dout,
      DUT.BSR.s9234_IS.SFF_133.dout,
      DUT.BSR.s9234_IS.SFF_134.dout,
      DUT.BSR.s9234_IS.SFF_135.dout,
      DUT.BSR.s9234_IS.SFF_136.dout,
      DUT.BSR.s9234_IS.SFF_137.dout,
      DUT.BSR.s9234_IS.SFF_138.dout,
      DUT.BSR.s9234_IS.SFF_139.dout,
      DUT.BSR.s9234_IS.SFF_140.dout,
      DUT.BSR.s9234_IS.SFF_141.dout,
      DUT.BSR.s9234_IS.SFF_142.dout,
      DUT.BSR.s9234_IS.SFF_143.dout,
      DUT.BSR.s9234_IS.SFF_144.dout,
      DUT.BSR.s9234_IS.SFF_145.dout,
      DUT.BSR.s9234_IS.SFF_146.dout,
      DUT.BSR.s9234_IS.SFF_147.dout,
      DUT.BSR.s9234_IS.SFF_148.dout,
      DUT.BSR.s9234_IS.SFF_149.dout,
      DUT.BSR.s9234_IS.SFF_150.dout,
      DUT.BSR.s9234_IS.SFF_151.dout,
      DUT.BSR.s9234_IS.SFF_152.dout,
      DUT.BSR.s9234_IS.SFF_153.dout,
      DUT.BSR.s9234_IS.SFF_154.dout,
      DUT.BSR.s9234_IS.SFF_155.dout,
      DUT.BSR.s9234_IS.SFF_156.dout,
      DUT.BSR.s9234_IS.SFF_157.dout,
      DUT.BSR.s9234_IS.SFF_158.dout,
      DUT.BSR.s9234_IS.SFF_159.dout,
      DUT.BSR.s9234_IS.SFF_160.dout,
      DUT.BSR.s9234_IS.SFF_161.dout,
      DUT.BSR.s9234_IS.SFF_162.dout,
      DUT.BSR.s9234_IS.SFF_163.dout,
      DUT.BSR.s9234_IS.SFF_164.dout,
      DUT.BSR.s9234_IS.SFF_165.dout,
      DUT.BSR.s9234_IS.SFF_166.dout,
      DUT.BSR.s9234_IS.SFF_167.dout,
      DUT.BSR.s9234_IS.SFF_168.dout,
      DUT.BSR.s9234_IS.SFF_169.dout,
      DUT.BSR.s9234_IS.SFF_170.dout,
      DUT.BSR.s9234_IS.SFF_171.dout,
      DUT.BSR.s9234_IS.SFF_172.dout,
      DUT.BSR.s9234_IS.SFF_173.dout,
      DUT.BSR.s9234_IS.SFF_174.dout,
      DUT.BSR.s9234_IS.SFF_175.dout,
      DUT.BSR.s9234_IS.SFF_176.dout,
      DUT.BSR.s9234_IS.SFF_177.dout,
      DUT.BSR.s9234_IS.SFF_178.dout,
      DUT.BSR.s9234_IS.SFF_179.dout,
      DUT.BSR.s9234_IS.SFF_180.dout,
      DUT.BSR.s9234_IS.SFF_181.dout,
      DUT.BSR.s9234_IS.SFF_182.dout,
      DUT.BSR.s9234_IS.SFF_183.dout,
      DUT.BSR.s9234_IS.SFF_184.dout,
      DUT.BSR.s9234_IS.SFF_185.dout,
      DUT.BSR.s9234_IS.SFF_186.dout,
      DUT.BSR.s9234_IS.SFF_187.dout,
      DUT.BSR.s9234_IS.SFF_188.dout,
      DUT.BSR.s9234_IS.SFF_189.dout,
      DUT.BSR.s9234_IS.SFF_190.dout,
      DUT.BSR.s9234_IS.SFF_191.dout,
      DUT.BSR.s9234_IS.SFF_192.dout,
      DUT.BSR.s9234_IS.SFF_193.dout,
      DUT.BSR.s9234_IS.SFF_194.dout,
      DUT.BSR.s9234_IS.SFF_195.dout,
      DUT.BSR.s9234_IS.SFF_196.dout,
      DUT.BSR.s9234_IS.SFF_197.dout,
      DUT.BSR.s9234_IS.SFF_198.dout,
      DUT.BSR.s9234_IS.SFF_199.dout,
      DUT.BSR.s9234_IS.SFF_200.dout,
      DUT.BSR.s9234_IS.SFF_201.dout,
      DUT.BSR.s9234_IS.SFF_202.dout,
      DUT.BSR.s9234_IS.SFF_203.dout,
      DUT.BSR.s9234_IS.SFF_204.dout,
      DUT.BSR.s9234_IS.SFF_205.dout,
      DUT.BSR.s9234_IS.SFF_206.dout,
      DUT.BSR.s9234_IS.SFF_207.dout,
      DUT.BSR.s9234_IS.SFF_208.dout,
      DUT.BSR.s9234_IS.SFF_209.dout,
      DUT.BSR.s9234_IS.SFF_210.dout
    };



    initial begin
        CK = 0;
        forever #50 CK = ~CK;
    end
    assign TCLK = CK;


    //Begin Test bench
    reg [38:0]  r_ext;
    reg [210:0] r_int;
    initial begin

        check_etr();

//        TMS  = 1;
//        TRST = 0;
//        @(posedge CK);
//
//        TRST = 1;
//        @(posedge CK);
//
//        shift_into_ir(2'b11);
//        @(posedge CK);
//
//        //Assign PIs and observe POs
//        assign {g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
//        g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
//        g41,g22,g44,g23} = 36'b1101_1000_0011_0101_1110_1000_1101_0010_1010;
//
//        //These values must be held for normal operation
//        TMS  = 1;
//        TRST = 0;
//        @(posedge CK);
//        @(posedge CK);
//        @(posedge CK);
//        @(posedge CK);
//        @(posedge CK);
//        @(posedge CK);
//
//        TRST = 1;
//        shift_into_ir(2'b10);
//        shift_into_int_dr(211'b111000011110000110111101100011111101010100100110101110101111101100110101010011011111001010110010101110111100111100001011001010011110001011011110000101000011110010100011101110101101110101111111_0100_1100_1010_0100_010);
//
//        //Apply one cycle to the circuit
//        @(posedge CK);
//        @(posedge CK);
//        @(posedge CK);
//        @(posedge TCLK);
//        @(posedge TCLK);
//        @(posedge TCLK);
//        @(posedge TCLK);
//        @(posedge TCLK);
//        @(posedge TCLK);


        $finish;
    end

    task start_bist();
    begin
        shift_into_ir(2'b11);
        @(posedge TCLK);
        @(posedge TCLK);
        @(posedge TCLK);
        @(posedge TCLK);
        @(posedge TCLK);
        @(posedge TCLK);
    end
    endtask

    //Starts in the Run Test State and ends in the Run Test State
    //Shifts the vector v into the BSR
    task shift_into_ext_dr(input [35:0] v);
        integer ii;
        begin
            TDI = 0;
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture DR

            ii = 0;
            while(ii <= 35) begin

                @(posedge TCLK); //Advance to Shift DR
                TDI = v[ii];

                // Return back to the initial state if we aren't done
                if(ii == 35) begin

                    TMS = 1;
                    @(posedge TCLK); //Advance to Exit1 DR
                    @(posedge TCLK); //Advance to Update DR

                    TMS = 0;
                    @(posedge TCLK); //Advance to Run Test
                    @(posedge TCLK);

                end
                ii = ii + 1;
            end

            $display("%d: DR contains: %h", $stime, {
                DUT.BSR.sff_g89.TDO,
                DUT.BSR.sff_g94.TDO,
                DUT.BSR.sff_g98.TDO,
                DUT.BSR.sff_g102.TDO,
                DUT.BSR.sff_g107.TDO,
                DUT.BSR.sff_g301.TDO,
                DUT.BSR.sff_g306.TDO,
                DUT.BSR.sff_g310.TDO,
                DUT.BSR.sff_g314.TDO,
                DUT.BSR.sff_g319.TDO,
                DUT.BSR.sff_g557.TDO,
                DUT.BSR.sff_g558.TDO,
                DUT.BSR.sff_g559.TDO,
                DUT.BSR.sff_g560.TDO,
                DUT.BSR.sff_g561.TDO,
                DUT.BSR.sff_g562.TDO,
                DUT.BSR.sff_g563.TDO,
                DUT.BSR.sff_g564.TDO,
                DUT.BSR.sff_g705.TDO,
                DUT.BSR.sff_g639.TDO,
                DUT.BSR.sff_g567.TDO,
                DUT.BSR.sff_g45.TDO,
                DUT.BSR.sff_g42.TDO,
                DUT.BSR.sff_g39.TDO,
                DUT.BSR.sff_g702.TDO,
                DUT.BSR.sff_g32.TDO,
                DUT.BSR.sff_g38.TDO,
                DUT.BSR.sff_g46.TDO,
                DUT.BSR.sff_g36.TDO,
                DUT.BSR.sff_g47.TDO,
                DUT.BSR.sff_g40.TDO,
                DUT.BSR.sff_g37.TDO,
                DUT.BSR.sff_g41.TDO,
                DUT.BSR.sff_g22.TDO,
                DUT.BSR.sff_g44.TDO,
                DUT.BSR.sff_g23.TDO}
            );
        end
    endtask

    task check_etr();
    begin
        @(posedge CK);
        assign {TMS, TRST, TDI} = 3'bz0z; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b011; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
//        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b110; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);
        assign {TMS, TRST, TDI} = 3'b010; @(posedge CK);

        assign {g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
        g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
        g41,g22,g44,g23} = 36'b1101_1000_0011_0101_1110_1000_1101_0010_1010;
        assign {TMS, TRST, TDI} = 3'b01z; @(posedge CK);

    end
    endtask


    //Starts in the Run Test State and ends in the Run Test State
    //Shifts the vector v into the Internal Scan Register
    task shift_into_int_dr(input [210:0] v);

        integer ii;
        begin
            TDI = 0;
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture DR

            ii = 210;
            while(ii >= 0) begin
                $display("GOING!");
                @(posedge TCLK); //Advance to Shift DR
                TDI = v[ii];

                // Return back to the initial state if we aren't done
                if(ii == 0) begin

                    TMS = 1;
                    @(posedge TCLK); //Advance to Exit1 DR
                    @(posedge TCLK); //Advance to Update DR

                    TMS = 0;
                    @(posedge TCLK); //Advance to Run Test
                    @(posedge TCLK);

                end
                ii = ii - 1;
            end
        end
    endtask

    //Outputs the vector that is obtained from running the test
    task shift_out_ext_data(output reg[38:0] result);
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

    //Outputs the vector that is obtained from running the test
    task shift_out_int_data(output reg[210:0] result);
        integer ii;
        begin
            TMS = 1;
            @(posedge TCLK); //Advance to Select DR Scan

            TMS = 0;
            @(posedge TCLK); //Advance to Capture DR
            @(posedge TCLK);

            ii = 0;
            result = 0;
            while(ii < 211) begin
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
