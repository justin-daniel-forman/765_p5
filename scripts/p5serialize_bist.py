#!/usr/bin/python
# p5serialize.py
#
# 18-765: Digital Systems Testing and Testable Design
# Script used for Project 5
#
#
# Used to create serialized vector file
#
# INPUTS:  <combfile(.etr)>
#               ** easy-to-read file for purely combinational circuit
#          <mappingfile(.p5map)>
#               ** Mapping file, defines scanchains and other signals
#          <outputfilename>
#               ** user-defined name for output
#
# OUTPUTS  <outputfilename>.Setr
#               ** serialized easy-to-read file
#
#
'''Module creates serialized vector file'''

import re
import sys
import optparse


# Reads in easy-to-read file
# Accepts name of file,
# Returns lists of input and output signals, input and output vectors
def read_etr(infetrname):
    '''Reads non-serialized Easy-to-Read file'''
    infile = open(infetrname, 'rU')
    innames = []  #stores names of inputs
    outnames = []  #stores names of outputs
    invecs = []  #stores vectors of inputs
    outvecs = [] #stores vectors of outputs

    for line in infile: #reads file line-by-line

        #clock signals should not be present
        cksig = re.search(r'^CLOCKS\s*:\s*(.+)\s*\n', line)
        if cksig:
            print 'Error: Circuit used to create \'.etr\'',
            print ' file should be purely combinational for serialization\n'
            sys.exit(2)


        insig = re.search(r'^INPUTS\s*:\s*(.+)\s*\n', line) #gets inputs
        if insig:
            innames = re.split(r',\s*', insig.group(1))
            continue
        outsig = re.search(r'^OUTPUTS\s*:\s*(.+)\s*\n', line) #gets outputs
        if outsig:
            outnames = re.split(r',\s*', outsig.group(1))
            continue

        #gets vectors
        vector = re.search(r'^\d+:\s*(\w*)\s*(\w*)\s*(\w*)\n', line)
        if vector:
            invecs.append(vector.group(1))
            outvecs.append(vector.group(2))

    infile.close()


    return (innames, outnames, invecs, outvecs)


# Creates dictionaries of inputs and outputs
# Accepts lists of input names, output names, input vectors, and output vectors
def makedict(innames, outnames, invecs, outvecs):
    '''Creates dictionaries of inputs and outputs'''
    indict = {}  #input dictionary
    outdict = {}  #output dictionary

    # each key is input signal, each value is list of 1 bit strings from vectors
    for vec in invecs:
        for name in innames:
            if not name in indict:
                indict[name] = []
            indict[name].append(vec[innames.index(name)])

    # each key is input signal, each value is list of 1 bit strings from vectors
    for vec in outvecs:
        for name in outnames:
            if not name in outdict:
                outdict[name] = []
            outdict[name].append(vec[outnames.index(name)])

    return (indict, outdict)



