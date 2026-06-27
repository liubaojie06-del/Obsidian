---
tags: [C语言, extern, 外部声明, 全局变量, 函数声明, 多文件编程, 链接]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | extern：声明外部符号

> [!abstract] 核心结论
> `extern` 用来声明一个变量或函数是在别的地方定义的。它告诉编译器“这个名字存在，但真正的内存或函数实现不在这里”，最后由链接器去其他目标文件中寻找真正定义。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>extern 的本质：</strong>
<ul>
  <li><strong>核心作用：</strong>声明外部变量或外部函数。</li>
  <li><strong>不是定义：</strong><code>extern int g_num;</code> 通常不分配内存。</li>
  <li><strong>告诉编译器：</strong>这个符号在别的文件里有定义。</li>
  <li><strong>交给链接器：</strong>编译后由链接器把声明和真正定义连接起来。</li>
  <li><strong>常见用途：</strong>多文件共享全局变量、声明外部函数、模块间通信。</li>
</ul>
</div>

### ② 代码用法

```c
extern int g_num;
```

含义：

```text
g_num 是一个 int 类型全局变量。
它在别的地方定义。
当前文件只是声明要使用它。
```

### ③ 使用场景

| 写法 | 含义 |
| :--- | :--- |
| `extern int g_num;` | 声明外部全局变量 |
| `extern void test(void);` | 声明外部函数 |
| `int g_num = 100;` | 定义全局变量并分配空间 |
| `void test(void) {}` | 定义函数并生成函数实现 |

> [!tip] 记忆口诀
> **extern 是声明，不是定义；编译器先认识，链接器再去找。**

---

# 02 | 声明和定义的区别

> [!abstract] 核心结论
> 声明是告诉编译器“有这个东西”；定义是创建这个东西。变量定义会分配存储空间，函数定义会提供函数体。

### ① 底层原理

```text
声明：
告诉编译器名字、类型、参数信息。

定义：
真正分配内存或提供函数代码。
```

### ② 变量声明

```c
extern int g_num;
```

含义：

```text
g_num 在别处定义。
这里只是声明。
通常不分配内存。
```

### ③ 变量定义

```c
int g_num = 100;
```

含义：

```text
真正创建 g_num。
分配全局变量存储空间。
初始化为 100。
```

### ④ 函数声明

```c
int add(int a, int b);
```

含义：

```text
告诉编译器 add 是一个函数。
它接收两个 int。
返回 int。
```

函数声明前面可以写 `extern`：

```c
extern int add(int a, int b);
```

但函数默认就是外部链接，所以通常省略。

### ⑤ 函数定义

```c
int add(int a, int b) {
    return a + b;
}
```

含义：

```text
真正写出 add 函数的实现代码。
```

> [!tip] 记忆口诀
> **声明只是报名字，定义才是真创建。**

---

# 03 | extern 声明全局变量

> [!abstract] 核心结论
> 如果一个全局变量在 `a.c` 中定义，另一个 `b.c` 想使用它，就需要在 `b.c` 中使用 `extern` 声明这个变量。

### ① 文件 1：定义变量

config.c：

```c
int g_count = 100;
```

这里：

```text
g_count 是真正的全局变量定义。
它分配了存储空间。
```

### ② 文件 2：声明并使用变量

main.c：

```c
#include <stdio.h>

extern int g_count;

int main() {
    printf("%d\n", g_count);

    return 0;
}
```

这里：

```text
extern int g_count;
告诉编译器 g_count 在别处定义。
```

### ③ 编译方式

```bash
gcc main.c config.c -o app
```

运行：

```bash
./app
```

输出：

```text
100
```

### ④ 链接过程理解

```text
main.c 编译时：
知道 g_count 是 int，但不知道它在哪里。

config.c 编译时：
生成真正的 g_count。

链接阶段：
把 main.o 里对 g_count 的引用，连接到 config.o 里的定义。
```

### ⑤ 重点

```text
extern 只是让当前文件“认识”外部变量。
真正变量必须在某个 .c 文件中定义一次。
```

> [!tip] 记忆口诀
> **一个文件定义变量，其他文件 extern 声明使用。**

---

# 04 | extern 不能重复定义变量

> [!abstract] 核心结论
> 全局变量只能有一个真正定义。如果多个 `.c` 文件都写了同名全局变量定义，链接时会出现重复定义错误。

### ① 错误写法

a.c：

```c
int g_num = 10;
```

b.c：

```c
int g_num = 20;
```

问题：

```text
两个文件都定义了 g_num。
链接器不知道应该用哪个。
```

可能报错：

```text
multiple definition of `g_num`
```

### ② 正确写法

a.c：

