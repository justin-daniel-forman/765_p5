#!/usr/bin/env python
# seq_to_comb.py
#
# Takes in a sequential circuit header and prints out what the resulting 
# combinational circuit I/O and wires should be.

import argparse
import os

def main():
    parser = argparse.ArgumentParser(description="Convert sequential Verilog circuit to a combinational one.")
    parser.add_argument("seq_ckt", help="Input: sequential Verilog header")
    parser.add_argument("comb_ckt", help="Output: combinational Verilog header")

    args = parser.parse_args()

    i_set = set()
    o_set = set()
    wire_set = set()
    dff_in_set = set()
    dff_out_set = set()

    with open(args.seq_ckt, "r") as seq_file:
        lines = seq_file.read().splitlines()
        for line in lines:
            list_type = line.split()[0]
            line = line.replace(' ', '')
            line = line.replace(';', '')
            if (list_type == "input"):
                i_set = set((line[len("input"):]).split(',')[0:])
            if (list_type == "output"):
                o_set = set((line[len("output"):]).split(',')[0:])
            if (list_type == "wire"):
                wire_set = set((line[len("wire"):]).split(',')[0:])
            if (list_type == "dff"):
                dff_in_set.add((line.split(',')[2]).split(")")[0])
                dff_out_set.add((line.split(',')[0]).split("(")[1])

    wire_set -= dff_in_set     #remove dffs from wires
    wire_set -= dff_out_set
    i_set = i_set.union(dff_in_set)
    o_set = o_set.union(dff_out_set)
    module_set = o_set.union(i_set)
    
    with open(args.comb_ckt, "w+") as comb_file:
        comb_file.write("Module I/O: %s"%",".join(str(e) for e in module_set))
        comb_file.write("\n\nInputs: %s"%",".join(str(e) for e in i_set))
        comb_file.write("\n\nOutputs: %s"%",".join(str(e) for e in o_set))
        comb_file.write("\n\nWires: %s"%",".join(str(e) for e in wire_set))

    comb_file.close()

if __name__ == '__main__':
    main()