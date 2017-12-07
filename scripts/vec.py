# this code is for copy/pasting into terminal; it doesn't run

# for i in range(1, len(arr)-1):
#     print("SFF sff_%s(tdi_%s,%s,clockdr,updatedr,shiftdr,bs_en,tdi_%s,cut_%s);"%(arr[i],arr[i],arr[i],arr[i+1],arr[i]));

# for i in range(1, len(arr)-1):
#     print("SFF sff_%s(tdi_%s,cut_%s,clockdr,updatedr,shiftdr,bs_en,tdi_%s,%s);"%(arr[i],arr[i],arr[i],arr[i+1],arr[i]));
    #SFF sff_g2584(tdi_g2584,cut_g2584,clockdr,updatedr,shiftdr,bs_en,tdi_g3222,g2584);


import argparse
import os

def main():
    parser = argparse.ArgumentParser(description="Convert sequential Verilog circuit to a combinational one.")
    parser.add_argument("ckt", help="Input: sequential Verilog header")

    args = parser.parse_args()

    i_set = set()
    o_set = set()
    wire_set = set()
    dff_in_set = set()
    dff_out_set = set()


    TDI = "TDI_ISR"
    TDO = ""
    lines = []
    vec = ""

    with open(args.ckt, "r") as seq_file:
        lines = seq_file.read().splitlines()

    # print(lines)
    for line in lines:
        # print(line)
        line = line.split()
        vec = vec + line[3]
        # print(line[3])

    print(vec)

if __name__ == '__main__':
    main()