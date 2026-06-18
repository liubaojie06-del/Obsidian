---
tags: [C语言, printf函数, 标准输入输出, 格式化输出, 编程基础]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | printf 函数：把数据格式化输出到屏幕

> [!abstract] 核心结论
> `printf` 是 C 语言中最常用的输出函数，作用是按照指定格式，把整数、小数、字符、字符串等数据输出到屏幕。它的核心能力是“格式控制”。

### ① 底层原理：printf 到底做了什么

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>printf 的本质：</strong>
<ul>
  <li><strong>printf 属于标准库函数：</strong> 使用前需要包含 <code>#include &lt;stdio.h&gt;</code>。</li>
  <li><strong>printf 不是关键字：</strong> 它不是 C 语言内置语法，而是标准输入输出库提供的函数。</li>
  <li><strong>printf 负责输出：</strong> 把内容写到标准输出设备，通常就是终端屏幕。</li>
  <li><strong>printf 支持格式化：</strong> 可以用 <code>%d</code>、<code>%f</code>、<code>%c</code>、<code>%s</code> 等占位符控制输出格式。</li>
</ul>
</div>

### ② 最简单用法

```c
#include <stdio.h>

int main() {
    printf("Hello C\n");
    return 0;
}
```

输出结果：

```text
Hello C
```

说明：

```text
printf 会把双引号中的内容输出到屏幕。
\n 表示换行。
```

### ③ printf 的基本结构

```c
printf("格式控制字符串", 输出数据1, 输出数据2, ...);
```

可以理解为：

```text
格式控制字符串：告诉 printf 怎么输出。
输出数据：真正要被输出的变量或常量。
```

示例：

```c
#include <stdio.h>

int main() {
    int age = 18;

    printf("age = %d\n", age);

    return 0;
}
```

输出结果：

```text
age = 18
```

解释：

```text
%d 是占位符。
age 的值会替换 %d 的位置。
```

### ④ 常用格式占位符

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px;">
<strong>最常见的 printf 占位符：</strong>
<ul>
  <li><strong>%d：</strong> 输出十进制整数。</li>
  <li><strong>%f：</strong> 输出小数，默认保留 6 位小数。</li>
  <li><strong>%c：</strong> 输出单个字符。</li>
  <li><strong>%s：</strong> 输出字符串。</li>
  <li><strong>%p：</strong> 输出地址。</li>
  <li><strong>%%：</strong> 输出百分号本身。</li>
</ul>
</div>

### ⑤ 输出整数

```c
#include <stdio.h>

int main() {
    int num = 100;

    printf("%d\n", num);

    return 0;
}
```

输出结果：

```text
100
```

常见写法：

```c
printf("num = %d\n", num);
```

输出结果：

```text
num = 100
```

### ⑥ 输出小数

```c
#include <stdio.h>

int main() {
    double pi = 3.14159;

    printf("%f\n", pi);

    return 0;
}
```

输出结果：

```text
3.141590
```

说明：

```text
%f 默认输出 6 位小数。
```

控制小数位数：

```c
#include <stdio.h>

int main() {
    double pi = 3.14159;

    printf("%.2f\n", pi);
    printf("%.3f\n", pi);

    return 0;
}
```

输出结果：

```text
3.14
3.142
```

说明：

```text
%.2f 表示保留 2 位小数。
%.3f 表示保留 3 位小数。
```

### ⑦ 输出字符

```c
#include <stdio.h>

int main() {
    char ch = 'A';

    printf("%c\n", ch);

    return 0;
}
```

输出结果：

```text
A
```

注意：

```text
字符用单引号。
字符串用双引号。
```

正确：

```c
char ch = 'A';
printf("%c\n", ch);
```

错误：

```c
char ch = "A";
printf("%c\n", ch);
```

### ⑧ 输出字符串

```c
#include <stdio.h>

int main() {
    printf("%s\n", "Hello C");

    return 0;
}
```

输出结果：

```text
Hello C
```

使用字符数组：

```c
#include <stdio.h>

int main() {
    char name[] = "Tom";

    printf("%s\n", name);

    return 0;
}
```

