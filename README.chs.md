# Lua 队列（Queue）

在 Lua 中使用 `Queue`

## 注意事项

此队列不会发生 `上溢（Overflow）`，但可能会发生 `下溢（Underflow）`。

如果要避免溢出，您可以调用 `Queue:full()` 方法来检查队列是否已满。

## API

```lua
Queue.new(QueueLength :number?)
```

创建一个新的队列

```lua
:push(element)
```

将元素添加到队列的尾部

```lua
:pop()
```

移除队列的头部元素

```lua
:size() :number
```

返回队列的大小（元素数量）

```lua
:empty() :boolean
```

检查队列是否为空

```lua
:full() :boolean
```

检查队列是否已满

```lua
:front() :any
```

返回队列头部元素的值

```lua
:back() :any
```

返回队列尾部元素的值

```lua
:each() :(queue, i) -> (i, v)
```

返回一个迭代器函数，用于遍历队列的元素

请注意，此队列不会发生上溢（Overflow），但可能会发生下溢（Underflow）。如果想要避免溢出，您可以调用 `Queue:full()` 方法来检查队列是否已满。

## 用法示例

```lua
local Queue = require("queue")

local q = Queue.new()

q:push(1)
q:push(2)
q:push(3)

print(q:size())  -- 输出 3

print(q:front())  -- 输出 1

q:pop()

print(q:front())  -- 输出 2
print(q:back())  -- 输出 3

print(q:empty())  -- 输出 false

q:pop()
q:pop()

print(q:empty())  -- 输出 true
```

以上是 Lua 队列的基本用法示例。您可以根据需要使用这些方法进行队列操作。
