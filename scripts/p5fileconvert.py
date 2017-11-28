#!/usr/bin/python
# p5fileconvert.py
#
# 18-765: Digital Systems Testing and Testable Design
# Script used for Project 5
#
# Modules used for reading and writing vector files
# Called by p5convert.py script
#
# Reads: STIL, Easy-to-Read
# Writes: TBDpatt, STIL, Easy-to-Read, Verilog TestBench


'''Modules used by p5convert.py to read/write vector files'''
import re


# ***MODULES FOR READING FILES***

# Reads information from STIL file given input file
def read_stil(infilename):
    '''Reads STIL vector file'''
    infile = open(infilename, 'rU')
    cknames = []
    innames = []
    outnames = []
    invecs = []
    outvecs = []
    for line in infile:  #reads file line by line
        #finds clock signals
        cksig = re.search(r'"(.+)"\s+{\s+01ZP\s+{', line)
        if cksig:
            cknames.append(cksig.group(1))

        #finds input signals
        insig = re.search(r'"(.+)"\s+{\s+01ZP?\s+{', line)
        if insig:
            innames.append(insig.group(1))
            continue
        #finds output signals
        outsig = re.search(r'"(.+)"\s+{\s+LHTX\s+{', line)
        if outsig:
            outnames.append(outsig.group(1))
            continue

        #finds input vectors
#        inputvec = re.search(r'"ALLPIs" =\s*(\w+)\s*;', line)
#        if inputvec:
#            invecs.append(inputvec.group(1))
#            continue

        #finds input vectors
        inputvec = re.search(r'"ALLPIs" =\s*(.+)\s*;', line)
        if inputvec:
            vecs = []
            invecstrings = inputvec.group(1).split()
            for i in range(len(invecstrings)):
                if r'\r' in invecstrings[i-1]:
                    continue
                #deals with repeats in vector
                if r'\r' in invecstrings[i]:
                    length = invecstrings[i][2:]
                    vecs.append(eval(length) * invecstrings[i+1])
                else:
                    vecs.append(invecstrings[i])
            invecs.append(''.join(vecs))
            continue



        #finds input vectors with one repeat (from CET)
#        inputvecr = re.search(
#            r'"ALLPIs" =\s*(\w*)\s*\\r(\d+)\s*(\w+)\s*(\w*)\s*;', line)
#        if inputvecr:
#            repval = inputvecr.group(3) * eval(inputvecr.group(2))
#            invecs.append(''.join([inputvecr.group(1),
#                                   repval, inputvecr.group(4)]))
#            continue

        #finds ouptut vectors
#        outputvec = re.search(r'"ALLPOs" =\s*(\w+)\s*;', line)
#        if outputvec:
#            outvecs.append(outputvec.group(1))
#            continue


        #finds output vectors
        outputvec = re.search(r'"ALLPOs" =\s*(.+)\s*;', line)
        if outputvec:
            vecs = []
            outvecstrings = outputvec.group(1).split()
            for i in range(len(outvecstrings)):
                if r'\r' in outvecstrings[i-1]:
                    continue
                #deals with repeats in vector
                if r'\r' in outvecstrings[i]:
                    length = outvecstrings[i][2:]
                    vecs.append(eval(length) * outvecstrings[i+1])
                else:
                    vecs.append(outvecstrings[i])
            outvecs.append(''.join(vecs))
            continue



        #finds output vectors with one repeat
#        outputvecr = re.search(
#            r'"ALLPOs" =\s*(\w*)\s*\\r(\d+)\s*(\w+)\s*(\w*)\s*;', line)
#        if outputvecr:
#            repval = outputvecr.group(3) * eval(outputvecr.group(2))
#            outvecs.append(''.join([outputvecr.group(1),
#                                    repval, outputvecr.group(4)]))
#            continue

    infile.close()

    return (cknames, innames, outnames, invecs, outvecs)


