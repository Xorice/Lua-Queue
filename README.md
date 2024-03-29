
# Lua Queue

Using `Queue` in Lua

## Attentions

* This queue won't `Overflow` but `Underflow`

If you want to avoid overflow, you have to call `Queue:full()`

* The default length of a Queue is `16`

## APIs

```lua
Queue.new(QueueLength :number?)
```

* Create a new Queue

```lua
:push(element)
```

* Add an element to the end of the queue

```lua
:pop()
```

* Remove the head element of the queue

```lua
:popTail()
```

* Remove the tail element of the queue

```lua
:size() :number
```

* Return the size of the queue (number of elements)

```lua
:empty() :boolean
```

* Check if the queue is empty

```lua
:full() :boolean
```

* Check if the queue is full

```lua
:front() :any
```

* Return the value of the front element of the queue

```lua
:back() :any
```

* Return the value of the back element of the queue

```lua
:each() :(queue, i) -> (i, v)
```

* Return an iterator function to iterate over the elements of the queue.

```lua
:clean()
```

* Clean the queue

Please note that this queue won't `Overflow`, but it may `Underflow`. If you want to avoid overflow, you can call `Queue:full()` method to check if the queue is full.

## Usage Example

```lua
local Queue = require("queue")

local q = Queue.new()

q:push(1)
q:push(2)
q:push(3)

for i,v in q:each() do
    print(i,v)
end
-- Output:
-- 1    1
-- 2    2
-- 3    3

q:pop()

print(q:front())  -- Output 2
print(q:back())  -- Output 3

print(q:empty())  -- Output false

q:pop()
q:pop()

print(q:empty())  -- Output true
```

The above is a basic usage example of Lua Queue. You can use these methods to perform queue operations as needed.
