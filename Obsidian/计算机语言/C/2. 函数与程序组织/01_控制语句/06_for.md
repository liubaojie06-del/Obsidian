---
tags: [C语言, for循环, 循环结构, 编程基础, 控制语句]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | for 循环：最适合控制次数的循环结构

> [!abstract] 核心结论
> `for` 是 C 语言中最常用的循环语句，特别适合“循环次数明确”的场景。它把初始化、条件判断、变量更新集中写在一行，让循环结构更紧凑、更清晰。

### ① 底层原理：for 到底做了什么

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>for 的本质：</strong>
<ul>
  <li><strong>for 是循环控制语句：</strong> 用来让一段代码重复执行。</li>
  <li><strong>适合次数明确的循环：</strong> 例如循环 10 次、遍历数组、打印九九乘法表。</li>
  <li><strong>三要素集中：</strong> 初始化、条件判断、变量更新都写在 <code>for()</code> 中。</li>
  <li><strong>底层仍然是条件跳转：</strong> 编译后本质上和 <code>while</code> 一样，都是判断和跳转。</li>
</ul>
</div>

### ② for 的基本结构

```c
for (初始化; 条件判断; 变量更新) {
    循环体;
}
```

执行顺序：

```text
1. 执行初始化，只执行一次。
2. 判断条件是否成立。
3. 如果条件为真，执行循环体。
4. 执行变量更新。
5. 回到第 2 步继续判断。
6. 如果条件为假，退出循环。
```

流程理解：

```text
初始化
  ↓
判断条件
  ↓
条件为真 ──→ 执行循环体
  ↑              ↓
  └────── 变量更新
  ↓
条件为假
  ↓
退出循环
```

> [!tip] 一句话理解
> **for 就是把 while 的“初始化、判断、更新”压缩到一行里。**

---

# 02 | for 最简单用法

> [!abstract] 核心结论
> 一个标准的 `for` 循环通常包含三个部分：循环变量初始化、循环条件、循环变量变化。

### ① 输出 1 到 5

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 5; i++) {
        printf("%d\n", i);
    }

    return 0;
}
```

输出：

```text
1
2
3
4
5
```

### ② 执行过程

```text
int i = 1       只执行一次
i <= 5          判断条件，成立
printf          输出 i
i++             i 加 1

然后继续判断 i <= 5
直到 i 变成 6，条件不成立，退出循环
```

### ③ 三要素拆解

```c
for (int i = 1; i <= 5; i++)
```

可以拆成：

```text
int i = 1     初始化
i <= 5        循环条件
i++           变量更新
```

等价 while 写法：

```c
int i = 1;

while (i <= 5) {
    printf("%d\n", i);
    i++;
}
```

> [!tip] 记忆口诀
> **一号位初始化，二号位管真假，三号位负责变化。**

---

# 03 | for 与计数循环

> [!abstract] 核心结论
> `for` 最适合做计数循环，例如循环固定次数、累加求和、统计数量、遍历范围。

### ① 循环固定次数

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 3; i++) {
        printf("Hello C\n");
    }

    return 0;
}
```

输出：

```text
Hello C
Hello C
Hello C
```

---

### ② 求 1 到 100 的和

```c
#include <stdio.h>

int main() {
    int sum = 0;

    for (int i = 1; i <= 100; i++) {
        sum += i;
    }

    printf("sum = %d\n", sum);

    return 0;
}
```

输出：

```text
sum = 5050
```

运行理解：

```text
sum 初始为 0。
i 从 1 到 100。
每轮把 i 加到 sum 里。
循环结束后，sum 保存总和。
```

---

### ③ 求 1 到 100 的偶数和

```c
#include <stdio.h>

int main() {
    int sum = 0;

    for (int i = 2; i <= 100; i += 2) {
        sum += i;
    }

    printf("sum = %d\n", sum);

    return 0;
}
```

输出：

```text
sum = 2550
```

也可以写成：

```c
#include <stdio.h>

int main() {
    int sum = 0;

    for (int i = 1; i <= 100; i++) {
        if (i % 2 == 0) {
            sum += i;
        }
    }

    printf("sum = %d\n", sum);

    return 0;
}
```

---

# 04 | for 与数组遍历

> [!abstract] 核心结论
> `for` 是遍历数组最常用的循环结构。数组下标从 `0` 开始，所以遍历条件通常写成 `i < len`。

### ① 遍历 int 数组

```c
#include <stdio.h>

int main() {
    int arr[5] = {10, 20, 30, 40, 50};

    for (int i = 0; i < 5; i++) {
        printf("%d\n", arr[i]);
    }

    return 0;
}
```

输出：

```text
10
20
30
40
50
```

### ② 使用 sizeof 自动计算数组长度

```c
#include <stdio.h>

int main() {
    int arr[] = {10, 20, 30, 40, 50};

    int len = sizeof(arr) / sizeof(arr[0]);

    for (int i = 0; i < len; i++) {
        printf("%d\n", arr[i]);
    }

    return 0;
}
```