# Reads easy-to-read file given filename
def read_etr(infname):
    '''Reads Easy-to-Read file'''
    infile = open(infname, 'rU')
    groupsorder = []
    cknames = []
    innames = []
    outnames = []
    invecs = []
    outvecs = []
    for line in infile:  #reads file line by line
        #finds clock signals (stores as clock and input)
        cksig = re.search(r'^CLOCKS\s*:\s*(.+)\s*\n', line)
        if cksig:
            cknames = re.split(r',\s*', cksig.group(1))
            innames.extend(cknames)
            groupsorder.append('IN')
            continue
        #finds control signals (stores as inputs)
        ctlsig = re.search(r'^CONTROLS\s*:\s*(.+)\s*\n', line)
        if ctlsig:
            innames.extend(re.split(r',\s*', ctlsig.group(1)))
            groupsorder.append('IN')
            continue
        #finds input signals
        insig = re.search(r'^INPUTS\s*:\s*(.+)\s*\n', line)
        if insig:
            innames.extend(re.split(r',\s*', insig.group(1)))
            groupsorder.append('IN')
            continue
        #finds output signals
        outsig = re.search(r'^OUTPUTS\s*:\s*(.+)\s*\n', line)
        if outsig:
            outnames.extend(re.split(r',\s*', outsig.group(1)))
            groupsorder.append('OUT')
            continue
        #finds primary input signals (inputs)
        pinsig = re.search(r'^PRIMARY_INPUTS\s*:\s*(.+)\s*\n', line)
        if pinsig:
            innames.extend(re.split(r',\s*', pinsig.group(1)))
            groupsorder.append('IN')
            continue
        #finds primary output signals (outputs)
        poutsig = re.search(r'^PRIMARY_OUTPUTS\s*:\s*(.+)\s*\n', line)
        if poutsig:
            outnames.extend(re.split(r',\s*', poutsig.group(1)))
            groupsorder.append('OUT')
            continue
        #finds scanin signals (inputs)
        scaninsig = re.search(r'^SCAN_INS\s*:\s*(.+)\s*\n', line)
        if scaninsig:
            innames.extend(re.split(r',\s*', scaninsig.group(1)))
            groupsorder.append('IN')
            continue
        #finds scanout signals (outputs)
        scanoutsig = re.search(r'^SCAN_OUTS\s*:\s*(.+)\s*\n', line)
        if scanoutsig:
            outnames.extend(re.split(r',\s*', scanoutsig.group(1)))
            groupsorder.append('OUT')
            continue
        #finds floatin signals (inputs)
        floatinsig = re.search(r'^FLOAT_INS\s*:\s*(.+)\s*\n', line)
        if floatinsig:
            innames.extend(re.split(r',\s*', floatinsig.group(1)))
            groupsorder.append('IN')
            continue
        #finds floatout signals(outputs)
        floatoutsig = re.search(r'^FLOAT_OUTS\s*:\s*(.+)\s*\n', line)
        if floatoutsig:
            outnames.extend(re.split(r',\s*', floatoutsig.group(1)))
            groupsorder.append('OUT')
            continue

        vector = re.search(r'^[\dX]+:\s*(.+)\s*', line)  #finds vectors
        if vector:
            vecs = re.split(r'\s*', vector.group(1))  #separates by grouping
            tempin = []
            tempout = []
            #places as input or output vectors based on ordering of groups above
            for i in range(len(groupsorder)):
                if groupsorder[i] == 'IN':
                    tempin.append(vecs[i])
                elif groupsorder[i] == 'OUT':
                    tempout.append(vecs[i])

            invecs.append(''.join(tempin))
            outvecs.append(''.join(tempout))

    infile.close()

    return (cknames, innames, outnames, invecs, outvecs)



# ***MODULES FOR WRITING FILES***

