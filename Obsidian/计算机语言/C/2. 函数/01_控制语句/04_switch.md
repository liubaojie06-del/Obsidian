---
tags: [C语言, switch语句, 条件判断, 分支结构, 编程基础]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | switch 语句：多分支等值匹配

> [!abstract] 核心结论
> `switch` 是 C 语言中的多分支选择语句，适合处理“一个变量等于多个固定值中的哪一个”的场景。它常用于菜单选择、等级判断、状态码处理。

### ① 底层原理：switch 到底做了什么

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>switch 的本质：</strong>
<ul>
  <li><strong>switch 是多分支语句：</strong> 根据表达式的值，跳转到匹配的 <code>case</code> 分支执行。</li>
  <li><strong>case 是固定匹配值：</strong> 每个 <code>case</code> 后面必须是常量表达式，不能是变量范围。</li>
  <li><strong>break 用来跳出 switch：</strong> 如果没有 <code>break</code>，程序会继续向下执行后面的 case。</li>
  <li><strong>default 是兜底分支：</strong> 所有 case 都不匹配时，执行 default。</li>
</ul>
</div>

### ② switch 基本结构

```c
switch (表达式) {
    case 常量1:
        语句1;
        break;

    case 常量2:
        语句2;
        break;

    default:
        默认语句;
        break;
}
```

执行逻辑：

```text
1. 先计算 switch 后面表达式的值。
2. 用这个值依次匹配 case 后面的常量。
3. 匹配成功后，从对应 case 开始执行。
4. 遇到 break，跳出整个 switch。
5. 如果都不匹配，执行 default。
```

---

# 02 | switch 最简单用法

> [!abstract] 核心结论
> 当一个变量可能等于几个固定值时，使用 `switch` 比多个 `if else if` 更清晰。

### ① 示例代码：数字菜单

```c
#include <stdio.h>

int main() {
    int choice = 2;

    switch (choice) {
        case 1:
            printf("开始游戏\n");
            break;

        case 2:
            printf("继续游戏\n");
            break;

        case 3:
            printf("退出游戏\n");
            break;

        default:
            printf("无效选择\n");
            break;
    }

    return 0;
}
```

输出：

```text
继续游戏
```

### ② 执行流程

```text
choice = 2
      ↓
进入 switch
      ↓
匹配 case 1：不匹配
      ↓
匹配 case 2：匹配成功
      ↓
执行 printf("继续游戏\n")
      ↓
遇到 break
      ↓
跳出 switch
```

---

# 03 | case、break、default 的作用

> [!abstract] 核心结论
> `case` 负责匹配值，`break` 负责跳出分支，`default` 负责兜底处理。三者配合，才能形成稳定清晰的多分支逻辑。

### ① case：匹配固定值

```c
case 1:
    printf("选择了 1\n");
    break;
```

说明：

```text
当 switch 表达式的值等于 1 时，从这个 case 开始执行。
```

---

### ② break：跳出 switch

```c
case 1:
    printf("选择了 1\n");
    break;
```

说明：

```text
break 会直接跳出整个 switch。
如果没有 break，程序会继续向下执行后面的 case。
```

---

### ③ default：默认分支

```c
default:
    printf("输入错误\n");
    break;
```

说明：

```text
当所有 case 都不匹配时，执行 default。
default 可以放在最后，也可以放在中间，但通常放最后最清晰。
```

---

# 04 | 没有 break 会发生什么

> [!abstract] 核心结论
> `switch` 中如果忘记写 `break`，程序不会自动停止，而是会继续向下执行后面的 case，这种现象叫“case 穿透”。

### ① 忘记 break 的示例

```c
#include <stdio.h>

int main() {
    int num = 1;

    switch (num) {
        case 1:
            printf("一\n");

        case 2:
            printf("二\n");

        case 3:
            printf("三\n");

        default:
            printf("其他\n");
    }

    return 0;
}
```

输出：

```text
一
二
三
其他
```

### ② 原因解释

```text
num = 1
      ↓
匹配 case 1
      ↓
执行 printf("一\n")
      ↓
没有 break
      ↓
继续执行 case 2
      ↓
继续执行 case 3
      ↓
继续执行 default
```

### ③ 正确写法

```c
switch (num) {
    case 1:
        printf("一\n");
        break;

    case 2:
        printf("二\n");
        break;

    case 3:
        printf("三\n");
        break;

    default:
        printf("其他\n");
        break;
}
```

> [!tip] 记忆口诀
> **case 只管入口，break 才管出口；忘了 break，就会一路往下走。**

---

# 05 | 有意利用 case 穿透

> [!abstract] 核心结论
> case 穿透不一定都是错误。多个 case 需要执行同一段代码时，可以故意省略 break，让多个值共用一个处理逻辑。

### ① 多个 case 共用代码

