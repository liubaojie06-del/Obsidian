---
tags:
  - C语言
  - strcmp
  - 字符串比较
  - 字符数组
  - 指针
  - 标准库函数
type: 知识卡片
date: 2026-05-23
cssclasses:
  - cards
  - clean-embeds
---

# 01 | strcmp：比较两个字符串的大小

> [!abstract] 核心结论
> `strcmp` 是 C 语言中用于比较两个字符串内容的函数。它从两个字符串首字符开始逐个比较 ASCII / 字符编码值，直到遇到不同字符或遇到字符串结束符 `'\0'` 为止。

### ① 底层原理：比较的是字符内容，不是地址

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>strcmp 的底层本质：</strong>
<ul>
  <li><strong>头文件：</strong> 使用 <code>strcmp</code> 需要包含 <code>&lt;string.h&gt;</code>。</li>
  <li><strong>作用：</strong> 比较两个字符串内容是否相同，以及谁大谁小。</li>
  <li><strong>比较方式：</strong> 从左到右逐个字符比较。</li>
  <li><strong>停止条件：</strong> 遇到不同字符，或者两个字符串都遇到 <code>'\0'</code>。</li>
  <li><strong>核心重点：</strong> <code>strcmp</code> 比较字符串内容，不能用 <code>==</code> 比较字符串内容。</li>
</ul>
</div>

### ② 函数原型

```c
int strcmp(const char *s1, const char *s2);
```

含义：

```text
s1：第一个字符串首地址。
s2：第二个字符串首地址。
返回值：比较结果。
```

### ③ 返回值规则

```text
返回 0：
两个字符串内容相同。

返回小于 0：
s1 小于 s2。

返回大于 0：
s1 大于 s2。
```

注意：

```text
不要死记返回 -1、0、1。
标准只保证小于 0、等于 0、大于 0。
```

### ④ 基本示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char a[] = "abc";
    char b[] = "abc";

    int ret = strcmp(a, b);

    printf("%d\n", ret);

    return 0;
}
```

输出：

```text
0
```

> [!tip] 记忆口诀
> **strcmp 比内容，返回看正负；相同为 0，小于负，大于正。**

---

# 02 | strcmp 的比较过程

> [!abstract] 核心结论
> `strcmp` 会从两个字符串的第 0 个字符开始比较。如果当前字符相同，就继续比较下一个字符；如果不同，就根据两个字符的编码差决定返回结果。

### ① 示例 1：完全相同

```c
strcmp("abc", "abc")
```

比较过程：

```text
'a' 和 'a' 相同，继续。
'b' 和 'b' 相同，继续。
'c' 和 'c' 相同，继续。
'\0' 和 '\0' 相同，结束。
```

结果：

```text
返回 0。
```

### ② 示例 2：中间不同

```c
strcmp("abc", "abd")
```

比较过程：

```text
'a' 和 'a' 相同，继续。
'b' 和 'b' 相同，继续。
'c' 和 'd' 不同。
```

因为：

```text
'c' < 'd'
```

所以：

```text
"abc" < "abd"
返回小于 0 的值。
```

### ③ 示例 3：前缀相同但长度不同

```c
strcmp("abc", "abcd")
```

比较过程：

```text
'a' 和 'a' 相同。
'b' 和 'b' 相同。
'c' 和 'c' 相同。
'\0' 和 'd' 不同。
```

因为：

```text
'\0' < 'd'
```

所以：

```text
"abc" < "abcd"
返回小于 0 的值。
```

### ④ 等价理解代码

```c
int my_strcmp(const char *s1, const char *s2) {
    while (*s1 != '\0' && *s1 == *s2) {
        s1++;
        s2++;
    }

    return (unsigned char)*s1 - (unsigned char)*s2;
}
```

### ⑤ 重点

```text
strcmp 不看字符串长度谁长。
它先看第一个不同字符。
第一个不同字符决定大小。
```

> [!tip] 记忆口诀
> **从左到右逐个比，谁先不同谁决定；前面全同，再看谁先遇到零。**

---

# 03 | strcmp 不能用来判断地址是否相同

> [!abstract] 核心结论
> `strcmp` 比较的是字符串内容，而 `==` 比较的是两个指针保存的地址是否相同。判断字符串内容是否相等，应该使用 `strcmp(a, b) == 0`。

### ① 错误写法

```c
char a[] = "hello";
char b[] = "hello";

