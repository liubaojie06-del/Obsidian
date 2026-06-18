---
tags:
  - C语言
  - strlen
  - 字符串长度
  - 字符数组
  - 指针
  - 标准库函数
type: 知识卡片
date: 2026-05-23
cssclasses:
  - cards
  - clean-embeds
---

# 01 | strlen：计算字符串有效字符个数

> [!abstract] 核心结论
> `strlen` 是 C 语言中用于计算字符串长度的函数。它从字符串首地址开始逐个统计字符，直到遇到字符串结束符 `'\0'` 为止。返回值不包含 `'\0'`。

### ① 底层原理：strlen 只认 `'\0'`

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>strlen 的底层本质：</strong>
<ul>
  <li><strong>头文件：</strong> 使用 <code>strlen</code> 需要包含 <code>&lt;string.h&gt;</code>。</li>
  <li><strong>作用：</strong> 计算字符串中有效字符的个数。</li>
  <li><strong>停止条件：</strong> 从首地址开始扫描，遇到 <code>'\0'</code> 停止。</li>
  <li><strong>不包含结尾零：</strong> 返回值不统计 <code>'\0'</code>。</li>
  <li><strong>风险点：</strong> 如果字符串没有 <code>'\0'</code>，<code>strlen</code> 会继续向后读，直到偶然遇到 <code>'\0'</code>。</li>
</ul>
</div>

### ② 函数原型

```c
size_t strlen(const char *str);
```

含义：

```text
str：字符串首地址。
返回值：字符串有效字符个数，不包含 '\0'。
返回类型：size_t，本质上是无符号整数类型。
```

### ③ 基本示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[] = "hello";

    printf("%zu\n", strlen(str));

    return 0;
}
```

输出：

```text
5
```

原因：

```text
"hello" 有 5 个有效字符。
底层实际存储是：
'h' 'e' 'l' 'l' 'o' '\0'

strlen 只返回 5，不包含 '\0'。
```

> [!tip] 记忆口诀
> **strlen 数字符，遇零就停；结尾零不计入长度。**

---

# 02 | strlen 的扫描过程

> [!abstract] 核心结论
> `strlen` 不是读取数组容量，而是从传入地址开始一个字符一个字符向后扫描，直到遇到 `'\0'`。

### ① 示例字符串

```c
char str[] = "abc";
```

底层存储：

```text
str:
┌────┬────┬────┬────┐
│ a  │ b  │ c  │ \0 │
└────┴────┴────┴────┘
```

### ② strlen 过程

```c
strlen(str);
```

执行逻辑：

```text
检查 str[0] = 'a'，不是 '\0'，计数 1
检查 str[1] = 'b'，不是 '\0'，计数 2
检查 str[2] = 'c'，不是 '\0'，计数 3
检查 str[3] = '\0'，停止
返回 3
```

### ③ 等价理解代码

```c
size_t my_strlen(const char *s) {
    size_t count = 0;

    while (s[count] != '\0') {
        count++;
    }

    return count;
}
```

### ④ 指针版理解

```c
size_t my_strlen(const char *s) {
    const char *p = s;

    while (*p != '\0') {
        p++;
    }

    return p - s;
}
```

### ⑤ 重点

```text
strlen 不知道数组有多大。
strlen 只知道从哪里开始。
strlen 靠 '\0' 判断字符串在哪里结束。
```

> [!tip] 记忆口诀
> **strlen 不看容量，只从地址往后找零。**

---

# 03 | strlen 和 sizeof 的区别

> [!abstract] 核心结论
> `strlen` 计算字符串有效长度，不包含 `'\0'`；`sizeof` 计算对象占用的字节数。如果是字符数组，`sizeof` 包含数组完整容量；如果是指针，`sizeof` 得到的是指针大小。

### ① 字符数组示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[] = "hello";

    printf("strlen(str) = %zu\n", strlen(str));
    printf("sizeof(str) = %zu\n", sizeof(str));

    return 0;
}
```

输出通常是：

```text
strlen(str) = 5
sizeof(str) = 6
```

