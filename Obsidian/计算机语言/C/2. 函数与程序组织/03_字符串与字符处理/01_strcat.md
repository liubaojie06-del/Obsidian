---
tags: [C语言, strcat, 字符串拼接, 字符数组, 指针, 内存, 标准库函数]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | strcat：把一个字符串追加到另一个字符串后面

> [!abstract] 核心结论
> `strcat` 是 C 语言字符串拼接函数，用来把源字符串 `src` 追加到目标字符串 `dest` 的末尾。它会先找到 `dest` 原来的 `'\0'`，再从这里开始复制 `src`，最后重新补上新的 `'\0'`。

### ① 底层原理：不是重新创建字符串，而是在目标空间后面继续写

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>strcat 的底层本质：</strong>
<ul>
  <li><strong>头文件：</strong> 使用 <code>strcat</code> 需要包含 <code>&lt;string.h&gt;</code>。</li>
  <li><strong>作用：</strong> 把 <code>src</code> 字符串追加到 <code>dest</code> 字符串末尾。</li>
  <li><strong>第一步：</strong> 先扫描 <code>dest</code>，找到原来的字符串结束符 <code>'\0'</code>。</li>
  <li><strong>第二步：</strong> 从 <code>dest</code> 的 <code>'\0'</code> 位置开始复制 <code>src</code>。</li>
  <li><strong>核心风险：</strong> <code>strcat</code> 不检查目标空间是否足够，空间不足会越界写入。</li>
</ul>
</div>

### ② 函数原型

```c
char *strcat(char *dest, const char *src);
```

含义：

```text
dest：目标字符串，也是拼接后的最终字符串存放位置。
src：源字符串，要追加到 dest 后面的内容。
返回值：返回 dest 的地址。
```

### ③ 基本示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[20] = "hello";

    strcat(str, " world");

    printf("%s\n", str);

    return 0;
}
```

输出：

```text
hello world
```

### ④ 一句话理解

```text
strcat(dest, src) = 找到 dest 的结尾，把 src 接到后面。
```

> [!tip] 记忆口诀
> **strcat 先找尾，再追加；目标空间要够大，结尾零会重写。**

---

# 02 | strcat 拼接过程：覆盖旧的 '\0'，写入新的 '\0'

> [!abstract] 核心结论
> `strcat` 拼接时，会覆盖 `dest` 原来的 `'\0'`，然后把 `src` 的字符一个个复制过来，最后把 `src` 的 `'\0'` 也复制到新的末尾。

### ① 拼接前

```c
char dest[20] = "abc";
char src[] = "XYZ";
```

底层：

```text
dest:
'a' 'b' 'c' '\0' ? ? ? ? ...

src:
'X' 'Y' 'Z' '\0'
```

### ② 执行拼接

```c
strcat(dest, src);
```

过程：

```text
1. 找到 dest[3] 的 '\0'。
2. 从 dest[3] 开始写入 'X'。
3. dest[4] 写入 'Y'。
4. dest[5] 写入 'Z'。
5. dest[6] 写入 '\0'。
```

### ③ 拼接后

```text
dest:
'a' 'b' 'c' 'X' 'Y' 'Z' '\0' ...
```

也就是：

```text
"abcXYZ"
```

### ④ 完整示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[20] = "abc";
    char src[] = "XYZ";

    strcat(dest, src);

    printf("%s\n", dest);

    return 0;
}
```

输出：

```text
abcXYZ
```

### ⑤ 重点理解

```text
strcat 不是在 dest 后面另开一块新空间。
它是在 dest 原有数组空间里继续写。
```

所以：

```text
dest 必须提前准备足够大的空间。
```

> [!tip] 记忆口诀
> **原来的 '\0' 是拼接入口，新的 '\0' 是拼接终点。**

---

# 03 | strcat 的目标空间必须足够大

> [!abstract] 核心结论
> `strcat` 不会检查 `dest` 剩余空间是否足够。目标数组必须能容纳原字符串、追加字符串和最后的 `'\0'`，否则就会发生缓冲区溢出。

### ① 正确容量

```c
char dest[20] = "hello";

strcat(dest, " world");
```

需要空间：