# Reads mapping file
# Accepts filename,
# Returns dict of scanchains, lists of controls, clocks, pri inputs, pri outputs
def read_map(fmapname):
    '''Reads Easy-to-Read mapping file'''
    fmap = open(fmapname, 'rU')
    scanchains = {}
    controls = {}
    clocks = []
    pins = []
    pouts = []
    fins = []
    fouts = []
    scanpairdict = {}
    iovecsadd = 0
    endvecsadd = 0

    for line in fmap:  #reads file line-by-line

        cksig = re.search(r'^\s*CLOCKS\s*:\s*(.+)', line) #finds clock signals
        if cksig:
            clockstr = cksig.group(1).strip()
            if clockstr:
                clocks = re.split(r',\s*', clockstr)
            continue
        #finds cntl signals
        cntlsig = re.search(r'^\s*CONTROLS\s*:\s*(.+)', line)
        if cntlsig:
            cntlstr = cntlsig.group(1).strip()
            if cntlstr:
                cntl = re.split(r',\s*', cntlstr)
                for sig in cntl:
                    sigspl = re.split(r'\s*=\s*', sig)
                    try:
                        controls[sigspl[0]] = sigspl[1].replace(' ', '')
                    except IndexError:
                        controls[sigspl[0]] = '%'
            continue

        #finds primary inputs
        pinsig = re.search(r'^\s*PRIMARY_INPUTS\s*:\s*(.+)', line)
        if pinsig:
            pinsstr = pinsig.group(1).strip()
            if pinsstr:
                pins = re.split(r',\s*', pinsstr)
            continue
        #finds primary outputs
        poutsig = re.search(r'^\s*PRIMARY_OUTPUTS\s*:\s*(.+)', line)
        if poutsig:
            poutsstr = poutsig.group(1).strip()
            if poutsstr:
                pouts = re.split(r',\s*', poutsstr)
            continue

        #finds internal scan pairs
        scanpairsig = re.search(r'^\s*SCAN_PAIRS\s*:\s*(.+)', line)
        if scanpairsig:
            scanstr = scanpairsig.group(1).strip()
            if scanstr:
                joinedscans = re.split(r',\s*', scanstr)
                for i in range(len(joinedscans)):
                    pair = re.split(r'\s*\+\s*', (joinedscans[i]))
                    scanpairdict[pair[0]] = pair[1] #***ALTERED***
            continue

        #finds scan chains
        scsig = re.search(r'^\s*SCAN_CHAIN\s+(.+)\s*:\s*(.+)', line)
        if scsig:
            chainstr = scsig.group(2).strip()
            if chainstr:
                chains = re.split(r',\s*', chainstr)
                scanchains[scsig.group(1)] = chains
            continue

        #finds signals used for boundary scan
        finsig = re.search(r'^\s*INPUT_BS_SIGNALS\s*:\s*(.+)', line)
        if finsig:
            finsigstr = finsig.group(1).strip()
            if finsigstr:
                fins = re.split(r',\s*', finsigstr)
            continue
        foutsig = re.search(r'^\s*OUTPUT_BS_SIGNALS\s*:\s*(.+)', line)
        if foutsig:
            foutsigstr = foutsig.group(1).strip()
            if foutsigstr:
                fouts = re.split(r',\s*', foutsigstr)
            continue

        #finds filler vectors before primary IO
        iovecsaddsig = re.search(r'^\s*ADD_VECTORS_BEFORE_IO\s*:\s*(\d+)', line)
        if iovecsaddsig:
            iovecsadd = eval(iovecsaddsig.group(1))
            continue

        #find filler vectors at end of cycle
        endvecsaddsig = re.search(r'^\s*END_OF_CYCLE_VECTORS\s*:\s*(\d+)', line)
        if endvecsaddsig:
            endvecsadd = eval(endvecsaddsig.group(1))
            continue

    fmap.close()

    return (scanchains, controls, clocks, pins, pouts, fins, fouts,
            scanpairdict, iovecsadd, endvecsadd)

#Checks for a couple of possible errors with data
def checkmap(cknames, scanchains, controls, scanpairdict, pins, pouts):
    '''Performs checks on mapping file'''
    for i in scanchains:
        # Makes sure no controls are in scan chains
        if set(scanchains[i]).intersection(set(controls.keys())):
            print 'Error: control value cannot be present in scan chain'
            sys.exit(2)
        # Makes sure no clocks are in scan chains
        if set(scanchains[i]).intersection(set(cknames)):
            print 'Error: clock signal cannot be present in scan chain'
            sys.exit(2)
        if set(scanchains[i]).intersection(set(pins)):
            print 'Error: primary input signals cannot be present in scan chain'
            sys.exit(2)
        if set(scanchains[i]).intersection(set(pouts)):
            print'Error: primary output signals cannot be present in scan chain'
            sys.exit(2)

    for sig in scanpairdict.keys():
        for i in scanchains:
            if sig in scanchains[i] and scanpairdict[sig] in scanchains[i]:
                print 'Error: both signals of scan pair',
                print ' cannot be present in scan chains'
                print 'Use the input to the scan flip-flop only'
                sys.exit(2)

    return