```c
int g_num = 10;
```

b.c：

```c
extern int g_num;
```

这样：

```text
a.c 负责定义。
b.c 只负责声明使用。
```

### ③ 更推荐写法：头文件声明

global.h：

```c
#ifndef GLOBAL_H
#define GLOBAL_H

extern int g_num;

#endif
```

global.c：

```c
#include "global.h"

int g_num = 10;
```

main.c：

```c
#include <stdio.h>
#include "global.h"

int main() {
    printf("%d\n", g_num);
    return 0;
}
```

### ④ 为什么头文件放 extern

因为：

```text
头文件可能被很多 .c 文件包含。
如果头文件里直接写 int g_num = 10;
就会导致多个 .c 文件各自定义一份 g_num。
```

所以头文件应该写：

```c
extern int g_num;
```

真正定义放在一个 `.c` 文件里。

### ⑤ 重点

```text
声明可以很多次。
定义只能一次。
```

> [!tip] 记忆口诀
> **头文件放 extern，源文件放定义；声明可多次，定义只能一次。**

---

# 05 | extern 与函数声明

> [!abstract] 核心结论
> 函数默认具有外部链接属性，所以函数声明前的 `extern` 通常可以省略。写不写 `extern`，多数情况下效果一样。

### ① 函数声明

```c
int add(int a, int b);
```

等价于：

```c
extern int add(int a, int b);
```

因为：

```text
普通函数默认可以被其他源文件调用。
```

### ② 文件 1：定义函数

math_utils.c：

```c
int add(int a, int b) {
    return a + b;
}
```

### ③ 文件 2：声明并调用函数

main.c：

```c
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(10, 20));

    return 0;
}
```

编译：

```bash
gcc main.c math_utils.c -o app
```

输出：

```text
30
```

### ④ 更常见写法

头文件 math_utils.h：

```c
#ifndef MATH_UTILS_H
#define MATH_UTILS_H

int add(int a, int b);

#endif
```

main.c：

```c
#include <stdio.h>
#include "math_utils.h"

int main() {
    printf("%d\n", add(10, 20));
    return 0;
}
```

### ⑤ 重点

```text
extern 声明函数可以写。
但普通函数声明默认就是 extern。
所以通常不写。
```

> [!tip] 记忆口诀
> **变量跨文件常写 extern，函数声明默认 extern。**

---

# 06 | extern 和 static 的区别

> [!abstract] 核心结论
> `extern` 表示去外部找符号，`static` 用在全局变量或函数上时表示只在当前源文件可见。二者方向相反，一个向外开放，一个向内隐藏。

### ① extern

```c
extern int g_num;
```

含义：

```text
g_num 在外部文件定义。
当前文件要引用它。
```

### ② static 全局变量

```c
static int g_num = 100;
```

含义：

```text
g_num 只能在当前 .c 文件内部使用。
其他文件不能 extern 它。
```

### ③ 错误示例

a.c：

```c
static int g_num = 100;
```

b.c：

```c
extern int g_num;
```

问题：

```text
b.c 找不到 a.c 里的 g_num。
因为 static 把它限制在 a.c 内部。
```

### ④ 对比表

| 关键字 | 作用方向 | 用在全局符号上 |
| :--- | :--- | :--- |
| `extern` | 向外找 | 声明外部符号 |
| `static` | 向内藏 | 限制当前文件可见 |

### ⑤ 模块封装建议

模块内部变量：

```c
static int g_count = 0;
```

对外提供函数：

```c
int get_count(void) {
    return g_count;
}
```

这样：

```text
外部不能直接访问 g_count。
只能通过函数间接使用。
```

> [!tip] 记忆口诀
> **extern 往外找，static 往里藏。**

---

# 07 | extern 和头文件的正确配合

> [!abstract] 核心结论
> 多文件编程中，头文件通常放外部声明，源文件放真正定义。变量声明用 `extern`，函数声明通常直接写函数原型。

### ① global.h

```c
#ifndef GLOBAL_H
#define GLOBAL_H

extern int g_count;

void print_count(void);

#endif
```

这里：

```text
extern int g_count;
是变量声明。

void print_count(void);
是函数声明。
```

### ② global.c

```c
#include <stdio.h>
#include "global.h"

int g_count = 100;

void print_count(void) {
    printf("g_count = %d\n", g_count);
}
```

这里：

```text
int g_count = 100;
是真正定义。
```

### ③ main.c

```c
#include "global.h"

int main() {
    print_count();

    g_count = 200;
    print_count();

    return 0;
}
```

### ④ 编译

```bash
gcc main.c global.c -o app
```

输出：

```text
g_count = 100
g_count = 200
```

### ⑤ 重点规则