if (a == b) {
    printf("same\n");
}
```

问题：

```text
a 和 b 是两个不同数组。
a 表示数组 a 的首地址。
b 表示数组 b 的首地址。
两个地址不同。
```

所以：

```text
a == b 比较的是地址，不是字符串内容。
```

### ② 正确写法

```c
#include <stdio.h>
#include <string.h>

int main() {
    char a[] = "hello";
    char b[] = "hello";

    if (strcmp(a, b) == 0) {
        printf("same\n");
    }

    return 0;
}
```

输出：

```text
same
```

### ③ 指针示例

```c
const char *p1 = "hello";
const char *p2 = "hello";
```

有些编译器可能把两个相同字符串常量合并。

所以：

```c
p1 == p2
```

可能为真，也可能不能依赖。

正确判断内容仍然是：

```c
strcmp(p1, p2) == 0
```

### ④ 对比表

| 写法 | 比较内容 | 是否适合比较字符串内容 |
| :--- | :--- | :--- |
| `a == b` | 地址是否相同 | 不适合 |
| `strcmp(a, b) == 0` | 字符串内容是否相同 | 适合 |
| `strcmp(a, b) < 0` | `a` 是否字典序小于 `b` | 适合 |
| `strcmp(a, b) > 0` | `a` 是否字典序大于 `b` | 适合 |

### ⑤ 重点

```text
字符串变量本质上经常是地址。
地址相同不等于内容判断的通用方法。
内容比较用 strcmp。
```

> [!tip] 记忆口诀
> **双等号比地址，strcmp 比内容；字符串相等看返回 0。**

---

# 04 | strcmp 返回值怎么用

> [!abstract] 核心结论
> 判断两个字符串是否相等时，用 `strcmp(a, b) == 0`；判断大小关系时，用 `< 0` 或 `> 0`。不要写成 `if (strcmp(a, b))` 后又忘记它非 0 代表不相等。

### ① 判断相等

```c
if (strcmp(a, b) == 0) {
    printf("两个字符串相等\n");
}
```

含义：

```text
strcmp 返回 0，表示内容完全相同。
```

### ② 判断不相等

```c
if (strcmp(a, b) != 0) {
    printf("两个字符串不相等\n");
}
```

### ③ 判断谁更小

```c
if (strcmp(a, b) < 0) {
    printf("a 小于 b\n");
}
```

### ④ 判断谁更大

```c
if (strcmp(a, b) > 0) {
    printf("a 大于 b\n");
}
```

### ⑤ 完整示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char a[] = "apple";
    char b[] = "banana";

    int ret = strcmp(a, b);

    if (ret == 0) {
        printf("a 等于 b\n");
    } else if (ret < 0) {
        printf("a 小于 b\n");
    } else {
        printf("a 大于 b\n");
    }

    return 0;
}
```

输出：

```text
a 小于 b
```

> [!tip] 记忆口诀
> **相等看等于零，不等看非零；大小看正负，别死记具体数。**

---

# 05 | strcmp 是按字典序比较

> [!abstract] 核心结论
> `strcmp` 的比较方式类似字典序，但它比较的是字符编码值。第一个不同字符的编码大小决定整个字符串的大小。

### ① 字典序理解

```c
strcmp("apple", "banana")
```

比较第一个字符：

```text
'a' 和 'b'
```

因为：

```text
'a' < 'b'
```

所以：

```text
"apple" < "banana"
```

### ② 不是按字符串长度比较

```c
strcmp("z", "apple")
```

虽然：

```text
"z" 长度是 1
"apple" 长度是 5
```

但是先比较第一个字符：

```text
'z' > 'a'
```

所以：

```text
"z" > "apple"
```

### ③ 大小写敏感

```c
strcmp("Apple", "apple")
```

在 ASCII 中：

```text
'A' = 65
'a' = 97
```

所以：

```text
"Apple" < "apple"
```

### ④ 数字字符也按编码比较

```c
strcmp("10", "2")
```

先比较：

```text
'1' 和 '2'
```

因为：

```text
'1' < '2'
```

所以：

```text
"10" < "2"
```

注意：

