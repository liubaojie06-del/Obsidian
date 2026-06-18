---
tags: [C语言, scanf函数, 标准输入输出, 格式化输入, 编程基础]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | scanf 函数：从键盘读取格式化数据

> [!abstract] 核心结论
> `scanf` 是 C 语言中最常用的输入函数，作用是从标准输入设备读取数据，并按照指定格式存入变量。它的核心规则是：普通变量前通常要加 `&`，字符串数组名通常不加 `&`。

### ① 底层原理：scanf 到底做了什么

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>scanf 的本质：</strong>
<ul>
  <li><strong>scanf 属于标准库函数：</strong> 使用前需要包含 <code>#include &lt;stdio.h&gt;</code>。</li>
  <li><strong>scanf 负责输入：</strong> 从标准输入设备读取内容，通常就是键盘。</li>
  <li><strong>scanf 需要地址：</strong> 它必须知道数据要存到哪块内存里，所以普通变量要传地址。</li>
  <li><strong>scanf 支持格式化读取：</strong> 可以用 <code>%d</code>、<code>%f</code>、<code>%c</code>、<code>%s</code> 等控制读取类型。</li>
</ul>
</div>

### ② 基本语法

```c
scanf("格式控制字符串", 地址1, 地址2, ...);
```

示例：

```c
int age;
scanf("%d", &age);
```

理解：

```text
%d 表示读取一个整数。
&age 表示变量 age 的地址。
scanf 会把键盘输入的整数存进 age 这块内存。
```

### ③ 最简单用法

```c
#include <stdio.h>

int main() {
    int age;

    printf("请输入年龄：");
    scanf("%d", &age);

    printf("age = %d\n", age);

    return 0;
}
```

输入：

```text
18
```

输出：

```text
age = 18
```

---

# 02 | 为什么 scanf 要加 &

> [!abstract] 核心结论
> `scanf` 要修改变量的值，就必须拿到变量的地址。`&变量名` 表示取变量地址。

### ① 地址理解

```c
int age;
scanf("%d", &age);
```

可以理解为：

```text
age 是一个变量。
&age 是 age 在内存中的地址。
scanf 通过这个地址，把输入的数据写入 age。
```

内存变化：

```text
输入前：

栈区 Stack
┌──────────────┐
│ age = 未知值  │
└──────────────┘

输入 18 后：

栈区 Stack
┌──────────────┐
│ age = 18      │
└──────────────┘
```

### ② 忘记 & 的错误

错误写法：

```c
int age;
scanf("%d", age);
```

问题：

```text
scanf 需要地址。
age 是变量值，不是地址。
这可能导致程序崩溃或结果异常。
```

正确写法：

```c
int age;
scanf("%d", &age);
```

---

# 03 | 读取不同类型的数据

> [!abstract] 核心结论
> `scanf` 的格式占位符必须和变量类型匹配，否则输入结果不可靠。

### ① 读取 int

```c
#include <stdio.h>

int main() {
    int num;

    scanf("%d", &num);

    printf("%d\n", num);

    return 0;
}
```

### ② 读取 double

```c
#include <stdio.h>

int main() {
    double score;

    scanf("%lf", &score);

    printf("%f\n", score);

    return 0;
}
```

注意：

```text
scanf 读取 double 要用 %lf。
printf 输出 double 通常用 %f。
```

### ③ 读取 float

```c
#include <stdio.h>

int main() {
    float price;

    scanf("%f", &price);

    printf("%f\n", price);

    return 0;
}
```

### ④ 读取 char

```c
#include <stdio.h>

int main() {
    char ch;

    scanf("%c", &ch);

    printf("%c\n", ch);

    return 0;
}
```

### ⑤ 读取字符串

```c
#include <stdio.h>

int main() {
    char name[20];

    scanf("%s", name);

    printf("%s\n", name);

    return 0;
}
```

说明：

```text
name 是数组名，数组名本身通常就表示首元素地址。
所以 scanf("%s", name) 不需要写 &name。
```

---

# 04 | 常用 scanf 占位符

> [!abstract] 核心结论
> `scanf` 的占位符决定了输入数据会被解释成什么类型。占位符写错，变量接收到的数据就可能出错。

### ① 常用格式