```text
"hello"       长度 5
" world"      长度 6
'\0'          1 个
总共需要      12 个 char
```

`dest[20]` 足够。

### ② 错误容量

```c
char dest[10] = "hello";

strcat(dest, " world");  // 错误，空间不够
```

需要：

```text
5 + 6 + 1 = 12 个 char
```

但：

```text
dest 只有 10 个 char。
```

后果：

```text
越界写入。
破坏其他变量。
程序崩溃。
安全漏洞。
```

### ③ 安全检查示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[20] = "hello";
    const char *src = " world";

    if (strlen(dest) + strlen(src) + 1 <= sizeof(dest)) {
        strcat(dest, src);
        printf("%s\n", dest);
    } else {
        printf("目标空间不足\n");
    }

    return 0;
}
```

输出：

```text
hello world
```

### ④ 计算公式

```text
目标空间至少需要：
strlen(dest) + strlen(src) + 1
```

其中：

```text
+1 是给最后的 '\0' 留位置。
```

### ⑤ 重点

```text
strcat 只负责拼接。
不会替你判断数组大小。
```

> [!tip] 记忆口诀
> **拼接空间要算清：原长度 + 新长度 + 结尾零。**

---

# 04 | strcat 的 dest 必须已经是合法字符串

> [!abstract] 核心结论
> `strcat` 会先扫描 `dest`，直到找到 `'\0'`。所以 `dest` 必须本来就是一个合法的 C 字符串。如果 `dest` 没有初始化或没有 `'\0'`，`strcat` 会失控扫描。

### ① 正确写法

```c
char dest[20] = "hello";

strcat(dest, " world");
```

这里：

```text
dest 已经是合法字符串。
里面有 '\0'。
```

### ② 错误写法：未初始化

```c
char dest[20];

strcat(dest, "hello");  // 错误
```

问题：

```text
dest 没有初始化。
里面是随机值。
strcat 找不到可靠的 '\0'。
```

可能导致：

```text
越界读取。
越界写入。
程序崩溃。
```

### ③ 正确初始化为空字符串

```c
char dest[20] = "";

strcat(dest, "hello");
```

这里：

```text
dest[0] = '\0'
```

表示：

```text
dest 是一个空字符串。
```

然后可以安全追加。

### ④ 完整示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[20] = "";

    strcat(dest, "hello");
    strcat(dest, " ");
    strcat(dest, "world");

    printf("%s\n", dest);

    return 0;
}
```

输出：

```text
hello world
```

### ⑤ 重点理解

```text
strcat 不是从 dest[0] 开始写。
它是先找 dest 的 '\0'，再从那里开始写。
```

所以：

```text
dest 必须先有一个正确的 '\0'。
```

> [!tip] 记忆口诀
> **strcat 先找旧结尾；目标没结尾，拼接就失控。**

---

# 05 | strcat 和 strcpy 的区别

> [!abstract] 核心结论
> `strcpy` 是覆盖复制，从目标开头开始写；`strcat` 是追加拼接，从目标原来的 `'\0'` 位置开始写。一个是替换内容，一个是接到后面。

### ① strcpy

```c
strcpy(dest, src);
```

含义：

```text
把 src 完整复制到 dest。
从 dest[0] 开始覆盖。
```

示例：

```c
char str[20] = "hello";

strcpy(str, "world");
```

结果：

```text
str = "world"
```

### ② strcat

```c
strcat(dest, src);
```

含义：

```text
把 src 追加到 dest 后面。
从 dest 原来的 '\0' 位置开始写。
```

示例：

```c
char str[20] = "hello";

strcat(str, "world");
```

结果：

```text
str = "helloworld"
```

### ③ 对比代码

```c
#include <stdio.h>
#include <string.h>

int main() {
    char a[20] = "hello";
    char b[20] = "hello";

    strcpy(a, "world");
    strcat(b, "world");

    printf("a = %s\n", a);
    printf("b = %s\n", b);

    return 0;
}
```

输出：

```text
a = world
b = helloworld
```

### ④ 对比表