# Finds necessary length for serialized vector
def findveclen(innames, outnames, scanchains, scanpairdict):
    '''Finds necessary length of serialized vector based on scan chains'''
    veclen = 0
    for chain in scanchains:
        inlen = 0
        outlen = len(scanchains[chain])
        for i in scanchains[chain]:
            if i in innames or i in scanpairdict.values():
                inlen = max(inlen, scanchains[chain].index(i)+1)
            if i in outnames:
                outlen = min(outlen, scanchains[chain].index(i))

        #finds length of deepest input/output
        veclen = max(veclen, inlen, len(scanchains[chain]) - outlen)

    return veclen


# Writes easy-to-read file using information from input files
def write_etr(clocks, indict, outdict, scanchains, controls, pins, pouts,
              fins, fouts, scanpairdict, veclen, iovecsadd, endvecsadd,
              outfname, infetrname, infmapname):
    '''Writes Serialized Easy-to-Read file'''
    outf = open(outfname + '.Setr', 'w')
    outf.write('EASY-TO-READ ** do not remove, file type detection\n')
    outf.write('-- ' + outfname + '.Setr --\n')
    outf.write('Initial etr input: ' + infetrname + '\n')
    outf.write('Mapped using: ' + infmapname + '\n\n')

    #writes information at top of file file
    outf.write(str(len(indict[indict.keys()[0]])+1) + ' vectors in file\n')
    outf.write(str(len(clocks)) + ' clock signals present\n')
    outf.write(str(len(controls)) + ' control signals present\n')
    outf.write(str(len(indict) + len(controls) + len(scanchains)
                   - len(scanpairdict))
               + ' total input signals present'
               + ' (with controls & scanins, not including clocks)\n')
    outf.write(str(len(outdict) + len(scanchains) - len(scanpairdict))
               + ' total output signals preset (including scanouts)\n')
    outf.write(str(len(scanpairdict)) + ' internal scan flip flops\n')
    outf.write(str(len(fins) + len(fouts)) + ' boundary scan cells\n')
    outf.write(str(len(scanchains)) + ' scan chains present\n\n\n')

    outf.write('** Ordering of signals corresponds to order of bits in test '
               + 'vectors **\n\n')
    #signal information
    if clocks:
        outf.write('CLOCKS: ' + ', '.join(clocks) + '\n')
    if controls:
        outf.write('CONTROLS: ' + ', '.join(controls.keys()) + '\n\n')

    tempin = []
    for chain in scanchains:
        tempin.append('SI_' + chain)
    if tempin:
        outf.write('SCAN_INS: ' + ', '.join(tempin) + '\n')

    tempout = []
    for chain in scanchains:
        tempout.append('SO_' + chain)
    if tempout:
        outf.write('SCAN_OUTS: ' + ', '.join(tempout) + '\n\n')

    if pins:
        outf.write('PRIMARY_INPUTS: ' + ', '.join(pins) + '\n')
    if pouts:
        outf.write('PRIMARY_OUTPUTS: ' + ', '.join(pouts) + '\n\n')


    if fins:
        outf.write('FLOAT_INS: ' + ', '.join(fins) + '\n')
    if fouts:
        outf.write('FLOAT_OUTS: ' + ', '.join(fouts) + '\n\n')

    #scan chain orientation
    for i in scanchains.keys():
        outf.write('**SCAN_CHAIN ' + i + ': SI_' + i + ' >> '
                   + ', '.join(scanchains[i]) + ' >> SO_' + i + '\n')
    outf.write('\n')
    outf.write('** User must define change values on control signal vectors\n')
    outf.write('** Inputs must have value \'0\', \'1\', or \'Z\'\n')
    outf.write('** Outputs must have value \'L\', \'H\', or \'X\'\n\n\n')

    #header at top of vectors
    outf.write('#\tCK' + (len(clocks)-2) * ' ' + '\tCTL'
               + (len(controls)-3) * ' ' + '\tSI'  + (len(scanchains)-2) * ' '
               + '\tSO'  + (len(scanchains)-2) * ' ' + '\tPIN'
               + (len(pins)-3) * ' ' + '\tPOUT' + (len(pouts) - 4) * ' '
               + '\tFIN' + (len(fins)-3) * ' ' + '\tFOUT\n')




    # initial vector sets clock value to allow for pulses
    outf.write('1:\t' + len(clocks) * '0' + '\t' + len(controls) * 'Z' + '\t'
               + len(scanchains) * 'Z' + '\t' + len(scanchains) * 'X' + '\t'
               + len(pins) * 'Z' + '\t' + len(pouts) * 'X' + '\t'
               + len(fins) * 'Z' + '\t' + len(fouts) * 'X' + '\n')

    #reverses scanchains for easier access
    for chain in scanchains:
        scanchains[chain].reverse()

    #find length of entire vector
    totalveclen = veclen + iovecsadd + endvecsadd + bool(pins or pouts)

    #makes dictionary of bits for each scanchain
    schainbits = makechaindict(indict, outdict, scanchains, scanpairdict,
                               veclen, totalveclen)
    count = 0


    for i in range(len(indict[indict.keys()[0]])+1):
        #scanchain vectors
        for _ in range(veclen):
            outf.write(str(count+2) + ':\t')
            outf.write('P' * len(clocks) + '\t')

            #control signal bits
            for ctlsig in controls:
                outf.write(controls[ctlsig][(count)%len(controls[ctlsig])])
            outf.write('\t')

            #scanchain bits
            for chain in scanchains:
                outf.write(schainbits['in'][chain][count])
            outf.write('\t')
            for chain in scanchains:
                outf.write(schainbits['out'][chain][count])
            outf.write('\t')

            outf.write('Z' * len(pins) + '\t' + 'X' * len(pouts))

            outf.write('\t' + 'Z' * len(fins) + '\t' + 'X' * len(fouts) + '\n')
            count += 1

        #filler vectors
        for _ in range(iovecsadd):
            outf.write(str(count+2) + ':\t')
            outf.write('P' * len(clocks) + '\t')

            #controls
            for ctlsig in controls:
                outf.write(controls[ctlsig][(count)%len(controls[ctlsig])])
            outf.write('\t')

            #scanchains
            for chain in scanchains:
                outf.write(schainbits['in'][chain][count])
            outf.write('\t')
            for chain in scanchains:
                outf.write(schainbits['out'][chain][count])
            outf.write('\t')
            outf.write('Z' * len(pins) + '\t' + 'X' * len(pouts))

            outf.write('\t' + 'Z' * len(fins) + '\t' + 'X' * len(fouts) + '\n')
            count += 1


        #primary input stim and primary output measuring
        if pins or pouts:
            outf.write(str(count+2) + ':\t')
            outf.write('P' * len(clocks) + '\t')

            #controls
            for ctlsig in controls:
                outf.write(controls[ctlsig][(count)%len(controls[ctlsig])])
            outf.write('\t')

            #scanchains
            for chain in scanchains:
                outf.write(schainbits['in'][chain][count])
            outf.write('\t')
            for chain in scanchains:
                outf.write(schainbits['out'][chain][count])
            outf.write('\t')
            #primary inputs/outputs bits
            for sig in pins:
                try:
                    outf.write(indict[sig][i])
                except IndexError:
                    outf.write('Z')
            outf.write('\t')
            for sig in pouts:
                try:
                    outf.write(outdict[sig][i])
                except IndexError:
                    outf.write('X')

            outf.write('\t' + 'Z' * len(fins) + '\t' + 'X' * len(fouts) + '\n')
            count += 1


        #filler vectors at end of cycle
        for _ in range(endvecsadd):
            outf.write(str(count+2) + ':\t')
            outf.write('P' * len(clocks) + '\t')

            for ctlsig in controls:
                outf.write(controls[ctlsig][(count)%len(controls[ctlsig])])
            outf.write('\t')

            for chain in scanchains:
                outf.write(schainbits['in'][chain][count])
            outf.write('\t')
            for chain in scanchains:
                outf.write(schainbits['out'][chain][count])
            outf.write('\t')
            outf.write('Z' * len(pins) + '\t' + 'X' * len(pouts))

            outf.write('\t' + 'Z' * len(fins) + '\t' + 'X' * len(fouts) + '\n')
            count += 1

        outf.write('** END OF VECTOR ' + str(i+1) + ' **\n')

    outf.close()

    return

