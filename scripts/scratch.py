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
    dffs = []
    chain = []

    with open(args.ckt, "r") as seq_file:
        file_lines = seq_file.read().splitlines()
        for fl in file_lines:
            if (fl.split()) and (fl.split()[0] == "dff"):
                lines.append(fl)

    # print(lines)
    for i in range(0,len(lines)):
        line = lines[i]
        if (line.split()) and (line.split()[0] == "dff"):
            line = line.split("(")[1]
            line = line.replace(");","")
            args = line.split(",")
            # newline = "SFF_" + str(i) + " (" + ",".join(new_args) + ");"
            # newline = "S" + line[1:]
            s = ("%s+%s"%(args[2],args[0]))
            dffs.append(s)
            chain.append(args[2])
            # return

    print(",".join(dffs))
    print(",".join(chain))


# def main():
#     parser = argparse.ArgumentParser(description="Convert sequential Verilog circuit to a combinational one.")
#     parser.add_argument("ckt", help="Input: sequential Verilog header")

#     args = parser.parse_args()

#     i_set = set()
#     o_set = set()
#     wire_set = set()
#     dff_in_set = set()
#     dff_out_set = set()


#     TDI = "TDI_ISR"
#     TDO = ""
#     lines = []
#     interm_wires = []

#     with open(args.ckt, "r") as seq_file:
#         file_lines = seq_file.read().splitlines()
#         for fl in file_lines:
#             if (fl.split()) and (fl.split()[0] == "dff"):
#                 lines.append(fl)

#     # print(lines)
#     for i in range(0,len(lines)):
#         line = lines[i]
#         if i == len(lines)-1:
#             TDO = "TDO_ISR"
#         else:
#             TDO = "tdi_" + (lines[i+1].split()[1]).split(",")[2][:-2]
#             interm_wires.append(TDO)
#             # print(TDO)
#         if (line.split()) and (line.split()[0] == "dff"):
#             # print(line)
#             line = line.split("(")[1]
#             line = line.replace(");","")
#             args = line.split(",")
#             new_args = [TDI, args[2], args[1], "updatedr,shiftdr,bs_en",TDO,args[0]]
#             newline = "SFF_" + str(i) + " (" + ",".join(new_args) + ");"
#             # newline = "S" + line[1:]
#             print("SFF " + newline)
#             TDI = TDO
#             # return

#     print(",".join(interm_wires))

if __name__ == '__main__':
    main()