说明：

```text
sizeof(arr) 得到整个数组字节数。
sizeof(arr[0]) 得到一个元素字节数。
两者相除就是数组元素个数。
```

### ③ 修改数组元素

```c
#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};

    for (int i = 0; i < 5; i++) {
        arr[i] *= 2;
    }

    for (int i = 0; i < 5; i++) {
        printf("%d\n", arr[i]);
    }

    return 0;
}
```

输出：

```text
2
4
6
8
10
```

> [!tip] 记忆口诀
> **数组从零开始数，条件常写小于长；`i < len` 最稳当，别写越界出祸殃。**

---

# 05 | for 的多种写法

> [!abstract] 核心结论
> `for` 的三个表达式都可以省略，也可以写多个表达式。但省略后要确保循环仍然能正确结束。

### ① 省略初始化

```c
#include <stdio.h>

int main() {
    int i = 1;

    for (; i <= 5; i++) {
        printf("%d\n", i);
    }

    return 0;
}
```

说明：

```text
初始化可以提前写在 for 外面。
但第一个分号不能省略。
```

---

### ② 省略变量更新

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 5;) {
        printf("%d\n", i);
        i++;
    }

    return 0;
}
```

说明：

```text
变量更新可以写在循环体里面。
但第三个表达式位置仍然要保留。
```

---

### ③ 省略条件，形成死循环

```c
for (;;) {
    printf("一直循环\n");
}
```

说明：

```text
for(;;) 等价于 while(1)。
条件省略时，默认认为条件一直成立。
```

---

### ④ 多变量控制

```c
#include <stdio.h>

int main() {
    for (int i = 1, j = 5; i <= 5; i++, j--) {
        printf("i=%d, j=%d\n", i, j);
    }

    return 0;
}
```

输出：

```text
i=1, j=5
i=2, j=4
i=3, j=3
i=4, j=2
i=5, j=1
```

说明：

```text
初始化部分和更新部分可以用逗号写多个表达式。
```

---

# 06 | break 与 continue

> [!abstract] 核心结论
> 在 `for` 循环中，`break` 用来立刻结束整个循环，`continue` 用来跳过本轮剩余代码，直接进入下一轮更新和判断。

### ① break：结束整个循环

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 10; i++) {
        if (i == 5) {
            break;
        }

        printf("%d\n", i);
    }

    return 0;
}
```

输出：

```text
1
2
3
4
```

说明：

```text
当 i == 5 时，break 直接跳出整个 for 循环。
```

---

### ② continue：跳过本轮循环

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 10; i++) {
        if (i == 5) {
            continue;
        }

        printf("%d\n", i);
    }

    return 0;
}
```

输出：

```text
1
2
3
4
6
7
8
9
10
```

说明：

```text
当 i == 5 时，continue 跳过本轮 printf。
然后执行 i++，继续下一轮判断。
```

### ③ for 中 continue 的特点

```text
在 for 循环中，continue 后会先执行第三部分的变量更新。
然后再回到条件判断。
```

执行路径：

```text
continue
  ↓
执行 i++
  ↓
判断 i <= 10
  ↓
进入下一轮
```

> [!tip] 记忆口诀
> **break 直接出门，continue 跳本轮；for 里 continue 后，更新表达式还会走。**

---

# 07 | for 嵌套循环

> [!abstract] 核心结论
> `for` 可以嵌套使用。外层循环通常控制行，内层循环通常控制列，适合打印图形、乘法表、二维数组遍历。

### ① 打印矩形

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 5; j++) {
            printf("*");
        }

        printf("\n");
    }

    return 0;
}
```

输出：

```text
*****
*****
*****
```

说明：

```text
外层 i 控制行数。
内层 j 控制每行打印几个星号。
```

---

### ② 打印三角形

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 5; i++) {
        for (int j = 1; j <= i; j++) {
            printf("*");
        }

        printf("\n");
    }

    return 0;
}
```

输出：

```text
*
**
***
****
*****
```

---

### ③ 九九乘法表

```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 9; i++) {
        for (int j = 1; j <= i; j++) {
            printf("%d*%d=%d\t", j, i, i * j);
        }

        printf("\n");
    }

    return 0;
}
```

输出效果：

```text
1*1=1
1*2=2   2*2=4
1*3=3   2*3=6   3*3=9
...
```

### ④ 嵌套循环执行规律

```text
外层循环执行 1 次，内层循环完整执行一轮。
如果外层执行 3 次，内层每次执行 5 次。
总执行次数 = 3 × 5 = 15 次。
```

> [!tip] 记忆口诀
> **外层管行，内层管列；外层走一步，内层跑一圈。**

---

# 08 | for 与 while 的区别

> [!abstract] 核心结论
> `for` 和 `while` 都能实现循环。一般来说，次数明确时优先用 `for`，次数不确定时优先用 `while`。

### ① for 适合次数明确

```c
for (int i = 1; i <= 10; i++) {
    printf("%d\n", i);
}
```

适合：

```text
循环 10 次。
遍历数组。
打印固定范围。
做计数累加。
```

---

### ② while 适合次数不确定

```c
int num;

