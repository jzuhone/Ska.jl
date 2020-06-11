module cheta

import PyCall: PyObject, pyimport, PyNULL

fetch = PyNULL()

function __init__()
    copy!(fetch, pyimport("cheta.fetch_sci"))
end

struct MSID
    msid::PyObject
    unit::String
    vals::Array{Float32,1}
    times::Array{Float64,1}
    function MSID(msid::PyObject, unit::String, vals::Array{Float32,1}, times::Array{Float64,1})
        new(msid, unit, vals, times)
    end
end 

function MSID(msid::String, start, stop)
    m = fetch.MSID(msid, start, stop)
    MSID(m, m.unit, m.vals, m.times)
end

Base.show(io::IO, msid::MSID) = print(io, msid.msid."__repr__"())

struct MSIDset
    msidset::Dict{Any,Any}
    function MSIDset(msidset::Dict{Any,Any})
        new(msidset)
    end
end 

function MSIDset(msids::Array{String}, start, stop)
    m = fetch.MSIDset(msids, start, stop)
    MSIDset(m)
end

function Base.getindex(m::MSIDset, i::String)
    MSID(m.msidset[i], m.msidset[i].unit, 
         m.msidset[i].vals, m.msidset[i].times)
end

end