```text
.h 文件：
放 extern 声明和函数原型。

.c 文件：
放变量定义和函数定义。
```

> [!tip] 记忆口诀
> **头文件让大家认识，源文件负责真正实现。**

---

# 08 | extern 常见错误

> [!abstract] 核心结论
> `extern` 常见错误包括只有声明没有定义、头文件中直接定义全局变量、extern 类型不匹配、试图 extern 一个 static 符号、忘记一起编译源文件。

### ① 错误 1：只有声明，没有定义

main.c：

```c
extern int g_num;

int main() {
    return g_num;
}
```

如果没有任何文件定义：

```c
int g_num = 10;
```

链接时会报：

```text
undefined reference to `g_num`
```

### ② 错误 2：头文件中定义全局变量

global.h：

```c
int g_num = 10;
```

如果多个 `.c` 文件包含它：

```text
每个 .c 文件都会定义一份 g_num。
链接时重复定义。
```

正确：

```c
extern int g_num;
```

然后在某个 `.c` 文件中写：

```c
int g_num = 10;
```

### ③ 错误 3：类型不匹配

a.c：

```c
int g_num = 10;
```

b.c：

```c
extern double g_num;
```

问题：

```text
声明类型和定义类型不一致。
会导致严重错误。
```

### ④ 错误 4：extern static 变量

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
static 限制 g_num 只在 a.c 内部可见。
b.c 无法链接到它。
```

### ⑤ 错误 5：忘记一起编译

```bash
gcc main.c -o app
```

如果 `g_num` 定义在 global.c 中，需要：

```bash
gcc main.c global.c -o app
```

> [!tip] 记忆口诀
> **extern 只声明，定义必须有；类型要一致，static 不能外找。**

---

# 09 | extern 的底层链接过程

> [!abstract] 核心结论
> `extern` 主要影响编译和链接过程。编译器看到 `extern` 后允许当前文件通过编译，但真正地址要等链接阶段才能确定。

### ① 编译阶段

main.c：

```c
extern int g_num;

int main() {
    return g_num;
}
```

编译器知道：

```text
g_num 是 int。
可以生成访问 g_num 的目标代码。
但当前文件里没有 g_num 的真正地址。
```

所以目标文件里会留下：

```text
未解析符号 g_num。
```

### ② 另一个目标文件

global.c：

```c
int g_num = 100;
```

编译后：

```text
global.o 中有 g_num 的真正定义。
```

### ③ 链接阶段

```bash
gcc main.o global.o -o app
```

链接器做：

```text
找到 main.o 里对 g_num 的引用。
找到 global.o 里的 g_num 定义。
把引用绑定到真实地址。
生成最终可执行文件。
```

### ④ 如果找不到定义

就会出现：

```text
undefined reference
```

说明：

```text
声明有了。
但链接器找不到真正定义。
```

### ⑤ 如果定义太多

就会出现：

```text
multiple definition
```

说明：

```text
同一个全局符号被定义了多次。
```

> [!tip] 记忆口诀
> **编译看声明，链接找定义；找不到叫未定义，找到多个叫重复定义。**

---

# 10 | extern 总结

> [!abstract] 核心结论
> `extern` 的底层核心是“外部声明”。它让当前源文件可以使用在其他源文件中定义的全局变量或函数。多文件编程时，变量在头文件中写 `extern` 声明，在一个源文件中写真正定义。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>extern 核心总结：</strong>
<ul>
  <li><strong>本质：</strong>外部声明。</li>
  <li><strong>作用：</strong>告诉编译器符号在别的地方定义。</li>
  <li><strong>修饰变量：</strong><code>extern int g_num;</code> 声明外部全局变量。</li>
  <li><strong>修饰函数：</strong><code>extern int add(int, int);</code> 声明外部函数，但普通函数声明通常可省略 <code>extern</code>。</li>
  <li><strong>不是定义：</strong><code>extern int g_num;</code> 通常不分配存储空间。</li>
  <li><strong>真正定义：</strong><code>int g_num = 100;</code>。</li>
  <li><strong>头文件：</strong>适合放 <code>extern</code> 变量声明。</li>
  <li><strong>源文件：</strong>放全局变量真正定义。</li>
  <li><strong>和 static：</strong><code>extern</code> 向外找，<code>static</code> 向内藏。</li>
  <li><strong>链接错误：</strong>只有声明没定义会出现 <code>undefined reference</code>。</li>
</ul>
</div>

### ② 最底层一句话

```text
extern = 当前文件只声明这个名字，真正定义在别处，最后由链接器去找。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **extern 是外部声明，声明不分配空间；头文件放声明，源文件放定义；编译先认识，链接再找人。**