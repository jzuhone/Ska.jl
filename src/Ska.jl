__precompile__()
module Ska

export MSID, MSIDset, interpolate
export CxoTime
#export XijaModel, make, calc
export get_states

include("cheta.jl")
include("time.jl")
include("kadi.jl")
#include("maude.jl")
#include("xija.jl")

import .cheta: MSID, MSIDset, interpolate
import .time: CxoTime
import .kadi: get_states

#import .xija: XijaModel, make, calc

end