输出结果：

```text
Tom
```

### ⑨ 一次输出多个数据

```c
#include <stdio.h>

int main() {
    int age = 18;
    double score = 95.5;
    char grade = 'A';

    printf("age = %d, score = %.1f, grade = %c\n", age, score, grade);

    return 0;
}
```

输出结果：

```text
age = 18, score = 95.5, grade = A
```

底层理解：

```text
第一个 %d 对应 age。
第二个 %.1f 对应 score。
第三个 %c 对应 grade。
```

### ⑩ 占位符和变量必须一一对应

正确写法：

```c
int a = 10;
int b = 20;

printf("%d %d\n", a, b);
```

输出结果：

```text
10 20
```

错误写法：

```c
int a = 10;

printf("%d %d\n", a);
```

问题：

```text
格式字符串里有两个 %d。
但是后面只提供了一个变量。
这会导致未定义行为，输出结果不可靠。
```

另一个错误：

```c
double x = 3.14;

printf("%d\n", x);
```

问题：

```text
%d 用来输出 int。
x 是 double。
占位符和数据类型不匹配，输出结果不可靠。
```

### ⑪ 常用格式控制

#### 1. 控制宽度

```c
#include <stdio.h>

int main() {
    int num = 42;

    printf("%5d\n", num);

    return 0;
}
```

输出效果：

```text
   42
```

说明：

```text
%5d 表示至少占 5 个字符宽度。
不足的位置默认用空格补齐。
```

---

#### 2. 左对齐

```c
#include <stdio.h>

int main() {
    int num = 42;

    printf("%-5dEND\n", num);

    return 0;
}
```

输出效果：

```text
42   END
```

说明：

```text
%-5d 表示左对齐，占 5 个字符宽度。
```

---

#### 3. 补 0

```c
#include <stdio.h>

int main() {
    int num = 42;

    printf("%05d\n", num);

    return 0;
}
```

输出结果：

```text
00042
```

说明：

```text
%05d 表示占 5 位，不足部分用 0 补齐。
```

---

#### 4. 控制小数位

```c
#include <stdio.h>

int main() {
    double x = 3.1415926;

    printf("%.2f\n", x);
    printf("%.4f\n", x);

    return 0;
}
```

输出结果：

```text
3.14
3.1416
```

说明：

```text
printf 会按照指定小数位进行四舍五入显示。
```

### ⑫ 不同进制输出

```c
#include <stdio.h>

int main() {
    int num = 255;

    printf("%d\n", num);
    printf("%o\n", num);
    printf("%x\n", num);
    printf("%X\n", num);

    return 0;
}
```

输出结果：

```text
255
377
ff
FF
```

说明：

```text
%d 输出十进制。
%o 输出八进制。
%x 输出十六进制小写。
%X 输出十六进制大写。
```

带前缀输出：

```c
#include <stdio.h>

int main() {
    int num = 255;

    printf("%#o\n", num);
    printf("%#x\n", num);
    printf("%#X\n", num);

    return 0;
}
```

输出结果：

```text
0377
0xff
0XFF
```

### ⑬ 输出地址

```c
#include <stdio.h>

int main() {
    int a = 10;

    printf("%p\n", &a);

    return 0;
}
```

说明：

```text
%p 用来输出地址。
&a 表示变量 a 的地址。
```

示例输出：

```text
0x7ffee3b8a9ac
```

注意：

```text
每次运行时，地址可能不同。
这是正常现象。
```

### ⑭ 输出百分号

```c
#include <stdio.h>

int main() {
    printf("progress = 80%%\n");

    return 0;
}
```

输出结果：

```text
progress = 80%
```

说明：

```text
%% 表示输出一个真正的百分号。
```

### ⑮ 转义字符

```c
#include <stdio.h>

int main() {
    printf("Hello\nWorld\n");
    printf("A\tB\n");
    printf("\"C Language\"\n");
    printf("\\\n");

    return 0;
}
```

输出结果：

```text
Hello
World
A       B
"C Language"
\
```