原因：

```text
strlen 统计有效字符：h e l l o，一共 5 个。
sizeof 统计数组总字节：h e l l o \0，一共 6 个。
```

### ② 固定容量数组示例

```c
char str[20] = "hello";
```

结果：

```text
strlen(str) = 5
sizeof(str) = 20
```

原因：

```text
strlen 只数到 '\0'。
sizeof 计算整个数组容量。
```

### ③ 指针示例

```c
const char *p = "hello";
```

```c
strlen(p);
```

结果：

```text
5
```

```c
sizeof(p);
```

结果：

```text
得到指针变量本身的大小。
常见 64 位系统是 8。
不是字符串长度。
```

### ④ 对比表

| 表达式 | 计算内容 | 是否包含 `'\0'` | 典型用途 |
| :--- | :--- | :--- | :--- |
| `strlen(str)` | 字符串有效字符数 | 不包含 | 判断字符串长度 |
| `sizeof(str)` | 对象占用字节数 | 数组时包含完整容量 | 判断数组容量 / 类型大小 |
| `sizeof(p)` | 指针变量大小 | 无关 | 判断指针类型大小 |

### ⑤ 重点区别

```text
strlen 是运行时扫描字符串。
sizeof 多数情况下是编译期计算对象大小。
```

> [!tip] 记忆口诀
> **strlen 看内容，sizeof 看空间；strlen 不算零，sizeof 数容量。**

---

# 04 | strlen 不包含 `'\0'`

> [!abstract] 核心结论
> `strlen` 的返回值只表示字符串中有效字符个数，不包含字符串结束符 `'\0'`。如果要给字符串分配空间，通常需要 `strlen(src) + 1`。

### ① 示例

```c
char str[] = "hello";
```

底层：

```text
'h' 'e' 'l' 'l' 'o' '\0'
```

```c
strlen(str)
```

返回：

```text
5
```

但实际占用字符数：

```text
6
```

因为：

```text
还要保存 '\0'。
```

### ② 复制字符串时要加 1

```c
char src[] = "hello";
char dest[5];

strcpy(dest, src);  // 错误，空间不够
```

原因：

```text
strlen(src) = 5
但 strcpy 需要复制：
'h' 'e' 'l' 'l' 'o' '\0'
一共 6 个字符。
```

正确：

```c
char dest[6];
strcpy(dest, src);
```

或者：

```c
char dest[strlen(src) + 1];
strcpy(dest, src);
```

### ③ malloc 分配字符串空间

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    const char *src = "hello";

    char *p = malloc(strlen(src) + 1);

    if (p == NULL) {
        return 1;
    }

    strcpy(p, src);

    printf("%s\n", p);

    free(p);

    return 0;
}
```

输出：

```text
hello
```

### ④ 为什么加 1

```text
+1 是给字符串结束符 '\0' 留空间。
```

### ⑤ 常见错误

```c
char *p = malloc(strlen(src));
strcpy(p, src);  // 错误，少了 '\0' 的空间
```

> [!tip] 记忆口诀
> **strlen 不含零，开空间要加一。**

---

# 05 | strlen 的参数必须是合法字符串

> [!abstract] 核心结论
> `strlen` 的参数必须指向一个以 `'\0'` 结尾的合法 C 字符串。如果传入的字符数组没有 `'\0'`，`strlen` 会越界读取，结果不可预测。

### ① 正确示例

```c
char str[] = "abc";
printf("%zu\n", strlen(str));
```

这里：

```text
str 自动包含 '\0'。
```

底层：

```text
'a' 'b' 'c' '\0'
```

所以安全。

### ② 错误示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[3] = {'a', 'b', 'c'};

    printf("%zu\n", strlen(str));

    return 0;
}
```

问题：

```text
str 中没有 '\0'。
strlen 会继续往数组后面读。
直到偶然遇到 '\0'。
```

后果：

```text
输出结果不确定。
可能越界读取。
可能崩溃。
```

### ③ 正确写法

```c
char str[4] = {'a', 'b', 'c', '\0'};
```