```c
#include <stdio.h>

int main() {
    int day = 6;

    switch (day) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            printf("工作日\n");
            break;

        case 6:
        case 7:
            printf("周末\n");
            break;

        default:
            printf("无效日期\n");
            break;
    }

    return 0;
}
```

输出：

```text
周末
```

### ② 执行理解

```text
day = 6
      ↓
匹配 case 6
      ↓
case 6 后面没有代码，也没有 break
      ↓
继续执行 case 7 下面的代码
      ↓
输出“周末”
      ↓
遇到 break 跳出
```

### ③ 使用建议

```text
如果是故意穿透，建议加注释说明。
避免以后自己或别人误以为忘记写 break。
```

示例：

```c
case 6:
case 7:
    // 故意穿透：周六和周日统一处理
    printf("周末\n");
    break;
```

---

# 06 | switch 能匹配哪些类型

> [!abstract] 核心结论
> C 语言中的 `switch` 主要用于整数类型表达式，不能直接匹配浮点数、字符串和范围条件。

### ① 可以使用的类型

```c
int num;
char ch;
enum Color color;
```

常见可用类型：

```text
int
char
short
long
枚举 enum
```

示例：char 匹配

```c
#include <stdio.h>

int main() {
    char op = '+';

    switch (op) {
        case '+':
            printf("加法\n");
            break;

        case '-':
            printf("减法\n");
            break;

        case '*':
            printf("乘法\n");
            break;

        case '/':
            printf("除法\n");
            break;

        default:
            printf("未知运算符\n");
            break;
    }

    return 0;
}
```

输出：

```text
加法
```

### ② 不能直接匹配小数

错误写法：

```c
double score = 3.14;

switch (score) {
    case 3.14:
        printf("pi\n");
        break;
}
```

原因：

```text
switch 表达式不能是 double。
case 后面也不能写浮点常量。
```

### ③ 不能直接匹配字符串

错误写法：

```c
char name[] = "Tom";

switch (name) {
    case "Tom":
        printf("Tom\n");
        break;
}
```

原因：

```text
C 语言中字符串不是基本整数值。
switch 不能直接比较字符串内容。
字符串比较应该使用 strcmp。
```

正确思路：

```c
#include <stdio.h>
#include <string.h>

int main() {
    char name[] = "Tom";

    if (strcmp(name, "Tom") == 0) {
        printf("Tom\n");
    }

    return 0;
}
```

### ④ 不能直接判断范围

错误写法：

```c
int score = 85;

switch (score) {
    case score >= 90:
        printf("优秀\n");
        break;
}
```

原因：

```text
case 后面必须是常量表达式。
不能写 score >= 90 这种范围判断。
```

范围判断推荐用 if：

```c
if (score >= 90) {
    printf("优秀\n");
} else if (score >= 80) {
    printf("良好\n");
} else if (score >= 60) {
    printf("及格\n");
} else {
    printf("不及格\n");
}
```

---

# 07 | switch 和 if else 的区别

> [!abstract] 核心结论
> `switch` 适合等值匹配，`if else` 适合范围判断和复杂条件。不是所有多分支都应该用 switch。

### ① switch 适合的场景

```text
1. 菜单选项：1、2、3、4。
2. 字符命令：'y'、'n'、'q'。
3. 枚举状态：START、RUNNING、STOP。
4. 固定状态码：200、404、500。
```

示例：

```c
switch (choice) {
    case 1:
        printf("添加\n");
        break;
    case 2:
        printf("删除\n");
        break;
    case 3:
        printf("查询\n");
        break;
    default:
        printf("无效选择\n");
        break;
}
```

### ② if else 适合的场景

```text
1. 范围判断：score >= 90。
2. 多条件组合：age >= 18 && score >= 60。
3. 字符串比较：strcmp(name, "Tom") == 0。
4. 浮点数近似比较：fabs(x - 0.3) < 1e-6。
```

示例：

```c
if (score >= 90) {
    printf("优秀\n");
} else if (score >= 80) {
    printf("良好\n");
} else {
    printf("继续努力\n");
}
```

### ③ 对比总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px;">
<strong>switch 与 if else 的选择：</strong>
<ul>
  <li><strong>等值匹配：</strong> 优先考虑 <code>switch</code>。</li>
  <li><strong>范围判断：</strong> 使用 <code>if else</code>。</li>
  <li><strong>复杂逻辑：</strong> 使用 <code>if else</code>。</li>
  <li><strong>字符串比较：</strong> 使用 <code>strcmp</code> 配合 <code>if</code>。</li>
</ul>
</div>

---

# 08 | switch 与枚举 enum

> [!abstract] 核心结论
> `switch` 和 `enum` 非常适合配合使用。枚举负责定义状态名，switch 负责根据状态执行不同逻辑。

### ① 示例代码

