module kadi

import PyCall: PyObject, pyimport, PyNULL, pycall
import DataFrames: DataFrame

cmd_states = PyNULL()

function __init__()
    copy!(cmd_states, pyimport("kadi.commands.states"))
end

function get_states(start, stop; state_keys=nothing, cmds=nothing, 
                    continuity=nothing, reduce=true, merge_identical=false)
    states = cmd_states.get_states(start=start, stop=stop, 
                                   state_keys=state_keys)
    colnames = states.colnames
    df = DataFrame()
    getitem = states."__getitem__"
    for colname in colnames
        if startswith(colname, "date")
            df[!, colname] = pycall(getitem, Array, colname)
        elseif colname == "trans_keys"
            df[!, colname] = [Set(tk) for tk in getitem(colname)]
        else
            df[!, colname] = getitem(colname)
        end    
        
    end
    df
end

end