#!/usr/bin/python
# p5convertfile.py
#
# 18-765: Digital Systems Testing and Testable Design
# Script used for Project 5
#
#
# Used to convert between vector file types
#
# INPUTS:
#   Starting File:
#       <inputfile>
#         ** File to convert from
#
#   Resulting File:
#        <outputfilename>
#
# OPTIONS:
#   Convert from file type -f:
#       -f stil  ** input file is type STIL (default)
#       -f etr   ** input file is type easy-to-read
#
#   Convert TO file type -t:
#       -t stil     ** output file will be type STIL (default)
#       -t etr      ** output file will be type easy-to-read
#        --map     ** creates template for mapping file (default: not created)
#       -t tbd      ** output file will be type TBDpatt
#       -t verilog  ** output file will be type verilog
#         --mod <modname>
#           ** module in TestBench name modname (default: 'modulename')
#
# OUTPUTS:
#
#   Converting to STIL (-t stil):
#     <stiloutputfilename>.vectors.stil
#       ** STIL file containing vectors, used for Cadence ET
#     <stiloutputfilename>.signals.stil
#       ** STIL file containing signal definitions for CET
#
#   Converting to easy-to-read (-t etr):
#       <etroutputfilename>.etr
#       ** easy-to-read file containing vectors
#       <etroutputfilename>.Tp5map (with --map)
#         ** template for mapping file used in p5serialize.py
#
#   Converting to TBD Pattern file (-t tbd)
#       TBDpatt.FULLSCAN.<tbdoutputname>
#       ** TBDpatt file containing vectors
#
#   Converting to Verilog (-t verilog):
#       TB_<vlogoutputfilename>.v
#         ** Verilog TestBench containing vectors and signals
#
#
'''Used for conversion between vector file types'''

import sys
import optparse
import p5fileconvert


# Checks for a couple possible errors in the data
def checkfinputs(innames, outnames, invecs, outvecs):
    '''Performs checks on data'''

    #import pdb; pdb.set_trace()

    #makes sure number of input signals matches length of input vector
    for vec in invecs:
        if not len(vec) == len(innames):
            vecnum = invecs.index(vec)
            print 'Error: length of vector', vecnum,
            print 'does not match defined number of inputs'
            print 'Vector', vecnum, ': ', invecs[vecnum]
            sys.exit(2)

    #makes sure number of ouptut signals matches length of output vector
    for vec in outvecs:
        if not len(vec) == len(outnames):
            vecnum = invecs.index(vec)
            print 'Error: length of vector', vecnum,
            print 'does not match defined number of outputs'
            print 'Vector', vecnum, ': ', invecs[vecnum]
            sys.exit(2)

    #makes sure number of input vectors and output vectors are the same
    if len(outvecs) > len(invecs):
        print 'Error: more output vectors than input vectors'
        sys.exit(2)
    if len(outvecs) < len(invecs):
        print 'Error: more input vectors than output vectors'
        sys.exit(2)

    #makes sure test vectors exist
    if not (invecs or outvecs):
        print 'Error: no test vectors found'
        sys.exit(2)

    return


#Creates dicts for input and output signals with data gathered from input file
def makedicts(cknames, innames, outnames, invecs, outvecs):
    '''Makes dictionaries of signal data'''
    indict = {}
    for vec in invecs:
        for name in innames:
            if not name in indict:
                indict[name] = []  #dict has input signals as keys
            #vectors are stored as list of 1 'bit' strings
            indict[name].append(vec[innames.index(name)])

    outdict = {}
    for vec in outvecs:
        for name in outnames:
            if not name in outdict:
                outdict[name] = []  #dict has output signals as keys
            #vectors are stored as list of 1 'bit' strings
            outdict[name].append(vec[outnames.index(name)])


    #removes clock values from invecs, already stored in indict
    for cksig in cknames:
        ckpl = innames.index(cksig)
        for i in range(len(invecs)):
            invecs[i] = invecs[i][:ckpl] + invecs[i][ckpl+1:]

        innames.remove(cksig)

    return (indict, outdict)


