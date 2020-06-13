module xija

import PyCall: PyObject, pyimport, PyNULL

pyxija = PyNULL()

function __init__()
    copy!(pyxija, pyimport("xija"))
end

struct XijaModel
    model::PyObject
    function XijaModel(model::PyObject)
        new(model)
    end
end

function XijaModel()
    new(model)
end

function make(model::XijaModel)
    model.model.make()
end

function calc(model::XijaModel)
    model.model.calc()
end

end