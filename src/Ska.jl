__precompile__()
module Ska

export MSID, MSIDset, interpolate
export CxoTime
#export XijaModel, make, calc
export CmdStates, Commands, export_to_dataframe

include("cheta.jl")
include("time.jl")
include("kadi.jl")
#include("maude.jl")
#include("xija.jl")

import .cheta: MSID, MSIDset, interpolate
import .time: CxoTime
import .kadi: CmdStates, Commands, export_to_dataframe

#import .xija: XijaModel, make, calc

end