```text
这不是按整数 10 和 2 比较。
这是按字符串字符逐个比较。
```

### ⑤ 中文字符串

如果比较中文字符串：

```c
strcmp("你", "我")
```

比较的是编码字节序列，不是拼音顺序，也不是中文词典顺序。

> [!tip] 记忆口诀
> **strcmp 比字典序，实际看编码值；不是比长度，也不是比数字大小。**

---

# 06 | strcmp 与 strncmp 的区别

> [!abstract] 核心结论
> `strcmp` 比较完整字符串，直到遇到不同字符或 `'\0'`；`strncmp` 最多比较前 `n` 个字符，常用于只判断字符串前缀是否相同。

### ① strcmp

```c
strcmp(s1, s2);
```

特点：

```text
比较完整字符串。
直到不同字符或 '\0'。
```

### ② strncmp

```c
strncmp(s1, s2, n);
```

特点：

```text
最多比较前 n 个字符。
```

### ③ 示例：比较前缀

```c
#include <stdio.h>
#include <string.h>

int main() {
    char url[] = "https://example.com";

    if (strncmp(url, "https", 5) == 0) {
        printf("HTTPS 地址\n");
    }

    return 0;
}
```

输出：

```text
HTTPS 地址
```

### ④ 示例：前 3 个字符相同

```c
strcmp("abcdef", "abcxyz")
```

结果：

```text
小于 0
```

因为：

```text
'd' < 'x'
```

但：

```c
strncmp("abcdef", "abcxyz", 3)
```

结果：

```text
0
```

因为只比较前 3 个字符：

```text
'a' 'b' 'c'
```

完全相同。

### ⑤ 对比表

| 函数 | 比较范围 | 停止条件 | 常见用途 |
| :--- | :--- | :--- | :--- |
| `strcmp` | 整个字符串 | 不同字符或 `'\0'` | 判断完整字符串 |
| `strncmp` | 最多前 `n` 个字符 | 不同字符、`'\0'` 或达到 `n` | 判断前缀 |

> [!tip] 记忆口诀
> **strcmp 全部比，strncmp 限量比；判断前缀用 strncmp。**

---

# 07 | strcmp 的参数必须是合法字符串

> [!abstract] 核心结论
> `strcmp` 的两个参数都必须指向以 `'\0'` 结尾的合法 C 字符串。如果其中一个字符数组没有 `'\0'`，`strcmp` 会继续越界读取，结果不可预测。

### ① 正确示例

```c
char a[] = "abc";
char b[] = "abd";

strcmp(a, b);
```

这里：

```text
a 和 b 都自动包含 '\0'。
```

所以是合法字符串。

### ② 错误示例

```c
char a[3] = {'a', 'b', 'c'};
char b[] = "abc";

strcmp(a, b);  // 错误
```

问题：

```text
a 没有 '\0'。
strcmp 会继续向后读。
直到偶然遇到 '\0'。
```

后果：

```text
越界读取。
比较结果不确定。
可能崩溃。
```

### ③ 正确写法

```c
char a[4] = {'a', 'b', 'c', '\0'};
char b[] = "abc";

strcmp(a, b);
```

或者：

```c
char a[] = "abc";
char b[] = "abc";
```

### ④ NULL 指针不能传入

错误：

```c
char *p = NULL;

strcmp(p, "abc");  // 错误
```

原因：

```text
strcmp 会从 p 指向的地址开始读。
NULL 不是合法字符串地址。
```

### ⑤ 安全判断

```c
if (p != NULL && strcmp(p, "abc") == 0) {
    printf("匹配\n");
}
```

> [!tip] 记忆口诀
> **strcmp 两边都要成串；没有结尾零，比较会越界。**

---

# 08 | strcmp 常见使用场景

> [!abstract] 核心结论
> `strcmp` 常用于判断用户输入命令、比较密码字符串、排序字符串数组、判断文件扩展名、匹配菜单选项等。

### ① 判断命令

```c
#include <stdio.h>
#include <string.h>

int main() {
    char cmd[20];

    scanf("%19s", cmd);

    if (strcmp(cmd, "start") == 0) {
        printf("启动\n");
    } else if (strcmp(cmd, "stop") == 0) {
        printf("停止\n");
    } else {
        printf("未知命令\n");
    }

    return 0;
}
```