常见转义字符：

```text
\n   换行
\t   制表符
\"   双引号
\'   单引号
\\   反斜杠
\0   字符串结束标志
```

### ⑯ printf 的返回值

```c
#include <stdio.h>

int main() {
    int count = printf("Hello\n");

    printf("count = %d\n", count);

    return 0;
}
```

输出结果：

```text
Hello
count = 6
```

说明：

```text
printf 的返回值是成功输出的字符个数。
Hello 有 5 个字符。
\n 也是 1 个字符。
所以返回值是 6。
```

### ⑰ printf 执行时，内存怎么变化

示例代码：

```c
#include <stdio.h>

int main() {
    int age = 18;
    double score = 95.5;
    char grade = 'A';

    printf("age=%d score=%.1f grade=%c\n", age, score, grade);

    return 0;
}
```

运行时可以理解为：

```text
1. 程序启动，main 函数进入栈区。
2. 栈区创建局部变量 age、score、grade。
3. 字符串常量 "age=%d score=%.1f grade=%c\n" 放在常量区。
4. 调用 printf 函数。
5. printf 读取格式字符串。
6. printf 看到 %d，就取 age 的值，用整数格式输出。
7. printf 看到 %.1f，就取 score 的值，用一位小数格式输出。
8. printf 看到 %c，就取 grade 的值，用字符格式输出。
9. printf 把最终文本送到标准输出，也就是终端。
10. main 函数结束，栈区局部变量销毁。
```

内存分布理解：

```text
代码区 Text
┌──────────────────────────────┐
│ main 函数机器指令             │
│ printf 函数调用指令           │
└──────────────────────────────┘

常量区 Rodata
┌──────────────────────────────┐
│ "age=%d score=%.1f grade=%c\n"│
└──────────────────────────────┘

栈区 Stack
┌──────────────────────────────┐
│ age = 18                      │
│ score = 95.5                  │
│ grade = 'A'                   │
└──────────────────────────────┘

标准输出 stdout
┌──────────────────────────────┐
│ age=18 score=95.5 grade=A     │
└──────────────────────────────┘
```

### ⑱ 常见错误

#### 错误 1：忘记包含头文件

错误写法：

```c
int main() {
    printf("Hello\n");
    return 0;
}
```

推荐写法：

```c
#include <stdio.h>

int main() {
    printf("Hello\n");
    return 0;
}
```

原因：

```text
printf 是 stdio.h 中声明的标准库函数。
```

---

#### 错误 2：忘记分号

错误写法：

```c
printf("Hello\n")
```

正确写法：

```c
printf("Hello\n");
```

---

#### 错误 3：占位符和变量类型不匹配

错误写法：

```c
double x = 3.14;
printf("%d\n", x);
```

正确写法：

```c
double x = 3.14;
printf("%f\n", x);
```

---

#### 错误 4：输出字符串时传错类型

错误写法：

```c
char ch = 'A';
printf("%s\n", ch);
```

正确写法：

```c
char ch = 'A';
printf("%c\n", ch);
```

---

#### 错误 5：想输出百分号却只写一个 %

错误写法：

```c
printf("80%\n");
```

正确写法：

```c
printf("80%%\n");
```

### ⑲ printf 总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>printf 核心总结：</strong>
<ul>
  <li><strong>printf 用于输出：</strong> 把数据打印到终端屏幕。</li>
  <li><strong>使用前包含头文件：</strong> <code>#include &lt;stdio.h&gt;</code>。</li>
  <li><strong>格式字符串控制输出：</strong> <code>%d</code>、<code>%f</code>、<code>%c</code>、<code>%s</code>。</li>
  <li><strong>占位符要和变量类型匹配：</strong> 否则结果不可靠。</li>
  <li><strong>printf 有返回值：</strong> 返回成功输出的字符个数。</li>
</ul>
</div>

> [!tip] 记忆口诀
> **printf 管输出，stdio 要引入；百分号占位置，变量顺序要对齐；整数 `%d`，小数 `%f`，字符 `%c`，字符串 `%s`。**