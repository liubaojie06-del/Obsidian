---
tags: [C语言, static, 静态变量, 静态函数, 作用域, 生命周期, 内存分区]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | static：改变变量生命周期和符号可见性的关键字

> [!abstract] 核心结论
> `static` 在 C 语言中主要有两类作用：修饰局部变量时，让变量离开函数后仍然存在；修饰全局变量或函数时，限制它只能在当前源文件中使用。

### ① 底层原理：static 不是简单“固定不变”

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>static 的底层本质：</strong>
<ul>
  <li><strong>修饰局部变量：</strong> 改变生命周期，让变量存放在静态存储区，不随函数栈帧销毁。</li>
  <li><strong>修饰全局变量：</strong> 改变链接属性，让变量只能在当前 <code>.c</code> 文件中访问。</li>
  <li><strong>修饰函数：</strong> 让函数只能在当前 <code>.c</code> 文件中调用，避免外部文件访问。</li>
  <li><strong>默认初始化：</strong> 静态变量如果没有手动初始化，默认初始化为 0。</li>
  <li><strong>不是 const：</strong> <code>static</code> 不代表不可修改，<code>const</code> 才表示只读约束。</li>
</ul>
</div>

### ② static 的三种常见用法

```c
static int count = 0;      // 静态局部变量或静态全局变量

static void helper() {     // 静态函数
    // 只能当前源文件使用
}
```

### ③ 一句话理解

```text
static 修饰局部变量：让它活得更久。
static 修饰全局变量 / 函数：让它藏在当前文件里。
```

> [!tip] 记忆口诀
> **局部 static 管生命周期，全局 static 管可见性；它不是只读，而是静态存储或文件私有。**

---

# 02 | static 局部变量：函数结束后仍然存在

> [!abstract] 核心结论
> 普通局部变量存放在栈区，函数结束后就销毁；`static` 局部变量存放在静态存储区，函数结束后不会销毁，下次调用还能保留上次的值。

### ① 普通局部变量

```c
#include <stdio.h>

void test() {
    int count = 0;
    count++;
    printf("count = %d\n", count);
}

int main() {
    test();
    test();
    test();

    return 0;
}
```

输出：

```text
count = 1
count = 1
count = 1
```

原因：

```text
每次调用 test，count 都重新创建。
函数结束后，count 被销毁。
```

### ② static 局部变量

```c
#include <stdio.h>

void test() {
    static int count = 0;
    count++;
    printf("count = %d\n", count);
}

int main() {
    test();
    test();
    test();

    return 0;
}
```

输出：

```text
count = 1
count = 2
count = 3
```

原因：

```text
static count 只初始化一次。
函数结束后不会销毁。
下次调用继续使用上一次的值。
```

### ③ 内存理解

```text
普通局部变量：
存放在栈区 Stack。
函数调用时创建，函数结束后销毁。

static 局部变量：
存放在静态存储区。
程序开始到程序结束期间一直存在。
```

### ④ 作用域没有变

虽然 `static` 局部变量生命周期变长了，但作用域仍然只在函数内部。

```c
void test() {
    static int count = 0;
}

int main() {
    // printf("%d\n", count); // 错误，count 只能在 test 内部使用
    return 0;
}
```

### ⑤ 重点区别

```text
生命周期：
变长了，整个程序运行期间都存在。

作用域：
没变，仍然只能在定义它的函数内部访问。
```

> [!tip] 记忆口诀
> **static 局部变量：活得像全局变量，用得像局部变量。**

---

# 03 | static 局部变量的初始化

> [!abstract] 核心结论
> `static` 局部变量只会初始化一次。后续函数再次调用时，不会重新执行初始化，而是继续使用上次留下的值。

### ① 只初始化一次

```c
#include <stdio.h>

void test() {
    static int x = 10;
    printf("x = %d\n", x);
    x++;
}

int main() {
    test();
    test();
    test();

    return 0;
}
```

输出：

```text
x = 10
x = 11
x = 12
```

解释：