### ② 判断密码

```c
char password[20];

scanf("%19s", password);

if (strcmp(password, "123456") == 0) {
    printf("登录成功\n");
} else {
    printf("密码错误\n");
}
```

### ③ 字符串排序

```c
if (strcmp(names[i], names[j]) > 0) {
    // names[i] 字典序更大，可以交换
}
```

### ④ 判断文件扩展名

```c
if (strcmp(ext, ".txt") == 0) {
    printf("文本文件\n");
}
```

### ⑤ 菜单匹配

```c
if (strcmp(choice, "1") == 0) {
    printf("选择了菜单 1\n");
}
```

> [!tip] 记忆口诀
> **凡是要判断两个字符串内容是否一样，就优先想到 strcmp。**

---

# 09 | strcmp 常见错误

> [!abstract] 核心结论
> `strcmp` 常见错误包括用 `==` 比较字符串内容、忘记判断返回值等于 0、传入未初始化字符数组、传入 NULL 指针、误以为返回值只会是 -1、0、1。

### ① 错误 1：用 == 比较字符串内容

```c
if (str == "hello") {
    printf("相等\n");
}
```

问题：

```text
比较的是地址，不是内容。
```

正确：

```c
if (strcmp(str, "hello") == 0) {
    printf("相等\n");
}
```

### ② 错误 2：把 strcmp 当布尔相等

错误：

```c
if (strcmp(str, "hello")) {
    printf("相等\n");
}
```

问题：

```text
strcmp 返回 0 才表示相等。
非 0 表示不相等。
```

正确：

```c
if (strcmp(str, "hello") == 0) {
    printf("相等\n");
}
```

### ③ 错误 3：死记返回 -1 或 1

错误：

```c
if (strcmp(a, b) == -1) {
    printf("a 小于 b\n");
}
```

问题：

```text
标准只保证返回小于 0。
不保证一定是 -1。
```

正确：

```c
if (strcmp(a, b) < 0) {
    printf("a 小于 b\n");
}
```

### ④ 错误 4：传入未初始化数组

```c
char str[20];

strcmp(str, "abc");  // 错误
```

原因：

```text
str 里面没有合法字符串。
```

正确：

```c
char str[20] = "";
```

### ⑤ 错误 5：传入 NULL

```c
char *p = NULL;

strcmp(p, "abc");  // 错误
```

正确：

```c
if (p != NULL && strcmp(p, "abc") == 0) {
    printf("匹配\n");
}
```

> [!tip] 记忆口诀
> **字符串相等不是 if(strcmp)，而是 if(strcmp == 0)。**

---

# 10 | strcmp 总结

> [!abstract] 核心结论
> `strcmp` 的底层核心是“从两个字符串首地址开始逐字符比较，遇到第一个不同字符就决定大小，两个都遇到 `'\0'` 则相等”。它比较的是字符串内容，而不是地址。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>strcmp 核心总结：</strong>
<ul>
  <li><strong>头文件：</strong> <code>#include &lt;string.h&gt;</code>。</li>
  <li><strong>原型：</strong> <code>int strcmp(const char *s1, const char *s2);</code></li>
  <li><strong>作用：</strong> 比较两个字符串内容。</li>
  <li><strong>返回 0：</strong> 两个字符串相等。</li>
  <li><strong>返回小于 0：</strong> <code>s1</code> 小于 <code>s2</code>。</li>
  <li><strong>返回大于 0：</strong> <code>s1</code> 大于 <code>s2</code>。</li>
  <li><strong>比较方式：</strong> 从左到右逐字符比较编码值。</li>
  <li><strong>停止条件：</strong> 遇到不同字符，或两个字符串都到达 <code>'\0'</code>。</li>
  <li><strong>参数要求：</strong> 两个参数都必须是合法 C 字符串。</li>
  <li><strong>常见错误：</strong> 用 <code>==</code> 比内容，或忘记 <code>strcmp == 0</code> 才是相等。</li>
</ul>
</div>

### ② 最底层一句话

```text
strcmp = 从左到右比较两个字符串的字符编码，第一个不同字符决定大小，完全相同返回 0。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **strcmp 比内容，双等号比地址；相等返回零，大小看正负。**