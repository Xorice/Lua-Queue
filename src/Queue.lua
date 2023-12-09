-- # 2023/12/10 Xorice
--------------------------------------------------------
-- MIT License
--
-- Copyright (c) 2023 Xorice
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--------------------------------------------------------
-- More Information: https://github.com/Xorice/Lua-Queue
--------------------------------------------------------
local DEFAULT_SIZE  = 16;
local STR_DATA      = "data";
local STR_HEAD      = "head";
local STR_TAIL      = "tail";
local STR_SIZE      = "_size";
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
        
        _size = 0;
        _queue_size = size;
    };
    return setmetatable(self, Queue);
end

local function _iter(q, i)
    local qsize = rawget(q, STR_QSIZE);
    local size = q:size();
    local head = rawget(q, STR_HEAD);
    local tail = head + size;

    if i == tail then return nil end;
    return i+1, rawget(q, STR_DATA)[(i%qsize)+1];
end

function Queue:push(element)
    local tail = rawget(self, STR_TAIL);
    local size = rawget(self,STR_SIZE);
    local qsize = rawget(self, STR_QSIZE);
    rawget(self, STR_DATA)[tail + 1] = element;
    rawset(self, STR_TAIL, (tail + 1) % qsize);

    if size==qsize then -- * Overflow
        local head = rawget(self, STR_HEAD);
        rawset(self, STR_HEAD, (head + 1) % qsize);
    else
        rawset(self, STR_SIZE, size + 1);
    end
end

function Queue:pop()
    if self:empty() then error(ERR_UNDERFLOW) end;
    local head = rawget(self, STR_HEAD);
    local size = rawget(self,STR_SIZE);
    local qsize = rawget(self, STR_QSIZE);
    rawset(self, STR_HEAD, (head + 1) % qsize);
    rawset(self, STR_SIZE, size - 1);
end

function Queue:size()
    return rawget(self,STR_SIZE);
end

function Queue:empty()
    return rawget(self,STR_SIZE) == 0;
end

function Queue:full()
    return self:size() == rawget(self, STR_QSIZE);
end

function Queue:front()
    local head = rawget(self, STR_HEAD);
    return rawget(self, STR_DATA)[head + 1];
end

function Queue:back()
    local size = rawget(self, STR_QSIZE);
    local tail = rawget(self, STR_TAIL);
    return rawget(self, STR_DATA)[(tail - 1)%size+1];
end

function Queue:each()
    return _iter, self, rawget(self, STR_HEAD);
end

return {new = new_queue};