```text
第一次调用 test 时，x 初始化为 10。
之后每次调用不会重新初始化。
x 保留上一次修改后的值。
```

### ② 没有初始化时默认为 0

```c
#include <stdio.h>

void test() {
    static int x;
    printf("%d\n", x);
}

int main() {
    test();
    return 0;
}
```

输出：

```text
0
```

原因：

```text
静态存储期变量默认初始化为 0。
```

### ③ 普通局部变量不初始化是随机值

```c
void test() {
    int x;
    printf("%d\n", x); // 不安全，x 是未初始化局部变量
}
```

普通局部变量如果不初始化：

```text
值不确定。
```

### ④ 初始化表达式限制

在标准 C 中，静态变量初始化通常要求使用常量表达式。

```c
static int x = 10;  // 正确
```

不能随便用运行时变量初始化静态存储期对象。

### ⑤ 适合场景

```text
统计函数被调用次数。
保存函数内部状态。
实现简单状态机。
保存只想在函数内部使用的缓存数据。
```

> [!tip] 记忆口诀
> **static 只初始化一次，不写初值默认零；函数反复调，值会接着变。**

---

# 04 | static 全局变量：只在当前源文件可见

> [!abstract] 核心结论
> 全局变量默认可以被其他源文件通过 `extern` 访问；加上 `static` 后，这个全局变量只能在当前 `.c` 文件内部使用，外部文件无法直接访问。

### ① 普通全局变量

file1.c：

```c
int g_num = 100;
```

file2.c：

```c
#include <stdio.h>

extern int g_num;

int main() {
    printf("%d\n", g_num);
    return 0;
}
```

这种情况下：

```text
file2.c 可以通过 extern 访问 file1.c 中的 g_num。
```

### ② static 全局变量

file1.c：

```c
static int g_num = 100;
```

file2.c：

```c
#include <stdio.h>

extern int g_num;

int main() {
    printf("%d\n", g_num);
    return 0;
}
```

此时：

```text
链接时会出错。
因为 static 全局变量只在 file1.c 内部可见。
```

### ③ 底层理解

```text
普通全局变量：
具有外部链接属性，其他文件可以引用。

static 全局变量：
具有内部链接属性，只能当前源文件访问。
```

### ④ 为什么要这样做

使用 `static` 全局变量可以：

```text
避免名字冲突。
隐藏模块内部状态。
防止其他文件误修改。
提高代码封装性。
```

### ⑤ 示例

config.c：

```c
static int g_debug_mode = 0;

void enable_debug() {
    g_debug_mode = 1;
}

int is_debug_enabled() {
    return g_debug_mode;
}
```

其他文件不能直接访问：

```c
g_debug_mode
```

只能通过函数间接操作。

> [!tip] 记忆口诀
> **普通全局变量到处可见，static 全局变量只在本文件露脸。**

---

# 05 | static 函数：只允许当前源文件调用

> [!abstract] 核心结论
> 函数默认具有外部链接属性，可以被其他源文件调用；函数前加 `static` 后，它就变成文件内部函数，只能在当前 `.c` 文件中使用。

### ① 普通函数

math_utils.c：

```c
int add(int a, int b) {
    return a + b;
}
```

main.c：

```c
#include <stdio.h>

int add(int a, int b);

int main() {
    printf("%d\n", add(10, 20));
    return 0;
}
```

可以正常调用。

### ② static 函数

math_utils.c：

```c
static int add(int a, int b) {
    return a + b;
}
```

main.c：

```c
#include <stdio.h>

int add(int a, int b);

int main() {
    printf("%d\n", add(10, 20));
    return 0;
}
```

此时：

```text
main.c 无法链接到 add。
因为 add 只在 math_utils.c 内部可见。
```

### ③ 适合做内部辅助函数

```c
static int check_range(int value) {
    return value >= 0 && value <= 100;
}

int set_score(int score) {
    if (!check_range(score)) {
        return -1;
    }

    return 0;
}
```

这里：

```text
check_range 是内部工具函数。
外部文件不需要知道它。
```

### ④ 好处

