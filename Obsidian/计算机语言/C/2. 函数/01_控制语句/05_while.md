---
tags: [C语言, while循环, 循环结构, 条件判断, 编程基础]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | while 循环：条件成立就反复执行

> [!abstract] 核心结论
> `while` 是 C 语言中最基础的循环语句。它会先判断条件，条件为真就执行循环体，执行完后再次判断条件，直到条件为假才退出循环。

### ① 底层原理：while 到底做了什么

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>while 的本质：</strong>
<ul>
  <li><strong>while 是循环控制语句：</strong> 用来让一段代码重复执行。</li>
  <li><strong>先判断，后执行：</strong> 每次进入循环体之前，都会先判断条件。</li>
  <li><strong>条件为真继续：</strong> 在 C 语言中，非 <code>0</code> 表示真。</li>
  <li><strong>条件为假退出：</strong> 条件结果为 <code>0</code> 时，跳出循环。</li>
  <li><strong>底层是条件跳转：</strong> 编译后会变成判断指令和跳转指令。</li>
</ul>
</div>

### ② while 的执行流程

```text
开始
  ↓
判断条件
  ↓
条件为真 ──→ 执行循环体
  ↑              ↓
  └────── 更新变量 / 改变条件
  ↓
条件为假
  ↓
退出循环
```

### ③ 基本语法

```c
while (条件表达式) {
    循环体语句;
}
```

执行逻辑：

```text
1. 先判断 while 后面的条件表达式。
2. 如果条件为真，执行大括号里的代码。
3. 执行完循环体后，再回到 while 继续判断。
4. 如果条件为假，退出循环，执行 while 后面的代码。
```

> [!tip] 一句话理解
> **while 就是“只要条件还成立，就一直重复做”。**

---

# 02 | while 最简单用法

> [!abstract] 核心结论
> `while` 最常见的写法是：先准备循环变量，再写循环条件，循环体里更新变量。缺少更新变量，很容易变成死循环。

### ① 输出 1 到 5

```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 5) {
        printf("%d\n", i);
        i++;
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
i = 1，判断 i <= 5，成立，输出 1，i 变成 2
i = 2，判断 i <= 5，成立，输出 2，i 变成 3
i = 3，判断 i <= 5，成立，输出 3，i 变成 4
i = 4，判断 i <= 5，成立，输出 4，i 变成 5
i = 5，判断 i <= 5，成立，输出 5，i 变成 6
i = 6，判断 i <= 5，不成立，退出循环
```

### ③ while 三要素

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px;">
<strong>循环三要素：</strong>
<ul>
  <li><strong>初始化：</strong> 循环开始前准备变量，例如 <code>int i = 1;</code></li>
  <li><strong>条件判断：</strong> 决定循环是否继续，例如 <code>i &lt;= 5</code></li>
  <li><strong>变量更新：</strong> 改变循环条件，例如 <code>i++</code></li>
</ul>
</div>

模板：

```c
int i = 初始值;

while (循环条件) {
    循环体;
    i++;
}
```

> [!tip] 记忆口诀
> **先初始化，再判断；循环体里要变化，不变就会死循环。**

---

# 03 | while 与计数循环

> [!abstract] 核心结论
> 当循环次数可以通过变量控制时，可以使用 `while` 实现计数循环，例如输出固定次数、累加求和、统计数量。

### ① 输出固定次数

```c
#include <stdio.h>

int main() {
    int count = 1;

    while (count <= 3) {
        printf("Hello C\n");
        count++;
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

### ② 求 1 到 100 的和

```c
#include <stdio.h>

int main() {
    int i = 1;
    int sum = 0;

    while (i <= 100) {
        sum += i;
        i++;
    }

    printf("sum = %d\n", sum);

    return 0;
}
```

输出：

```text
sum = 5050
```

执行理解：

```text
sum 初始为 0。
每次循环把当前 i 加到 sum 中。
i 从 1 增加到 100。
最后 sum 保存总和。
```

### ③ 求 1 到 100 的偶数和

```c
#include <stdio.h>

int main() {
    int i = 1;
    int sum = 0;

    while (i <= 100) {
        if (i % 2 == 0) {
            sum += i;
        }

        i++;
    }

    printf("sum = %d\n", sum);

    return 0;
}
```

输出：

```text
sum = 2550
```

更简洁写法：

```c
#include <stdio.h>

int main() {
    int i = 2;
    int sum = 0;

    while (i <= 100) {
        sum += i;
        i += 2;
    }

    printf("sum = %d\n", sum);

    return 0;
}
```

---

# 04 | while 与输入控制

> [!abstract] 核心结论
> `while` 很适合处理“不确定次数”的输入场景，例如用户一直输入，直到输入特定值才停止。

### ① 输入数字，直到输入 0 结束

```c
#include <stdio.h>