def makechaindict(indict, outdict, scanchains, scanpairdict, veclen,
                  totalveclen):

    '''Creates string of bits used for printing scan chain values'''
    scbits = {'in' : {},
              'out' : {}}
    #loops through scanchains
    for chain in scanchains:
        scbits['in'][chain] = ''
        scbits['out'][chain] = ''
        #for unserialized vectors
        for i  in range(len(indict[indict.keys()[0]])):
            #for length of longest scan chain
            for j in range(veclen):
                #output signal
                try:
                    sigout = scanchains[chain][j]
                except (KeyError, IndexError):
                    sigout = None
                #input siganl
                try:
                    sigin = scanchains[chain][-veclen + j]
                except (KeyError, IndexError):
                    sigin = None

                #check for input signals
                if sigin in scanpairdict:
                    scbits['in'][chain] += indict[scanpairdict[sigin]][i]
                elif sigin in indict:
                    scbits['in'][chain] += indict[sigin][i]
                else:
                    scbits['in'][chain] += 'Z'

                #check for output signals
                if sigout in outdict:
                    scbits['out'][chain] += outdict[sigout][i]
                else:
                    scbits['out'][chain] += 'X'

            #Add required padding
            scbits['in'][chain] += 'Z' * (totalveclen - veclen)
            scbits['out'][chain] += 'X' * (totalveclen - veclen)

        #No expects for outputs in first cycle
        scbits['out'][chain] = ('X' * (totalveclen - 1) + scbits['out'][chain]
                                + 'X')
        #No input bits applied on last cycle
        scbits['in'][chain] += 'Z' * (totalveclen)


    return scbits



