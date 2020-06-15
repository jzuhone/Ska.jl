module kadi

import PyCall: PyObject, pyimport, PyNULL, pycall
import DataFrames: DataFrame

kadi_states = PyNULL()
kadi_commands = PyNULL()

function __init__()
    copy!(kadi_states, pyimport("kadi.commands.states"))
    copy!(kadi_commands, pyimport("kadi.commands"))
end

struct Commands
    cmds_table::PyObject
    function Commands(cmds_table:PyObject)
        new(cmds_table)
    end
end

struct CmdStates
    states_table::PyObject
    function CmdStates(states_table::PyObject)
        new(states_table)
    end
end

function CmdStates(start, stop; state_keys=nothing, continuity=nothing,
                   reduce=true, merge_identical=false)
    cmd_states = kadi_states.get_states(start=start, stop=stop, 
                                        state_keys=state_keys, reduce=reduce,
                                        merge_identical=merge_identical)
    CmdStates(cmd_states)
end

function CmdStates(cmds; state_keys=nothing, continuity=nothing,
                   reduce=true, merge_identical=false)
    cmd_states = kadi_states.get_states(cmds=cmds, state_keys=state_keys, 
                                        reduce=reduce,
                                        merge_identical=merge_identical)
    CmdStates(cmd_states)
end

function export_to_dataframe(cmd_states::CmdStates)
    colnames = cmd_states.states_table.colnames
    df = DataFrame()
    getitem = cmd_states.states_table."__getitem__"
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

function export_to_dataframe(commands::Commands)
    colnames = commands.cmds_table.colnames
    df = DataFrame()
    getitem = commands.cmds_table."__getitem__"
    for colname in colnames
        if startswith(colname, "date")
            df[!, colname] = pycall(getitem, Array, colname)
        else
            df[!, colname] = getitem(colname)
        end    
        
    end
    df
end