# Converts signal bit values to use in TBD form
# Accepts input and output dictionaries, returns two modified dictionaries
def bits_tbdpatt(indict, outdict):
    '''Reformats bits for printing into TBDpatt file'''
    indictm = indict
    outdictm = outdict
    for sig in indict.keys():
        for vec in range(len(indict[sig])):
            indictm[sig][vec] = indict[sig][vec].replace('Z', 'z') # Z -> z

    for sig in outdict.keys():
        for vec in range(len(outdict[sig])):
            outdictm[sig][vec] = outdict[sig][vec].replace('H', '1') # H -> 1
            outdictm[sig][vec] = outdict[sig][vec].replace('L', '0') # L -> 0
            outdictm[sig][vec] = outdict[sig][vec].replace('X', 'x') # X -> x

    return (indictm, outdictm)


# Writes TBDpatt vector file
def write_tbdpatt(cknames, innames, indict, intype,
                  outnames, outdict, outfname, infname):
    '''Writes TBDpatt vector file'''

    outf = open('TBDpatt.FULLSCAN.' + outfname, 'w')

    outf.write('# File name = TBDpatt.FULLSCAN.' + outfname + '\n#\n#\n')

    #info about file
    outf.write('# Input file: ' + infname + '\n')
    outf.write('# Converted from ' + intype + ' to TBDpatt\n#\n')

    #info about circuit/vectors
    outf.write('# ' + str(len(indict[indict.keys()[0]])) + ' vectors in file\n')
    outf.write('# ' + str(len(cknames)) + ' clock signals present\n')
    outf.write('# ' + str(len(innames) - len(cknames))
               + ' input signals present (not including clocks)\n')
    outf.write('# ' + str(len(outnames)) + ' output signals preset\n#\n')

    if cknames:
        outf.write('# CLOCKS: ' + ', '.join(cknames) + '\n')
    outf.write('# INPUTS: ' + ', '.join(innames) + '\n')
    outf.write('# OUTPUTS: ' + ', '.join(outnames) + '\n#\n#\n')


    # required for TBDpatt files
    outf.write('TBDpatt_Format (mode=vector, model_entity_form=name);\n#\n')


    # sorts signals in alpha order for ET
    pinames = cknames + innames
    pinames.sort()
    outnames.sort()

    # prints out pins in order
    outf.write('#Vector_Correspondence\n#\n#\n')
    outf.write('# PI:\n')
    ctc = 0
    for cta in range(len(pinames)):
        if cta == 0:
            outf.write('#     (PI 1 = "Pin.f.l.MODULE.nl.' + pinames[0]
                       + '",   #  index = ' + str(ctc) + '\n')
        elif cta == (len(pinames) - 1):
            outf.write('#      PI ' + str(cta+1) + ' = "Pin.f.l.MODULE.nl.'
                       + pinames[cta] + '")   #  index = ' + str(ctc) + '\n')
        else:
            outf.write('#      PI ' + str(cta+1) + ' = "Pin.f.l.MODULE.nl.'
                       + pinames[cta] + '",   #  index = ' + str(ctc) + '\n')
        ctc += 1

    outf.write('#\n# PO:\n')
    for ctb in range(len(outnames)):
        if ctb == 0:
            outf.write('#     (PO 1 = "Pin.f.l.MODULE.nl.' + outnames[0]
                       + '",   #  index = ' + str(ctc) + '\n')
        elif ctb == len(outnames) - 1:
            outf.write('#      PO ' + str(ctb+1) + ' = "Pin.f.l.MODULE.nl.'
                       + outnames[ctb] + '")   #  index = ' + str(ctc) + '\n')
        else:
            outf.write('#      PO ' + str(ctb+1) + ' = "Pin.f.l.MODULE.nl.'
                       + outnames[ctb] + '",   #  index = ' + str(ctc) + '\n')
        ctc += 1

    outf.write('#\n#      ;\t End of vector correspondence\n\n')


    # information used by ET
    outf.write('[ Experiment ' + outfname + ' 1 ();\n')
    outf.write(' [ Test_Section 1.1 (tester_termination = none,  '
               + 'test_section_type = logic, test_type = static, simulated);\n')
    outf.write('   [ Keyed_Data;\n')
    outf.write('    "SimOptions" = "simulation=hsscan 01hot=no choppers=safe '
               + 'clockoffsim=nonstable controlpipeline=gm forcehterm=no '
               + 'globalterm=none ignoremeasureinputx=no infinitex=default '
               + 'keepers=safe latchsimulation=optimistic '
               + 'markpdlfaultstested=no maxfaultcopies=100000 '
               + 'maxfaultsize=500000 maxfaultxsize=1000 pdl=0 propXignore=no '
               + 'ramcalctype=sparse ramsize=all removexlatch=no removexpo=no '
               + 'simdynamic=no zmemory=no"\n')
    outf.write('   ] Keyed_Data;\n')

    #start of vectors
    outf.write('  [ Tester_Loop 1.1.1 ();\n')
    outf.write('   [ Test_Procedure 1.1.1.1 (type = init);\n')
    outf.write('    [ Test_Sequence 1.1.1.1.1 (type = init);\n')
    outf.write('      [ Keyed_Data;\n')
    outf.write('       "AnalysisSimOptions" = "useppis=no simwaitosc=no '
               + 'simforce=yes stopatunpowered=no delaymode=unit '
               + 'stabilitylatch=no"\n')
    outf.write('      ] Keyed_Data;\n')

    #initialize clock signals
    if cknames:
        outf.write('    [ Pattern 1.1.1.1.1.1 (pattern_type = static);\n')
        outf.write('       Event 1.1.1.1.1.1.1   Stim_PI ():\n')
        for sig in pinames:
            if sig in cknames:
                outf.write(indict[sig][0])
            else:
                outf.write('.')

        outf.write(';\n     ] Pattern 1.1.1.1.1.1;\n')
    outf.write('    ] Test_Sequence 1.1.1.1.1;\n')
    outf.write('   ] Test_Procedure 1.1.1.1;\n')

    #start of test vectors
    outf.write('   [ Test_Procedure 1.1.1.2;\n')
    for tsct in range(bool(cknames), len(indict[indict.keys()[0]])):
        outf.write('    [ Test_Sequence 1.1.1.2.%d (); # Test %d\n'
                   % (tsct+1, tsct+1))
        outf.write('     [ sort_keys (sone=1):\n')
        outf.write('     ] sort_keys;\n')

        # finds if any clocks exist and pulse
        pulseflag = False
        for clock in cknames:
            if indict[clock][tsct] == 'P':
                pulseflag = True

        # Pulse event, if clock pulses
        if pulseflag:
            outf.write('     [ Pattern 1.1.1.2.%d.3 (pattern_type = static);\n'
                       % (tsct+1))
            outf.write('        Event 1.1.1.2.%d.3.1   Pulse ():\n' % (tsct+1))
            for clock in cknames:
                if indict[clock][tsct] == 'P':
                    outf.write('"' + clock + '"=+ ;\n')
            outf.write('     ]  Pattern 1.1.1.2.1.3;\n')


        # Stim_PI event
        outf.write('     [ Pattern 1.1.1.2.%d.1 (pattern_type = static);\n'
                   % (tsct+1))
        outf.write('        Event 1.1.1.2.%d.1.1   Stim_PI ():\n' % (tsct+1))
        for sig in pinames:
            if indict[sig][tsct] == 'P':
                outf.write('.')
            else:
                outf.write(indict[sig][tsct])
        outf.write(';\n')
        outf.write('     ] Pattern 1.1.1.2.%d.1;\n' % (tsct+1))

        # Measure_PO event
        outf.write('     [ Pattern 1.1.1.2.%d.2 (pattern_type = static);\n'
                   % (tsct+1))
        outf.write('        Event 1.1.1.2.%d.2.1   Measure_PO ():\n' % (tsct+1))

        for sig in outnames:
            outf.write(outdict[sig][tsct])
        outf.write(';\n')

        outf.write('     ] Pattern 1.1.1.2.%d.2;\n' % (tsct+1))
        outf.write('    ] Test_Sequence 1.1.1.2.%d;\n' % (tsct+1))


    # Final TBDpatt file requirements
    outf.write('   ] Test_Procedure 1.1.1.2;\n')
    outf.write('  ] Tester_Loop 1.1.1;\n')
    outf.write(' ] Test_Section 1.1;\n')
    outf.write('] Experiment ' + outfname + '1;\n')

    outf.close()

    return