def main():
    '''calls functions, etc'''
    # optparse used to accept arguments
    prog = "p5convertfile.py"
    usage = "usage: ./%prog inetrfile inmapfile outfilename"
    version = "%prog 1.0"

    parser = optparse.OptionParser(usage=usage, version=version)

    (options, args) = parser.parse_args()


    # returns error if wrong number of arguments are input
    if not len(args) == 3:
        parser.error('Incorrect number of arguments')

    # input arguments stored
    infetrname = args[0]
    infmapname = args[1]
    outfname = args[2]

    #reads etr file
    (innames, outnames, invecs, outvecs) = read_etr(infetrname)

    #makes dicts
    (indict, outdict) = makedict(innames, outnames, invecs, outvecs)

    #prints info from etr file
    print '\n',
    print 'READING FROM INPUT FILE'
    print len(innames), ' input signals found'
    print len(outnames), ' output signals found'
    print len(invecs), ' vectors found\n'

    #reads mapping files
    (scanchains, controls, clocks, pins, pouts,
     fins, fouts, scanpairdict, iovecsadd, endvecsadd) = read_map(infmapname)

    #prints info from mapping file

    print 'READING FROM MAPPING FILE'
    print len(pins), ' primary inputs defined'
    print len(pouts), ' primary outputs defined'
    print len(fins) + len(fouts), ' boundary scan signals defined'
    print len(scanpairdict), ' internal scan flip flops defined'
    print len(clocks), ' clock signals defined'
    print len(controls), ' control signals defined'
    print len(scanchains), ' scanchains defined'
    for chain in scanchains:
        print '\tScanchain ', chain, ' of length', len(scanchains[chain])
    print '\n',


    #checks for possible errors in data
    checkmap(clocks, scanchains, controls, scanpairdict, pins, pouts)

    #gets length of serialized vector
    veclen = findveclen(innames, outnames, scanchains, scanpairdict)


    #writes serialized etr file
    write_etr(clocks, indict, outdict, scanchains, controls, pins, pouts,
              fins, fouts, scanpairdict, veclen, iovecsadd, endvecsadd,
              outfname, infetrname, infmapname)

if __name__ == '__main__':
    main()
