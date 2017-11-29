# this code is for copy/pasting into terminal; it doesn't run

for i in range(1, len(arr)-1):
    print("SFF sff_%s(tdi_%s,%s,clockdr,updatedr,shiftdr,bs_en,tdi_%s,cut_%s);"%(arr[i],arr[i],arr[i],arr[i+1],arr[i]));

for i in range(1, len(arr)-1):
    print("SFF sff_%s(tdi_%s,cut_%s,clockdr,updatedr,shiftdr,bs_en,tdi_%s,%s);"%(arr[i],arr[i],arr[i],arr[i+1],arr[i]));
    #SFF sff_g2584(tdi_g2584,cut_g2584,clockdr,updatedr,shiftdr,bs_en,tdi_g3222,g2584);