或者：

```c
char str[] = "abc";
```

### ④ 空字符串

```c
char str[] = "";
```

底层：

```text
'\0'
```

所以：

```c
strlen(str)
```

返回：

```text
0
```

### ⑤ 重点

```text
字符数组不一定是字符串。
只有以 '\0' 结尾的字符数组，才是合法 C 字符串。
```

> [!tip] 记忆口诀
> **有字符不一定是字符串，有结尾零才是字符串。**

---

# 06 | strlen 和中文字符

> [!abstract] 核心结论
> `strlen` 计算的是字节数，不是人眼看到的字符个数。中文在 UTF-8 编码中通常一个汉字占多个字节，所以 `strlen("你好")` 的结果通常不是 2。

### ① 示例代码

```c
#include <stdio.h>
#include <string.h>

int main() {
    const char *s = "你好";

    printf("%zu\n", strlen(s));

    return 0;
}
```

在 UTF-8 环境中，常见输出：

```text
6
```

原因：

```text
"你" 通常占 3 个字节。
"好" 通常占 3 个字节。
所以总共 6 个字节。
```

### ② strlen 统计什么

```text
strlen 统计的是从首地址到 '\0' 前面的字节数量。
```

不是：

```text
汉字个数。
字符显示宽度。
屏幕占几列。
```

### ③ 英文字符串

```c
strlen("abc")
```

通常返回：

```text
3
```

因为 ASCII 字符通常一个字符占 1 字节。

### ④ 中文字符串

```c
strlen("中国")
```

UTF-8 下通常返回：

```text
6
```

因为：

```text
每个汉字常见 3 字节。
```

### ⑤ 重点

```text
strlen 只懂字节和 '\0'。
它不理解 Unicode 字符数量。
```

> [!tip] 记忆口诀
> **strlen 数字节，不数汉字；中文一个字，可能多个字节。**

---

# 07 | strlen 的返回类型 size_t

> [!abstract] 核心结论
> `strlen` 返回值类型是 `size_t`，它是无符号整数类型，专门用于表示大小和长度。打印时推荐使用 `%zu`。

### ① 函数原型

```c
size_t strlen(const char *str);
```

其中：

```text
size_t 是无符号整数类型。
通常用于表示对象大小、数组长度、字符串长度。
```

### ② 推荐打印方式

```c
printf("%zu\n", strlen("hello"));
```

输出：

```text
5
```

### ③ 不推荐写法

```c
printf("%d\n", strlen("hello"));
```

问题：

```text
strlen 返回 size_t。
%d 用于 int。
类型不匹配。
```

### ④ size_t 是无符号类型

所以要注意这种写法：

```c
size_t len = strlen(str);

if (len - 1 >= 0) {
    // ...
}
```

问题：

```text
size_t 是无符号。
如果 len 是 0，len - 1 会发生无符号下溢，变成很大的数。
```

### ⑤ 安全写法

```c
size_t len = strlen(str);

if (len > 0) {
    printf("last char = %c\n", str[len - 1]);
}
```

> [!tip] 记忆口诀
> **strlen 返回 size_t，打印用 %zu；无符号做减法，先判断大于零。**

---

# 08 | strlen 常见使用场景

> [!abstract] 核心结论
> `strlen` 常用于判断字符串长度、检查数组空间是否足够、遍历字符串、动态分配字符串空间、限制输入长度等场景。

### ① 判断字符串是否为空

```c
if (strlen(str) == 0) {
    printf("空字符串\n");
}
```

更直接写法：

```c
if (str[0] == '\0') {
    printf("空字符串\n");
}
```

