---
tags: [C语言, static, 静态变量, 静态函数, 存储周期, 作用域, 多文件编程]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | static：让变量寿命变长，让符号范围变小

> [!abstract] 核心结论
> `static` 在 C 语言中有两个核心作用：修饰局部变量时，让变量存放在静态区，生命周期变成整个程序；修饰全局变量或函数时，限制它们只能在当前 `.c` 文件内部使用。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>static 的本质：</strong>
<ul>
  <li><strong>修饰局部变量：</strong>改变存储位置和生命周期。</li>
  <li><strong>局部 static：</strong>变量不再放栈区，而是放静态区。</li>
  <li><strong>修饰全局变量：</strong>限制变量只能在当前源文件内部使用。</li>
  <li><strong>修饰函数：</strong>限制函数只能在当前源文件内部调用。</li>
  <li><strong>核心思想：</strong>局部变量用 static 延长寿命，全局符号用 static 隐藏起来。</li>
</ul>
</div>

### ② 代码用法

```c
void test(void) {
    static int count = 0;
    count++;
}
```

```c
static int g_num = 10;

static void helper(void) {
    // 只在当前 .c 文件内部使用
}
```

### ③ 使用场景

| static 位置 | 作用 |
| :--- | :--- |
| 局部变量前 | 生命周期变长，函数结束不销毁 |
| 全局变量前 | 限制在当前 `.c` 文件内部可见 |
| 函数前 | 限制函数只能在当前 `.c` 文件内部调用 |
| 模块内部状态 | 用 static 隐藏数据 |
| 内部辅助函数 | 用 static 避免暴露接口 |

> [!tip] 记忆口诀
> **局部 static 延寿命，全局 static 藏名字。**

---

# 02 | static 修饰局部变量

> [!abstract] 核心结论
> 普通局部变量通常存放在栈区，函数结束就销毁；`static` 局部变量存放在静态区，函数结束后不会销毁，下次调用还能保留上次的值。

### ① 普通局部变量

```c
#include <stdio.h>

void test(void) {
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
每次调用 test，都会重新创建 count。
函数结束后 count 被销毁。
```

### ② static 局部变量

```c
#include <stdio.h>

void test(void) {
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

### ③ 底层理解

```text
count 写在函数里面。
作用域仍然只在 test 函数内部。
但是它的存储空间在静态区。
程序运行期间一直存在。
```

### ④ 生命周期和作用域

| 变量 | 生命周期 | 作用域 |
| :--- | :--- | :--- |
| 普通局部变量 | 函数调用期间 | 当前代码块 |
| static 局部变量 | 整个程序运行期间 | 当前代码块 |

### ⑤ 重点

```text
static 局部变量不是每次调用重新创建。
它只初始化一次。
```

> [!tip] 记忆口诀
> **普通局部每次新建，static 局部只建一次。**

---

# 03 | static 局部变量只初始化一次

> [!abstract] 核心结论
> `static` 局部变量只会在程序运行过程中初始化一次。后续再次执行到定义语句时，不会重新初始化，只会继续使用原来的值。

### ① 示例代码

```c
#include <stdio.h>

