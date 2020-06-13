module time

import PyCall: PyObject, pyimport, PyNULL

cxotime = PyNULL()

function __init__()
    copy!(cxotime, pyimport("cxotime"))
end

struct CxoTime
    ctime::PyObject
    function CxoTime(ctime::PyObject)
        new(ctime)
    end
end

function CxoTime(t::Union{String,Array{Float64,1},Float64})
    ctime = cxotime.CxoTime(t)
    CxoTime(ctime)
end

function Base.getproperty(t::CxoTime, v::Symbol)
    if v == :ctime
        return getfield(t, :ctime)
    else
        return getproperty(t.ctime, v)
    end
end

Base.show(io::IO, t::CxoTime) = print(io, t.ctime."__repr__"())

end 