# If no type is given for input file tries to find one in file
# Looks for specific strings corresponding to file types
# These strings are printed anytime file is created by script or Cadence ET
def getintype(fname):
    '''If no input file type is defined tries to detect in file'''
    infile = open(fname, 'rU')
    ftype = 'none'
    for line in infile:
        #searches for certain string within file
        if 'STIL VECTOR FILE' in line:
            ftype = 'stil'
            break
        elif 'EASY-TO-READ' in line:
            ftype = 'etr'
            break
    if ftype == 'none':
        print 'Error: Input file type not recognized'
        print 'Choose file of proper type or define input type option'
        sys.exit(2)

    return ftype


def main():
    '''calls functions, etc'''
    # optparse used to accept arguments
    prog = "p5convert.py"
    usagedef = "usage: ./%prog "
    usageord = "infile [-f <intype>] [-t <outtype>] [options] outfilename"
    usage = usagedef + usageord
    version = "%prog 1.0"

    parser = optparse.OptionParser(usage=usage, version=version)
    # input file type
    parser.add_option('-f', '--from', type='choice',
                      choices=['stil', 'etr', 'none'], action="store",
                      dest="intype", default='none',
                      help="Determine input file type: 'stil' or 'etr'")
    # output file type
    parser.add_option('-t', '--to', type='choice',
                      choices=['stil', 'etr', 'tbd', 'verilog', 'none'],
                      action="store", dest="outtype", default='none',
                      help="Determine output file type: 'stil' (default),"
                      + " 'etr', 'verilog', or 'tbd'")
    # for converting to etr, mapping file flag
    parser.add_option('--map', action="store_true",
                      dest="mapflag", default=False,
                      help="With '-t etr', creates template for "
                      + "p5serialize.py mapping file")
    # for converting to verilog, module name
    parser.add_option('--mod', action="store",
                      dest="modname", default='modulename',
                      help="With '-t verilog', uses defined name as name of "
                      + "module (default: 'modulename')")


    (options, args) = parser.parse_args()



    # returns error if wrong number of arguments are input
    if not len(args) == 2:
        parser.error('Incorrect number of arguments')

    infname = args[0]
    outfname = args[1]

    modname = options.modname
    mapflag = options.mapflag

    #if no input type is defined
    if options.intype == 'none':
        intype = getintype(infname)
    else:
        intype = options.intype

    # if no output type is defined
    if options.outtype == 'none':
        if intype == 'stil':
            outtype = 'etr' #if STIL is input, easy-to-read is default output
        elif intype == 'etr':
            outtype = 'stil' #if easy-to-read is input, STIL is default output
    else:
        outtype = options.outtype


    #reads in file
    if intype == 'stil':
        (cknames, innames, outnames, invecs,
         outvecs) = p5fileconvert.read_stil(args[0])
    elif intype == 'etr':
        (cknames, innames, outnames, invecs,
         outvecs) = p5fileconvert.read_etr(args[0])
    else:
        print 'Error: input type not recognized'
        sys.exit(1)


    #checks for possible errors in input file data
    checkfinputs(innames, outnames, invecs, outvecs)

    #prints info from input file
    print '\n',
    print 'READING FROM INPUT FILE'
    print len(cknames), 'clock signals found'
    print len(innames) - len(cknames), ' input signals found (without clocks)'
    print len(outnames), ' output signals found'
    print len(invecs), ' vectors found\n'

    #stores values in dictionaries
    (indict, outdict) = makedicts(cknames, innames, outnames, invecs, outvecs)



    #outputs files
    if options.outtype == 'stil':
        p5fileconvert.write_stilvec(cknames, innames, invecs, indict, intype,
                                    outnames, outvecs, outfname, infname)
        p5fileconvert.write_stilsig(cknames, innames, invecs, intype,
                                    outnames, outfname, infname)
    elif outtype == 'verilog':
        p5fileconvert.write_vlogtb(cknames, innames, invecs, indict, intype,
                                   outnames, modname, outfname, infname)
    elif outtype == 'tbd':
        (indictm, outdictm) = p5fileconvert.bits_tbdpatt(indict, outdict)

        p5fileconvert.write_tbdpatt(cknames, innames, indictm, intype,
                                    outnames, outdictm, outfname, infname)
    elif outtype == 'etr':
        p5fileconvert.write_etr(cknames, innames, indict, intype,
                                outnames, outdict, outfname, infname)
        if mapflag:
            p5fileconvert.write_etrmap(innames, outnames, outfname)
    else:
        print 'Error: output type not recognized'
        sys.exit(1)


if __name__ == '__main__':
    main()