int main() {
    int num;

    printf("请输入数字，输入 0 结束：");
    scanf("%d", &num);

    while (num != 0) {
        printf("你输入的是：%d\n", num);

        printf("请输入数字，输入 0 结束：");
        scanf("%d", &num);
    }

    printf("程序结束\n");

    return 0;
}
```

示例输入：

```text
5
8
3
0
```

示例输出：

```text
你输入的是：5
你输入的是：8
你输入的是：3
程序结束
```

### ② 使用 scanf 返回值控制循环

```c
#include <stdio.h>

int main() {
    int num;

    printf("请输入整数，输入非整数结束：\n");

    while (scanf("%d", &num) == 1) {
        printf("读取成功：%d\n", num);
    }

    printf("输入结束\n");

    return 0;
}
```

说明：

```text
scanf("%d", &num) == 1 表示成功读取一个整数。
如果用户输入 abc，读取失败，循环结束。
```

### ③ 统计输入数字的和

```c
#include <stdio.h>

int main() {
    int num;
    int sum = 0;

    printf("请输入数字，输入 0 结束：");

    scanf("%d", &num);

    while (num != 0) {
        sum += num;
        scanf("%d", &num);
    }

    printf("sum = %d\n", sum);

    return 0;
}
```

> [!tip] 记忆口诀
> **次数不确定，while 最合适；输入当条件，失败就停止。**

---

# 05 | while 与死循环

> [!abstract] 核心结论
> 死循环是指循环条件一直为真，程序永远无法自然退出。死循环可能是错误，也可能是故意设计，例如服务器主循环、菜单系统、游戏主循环。

### ① 错误死循环

```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 5) {
        printf("%d\n", i);
    }

    return 0;
}
```

问题：

```text
i 没有变化。
i 永远等于 1。
条件 i <= 5 永远成立。
程序会一直输出 1。
```

正确写法：

```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 5) {
        printf("%d\n", i);
        i++;
    }

    return 0;
}
```

### ② 故意死循环

```c
while (1) {
    printf("一直运行\n");
}
```

说明：

```text
while(1) 表示条件永远为真。
常用于需要长期运行的程序。
```

### ③ 用 break 跳出死循环

```c
#include <stdio.h>

