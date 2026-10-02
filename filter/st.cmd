#!../../bin/linux-x86_64/opticsExApp

# Linux startup script

< envPaths

# save_restore.cmd needs the full path to the startup directory, which
# envPaths currently does not provide
epicsEnvSet(STARTUP,$(TOP)/iocBoot/$(IOC))

# Specify largest array CA will transport
# Note for N sscanRecord data points, need (N+1)*8 bytes, else MEDM
# plot doesn't display
epicsEnvSet EPICS_CA_MAX_ARRAY_BYTES 64008

################################################################################
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in the software we just loaded (xxx.munch)
dbLoadDatabase("../../dbd/iocxxxLinux.dbd")
iocxxxLinux_registerRecordDeviceDriver(pdbbase)

### Load database records for alternative PF4-filter support
dbLoadTemplate "filter.substitutions"

###############################################################################
iocInit

# Alternative pf4 filter seq program
seq &filterDrive,"NAME=filterDrive,P=xxx:,R=filter:,NUM_FILTERS=4"

dbcar(0,1)