### ② 遍历字符串

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[] = "hello";
    size_t len = strlen(str);

    for (size_t i = 0; i < len; i++) {
        printf("%c\n", str[i]);
    }

    return 0;
}
```

### ③ 检查空间是否足够

```c
if (strlen(src) + 1 <= sizeof(dest)) {
    strcpy(dest, src);
}
```

### ④ 拼接前检查空间

```c
if (strlen(dest) + strlen(src) + 1 <= sizeof(dest)) {
    strcat(dest, src);
}
```

### ⑤ 动态分配

```c
char *p = malloc(strlen(src) + 1);
```

含义：

```text
给字符串内容和 '\0' 都分配空间。
```

> [!tip] 记忆口诀
> **复制看 strlen + 1，拼接看两个 strlen + 1。**

---

# 09 | strlen 常见错误

> [!abstract] 核心结论
> `strlen` 常见错误包括传入未初始化数组、传入没有 `'\0'` 的字符数组、把 `strlen` 当数组容量、循环中反复调用导致效率低、忽略返回值是无符号类型。

### ① 错误 1：未初始化字符数组

```c
char str[20];

printf("%zu\n", strlen(str));  // 错误
```

原因：

```text
str 没有初始化。
里面可能没有可靠的 '\0'。
```

正确：

```c
char str[20] = "";
```

### ② 错误 2：字符数组没有 `'\0'`

```c
char str[3] = {'a', 'b', 'c'};

strlen(str);  // 错误
```

正确：

```c
char str[4] = {'a', 'b', 'c', '\0'};
```

### ③ 错误 3：把 strlen 当数组容量

```c
char str[20] = "hello";

printf("%zu\n", strlen(str));  // 5
```

但数组容量是：

```text
20
```

不是：

```text
5
```

容量要看：

```c
sizeof(str)
```

### ④ 错误 4：循环里反复调用 strlen

不推荐：

```c
for (int i = 0; i < strlen(str); i++) {
    printf("%c\n", str[i]);
}
```

原因：

```text
strlen 每次都要从头扫描字符串。
字符串长时效率较差。
```

推荐：

```c
size_t len = strlen(str);

for (size_t i = 0; i < len; i++) {
    printf("%c\n", str[i]);
}
```

### ⑤ 错误 5：无符号下溢

错误：

```c
size_t len = strlen(str);

for (size_t i = len - 1; i >= 0; i--) {
    printf("%c\n", str[i]);
}
```

问题：

```text
size_t 是无符号。
i >= 0 永远成立。
可能死循环。
```

安全写法：

```c
size_t len = strlen(str);

for (size_t i = len; i > 0; i--) {
    printf("%c\n", str[i - 1]);
}
```

> [!tip] 记忆口诀
> **strlen 参数要成串，容量别用它来算；size_t 无符号，倒序循环要小心。**

---

# 10 | strlen 总结

> [!abstract] 核心结论
> `strlen` 的底层核心是“从字符串首地址开始扫描，直到遇到 `'\0'`，返回前面经过的字节数”。它不包含结尾零，不检查数组容量，也不理解中文字符数量，只负责按字节数合法 C 字符串长度。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>strlen 核心总结：</strong>
<ul>
  <li><strong>头文件：</strong> <code>#include &lt;string.h&gt;</code>。</li>
  <li><strong>原型：</strong> <code>size_t strlen(const char *str);</code></li>
  <li><strong>作用：</strong> 计算字符串有效字符长度。</li>
  <li><strong>停止条件：</strong> 遇到 <code>'\0'</code> 停止。</li>
  <li><strong>返回值：</strong> 返回 <code>'\0'</code> 前面的字节数。</li>
  <li><strong>不包含：</strong> 不包含字符串结尾的 <code>'\0'</code>。</li>
  <li><strong>参数要求：</strong> 必须是合法 C 字符串。</li>
  <li><strong>和 sizeof：</strong> <code>strlen</code> 看字符串内容，<code>sizeof</code> 看对象空间大小。</li>
  <li><strong>中文问题：</strong> <code>strlen</code> 统计字节数，不统计汉字个数。</li>
  <li><strong>空间分配：</strong> 保存字符串通常需要 <code>strlen(str) + 1</code> 个 char。</li>
</ul>
</div>

### ② 最底层一句话

```text
strlen = 从字符串首地址开始数普通字节，数到 '\0' 停止，但不把 '\0' 算进去。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **strlen 只认结尾零，返回长度不含零；它数的是字节数，不是数组容量。**