| 函数 | 作用 | 写入位置 | 结果 |
| :--- | :--- | :--- | :--- |
| `strcpy(dest, src)` | 复制 | 从 `dest[0]` 开始 | 覆盖原内容 |
| `strcat(dest, src)` | 拼接 | 从 `dest` 原 `'\0'` 开始 | 保留原内容并追加 |

### ⑤ 重点

```text
strcpy 要求 dest 有可写空间。
strcat 除了要求 dest 有可写空间，还要求 dest 原本就是合法字符串。
```

> [!tip] 记忆口诀
> **strcpy 是覆盖，strcat 是接尾；一个从头写，一个找尾写。**

---

# 06 | strcat 和指针：目标必须指向可写空间

> [!abstract] 核心结论
> `strcat` 的目标参数必须指向一块可写、并且已经包含合法字符串的内存。如果目标指针没有分配空间，或者指向字符串常量，就不能使用 `strcat`。

### ① 正确：目标是字符数组

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[30] = "hello";

    strcat(str, " world");

    printf("%s\n", str);

    return 0;
}
```

输出：

```text
hello world
```

### ② 错误：目标指针未初始化

```c
char *p;

strcat(p, "hello");  // 错误
```

原因：

```text
p 没有指向有效可写空间。
```

### ③ 错误：目标指向字符串常量

```c
char *p = "hello";

strcat(p, " world");  // 错误
```

原因：

```text
p 指向字符串常量。
字符串常量通常在只读区。
不能往后追加内容。
```

### ④ 正确：动态分配空间

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char *p = malloc(30);

    if (p == NULL) {
        return 1;
    }

    strcpy(p, "hello");
    strcat(p, " world");

    printf("%s\n", p);

    free(p);

    return 0;
}
```

输出：

```text
hello world
```

### ⑤ 为什么要先 strcpy

```c
char *p = malloc(30);
```

此时：

```text
p 指向可写空间。
但这块空间里的内容是未初始化的。
```

所以不能直接：

```c
strcat(p, "hello");
```

应该先让它成为合法字符串：

```c
strcpy(p, "hello");
```

或者：

```c
p[0] = '\0';
strcat(p, "hello");
```

> [!tip] 记忆口诀
> **strcat 的目标要两条件：空间能写，里面已有合法字符串。**

---

# 07 | strcat 返回值

> [!abstract] 核心结论
> `strcat` 的返回值是目标字符串地址，也就是 `dest`。拼接完成后，返回的地址和传入的目标地址相同。

### ① 返回值类型

```c
char *strcat(char *dest, const char *src);
```

返回：

```text
dest
```

### ② 示例代码

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[20] = "hello";

    char *ret = strcat(str, " world");

    printf("str = %s\n", str);
    printf("ret = %s\n", ret);

    return 0;
}
```

输出：

```text
str = hello world
ret = hello world
```

### ③ 直接打印返回值

```c
char str[20] = "hello";

printf("%s\n", strcat(str, " world"));
```

输出：

```text
hello world
```

### ④ 返回 dest 的意义

这样可以：

```text
作为表达式继续使用。
符合字符串库函数风格。
方便链式处理。
```

### ⑤ 初学建议

推荐分开写：

```c
strcat(str, " world");
printf("%s\n", str);
```

这样：

```text
逻辑更清楚。
更容易检查空间是否足够。
```

> [!tip] 记忆口诀
> **strcat 拼完返回 dest，返回的是目标地址，不是新开空间。**

---

# 08 | strcat 和 strncat 的区别

> [!abstract] 核心结论
> `strcat` 会把整个源字符串追加到目标字符串后面；`strncat` 最多追加指定数量的字符，并且会在末尾补 `'\0'`。但 `strncat` 仍然需要自己保证目标剩余空间足够。

### ① strcat

```c
strcat(dest, src);
```

特点：

```text
追加完整 src 字符串。
直到遇到 src 的 '\0'。
不检查 dest 空间。
```

### ② strncat

```c
strncat(dest, src, n);
```

特点：

```text
最多追加 src 中的 n 个字符。
最后会补 '\0'。
```

### ③ 示例代码

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[20] = "hello";

    strncat(str, " world", 3);

    printf("%s\n", str);

    return 0;
}
```

输出：

```text
hello wo
```

解释：