void test(void) {
    static int count = 10;

    printf("count = %d\n", count);

    count++;
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
count = 10
count = 11
count = 12
```

### ② 为什么不是每次 10

因为：

```text
static int count = 10;
```

这句初始化只执行一次。

之后每次调用：

```text
不会重新把 count 变成 10。
```

### ③ 普通局部变量对比

```c
void test(void) {
    int count = 10;
    count++;
}
```

每次调用都会：

```text
重新创建 count。
重新初始化为 10。
```

### ④ 默认初始化

```c
static int count;
```

如果没有手动初始化：

```text
默认初始化为 0。
```

这点和普通局部变量不同：

```c
int count;
```

普通局部变量未初始化时：

```text
值不确定。
```

### ⑤ 重点

```text
static 局部变量存放在静态区。
静态区变量在程序启动时会被初始化。
```

> [!tip] 记忆口诀
> **static 初始化只一次，没写初值默认零。**

---

# 04 | static 修饰全局变量

> [!abstract] 核心结论
> `static` 修饰全局变量时，变量仍然存放在静态区，但它的可见范围被限制在当前 `.c` 文件内部，其他文件不能通过 `extern` 访问它。

### ① 普通全局变量

a.c：

```c
int g_num = 100;
```

b.c：

```c
extern int g_num;

void test(void) {
    g_num = 200;
}
```

说明：

```text
普通全局变量具有外部链接属性。
其他文件可以用 extern 声明并访问。
```

### ② static 全局变量

a.c：

```c
static int g_num = 100;
```

b.c：

```c
extern int g_num;

void test(void) {
    g_num = 200;
}
```

问题：

```text
b.c 无法链接到 a.c 中的 g_num。
因为 static 把 g_num 限制在 a.c 内部。
```

### ③ 底层理解

```text
static 全局变量：
生命周期仍然是整个程序。
存储位置仍然是静态区。
但链接属性变成内部链接。
```

### ④ 使用场景

```text
模块内部状态。
不希望外部直接访问的数据。
避免全局变量命名冲突。
实现封装。
```

### ⑤ 推荐写法

counter.c：

```c
static int g_count = 0;

void counter_add(void) {
    g_count++;
}

int counter_get(void) {
    return g_count;
}
```

说明：

```text
外部不能直接改 g_count。
只能通过 counter_add 和 counter_get 间接操作。
```

> [!tip] 记忆口诀
> **全局 static 不给外部看，只在本文件内可见。**

---

# 05 | static 修饰函数

> [!abstract] 核心结论
> `static` 修饰函数时，表示该函数只在当前 `.c` 文件内部可见。它常用于隐藏模块内部辅助函数，避免和其他文件中的同名函数冲突。

### ① 普通函数

calc.c：

```c
int helper(int x) {
    return x * 2;
}
```

问题：

```text
普通函数默认具有外部链接属性。
其他 .c 文件也可能声明并调用 helper。
如果多个文件都有 helper，容易命名冲突。
```

### ② static 函数

calc.c：

```c
static int helper(int x) {
    return x * 2;
}

int calc_result(int x) {
    return helper(x) + 1;
}
```

说明：

```text
helper 只在 calc.c 内部可见。
calc_result 可以对外暴露。
```

### ③ 头文件只声明对外接口

calc.h：

```c
#ifndef CALC_H
#define CALC_H

int calc_result(int x);

#endif
```

不要在头文件里声明：

```c
static int helper(int x);
```

因为：

```text
helper 是模块内部函数。
不应该暴露给外部。
```

### ④ 使用场景

```text
内部检查函数。
内部转换函数。
内部工具函数。
模块私有算法。
避免函数名污染全局符号表。
```

### ⑤ 重点

```text
对外函数写进 .h。
内部函数写在 .c，并加 static。
```

> [!tip] 记忆口诀
> **对外函数进头文件，内部函数加 static。**

---

# 06 | static 和 extern 的区别

> [!abstract] 核心结论
> `extern` 是向外寻找符号，`static` 是把符号限制在当前文件内部。二者方向相反：一个开放，一个隐藏。

### ① extern

```c
extern int g_num;
```

含义：

```text
g_num 在别的文件中定义。
当前文件只是声明要使用它。
链接器去外部找真正定义。
```

### ② static

```c
static int g_num = 100;
```

含义：

```text
g_num 在当前文件中定义。
但只允许当前文件内部使用。
外部文件不能链接到它。
```

### ③ 对比表

| 关键字 | 作用方向 | 常见含义 |
| :--- | :--- | :--- |
| `extern` | 向外找 | 声明外部符号 |
| `static` | 向内藏 | 限制当前文件可见 |
| 普通全局变量 | 对外开放 | 可被 extern |
| static 全局变量 | 文件私有 | 不可被 extern |

### ④ 示例

a.c：

```c
static int g_num = 10;
```

b.c：

```c
extern int g_num;
```

链接时：

```text
找不到 g_num。
因为 a.c 的 g_num 被 static 隐藏了。
```

### ⑤ 重点

```text
extern 不创建变量，只声明。
static 全局变量会创建变量，但不让外部访问。
```

> [!tip] 记忆口诀
> **extern 往外找，static 往里藏。**

---

# 07 | static 和内存区域

> [!abstract] 核心结论
> `static` 变量通常存放在静态存储区。已初始化的 static 变量通常在 `.data` 段，未初始化或初始化为 0 的 static 变量通常在 `.bss` 段。

### ① 已初始化 static 变量

```c
static int a = 10;
```

通常存放在：

```text
.data 段
```

因为：

```text
它有明确的非零初始值。
```

### ② 未初始化 static 变量

```c
static int b;
```

通常存放在：

```text
.bss 段
```

因为：

```text
它默认初始化为 0。
```

### ③ 初始化为 0

```c
static int c = 0;
```

通常也可能放在：

```text
.bss 段
```

因为：

```text
它的初始值为 0。
```

### ④ 局部 static 也是静态存储

```c
void test(void) {
    static int count = 0;
}
```

虽然写在函数内部，但它：

```text
不在栈区。
在静态存储区。
```

### ⑤ 对比

| 写法 | 常见存储区域 |
| :--- | :--- |
| `int a;` 局部变量 | 栈区 |
| `static int a;` 局部静态变量 | `.bss` / 静态区 |
| `static int a = 10;` | `.data` / 静态区 |
| `int g = 10;` 全局变量 | `.data` / 全局区 |
| `static int g = 10;` | `.data` / 静态区，文件内可见 |

> [!tip] 记忆口诀
> **static 变量不住栈，初始化看 data，零值多在 bss。**

---

# 08 | static 在多文件编程中的作用

> [!abstract] 核心结论
> 多文件编程中，`static` 是实现模块封装的重要工具。它可以隐藏模块内部变量和辅助函数，只把真正需要给外部使用的接口写到头文件中。

### ① 模块结构

```text
counter_project/
├── main.c
├── counter.h
└── counter.c
```

### ② counter.h：只暴露接口

```c
#ifndef COUNTER_H
#define COUNTER_H

void counter_add(void);
void counter_reset(void);
int counter_get(void);

#endif
```

### ③ counter.c：隐藏内部状态

```c
#include "counter.h"

static int g_count = 0;

static int check_limit(void) {
    return g_count < 100;
}

void counter_add(void) {
    if (check_limit()) {
        g_count++;
    }
}

void counter_reset(void) {
    g_count = 0;
}

int counter_get(void) {
    return g_count;
}
```

### ④ main.c：只能通过接口访问

```c
#include <stdio.h>
#include "counter.h"

int main() {
    counter_add();
    counter_add();

    printf("%d\n", counter_get());

    return 0;
}
```

### ⑤ 编译

```bash
gcc main.c counter.c -o app
```

说明：

```text
main.c 不能直接访问 g_count。
main.c 也不能直接调用 check_limit。
它只能通过 counter.h 里的接口使用模块。
```

> [!tip] 记忆口诀
> **模块内部用 static 藏，对外接口放头文件。**

---

# 09 | static 常见错误

> [!abstract] 核心结论
> `static` 常见错误包括以为局部 static 每次重新初始化、试图 `extern` 一个 static 全局变量、把该暴露的接口写成 static、滥用 static 导致测试和复用困难。

### ① 错误 1：以为局部 static 每次重新初始化

```c
void test(void) {
    static int count = 0;
    count++;
}
```

实际：

```text
count 只初始化一次。
每次调用都保留上次的值。
```

### ② 错误 2：extern static 全局变量

a.c：

```c
static int g_num = 10;
```

b.c：

```c
extern int g_num;
```

问题：

```text
b.c 链接不到 g_num。
因为 static 全局变量只在 a.c 内部可见。
```

### ③ 错误 3：把对外函数写成 static

calc.c：

```c
static int add(int a, int b) {
    return a + b;
}
```

main.c：

```c
#include "calc.h"

int main() {
    return add(1, 2);
}
```

问题：

```text
如果 add 需要给外部调用，就不能写 static。
```

### ④ 错误 4：头文件中乱写 static 变量

不推荐：

```c
// config.h
static int g_config = 1;
```

问题：

```text
每个包含 config.h 的 .c 文件都会有自己的一份 g_config。
它们不是同一个变量。
```

### ⑤ 错误 5：滥用 static

```text
所有函数都 static，外部无法复用。
所有数据都 static，测试和调试困难。
```

建议：

```text
只把真正内部使用的变量和函数加 static。
需要对外调用的接口不要加 static。
```

> [!tip] 记忆口诀
> **该藏才 static，该给别人用就别 static。**

---

# 10 | static 总结

> [!abstract] 核心结论
> `static` 的底层核心有两层：修饰局部变量时改变生命周期，让它存放在静态区并保留值；修饰全局变量和函数时改变链接属性，让它们只在当前 `.c` 文件内部可见。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>static 核心总结：</strong>
<ul>
  <li><strong>修饰局部变量：</strong>变量生命周期变成整个程序运行期间。</li>
  <li><strong>局部 static：</strong>作用域仍在函数内部，但函数结束不销毁。</li>
  <li><strong>只初始化一次：</strong>后续调用不会重复初始化。</li>
  <li><strong>默认初值：</strong>未初始化的 static 变量默认是 0。</li>
  <li><strong>存储区域：</strong>static 变量通常在静态区，不在栈区。</li>
  <li><strong>修饰全局变量：</strong>限制变量只在当前源文件内部可见。</li>
  <li><strong>修饰函数：</strong>限制函数只在当前源文件内部调用。</li>
  <li><strong>和 extern：</strong><code>extern</code> 向外找，<code>static</code> 向内藏。</li>
  <li><strong>多文件作用：</strong>隐藏模块内部状态和辅助函数。</li>
  <li><strong>使用原则：</strong>内部实现用 static，对外接口不要 static。</li>
</ul>
</div>

### ② 最底层一句话

```text
static = 局部变量延长生命周期，全局变量和函数限制文件内可见。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **局部 static 记住值，全局 static 藏名字；extern 往外找，static 往里藏。**