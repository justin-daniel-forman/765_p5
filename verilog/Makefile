all:
	vcs primitives.v TAP.v JTAG.v

top:
	vcs -debug primitives.v TAP.v JTAG.v s9234_JTAG_TOP.v s9234_JTAG_BSR.v \
		s9234.v top_tb.v s9234_inscan.v

ref:
	vcs -debug primitives.v s9234_test2.v ref_tb.v

ir:
	vcs -debug primitives.v TAP.v JTAG.v ir_tb.v