# To use STIL files as an input for Cadence ET, two separate files are needed
# <stilfilename>.vectors.stil contains the definition of the vectors
# <stilfilename>.signals.stil contains the definition of the signals, other info
# The vectors file contains an 'Include' line which adds the STIL signals file
# Only vectors file is used as an input to Cadence ET
# The signals file should be in the same directory as the vectors file

# Writes STIL vector file with data from input file to given output file
def write_stilvec(cknames, innames, invecs, indict, intype,
                  outnames, outvecs, outfname, infname):
    '''Writes STIL vector file'''
    #resulting file in form <fname>.vectors.stil
    outf = open(outfname + '.vectors.stil', 'w')
    outf.write('STIL 1.0;\n\n')  #needed at top of stil files

    #info about file
    outf.write('// --- STIL VECTOR FILE --- // Do not remove, file type'
               + ' detection\n')
    outf.write('// ' + outfname + '.vectors.stil\n')

    outf.write('// Input file: ' + infname + '\n')
    outf.write('// Converted from ' + intype + ' to STIL\n\n')

    #info about circuit/vectors
    outf.write('// ' + str(len(invecs)) + ' vectors in file\n')
    outf.write('// ' + str(len(cknames)) + ' clock signals present\n')
    outf.write('// ' + str(len(innames) - len(cknames))
               + ' input signals present (not including clocks)\n')
    outf.write('// ' + str(len(outnames)) + ' output signals preset\n\n')

    if cknames:
        outf.write('// CLOCKS: ' + ', '.join(cknames) + '\n')
    outf.write('// INPUTS: ' + ', '.join(innames) + '\n')
    outf.write('// OUTPUTS: ' + ', '.join(outnames) + '\n\n\n')

    #include signals file
    outf.write('  Include "' + outfname + '.signals.stil";\n\n')

    # Timing definitions, placed same order as corresponding values in vectors
    outf.write('// ----TIMING DEFINITIONS---- //\n\n')
    outf.write('  Timing {\n')
    outf.write('    WaveformTable "test_cycle" { Period \'80.000000ns\';\n')
    outf.write('      Waveforms {\n')
    for inp in cknames + innames:
        if inp in cknames:  #clock signal 'signature'
            outf.write('        "' + inp + '" { 01ZP { \'0ns\' P/P/P/P;'
                       + ' \'8.000000ns\' D/U/Z/U; \'16.000000ns\''
                       + ' D/U/Z/D; } }\n')
        else:
            outf.write('        "' + inp + '" { 01Z  { \'0.000000ns\''
                       + ' D/U/Z; } }\n') #input signals

    for outp in outnames:  #output signals
        outf.write('        "' + outp + '" { LHTX { \'0ns\' X/X/X/X;'
                   +' \'72.000000ns\' L/H/T/X; } }\n')
    outf.write('  } }\n}\n\n')

    # Test vectors, placed here to replicate STIL files from CET
    outf.write('// ----TEST VECTORS---- //\n\n')
    outf.write('PatternBurst\n')
    outf.write('  MAIN_BRST { Termination { "ALLPOs" TerminateOff; }\n')
    outf.write('    PatList { MAIN_TEST; } }\n\n')
    outf.write('PatternExec\n')
    outf.write('  MAIN_EXEC { PatternBurst MAIN_BRST; }\n\n')
    outf.write('Pattern\n')
    outf.write('  MAIN_TEST {\n\n')

    # Outputs vectors
    for i in range(len(invecs)):
        outf.write('  // -- Pattern ' + str(i+1) + ' -- \n')
        outf.write('  "1.1.1.1.2.' + str(i+1) + '.2":\n')
        outf.write('  Macro "TEST" {\n')
        outf.write('    "ALLPIs" = ')
        for sig in cknames+innames:
            outf.write(indict[sig][i])
        outf.write(';\n')
        outf.write('    "ALLPOs" = ' + outvecs[i] + '; }\n\n')
    outf.write('  }')

    outf.close()
    return


