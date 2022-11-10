# Project config
PROJ := blinking-led-external

PROJ_DEPS :=
PROJ_RTL_SRCS := $(addprefix rtl/, \
	slowclock.v \
)
PROJ_TOP_SRC := rtl/blinking.v
PROJ_TOP_MOD := top

# Include default rules
include ../_common/build.mk