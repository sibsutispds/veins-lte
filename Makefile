#
#  Makefile for IPSuite-cvs
#
#  ** This file was automatically generated by the command:
#  opp_makemake -f -N -n -r -c ipsuiteconfig
#

# Name of target to be created (-o option)
TARGET = IPSuite-cvs

# User interface (uncomment one) (-u option)
# USERIF_LIBS=$(CMDENV_LIBS)
USERIF_LIBS=$(TKENV_LIBS)

# .ned or .h include paths with -I
INCLUDE_PATH=

# misc additional object and library files to link
EXTRA_OBJS=

# object files from other directories to link with (wildcard needed to prevent "no such file *.o" errors)
EXT_DIR_OBJS=$(wildcard )

# time stamps of other directories (used as dependency)
EXT_DIR_TSTAMPS=

# Additional libraries (-L option -l option)
LIBS=

#------------------------------------------------------------------------------
# Import generic settings from ipsuiteconfig
include ipsuiteconfig

#------------------------------------------------------------------------------

# subdirectories to recurse into
SUBDIRS=  Applications Base Documentation Examples Network NetworkInterfaces Nodes PHY Tests Transport Unsupported Util

# object files in this directory
OBJS=  

# header files generated (from msg files)
GENERATEDHEADERS= 

#------------------------------------------------------------------------------
# contents of file makefrag:
# this file automatically gets inserted into Makefiles generated by opp_makemake

# override SUBDIRS, leaving out the Documentation directory from the build
SUBDIRS=  Applications Examples Network NetworkInterfaces Nodes PHY Tests Transport Base Util

# preserve default target
all: $(TARGET)

# all _m.h files must exist before we build anything, so run opp_msgc first
subdirs $(OBJS) : generateheaders

# add dependencies across directories
Network Transport NetworkInterfaces PHY Applications : Base Util
Transport NetworkInterfaces Applications : Network
Nodes : Network Transport NetworkInterfaces PHY Applications
Examples Tests : Nodes

# documentation targets
DOC_DIR=Documentation

docs: doxy neddoc

doxy:
	doxygen doxy.cfg

neddoc:
	opp_neddoc -a -o $(DOC_DIR)/neddoc -t $(DOC_DIR)/doxy/doxytags.xml -d ../doxy

neddoc-without-doxy:
	opp_neddoc -a -o $(DOC_DIR)/neddoc

#------------------------------------------------------------------------------

$(TARGET): $(OBJS) subdirs Makefile .tstamp
	@# do nothing

.tstamp: $(OBJS)
	echo>.tstamp

$(OBJS) : $(GENERATEDHEADERS)


purify: $(OBJS) $(EXTRA_OBJS) $(EXT_DIR_TSTAMPS) subdirs Makefile
	purify $(CXX) $(LDFLAGS) $(OBJS) $(EXTRA_OBJS) $(EXT_DIR_OBJS) $(LIBS) -L$(OMNETPP_LIB_DIR) $(KERNEL_LIBS) $(USERIF_LIBS) $(SYS_LIBS_PURE) -o $(TARGET).pure

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

Applications:
	cd Applications && $(MAKE)

Base:
	cd Base && $(MAKE)

Documentation:
	cd Documentation && $(MAKE)

Examples:
	cd Examples && $(MAKE)

Network:
	cd Network && $(MAKE)

NetworkInterfaces:
	cd NetworkInterfaces && $(MAKE)

Nodes:
	cd Nodes && $(MAKE)

PHY:
	cd PHY && $(MAKE)

Tests:
	cd Tests && $(MAKE)

Transport:
	cd Transport && $(MAKE)

Unsupported:
	cd Unsupported && $(MAKE)

Util:
	cd Util && $(MAKE)


#doc: neddoc doxy

#neddoc:
#	opp_neddoc -a

#doxy: doxy.cfg
#	doxygen doxy.cfg

generateheaders: $(GENERATEDHEADERS)
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) generateheaders) || exit 1; done

clean:
	rm -f *.o *_n.cc *_n.h *_m.cc *_m.h $(TARGET)$(EXE_SUFFIX) .tstamp
	rm -f *.vec *.sca
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) clean); done

depend:
	$(MAKEDEPEND) $(INCLUDE_PATH) -- *.cc
	# $(MAKEDEPEND) $(INCLUDE_PATH) -fMakefile.in -- *.cc
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) depend) || exit 1; done

makefiles:
	# recreate Makefile
	opp_makemake -f  -N -n -r -c ipsuiteconfig 
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) makefiles) || exit 1; done

makefile-ins:
	# recreate Makefile.in
	opp_makemake -f -m  -N -n -r -c ipsuiteconfig 
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) makefile-ins) || exit 1; done

# "re-makemake" and "re-makemake-m" are deprecated, historic names of the above two targets
re-makemake: makefiles
re-makemake-m: makefile-ins


# DO NOT DELETE THIS LINE -- make depend depends on it.