# Writes the STIL signals file given input file information and output file name
def write_stilsig(cknames, innames, invecs, intype, outnames, outfname,
                  infname):
    '''Writes STIL signal file'''
    #resulting file in form <fname>.signals.stil
    outf = open(outfname + '.signals.stil', 'w')
    outf.write('STIL 1.0;\n\n')  #needed at top of STIL files

    #file information
    outf.write('// --- STIL SIGNAL FILE ---\n')
    outf.write('// ' + outfname + '.signals.stil\n')
    outf.write('// Input file: ' + infname + '\n')
    outf.write('// Converted from ' + intype + ' to STIL\n\n')

    #circuit/vectors inforamtion
    outf.write('// ' + str(len(invecs)) + ' vectors in file\n')
    outf.write('// ' + str(len(cknames)) + ' clock signals present\n')
    outf.write('// ' + str(len(innames) - len(cknames))
               + ' input signals present (not including clocks)\n')
    outf.write('// ' + str(len(outnames)) + ' output signals preset\n\n')

    if cknames:
        outf.write('// CLOCKS: ' + ', '.join(cknames) + '\n')
    outf.write('// INPUTS: ' + ', '.join(innames) + '\n')
    outf.write('// OUTPUTS: ' + ', '.join(outnames) + '\n\n\n')

    # Defines signals, placed in same order as in vectors file
    outf.write('// --- DEFINE SIGNALS ---\n\n')
    outf.write('  Signals {\n')
    for inp in cknames + innames:
        outf.write('    "' + inp + '" In;\n')
    for outp in outnames:
        outf.write('    "' + outp + '" Out;\n')

    # Defines signal groups (inputs vs outputs), same order maintained
    outf.write('  }\n\n\n// --- DEFINE SIGNAL GROUPS ---\n\n')
    outf.write('  SignalGroups {\n')

    outf.write('    "ALLPIs" = \'"' + '"+"'.join(cknames + innames) + '"\';\n')
    outf.write('    "ALLPOs" = \'"' + '"+"'.join(outnames) + '"\';\n  }\n\n')

    # Defines how vectors are represented in vector file, from CET STIL files
    outf.write('// --- DEFINE MACROS --- \n\n')
    outf.write('  MacroDefs {\n')
    outf.write('    "TEST" { WaveformTable "test_cycle";\n')
    outf.write('      Vector {\n')
    outf.write('        "ALLPOs" = %;\n')
    outf.write('        "ALLPIs" = %; } }\n}\n')

    outf.close()

    return



