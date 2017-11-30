all:
	vcs primitives.v TAP.v JTAG.v

top_tb:
	vcs -debug primitives.v TAP.v JTAG.v s9234_JTAG_TOP.v s9234_JTAG_BSR.v \
	s9234.v top_tb.v

ir_tb:
	vcs -debug primitives.v TAP.v JTAG.v ir_tb.v