| 占位符 | 读取类型 |
| :--- | :--- |
| `%d` | int 十进制整数 |
| `%u` | unsigned int 无符号整数 |
| `%f` | float 小数 |
| `%lf` | double 小数 |
| `%c` | char 单个字符 |
| `%s` | 字符串，遇到空白字符停止 |
| `%x` | 十六进制整数 |
| `%o` | 八进制整数 |

### ② 对比 printf

```text
scanf 读取 double：%lf
printf 输出 double：%f
```

这是新手最容易混淆的地方。

---

# 05 | 一次读取多个数据

> [!abstract] 核心结论
> `scanf` 可以一次读取多个变量，但格式占位符、变量地址、输入内容必须一一对应。

### ① 示例代码

```c
#include <stdio.h>

int main() {
    int age;
    double score;
    char grade;

    scanf("%d %lf %c", &age, &score, &grade);

    printf("age=%d score=%.1f grade=%c\n", age, score, grade);

    return 0;
}
```

输入：

```text
18 95.5 A
```

输出：

```text
age=18 score=95.5 grade=A
```

### ② 匹配关系

```text
第一个 %d  →  &age
第二个 %lf →  &score
第三个 %c  →  &grade
```

---

# 06 | scanf 和空白字符

> [!abstract] 核心结论
> `scanf` 读取数字和字符串时，会自动跳过空格、换行、Tab；但读取字符 `%c` 时，不会自动跳过空白字符。

### ① 数字会跳过空白

```c
int a;
scanf("%d", &a);
```

输入：

```text

      100
```

结果：

```text
a = 100
```

### ② %c 会读取空白字符

```c
#include <stdio.h>

int main() {
    int age;
    char ch;

    scanf("%d", &age);
    scanf("%c", &ch);

    printf("age=%d ch=%c\n", age, ch);

    return 0;
}
```

输入：

```text
18
A
```

问题：

```text
第二个 scanf("%c", &ch) 可能读到的是 18 后面的换行符。
```

### ③ 解决方法：在 %c 前加空格

```c
scanf(" %c", &ch);
```

完整写法：

```c
#include <stdio.h>

int main() {
    int age;
    char ch;

    scanf("%d", &age);
    scanf(" %c", &ch);

    printf("age=%d ch=%c\n", age, ch);

    return 0;
}
```

说明：

```text
" %c" 前面的空格表示先跳过所有空白字符，再读取真正的字符。
```

---

# 07 | scanf 读取字符串

> [!abstract] 核心结论
> `%s` 读取字符串时，遇到空格、换行、Tab 就会停止，因此它不能直接读取带空格的一整句话。

### ① 基本读取

```c
#include <stdio.h>

int main() {
    char name[20];

    scanf("%s", name);

    printf("%s\n", name);

    return 0;
}
```

输入：

```text
Tom
```

输出：

```text
Tom
```

### ② 遇到空格会停止

输入：

```text
Tom Jerry
```

输出：

```text
Tom
```

说明：

```text
%s 只读取第一个单词。
遇到空格就停止。
```

### ③ 限制输入宽度，防止越界

```c
char name[20];
scanf("%19s", name);
```

说明：

```text
name 数组大小是 20。
最多读取 19 个字符，最后留 1 个位置给 '\0'。
```

这是比 `scanf("%s", name)` 更安全的写法。

---

# 08 | scanf 的返回值

> [!abstract] 核心结论
> `scanf` 的返回值表示成功读取并赋值的变量个数。检查返回值可以判断输入是否成功。

### ① 示例代码

```c
#include <stdio.h>

int main() {
    int age;

    int ret = scanf("%d", &age);

    printf("ret = %d\n", ret);

    return 0;
}
```

输入：

```text
18
```

输出：

```text
ret = 1
```

如果输入：

```text
abc
```

可能输出：

```text
ret = 0
```

说明：

```text
scanf 期望读取整数。
但输入 abc，不符合 %d。
所以成功读取数量为 0。
```

### ② 推荐检查写法

```c
#include <stdio.h>

int main() {
    int age;

    if (scanf("%d", &age) == 1) {
        printf("输入成功：%d\n", age);
    } else {
        printf("输入失败\n");
    }

    return 0;
}
```