# Writes out Verilog TestBench files given data from input file
def write_vlogtb(cknames, innames, invecs, indict, intype,
                 outnames, modname, outfname, infname):
    '''Writes Verilog TestBench file'''
    #resulting file in form TB_<fname>.v
    outf = open('TB_' + outfname + '.v', 'w')
    outf.write('`timescale 1ns/100ps\n')  #timescale
    #file info
    outf.write('// VERILOG TESTBENCH')
    outf.write('// TB_' + outfname + '.v\n')
    outf.write('// Input file: ' + infname + '\n')
    outf.write('// Converted from ' + intype + ' to Verilog TestBench\n//\n')
    outf.write('// Module "' + modname + '"\n')
    #circuit/vectors information
    outf.write('// ' + str(len(invecs)) + ' vectors in file\n')
    outf.write('// ' + str(len(cknames)) + ' clock signals present\n')
    outf.write('// ' + str(len(innames) - len(cknames))
               + ' input signals present (not including clocks)\n')
    outf.write('// ' + str(len(outnames)) + ' output signals preset\n//\n')

    if cknames:
        outf.write('// CLOCKS: ' + ', '.join(cknames) + '\n')
    outf.write('// INPUTS: ' + ', '.join(innames) + '\n')
    outf.write('// OUTPUTS: ' + ', '.join(outnames) + '\n')


    outf.write('\n\n')

    #module starts
    outf.write('module TB_' + modname + '();\n')

    #wire/reg declarations
    outf.write('\twire ' + ', '.join(outnames) + ';\t//output signals\n')
    outf.write('\treg ' + ', '.join(cknames + innames)
               + ';\t//input signals\n\n')
