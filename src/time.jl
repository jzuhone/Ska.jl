module cxotime

import PyCall: PyObject, pyimport, PyNULL

cxotime = PyNULL()

function __init__()
    copy!(fetch, pyimport("cxotime"))
end

struct CxoTime
    cxotime::PyObject
    new()
end

end 