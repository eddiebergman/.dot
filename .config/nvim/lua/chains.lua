local py = require('py')

local self = {}

-- update d1 .with d2
function self.update(d1)
    return { with = function(d2) py.update(d1, d2) end }
end

return self