scanf("%d", &num);

while (num != 0) {
    printf("%d\n", num);
    scanf("%d", &num);
}
```

适合：

```text
用户输入直到 0。
读取文件直到结束。
等待某个条件发生。
服务器持续运行。
```

### ③ 等价转换

for 写法：

```c
for (int i = 1; i <= 5; i++) {
    printf("%d\n", i);
}
```

while 写法：

```c
int i = 1;

while (i <= 5) {
    printf("%d\n", i);
    i++;
}
```

对比：

```text
for：
三要素集中，结构紧凑。

while：
条件更突出，适合不确定次数。
```

---

# 09 | for 常见错误

> [!abstract] 核心结论
> `for` 最常见的问题包括条件边界写错、分号误加、数组越界、死循环、循环变量作用域不清楚。

### ① 错误 1：条件边界写错

```c
int arr[5] = {1, 2, 3, 4, 5};

for (int i = 0; i <= 5; i++) {
    printf("%d\n", arr[i]);
}
```

问题：

```text
数组下标是 0 到 4。
i <= 5 会访问 arr[5]，发生越界。
```

正确：

```c
for (int i = 0; i < 5; i++) {
    printf("%d\n", arr[i]);
}
```

---

### ② 错误 2：for 后面误加分号

错误：

```c
for (int i = 1; i <= 5; i++);
{
    printf("Hello\n");
}
```

问题：

```text
for 后面的分号表示空循环。
后面的大括号已经不属于 for。
```

正确：

```c
for (int i = 1; i <= 5; i++) {
    printf("Hello\n");
}
```

---

### ③ 错误 3：忘记更新变量导致死循环

错误：

```c
for (int i = 1; i <= 5;) {
    printf("%d\n", i);
}
```

问题：

```text
i 一直不变。
条件一直成立。
程序进入死循环。
```

正确：

```c
for (int i = 1; i <= 5; i++) {
    printf("%d\n", i);
}
```

---

### ④ 错误 4：循环变量作用域问题

```c
for (int i = 1; i <= 5; i++) {
    printf("%d\n", i);
}

printf("%d\n", i);
```

问题：

```text
如果 i 定义在 for 的初始化部分，
它通常只在 for 循环内部有效。
循环外不能继续使用。
```

正确：

```c
int i;

for (i = 1; i <= 5; i++) {
    printf("%d\n", i);
}

printf("%d\n", i);
```

---

### ⑤ 错误 5：循环里修改循环变量导致逻辑混乱

不推荐：

```c
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        i = 100;
    }

    printf("%d\n", i);
}
```

问题：

```text
循环变量在循环体里被强行修改。
容易导致循环次数不清晰。
```

建议：

```text
循环变量尽量只在 for 的第三部分更新。
特殊退出场景使用 break。
```

---

# 10 | for 总结

> [!abstract] 核心结论
> `for` 是 C 语言中最适合“计数”和“遍历”的循环结构。写 for 时，最重要的是看清楚：从哪里开始，到哪里结束，每次怎么变化。

### ① for 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>for 循环核心总结：</strong>
<ul>
  <li><strong>for：</strong> 适合循环次数明确的场景。</li>
  <li><strong>三要素：</strong> 初始化、条件判断、变量更新。</li>
  <li><strong>数组遍历：</strong> 常用 <code>for (int i = 0; i &lt; len; i++)</code>。</li>
  <li><strong>break：</strong> 直接结束整个循环。</li>
  <li><strong>continue：</strong> 跳过本轮，进入下一轮。</li>
  <li><strong>嵌套 for：</strong> 外层管行，内层管列。</li>
  <li><strong>注意：</strong> 不要越界，不要误加分号，不要写死循环。</li>
</ul>
</div>

### ② for 模板速查

**基础计数：**

```c
for (int i = 1; i <= n; i++) {
    循环体;
}
```

**数组遍历：**

```c
for (int i = 0; i < len; i++) {
    printf("%d\n", arr[i]);
}
```

**倒序循环：**

```c
for (int i = n; i >= 1; i--) {
    printf("%d\n", i);
}
```

**死循环：**

```c
for (;;) {
    循环体;

    if (退出条件) {
        break;
    }
}
```

**嵌套循环：**

```c
for (int i = 1; i <= 行数; i++) {
    for (int j = 1; j <= 列数; j++) {
        printf("*");
    }

    printf("\n");
}
```

> [!tip] 记忆口诀
> **for 管次数最清楚，三段分别是起点、条件、步数；数组遍历从零起，小于长度最稳妥。**