# Compress Bitstream and Enable Temp Shutdown
set_property BITSTREAM.GENERAL.COMPRESS TRUE [get_designs impl_1]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN ENABLE [get_designs impl_1]