int main() {
    int num;

    while (1) {
        printf("请输入数字，输入 0 退出：");
        scanf("%d", &num);

        if (num == 0) {
            break;
        }

        printf("你输入的是：%d\n", num);
    }

    printf("程序结束\n");

    return 0;
}
```

说明：

```text
while(1) 负责一直循环。
if 判断退出条件。
break 负责跳出循环。
```

---

# 06 | break 与 continue

> [!abstract] 核心结论
> `break` 用来立刻结束整个循环，`continue` 用来跳过本次循环剩余代码，直接进入下一轮判断。

### ① break：结束整个循环

```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 10) {
        if (i == 5) {
            break;
        }

        printf("%d\n", i);
        i++;
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
当 i == 5 时，break 直接跳出 while。
后面的 5 到 10 都不会输出。
```

### ② continue：跳过本次循环

```c
#include <stdio.h>

int main() {
    int i = 0;

    while (i < 10) {
        i++;

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
当 i == 5 时，continue 跳过本轮后面的 printf。
然后继续下一轮循环。
```

### ③ continue 小心死循环

危险写法：

```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 10) {
        if (i == 5) {
            continue;
        }

        printf("%d\n", i);
        i++;
    }

    return 0;
}
```

问题：

```text
当 i == 5 时，执行 continue。
i++ 在 continue 后面，永远执行不到。
i 一直是 5，形成死循环。
```

正确写法：

```c
#include <stdio.h>

int main() {
    int i = 0;

    while (i < 10) {
        i++;

        if (i == 5) {
            continue;
        }

        printf("%d\n", i);
    }

    return 0;
}
```

> [!tip] 记忆口诀
> **break 结束整个循环，continue 结束本轮循环。**

---

# 07 | while 与 do while 的区别

> [!abstract] 核心结论
> `while` 是先判断后执行，可能一次都不执行；`do while` 是先执行后判断，至少会执行一次。

### ① while：先判断后执行

```c
#include <stdio.h>

int main() {
    int i = 10;

    while (i < 5) {
        printf("while 执行了\n");
        i++;
    }

    return 0;
}
```

输出：

```text
没有任何输出
```

原因：

```text
i < 5 一开始就是假。
所以循环体一次都不执行。
```

### ② do while：先执行后判断

```c
#include <stdio.h>

int main() {
    int i = 10;

    do {
        printf("do while 执行了\n");
        i++;
    } while (i < 5);

    return 0;
}
```

输出：

```text
do while 执行了
```

原因：

```text
do while 先执行循环体，再判断条件。
所以至少执行一次。
```

### ③ do while 基本语法

```c
do {
    循环体;
} while (条件);
```

注意：

```text
do while 最后 while 后面有分号。
```

### ④ 使用场景

```text
while：
适合先判断条件，再决定是否执行。

do while：
适合菜单、输入确认等至少要执行一次的场景。
```

---

# 08 | while 嵌套循环

> [!abstract] 核心结论
> while 可以嵌套使用。外层循环控制行，内层循环控制列，常用于打印矩形、九九乘法表、二维数组遍历。

### ① 打印矩形

```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 3) {
        int j = 1;

        while (j <= 5) {
            printf("*");
            j++;
        }

        printf("\n");
        i++;
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

执行理解：

```text
外层 i 控制行数，一共 3 行。
内层 j 控制每行输出 5 个星号。
```

### ② 打印九九乘法表

```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 9) {
        int j = 1;

        while (j <= i) {
            printf("%d*%d=%d\t", j, i, i * j);
            j++;
        }

        printf("\n");
        i++;
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

### ③ 嵌套循环执行规律

```text
外层循环执行 1 次。
内层循环会完整执行一轮。

如果外层执行 3 次，内层每次执行 5 次。
总执行次数 = 3 × 5 = 15 次。
```

> [!tip] 记忆口诀
> **外层管行，内层管列；外层走一步，内层跑一圈。**

---

# 09 | while 常见错误

> [!abstract] 核心结论
> `while` 最常见的问题是忘记更新变量、条件写错、分号误加、continue 导致更新语句被跳过、输入缓冲处理不当。

### ① 错误 1：忘记更新变量

错误：

```c
int i = 1;

while (i <= 5) {
    printf("%d\n", i);
}
```

问题：

```text
i 永远不变，循环无法结束。
```

正确：

```c
int i = 1;

while (i <= 5) {
    printf("%d\n", i);
    i++;
}
```

---

### ② 错误 2：while 后面误加分号

错误：

```c
int i = 1;

while (i <= 5);
{
    printf("%d\n", i);
    i++;
}
```

问题：

```text
while 后面的分号表示空循环。
真正的大括号代码已经不属于 while。
如果 i <= 5 一直成立，就会卡死在空循环里。
```

正确：

```c
int i = 1;

while (i <= 5) {
    printf("%d\n", i);
    i++;
}
```

---

### ③ 错误 3：循环条件边界写错

```c
int i = 1;

while (i < 5) {
    printf("%d\n", i);
    i++;
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
如果想输出到 5，条件应该写 i <= 5。
```

---

### ④ 错误 4：continue 跳过更新语句

错误：

```c
int i = 1;

while (i <= 10) {
    if (i == 5) {
        continue;
    }

    printf("%d\n", i);
    i++;
}
```

问题：

```text
i 等于 5 后永远不会执行 i++。
程序进入死循环。
```

正确：

```c
int i = 0;

while (i < 10) {
    i++;

    if (i == 5) {
        continue;
    }

    printf("%d\n", i);
}
```

---

### ⑤ 错误 5：scanf 失败后死循环

错误思路：

```c
int num;

while (scanf("%d", &num) != 1) {
    printf("输入错误\n");
}
```

问题：

```text
如果输入 abc，scanf 读取失败。
abc 仍然留在输入缓冲区。
下一次 scanf 还会继续读到 abc，导致一直失败。
```

简单处理方式：

```c
int num;
int ch;

while (scanf("%d", &num) != 1) {
    printf("输入错误，请重新输入：");

    while ((ch = getchar()) != '\n' && ch != EOF) {
        // 清空输入缓冲区
    }
}
```

---

# 10 | while 总结

> [!abstract] 核心结论
> `while` 适合条件控制循环，尤其适合循环次数不确定的场景。写 while 时最重要的是保证循环条件最终会变成假。

### ① while 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>while 循环核心总结：</strong>
<ul>
  <li><strong>while：</strong> 先判断条件，再决定是否执行循环体。</li>
  <li><strong>条件为真：</strong> 执行循环体。</li>
  <li><strong>条件为假：</strong> 退出循环。</li>
  <li><strong>循环三要素：</strong> 初始化、条件判断、变量更新。</li>
  <li><strong>break：</strong> 直接结束整个循环。</li>
  <li><strong>continue：</strong> 跳过本轮循环剩余代码。</li>
  <li><strong>重点：</strong> 循环条件必须有机会变成假，否则会死循环。</li>
</ul>
</div>

### ② while 模板速查

**计数循环：**

```c
int i = 1;

while (i <= n) {
    循环体;
    i++;
}
```

**输入控制循环：**

```c
int num;

scanf("%d", &num);

while (num != 0) {
    处理 num;
    scanf("%d", &num);
}
```

**死循环 + break：**

```c
while (1) {
    执行代码;

    if (退出条件) {
        break;
    }
}
```

**嵌套循环：**

```c
int i = 1;

while (i <= 行数) {
    int j = 1;

    while (j <= 列数) {
        printf("*");
        j++;
    }

    printf("\n");
    i++;
}
```

> [!tip] 记忆口诀
> **while 先判断，真就一直干；变量要更新，条件会变假；break 直接走，continue 跳本轮。**