```c
#include <stdio.h>

enum State {
    START,
    RUNNING,
    STOP
};

int main() {
    enum State state = RUNNING;

    switch (state) {
        case START:
            printf("开始状态\n");
            break;

        case RUNNING:
            printf("运行状态\n");
            break;

        case STOP:
            printf("停止状态\n");
            break;

        default:
            printf("未知状态\n");
            break;
    }

    return 0;
}
```

输出：

```text
运行状态
```

### ② 底层理解

```text
enum State {
    START,    // 默认是 0
    RUNNING,  // 默认是 1
    STOP      // 默认是 2
};
```

所以：

```text
switch 本质上还是在匹配整数。
只是 enum 让代码可读性更好。
```

### ③ 枚举配 switch 的好处

```text
1. 比直接写 0、1、2 更清晰。
2. 状态含义更明确。
3. 多状态分支更容易维护。
4. 适合状态机、菜单系统、错误码处理。
```

---

# 09 | switch 常见错误

> [!abstract] 核心结论
> `switch` 最常见错误包括忘记 break、case 后写变量、case 重复、用 switch 判断范围、误以为 default 必须放最后。

### ① 错误 1：忘记 break

错误写法：

```c
switch (num) {
    case 1:
        printf("一\n");
    case 2:
        printf("二\n");
}
```

问题：

```text
匹配 case 1 后，会继续执行 case 2。
```

正确写法：

```c
switch (num) {
    case 1:
        printf("一\n");
        break;

    case 2:
        printf("二\n");
        break;
}
```

---

### ② 错误 2：case 后面写变量

错误写法：

```c
int x = 1;
int num = 1;

switch (num) {
    case x:
        printf("匹配\n");
        break;
}
```

原因：

```text
case 后面必须是常量表达式，不能是普通变量。
```

正确写法：

```c
#define X 1

switch (num) {
    case X:
        printf("匹配\n");
        break;
}
```

或者：

```c
const int x = 1;
```

注意：

```text
在 C 语言中，const int x = 1 通常不一定能作为 case 标签。
更稳的是使用 #define 或 enum。
```

---

### ③ 错误 3：case 值重复

错误写法：

```c
switch (num) {
    case 1:
        printf("A\n");
        break;

    case 1:
        printf("B\n");
        break;
}
```

问题：

```text
同一个 switch 中，case 常量不能重复。
```

---

### ④ 错误 4：用 switch 判断范围

错误写法：

```c
switch (score) {
    case 90:
    case 91:
    case 92:
        printf("优秀\n");
        break;
}
```

问题：

```text
虽然可以列举固定值，但范围很大时非常不适合。
成绩等级、年龄范围等场景应该使用 if else。
```

正确：

```c
if (score >= 90) {
    printf("优秀\n");
} else if (score >= 80) {
    printf("良好\n");
}
```

---

### ⑤ 错误 5：以为 default 必须在最后

```c
switch (num) {
    default:
        printf("默认\n");
        break;

    case 1:
        printf("一\n");
        break;
}
```

说明：

```text
default 不一定必须放最后。
但为了可读性，强烈推荐放最后。
```

---

# 10 | switch 总结

> [!abstract] 核心结论
> `switch` 的核心是“一个表达式，多种固定值匹配”。它适合菜单、状态码、枚举状态，不适合范围、字符串和复杂逻辑。

### ① switch 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>switch 语句核心总结：</strong>
<ul>
  <li><strong>switch：</strong> 根据表达式的值选择分支。</li>
  <li><strong>case：</strong> 匹配固定常量值。</li>
  <li><strong>break：</strong> 跳出整个 switch，防止继续向下执行。</li>
  <li><strong>default：</strong> 所有 case 不匹配时执行。</li>
  <li><strong>适合场景：</strong> 菜单、状态码、枚举、字符命令。</li>
  <li><strong>不适合场景：</strong> 范围判断、字符串比较、复杂条件组合。</li>
</ul>
</div>

### ② switch 模板速查

```c
switch (变量或表达式) {
    case 值1:
        执行代码1;
        break;

    case 值2:
        执行代码2;
        break;

    case 值3:
        执行代码3;
        break;

    default:
        默认执行代码;
        break;
}
```

### ③ 菜单模板

```c
#include <stdio.h>

int main() {
    int choice;

    printf("1. 添加\n");
    printf("2. 删除\n");
    printf("3. 查询\n");
    printf("请选择：");

    scanf("%d", &choice);

    switch (choice) {
        case 1:
            printf("执行添加\n");
            break;

        case 2:
            printf("执行删除\n");
            break;

        case 3:
            printf("执行查询\n");
            break;

        default:
            printf("无效选择\n");
            break;
    }

    return 0;
}
```

> [!tip] 记忆口诀
> **switch 看一个值，case 找固定值；break 不写会穿透，default 负责兜底。范围判断用 if，等值菜单用 switch。**