#    outf.write('\t//reg [' + str(len(innames)-1)
#               + ':0] inputs;\t//clocks not included\n\n')

    #top cell module instantiation
    outf.write('\t//Insert correct wiring below\n')
    outf.write('\t' + modname + ' TOP ' + '(CLOCKS, INPUTS, OUTPUTS);\n\n')

    #initial
    outf.write('\tinitial begin\n')


    #test input waveform
    for i in range(len(invecs)):
        for cksig in cknames:
            if indict[cksig][i] == 'P':  #Performs clock pulse if defined
                outf.write('\t\t' + cksig + ' = 1\'b0;\n')
            else:
                outf.write('\t\t' + cksig + ' = 1\'b'
                           + indict[cksig][i] + ';\n')

        #Changes input values
        outf.write('\t\t//Test vector ' + str(i+1) + '\n')
        outf.write('\t\t{' + ', '.join(innames) + '} = ' + str(len(innames))
                   + '\'b' + invecs[i] + ';\n')

        outf.write('\t\t#5;\n')
        for cksig in cknames:
            if indict[cksig][i] == 'P':
                outf.write('\t\t' + cksig + ' = 1\'b1;\n')
        outf.write('\t\t#5;\n')
    outf.write('\tend\n')
    outf.write('endmodule\n')

    outf.close()

    return

# Writes easy-to-read file given input file data and output filename
def write_etr(cknames, innames, indict, intype,
              outnames, outdict, outfname, infname):
    '''Writes Easy-to-Read file'''
    outf = open(outfname + '.etr', 'w') #resulting file in form <fname>.etr

    #File info
    outf.write('EASY-TO-READ ** do not remove, file type detection\n')
    outf.write('-- ' + outfname + '.etr --\n')
    outf.write('Initial input: ' + infname + '\n')
    outf.write('Converted from ' + intype + ' to easy-to-read\n')

    #circuit/vector info
    outf.write(str(len(indict[innames[0]])) + ' vectors in file\n')
    outf.write(str(len(cknames)) + ' clock signals present\n')
    outf.write(str(len(innames) - len(cknames))
               + ' input signals present (not including clocks)\n')
    outf.write(str(len(outdict)) + ' output signals preset\n\n')

    #signal information, used when converting from etr
    
    if cknames:
        outf.write('CLOCKS: ' + ', '.join(cknames) + '\n')
    outf.write('INPUTS: ' + ', '.join(innames) + '\n')
    outf.write('OUTPUTS: ' + ', '.join(outnames) + '\n')
    outf.write('Ordering of signals corresponds to order of bits in test '
               + 'vector\n')
    outf.write('\n\n')

    #header for file
    if cknames:
        outf.write('#\tCK' + (' ' * (len(cknames)-2)) + '\tIN'
                   + (' ' * (len(innames)-2)) + '\tOUT\n')
    else:
        outf.write('#\tIN' + (' ' * (len(innames)-2)) + '\tOUT\n')

    #writes vectors in same order as signals are ordered above
    for i in range(len(indict[innames[0]])):
        outf.write(str(i+1) + ':\t')
        for cksig in cknames:
            outf.write(str(indict[cksig][i]))
        if cknames:
            outf.write('\t')
        for insig in innames:
            outf.write(str(indict[insig][i]))
        outf.write('\t')
        for outsig in outnames:
            outf.write(str(outdict[outsig][i]))
        outf.write('\n')

    outf.write('\n')

    outf.close()
    return