```text
隐藏实现细节。
避免函数名冲突。
减少外部接口数量。
让模块边界更清晰。
```

### ⑤ 头文件中不要随便声明 static 函数

如果在头文件中写：

```c
static void helper() {
    // ...
}
```

每个包含这个头文件的 `.c` 文件都会生成一份自己的 `helper`。

这有时可以用，但初学阶段不要滥用。

> [!tip] 记忆口诀
> **函数加 static，变成本文件私有工具函数。**

---

# 06 | static 和内存分区

> [!abstract] 核心结论
> `static` 变量通常存放在静态存储区。已初始化的 static 变量通常进入 `.data` 段，未初始化或初始化为 0 的 static 变量通常进入 `.bss` 段。

### ① 常见内存分区

```text
代码区 Text：
存放程序机器指令。

只读数据区 Rodata：
存放字符串常量、const 只读数据等。

已初始化数据区 Data：
存放已初始化的全局变量、已初始化 static 变量。

未初始化数据区 BSS：
存放未初始化或初始化为 0 的全局变量、static 变量。

堆区 Heap：
malloc / free 管理的动态内存。

栈区 Stack：
局部变量、函数参数、栈帧等。
```

### ② static 局部变量在哪里

```c
void test() {
    static int x = 10;
}
```

`x` 通常存放在：

```text
.data 段
```

因为它是：

```text
static 变量，并且已初始化为 10。
```

### ③ 未初始化 static 变量

```c
void test() {
    static int x;
}
```

`x` 通常存放在：

```text
.bss 段
```

并且默认值为：

```text
0
```

### ④ static 全局变量在哪里

```c
static int g_value = 100;
```

通常存放在：

```text
.data 段
```

如果：

```c
static int g_value;
```

通常存放在：

```text
.bss 段
```

### ⑤ 和普通局部变量对比

```c
void test() {
    int a = 10;
    static int b = 20;
}
```

内存理解：

```text
a 在栈区，函数结束后销毁。
b 在静态存储区，程序结束后才销毁。
```

> [!tip] 记忆口诀
> **普通局部在栈里，static 变量进静态区；有初值进 data，零初值进 bss。**

---

# 07 | static 和 extern 的区别

> [!abstract] 核心结论
> `static` 用于限制全局符号只在当前文件内部可见；`extern` 用于声明一个变量或函数在别的文件中定义。一个是隐藏，一个是引用外部。

### ① extern 的作用

file1.c：

```c
int g_num = 100;
```

file2.c：

```c
extern int g_num;
```

含义：

```text
g_num 在别的地方定义。
当前文件只是声明要使用它。
```

### ② static 的作用

file1.c：

```c
static int g_num = 100;
```

含义：

```text
g_num 只在 file1.c 内部可见。
其他文件不能 extern 它。
```

### ③ 对比

| 关键字 | 作用 | 用在全局变量 / 函数上 |
| :--- | :--- | :--- |
| `extern` | 引用外部定义 | 让当前文件知道外部符号 |
| `static` | 限制外部访问 | 让符号只在当前文件可见 |

### ④ 常见组合思路

模块内部变量：

```c
static int g_count = 0;
```

对外提供函数：

```c
int get_count() {
    return g_count;
}
```

这样：

```text
外部不能直接改 g_count。
只能通过函数访问。
```

### ⑤ 不要同时乱用

这种写法概念冲突：

```c
extern static int x;
```

因为：

```text
extern 想外部引用。
static 想文件内部隐藏。
```

> [!tip] 记忆口诀
> **extern 向外找，static 往里藏；一个开放引用，一个文件私有。**

---

# 08 | static 与 const 的区别

> [!abstract] 核心结论
> `static` 控制生命周期或可见性，`const` 控制是否允许修改。二者可以同时使用，但含义完全不同。

### ① static 不代表不可修改

```c
void test() {
    static int count = 0;
    count++;
}
```

这里：

```text
count 可以修改。
```

`static` 只是让它：

```text
函数结束后仍然存在。
```

### ② const 表示只读约束

```c
const int x = 10;
```