```text
只追加了 " world" 的前 3 个字符：
空格、w、o。
```

### ④ strncat 也要留空间

如果目标数组是：

```c
char dest[10] = "hello";
```

剩余可用空间：

```text
10 - strlen("hello") - 1 = 4
```

最多只能追加：

```text
4 个普通字符
```

因为还要保留：

```text
最后的 '\0'
```

### ⑤ 安全写法

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[10] = "hello";
    const char *src = " world";

    size_t remain = sizeof(dest) - strlen(dest) - 1;

    strncat(dest, src, remain);

    printf("%s\n", dest);

    return 0;
}
```

输出：

```text
hello wor
```

> [!tip] 记忆口诀
> **strcat 全接，strncat 限量接；但空间还要自己算。**

---

# 09 | strcat 常见错误

> [!abstract] 核心结论
> `strcat` 常见错误包括目标空间不足、目标字符串未初始化、目标指向只读字符串、源字符串没有 `'\0'`、源和目标内存重叠。

### ① 错误 1：目标空间不足

```c
char dest[8] = "hello";

strcat(dest, " world");  // 错误
```

原因：

```text
"hello world" 需要 12 个 char，包括 '\0'。
dest 只有 8 个。
```

### ② 错误 2：目标未初始化

```c
char dest[20];

strcat(dest, "hello");  // 错误
```

原因：

```text
dest 里面没有可靠的 '\0'。
strcat 不知道从哪里开始追加。
```

正确：

```c
char dest[20] = "";
strcat(dest, "hello");
```

### ③ 错误 3：目标是字符串常量

```c
char *dest = "hello";

strcat(dest, " world");  // 错误
```

原因：

```text
字符串常量通常不可写。
```

### ④ 错误 4：源字符串没有 '\0'

```c
char src[3] = {'a', 'b', 'c'};
char dest[20] = "hello";

strcat(dest, src);  // 错误
```

原因：

```text
src 不是合法 C 字符串。
strcat 会继续往后读，直到偶然遇到 '\0'。
```

### ⑤ 错误 5：源和目标重叠

```c
char str[30] = "hello world";

strcat(str, str + 5);  // 不建议，存在重叠风险
```

原因：

```text
strcat 不适合处理源和目标重叠的情况。
行为可能不可靠。
```

> [!tip] 记忆口诀
> **目标要够大，目标先成串；源也要有零，重叠别乱拼。**

---

# 10 | strcat 总结

> [!abstract] 核心结论
> `strcat` 的底层核心是“先找到目标字符串末尾的 `'\0'`，再从该位置开始复制源字符串，最后写入新的 `'\0'`”。它适合字符串拼接，但不会自动检查空间大小，使用时必须自己保证目标空间足够。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>strcat 核心总结：</strong>
<ul>
  <li><strong>头文件：</strong> <code>#include &lt;string.h&gt;</code>。</li>
  <li><strong>原型：</strong> <code>char *strcat(char *dest, const char *src);</code></li>
  <li><strong>作用：</strong> 把 <code>src</code> 追加到 <code>dest</code> 末尾。</li>
  <li><strong>写入位置：</strong> 从 <code>dest</code> 原来的 <code>'\0'</code> 位置开始写。</li>
  <li><strong>返回值：</strong> 返回 <code>dest</code>。</li>
  <li><strong>目标要求：</strong> <code>dest</code> 必须是可写空间。</li>
  <li><strong>字符串要求：</strong> <code>dest</code> 和 <code>src</code> 都必须是合法 C 字符串。</li>
  <li><strong>空间要求：</strong> 至少需要 <code>strlen(dest) + strlen(src) + 1</code> 个 char。</li>
  <li><strong>和 strcpy：</strong> <code>strcpy</code> 覆盖复制，<code>strcat</code> 追加拼接。</li>
  <li><strong>主要风险：</strong> 不检查目标剩余空间，容易缓冲区溢出。</li>
</ul>
</div>

### ② 最底层一句话

```text
strcat = 找到 dest 的结尾 '\0'，把 src 从这里接上去，并写入新的结尾 '\0'。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **strcat 找尾巴，src 接后面；目标先有零，空间要够用。**