---

# 09 | scanf 执行时，内存怎么变化

> [!abstract] 核心结论
> `scanf` 通过地址直接修改变量对应的内存。格式字符串通常在常量区，局部变量在栈区，输入内容先进入标准输入缓冲区，再被 `scanf` 解析后写入变量。

### ① 示例代码

```c
#include <stdio.h>

int main() {
    int age;
    double score;
    char name[20];

    scanf("%d %lf %19s", &age, &score, name);

    printf("age=%d score=%.1f name=%s\n", age, score, name);

    return 0;
}
```

输入：

```text
18 95.5 Tom
```

运行时变化：

```text
1. 程序启动，main 函数进入栈区。
2. 栈区创建 age、score、name 数组。
3. 格式字符串 "%d %lf %19s" 放在常量区。
4. 用户输入 18 95.5 Tom，内容进入标准输入缓冲区。
5. scanf 读取格式字符串。
6. 看到 %d，把 18 转成 int，写入 &age。
7. 看到 %lf，把 95.5 转成 double，写入 &score。
8. 看到 %19s，把 Tom 写入 name 数组，并自动补 '\0'。
9. printf 再从这些变量中读取数据并输出。
10. main 函数结束，栈区变量销毁。
```

### ② 内存分布理解

```text
代码区 Text
┌──────────────────────────────┐
│ main 函数机器指令             │
│ scanf / printf 调用指令       │
└──────────────────────────────┘

常量区 Rodata
┌──────────────────────────────┐
│ "%d %lf %19s"                 │
│ "age=%d score=%.1f name=%s\n" │
└──────────────────────────────┘

标准输入缓冲区 stdin
┌──────────────────────────────┐
│ 18 95.5 Tom                   │
└──────────────────────────────┘

栈区 Stack
┌──────────────────────────────┐
│ age = 18                      │
│ score = 95.5                  │
│ name = {'T','o','m','\0',...} │
└──────────────────────────────┘
```

---

# 10 | scanf 常见错误与总结

> [!abstract] 核心结论
> `scanf` 最常见的问题是忘记 `&`、占位符不匹配、`%c` 读取换行符、`%s` 字符数组越界。使用时一定要记住：普通变量传地址，字符串数组限制宽度。

### ① 常见错误

**错误 1：忘记加 &**

```c
int age;
scanf("%d", age);
```

正确：

```c
int age;
scanf("%d", &age);
```

---

**错误 2：double 用错占位符**

```c
double score;
scanf("%f", &score);
```

正确：

```c
double score;
scanf("%lf", &score);
```

---

**错误 3：%c 读到换行符**

```c
int age;
char ch;

scanf("%d", &age);
scanf("%c", &ch);
```

正确：

```c
scanf("%d", &age);
scanf(" %c", &ch);
```

---

**错误 4：字符串输入越界**

危险写法：

```c
char name[20];
scanf("%s", name);
```

更安全：

```c
char name[20];
scanf("%19s", name);
```

---

**错误 5：输入格式和 scanf 格式不匹配**

```c
int a, b;
scanf("%d,%d", &a, &b);
```

这要求输入必须类似：

```text
10,20
```

如果输入：

```text
10 20
```

第二个数字可能读取失败。

### ② scanf 总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>scanf 核心总结：</strong>
<ul>
  <li><strong>scanf 用于输入：</strong> 从键盘读取数据。</li>
  <li><strong>使用前包含头文件：</strong> <code>#include &lt;stdio.h&gt;</code>。</li>
  <li><strong>普通变量要加 &amp;：</strong> 例如 <code>&amp;age</code>。</li>
  <li><strong>字符数组不用加 &amp;：</strong> 例如 <code>scanf("%s", name)</code>。</li>
  <li><strong>double 输入用 %lf：</strong> 不是 <code>%f</code>。</li>
  <li><strong>%c 前常加空格：</strong> 避免读到换行符。</li>
  <li><strong>%s 要限制宽度：</strong> 例如 <code>%19s</code>。</li>
</ul>
</div>

> [!tip] 记忆口诀
> **scanf 管输入，普通变量给地址；整数 `%d`，小数 double `%lf`；字符 `%c` 前加空，字符串 `%s` 限宽度。**