这里：

```text
x 不允许被普通代码修改。
```

### ③ static const

```c
static const int max_size = 100;
```

含义：

```text
static：
限制在当前作用域 / 当前文件内部。

const：
不允许修改。
```

如果定义在全局位置：

```c
static const int max_size = 100;
```

通常表示：

```text
当前文件私有的只读常量。
```

### ④ 常用于文件内常量

```c
static const int BUFFER_SIZE = 1024;
```

好处：

```text
避免宏污染。
有类型检查。
限制在当前文件内部。
不可修改。
```

### ⑤ 对比表

| 关键字 | 控制内容 | 代表含义 |
| :--- | :--- | :--- |
| `static` | 生命周期 / 链接属性 | 活得久或文件私有 |
| `const` | 可修改性 | 不允许修改 |
| `static const` | 两者都有 | 文件私有且只读 |

> [!tip] 记忆口诀
> **static 管活多久、谁能看；const 管能不能改。**

---

# 09 | static 常见错误

> [!abstract] 核心结论
> `static` 最常见的错误是误以为它表示不可修改、滥用静态局部变量导致状态混乱、在多文件中误用 static 导致链接失败。

### ① 错误 1：以为 static 不可修改

```c
static int x = 10;
x = 20;  // 正确，可以修改
```

说明：

```text
static 不是 const。
```

### ② 错误 2：以为 static 局部变量每次都会重新初始化

```c
void test() {
    static int x = 0;
    x++;
}
```

实际：

```text
x 只初始化一次。
后续会保留上次的值。
```

### ③ 错误 3：static 全局变量无法 extern

file1.c：

```c
static int g_num = 10;
```

file2.c：

```c
extern int g_num;
```

问题：

```text
链接失败。
因为 g_num 被 static 限制在 file1.c 内部。
```

### ④ 错误 4：滥用 static 局部变量

```c
int next_id() {
    static int id = 0;
    return ++id;
}
```

这本身没错，但要注意：

```text
函数变得有状态。
多线程下可能有竞争。
测试和复用更困难。
```

### ⑤ 错误 5：把需要对外调用的函数写成 static

```c
static void api_func() {
    // ...
}
```

如果其他文件需要调用它：

```text
就不能加 static。
```

> [!tip] 记忆口诀
> **static 不是只读；局部只初始化一次，全局只本文件可见。**

---

# 10 | static 总结

> [!abstract] 核心结论
> `static` 的底层核心是“静态存储期”和“内部链接”。修饰局部变量时，它改变生命周期；修饰全局变量和函数时，它限制可见范围。理解这两点，就能掌握 C 语言中的 static。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>static 核心总结：</strong>
<ul>
  <li><strong>修饰局部变量：</strong> 变量存放在静态存储区，函数结束后仍然存在。</li>
  <li><strong>修饰全局变量：</strong> 变量只在当前源文件可见，其他文件不能直接访问。</li>
  <li><strong>修饰函数：</strong> 函数只在当前源文件可见，适合做内部辅助函数。</li>
  <li><strong>初始化：</strong> static 变量只初始化一次，未初始化默认值为 0。</li>
  <li><strong>内存位置：</strong> 已初始化 static 变量通常在 .data，零初始化 static 变量通常在 .bss。</li>
  <li><strong>不是 const：</strong> static 变量仍然可以修改。</li>
  <li><strong>和 extern 相反：</strong> extern 表示引用外部符号，static 表示隐藏在当前文件。</li>
  <li><strong>作用域：</strong> static 局部变量作用域仍然只在函数内部。</li>
  <li><strong>生命周期：</strong> static 变量从程序开始到程序结束都存在。</li>
  <li><strong>封装作用：</strong> static 全局变量和 static 函数可以隐藏模块内部实现。</li>
</ul>
</div>

### ② 最底层一句话

```text
static 修饰局部变量时让它不随栈帧销毁；修饰全局变量或函数时让它只在当前源文件可见。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **局部 static 活得久，全局 static 藏文件；函数 static 做私有，static 不是不能改。**