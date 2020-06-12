module cheta

import PyCall: PyObject, pyimport, PyNULL, pycall

fetch = PyNULL()

function __init__()
    copy!(fetch, pyimport("cheta.fetch_sci"))
end

# MSID

struct MSID
    msid::PyObject
    function MSID(msid::PyObject)
        new(msid)
    end
end 

function MSID(msid::String, start, stop)
    m = fetch.MSID(msid, start, stop)
    MSID(m)
end

function Base.getproperty(m::MSID, v::Symbol)
    if v == :msid
        return getfield(m, :msid)
    else
        return getproperty(m.msid, v)
    end
end

Base.show(io::IO, msid::MSID) = print(io, msid.msid."__repr__"())

function interpolate(msid::MSID; dt=nothing, start=nothing, stop=nothing, times=nothing)
    msid.msid.interpolate(dt, start, stop, times)
    nothing
end

# MSIDset

struct MSIDset
    msidset::PyObject
    function MSIDset(msidset::PyObject)
        new(msidset)
    end
end 

function MSIDset(msids::Array{String}, start, stop)
    m = pycall(fetch.MSIDset, PyObject, msids, start, stop)
    MSIDset(m)
end

function Base.getindex(m::MSIDset, i::String)
    MSID(m.msidset."__getitem__"(i))
end

Base.show(io::IO, m::MSIDset) = print(io, m.msidset."__repr__"())

end
