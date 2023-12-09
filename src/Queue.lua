
local DEFAULT_SIZE  = 16;
local STR_DATA      = "data";
local STR_HEAD      = "head";
local STR_TAIL      = "tail";
local STR_QSIZE     = "_queue_size";

local ERR_UNDERFLOW = "Queue Underflow";

local Queue = {};
Queue.__index = Queue;

local function new_queue(size)
    size = size or DEFAULT_SIZE;
    local self = {
        head = 0;
        tail = 0;
        data = table.create(size);

        _queue_size = size;
    };
    return setmetatable(self, Queue);
end

function Queue:push(element)
    local tail = rawget(self, STR_TAIL);
    local size = rawget(self, STR_QSIZE);
    rawget(self, STR_DATA)[tail + 1] = element;
    rawset(self, STR_TAIL, (tail + 1) % size);
end

function Queue:pop()
    if self:empty() then error(ERR_UNDERFLOW) end;
    local head = rawget(self, STR_HEAD);
    local size = rawget(self, STR_QSIZE);
    rawset(self, STR_HEAD, (head + 1) % size);
end

function Queue:size()
    return (rawget(self,STR_TAIL) - rawget(self,STR_HEAD)) % rawget(self, STR_QSIZE);
end

function Queue:empty()
    return rawget(self,STR_TAIL) == rawget(self,STR_HEAD);
end

function Queue:full()
    return self:size()+1 == rawget(self, STR_QSIZE);
end

function Queue:front()
    local head = rawget(self, STR_HEAD);
    return rawget(self, STR_DATA)[head + 1];
end

function Queue:back()
    local tail = rawget(self, STR_TAIL);
    return rawget(self, STR_DATA)[tail];
end

return {new = new_queue};