# Writes template for easy-to-read mapping file, file used in p5serialize.py
def write_etrmap(innames, outnames, outfname):
    '''Writes Easy-to-Read template mapping file'''
    outf = open(outfname + '.Tp5map', 'w')
    #file info
    outf.write(' -- ' + outfname + '.Tp5map --\n\n')
    outf.write('Project 5 mapping file template\n')
    outf.write('File used to define scan chains for use with' +
               ' \'p5serialize.py\' script\n\n\n')

    #Already defined, input and output signals of combinational circuit
    outf.write('** Input/output definitions do not need modification\n')
    outf.write('INPUTS: ' + ', '.join(innames) + '\n')
    outf.write('OUTPUTS: ' + ', '.join(outnames) + '\n\n\n')

    outf.write('** EACH OF THE ABOVE SIGNALS MUST BE ASSIGNED TO ONE OF THE '
               + 'FOLLOWING GROUPS **\n')
    outf.write('** Each signal group definition must be on one line **\n')

    #user defines, signals corresponding to remaining primary outpus
    outf.write('\n** Which of the inputs/outputs are to remain primary I/Os?\n')
    outf.write('PRIMARY_INPUTS: \n')
    outf.write('PRIMARY_OUTPUTS: \n\n')

    #user defines, signals corresponding to boundary scan cells
    outf.write('** Which of the inputs/outputs are being used in boundary scan'
               + ' cells?\n')
    outf.write('INPUT_BS_SIGNALS: \n')
    outf.write('OUTPUT_BS_SIGNALS: \n\n')

    #user defines, signal pairs corresponding to internal scan flip flop
    outf.write('** Which of the inputs/outputs correspond to internal scan flip'
               + ' flops?\n')
    outf.write('** If \'A_in\' (PO of comb circuit) is the serial '
               + 'input to the scan flip flop and\n')
    outf.write('**    \'A_out\' (PI of comb circuit) is the serial '
               + 'output of the scan flip flop\n')
    outf.write('** Use form:    \'A_in+A_out, ...\'\n')
    outf.write('SCAN_PAIRS: \n\n\n\n')

    #user defines, clock and control signals
    outf.write('** Define clock or control signals if desired.\n')
    outf.write('** Clock signals will contain an initial 0 followed by'
               + ' pulses.\n')
    outf.write('** Control signals can be assigned a cycle using the form:\n')
    outf.write('**\t\'CNTLA=1, CNTLB=1110, CNTLC=ABC\'\n')
    outf.write('** If value is not assigned for control signal the'
               + ' value \'%\' will be given\n')
    outf.write('CLOCKS: \n')
    outf.write('CONTROLS: \n\n\n')

    #user defines, number of filler vectors before stimming PIs/reading POs
    outf.write('** How many filler vectors should print before stimulating'
               + ' PIs or reading POs?\n')
    outf.write('** Use digit, or leave blank if no added vectors are desired\n')
    outf.write('ADD_VECTORS_BEFORE_IO: \n\n')

    #user defines, filler vectors at end of cycle
    outf.write('** How many filler vectors should print at the end of each'
               + ' cycle?\n')
    outf.write('** Use digit, or leave blank if no added vectors are desired\n')
    outf.write('END_OF_CYCLE_VECTORS: \n\n\n')


    #information for user about how to define scanchains and scanchain ordering
    #user defines, scan chain definitions
    outf.write('** User defines scan chains to produce corresponding serialized'
               + ' output\n')
    outf.write('** Scan in port and scan out port will be created'
               + ' automatically\n')
    outf.write('** Definition should be in following form \n')
    outf.write('**  Use form:\n')
    outf.write('**\tSCAN_CHAIN <name>: <signal 1>, <signal 2>, '
               + ' ... , <signal n>\n')
    outf.write('**  For scan chain with order:\n')
    outf.write('**\t>|SI_<name>| >> signal 1 > signal 2 >  ... >'
               + ' signal n >> |SO_name|>\n')
    outf.write('** Multiple scan chains can be defined\n')
    outf.write('** For internal scan FFs give only the serial input '
               + 'signal (comb circuit output)\n')
    outf.write('** Reference help document \'Project 5 Scripts Help\' for '
               + 'details on serialization\n')
    outf.write('SCAN_CHAIN A: \n\n')

    outf.close()


    return
