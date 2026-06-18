---
tags: [C语言, strcpy, 字符串, 字符数组, 指针, 内存, 标准库函数]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | strcpy：把一个字符串复制到另一个字符数组中

> [!abstract] 核心结论
> `strcpy` 是 C 语言字符串复制函数，用来把源字符串中的字符逐个复制到目标空间中，直到遇到字符串结束符 `'\0'` 为止。它不会自动检查目标空间是否足够大，所以使用时必须保证目标数组容量够用。

### ① 底层原理：复制的是字符内容，不是地址

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>strcpy 的底层本质：</strong>
<ul>
  <li><strong>头文件：</strong> 使用 <code>strcpy</code> 需要包含 <code>&lt;string.h&gt;</code>。</li>
  <li><strong>作用：</strong> 把源字符串的内容复制到目标字符数组中。</li>
  <li><strong>结束条件：</strong> 一直复制到遇到 <code>'\0'</code> 为止，并且 <code>'\0'</code> 也会被复制过去。</li>
  <li><strong>目标空间：</strong> 目标数组必须足够大，否则会越界写入。</li>
  <li><strong>本质：</strong> 字符一个一个搬运，不是让两个指针指向同一块字符串。</li>
</ul>
</div>

### ② 函数原型

```c
char *strcpy(char *dest, const char *src);
```

含义：

```text
dest：目标地址，也就是复制到哪里。
src：源字符串地址，也就是从哪里复制。
返回值：返回 dest 的地址。
```

### ③ 基本示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[20];

    strcpy(str, "hello");

    printf("%s\n", str);

    return 0;
}
```

输出：

```text
hello
```

### ④ 一句话理解

```text
strcpy(dest, src) = 把 src 指向的字符串内容复制到 dest 指向的空间中。
```

> [!tip] 记忆口诀
> **源头 src 往目标 dest 搬，字符一个个复制，结尾零也要带上。**

---

# 02 | strcpy 复制过程：直到遇到 '\0'

> [!abstract] 核心结论
> `strcpy` 并不知道字符串长度，它靠 `'\0'` 判断什么时候停止复制。所以源字符串必须是一个合法的、以 `'\0'` 结尾的字符串。

### ① 示例字符串

```c
char src[] = "abc";
```

底层实际存储：

```text
'a'  'b'  'c'  '\0'
```

### ② 执行复制

```c
char dest[10];

strcpy(dest, src);
```

复制过程：

```text
第 1 次：dest[0] = 'a'
第 2 次：dest[1] = 'b'
第 3 次：dest[2] = 'c'
第 4 次：dest[3] = '\0'
复制结束
```

### ③ 内存示意

复制前：

```text
src:
┌────┬────┬────┬────┐
│ a  │ b  │ c  │ \0 │
└────┴────┴────┴────┘

dest:
┌────┬────┬────┬────┬────┐
│ ?  │ ?  │ ?  │ ?  │ ?  │ ...
└────┴────┴────┴────┴────┘
```

复制后：

```text
dest:
┌────┬────┬────┬────┬────┐
│ a  │ b  │ c  │ \0 │ ?  │ ...
└────┴────┴────┴────┴────┘
```

### ④ 为什么 '\0' 也要复制

如果不复制 `'\0'`：

```text
目标数组里就不是一个完整字符串。
printf("%s", dest) 不知道在哪里停止。
```

所以：

```text
strcpy 一定会把结尾的 '\0' 一起复制过去。
```

### ⑤ 源字符串必须合法

错误风险：

```c
char src[3] = {'a', 'b', 'c'};
char dest[10];

strcpy(dest, src);
```

问题：

```text
src 没有 '\0'。
strcpy 会继续往后读，直到偶然遇到 '\0'。
可能越界读取。
```

> [!tip] 记忆口诀
> **strcpy 不看数组长度，只认结尾零；源串没零，复制就会失控。**

---

# 03 | strcpy 和字符数组

> [!abstract] 核心结论
> 字符数组如果已经定义好，不能直接用 `=` 给它整体赋值字符串，应该使用 `strcpy` 复制字符串内容。

### ① 错误写法

```c
char str[20];

str = "hello";  // 错误
```

原因：

```text
数组名不是普通变量。
数组名代表数组首地址，不能被重新赋值。
```

### ② 正确写法

```c
#include <string.h>

char str[20];

strcpy(str, "hello");
```

含义：

```text
把 "hello" 中的字符内容复制到 str 数组中。
```

### ③ 初始化时可以直接赋值

```c
char str[20] = "hello";
```

这是正确的。

原因：

```text
这是定义数组时的初始化。
不是后续赋值。
```

### ④ 定义后想改内容用 strcpy

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[20] = "hello";

    strcpy(str, "world");

    printf("%s\n", str);

    return 0;
}
```

输出：

```text
world
```

### ⑤ 内存变化

原来：

```text
str = "hello\0"
```

执行：

```c
strcpy(str, "world");
```

之后：

```text
str = "world\0"
```

> [!tip] 记忆口诀
> **数组初始化可用等号，定义之后改字符串内容用 strcpy。**

---

# 04 | strcpy 和指针：目标必须指向可写空间

> [!abstract] 核心结论
> `strcpy` 的目标参数必须指向一块可写的内存。如果目标指针没有分配空间，或者指向字符串常量，就会产生严重错误。

### ① 正确：目标是字符数组

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[20];

    strcpy(dest, "hello");

    printf("%s\n", dest);

    return 0;
}
```

原因：

```text
dest 是字符数组，有可写空间。
```

### ② 错误：目标指针未初始化

```c
char *p;

strcpy(p, "hello");  // 错误
```

问题：

```text
p 没有指向有效空间。
strcpy 会往未知地址写入。
```

### ③ 错误：目标指向字符串常量

```c
char *p = "hello";

strcpy(p, "world");  // 错误
```

问题：

```text
p 指向字符串常量 "hello"。
字符串常量通常在只读区。
不能写入。
```

### ④ 正确：动态分配空间

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char *p = malloc(20);

    if (p == NULL) {
        return 1;
    }

    strcpy(p, "hello");

    printf("%s\n", p);

    free(p);

    return 0;
}
```

### ⑤ 关键点

```text
char *p 只是一个指针变量。
它本身只保存地址。
不会自动拥有字符串存储空间。
```

所以：

```text
strcpy 的目标不是“有个指针就行”，而是指针必须指向可写空间。
```

> [!tip] 记忆口诀
> **目标 dest 必须能写；野指针不能写，只读字符串不能写。**

---

# 05 | strcpy 的空间要求：目标数组必须足够大

> [!abstract] 核心结论
> `strcpy` 不会检查目标数组大小。如果源字符串长度超过目标空间，就会发生数组越界，破坏其他内存。

### ① 正确容量

```c
char dest[6];

strcpy(dest, "hello");
```

为什么是 6：

```text
"hello" 有 5 个字符。
还需要 1 个 '\0'。
所以至少需要 6 个 char。
```

### ② 错误容量

```c
char dest[5];

strcpy(dest, "hello");  // 错误，空间不够
```

问题：

```text
需要存：
'h' 'e' 'l' 'l' 'o' '\0'
一共 6 个字符。
但 dest 只有 5 个空间。
```

会造成：

```text
越界写入。
内存破坏。
程序崩溃。
安全漏洞。
```

### ③ 计算空间

```c
strlen("hello") = 5
```

但实际需要空间：

```text
strlen("hello") + 1 = 6
```

因为：

```text
还要保存 '\0'。
```

### ④ 安全检查示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[20];
    const char *src = "hello";

    if (strlen(src) + 1 <= sizeof(dest)) {
        strcpy(dest, src);
        printf("%s\n", dest);
    } else {
        printf("目标空间不足\n");
    }

    return 0;
}
```

### ⑤ 重点

```text
strcpy 只负责复制。
不会替你判断 dest 有多大。
```

> [!tip] 记忆口诀
> **目标空间看 strlen + 1，别忘了结尾的 '\0'。**

---

# 06 | strcpy 返回值

> [!abstract] 核心结论
> `strcpy` 的返回值是目标字符串地址，也就是 `dest`。因此可以把它直接用于打印、赋值或链式调用，但初学阶段更推荐分开写，清晰安全。

### ① 返回值类型

```c
char *strcpy(char *dest, const char *src);
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
    char str[20];

    char *ret = strcpy(str, "hello");

    printf("str = %s\n", str);
    printf("ret = %s\n", ret);

    return 0;
}
```

输出：

```text
str = hello
ret = hello
```

### ③ 直接打印返回值

```c
char str[20];

printf("%s\n", strcpy(str, "hello"));
```

输出：

```text
hello
```

### ④ 为什么返回 dest

这样可以方便：

```text
链式使用。
直接作为表达式使用。
保持标准库函数风格。
```

### ⑤ 初学建议

推荐写清楚：

```c
strcpy(str, "hello");
printf("%s\n", str);
```

不推荐为了炫技写复杂表达式。

> [!tip] 记忆口诀
> **strcpy 返回目标地址，复制完还能继续用 dest。**

---

# 07 | strcpy 和 strncpy 的区别

> [!abstract] 核心结论
> `strcpy` 会一直复制到 `'\0'`，不限制长度；`strncpy` 可以指定最多复制多少个字符，但它不一定自动补 `'\0'`，使用时也要小心。

### ① strcpy

```c
strcpy(dest, src);
```

特点：

```text
复制整个 src 字符串。
直到遇到 '\0'。
不检查 dest 空间大小。
```

### ② strncpy

```c
strncpy(dest, src, n);
```

特点：

```text
最多复制 n 个字符。
```

但注意：

```text
如果 src 长度 >= n，dest 可能没有 '\0' 结尾。
```

### ③ strncpy 风险示例

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[5];

    strncpy(dest, "hello", sizeof(dest));

    printf("%s\n", dest);  // 风险：dest 可能不是合法字符串

    return 0;
}
```

问题：

```text
"hello" 长度是 5。
dest 只有 5。
没有空间存 '\0'。
```

### ④ 更安全写法

```c
#include <stdio.h>
#include <string.h>

int main() {
    char dest[5];

    strncpy(dest, "hello", sizeof(dest) - 1);
    dest[sizeof(dest) - 1] = '\0';

    printf("%s\n", dest);

    return 0;
}
```

输出：

```text
hell
```

### ⑤ 对比总结

| 函数 | 是否限制复制长度 | 是否一定自动结尾 `'\0'` | 主要风险 |
| :--- | :--- | :--- | :--- |
| `strcpy` | 不限制 | 是，前提源串合法 | 目标空间溢出 |
| `strncpy` | 限制 | 不一定 | 可能没有 `'\0'` |

> [!tip] 记忆口诀
> **strcpy 不限长，strncpy 限长度；但 strncpy 不保证结尾零。**

---

# 08 | strcpy 和 memcpy 的区别

> [!abstract] 核心结论
> `strcpy` 用于复制字符串，会遇到 `'\0'` 停止；`memcpy` 用于复制指定字节数，不关心内容是不是字符串，也不会因为 `'\0'` 停止。

### ① strcpy 复制字符串

```c
strcpy(dest, src);
```

特点：

```text
适合字符串。
自动复制到 '\0'。
依赖源字符串合法结尾。
```

### ② memcpy 复制内存块

```c
memcpy(dest, src, n);
```

特点：

```text
复制 n 个字节。
不管内容是什么。
不会遇到 '\0' 停止。
适合复制数组、结构体、二进制数据。
```

### ③ 示例对比

```c
char src[] = {'a', 'b', '\0', 'c', 'd'};
char dest1[10];
char dest2[10];

strcpy(dest1, src);
memcpy(dest2, src, 5);
```

结果：

```text
dest1 只得到 "ab"
因为 strcpy 遇到 '\0' 停止。

dest2 得到 5 个字节：
'a' 'b' '\0' 'c' 'd'
因为 memcpy 按字节数复制。
```

### ④ 什么时候用 strcpy

```text
复制 C 字符串。
源数据一定以 '\0' 结尾。
目标空间足够。
```

### ⑤ 什么时候用 memcpy

```text
复制任意内存。
复制结构体。
复制数组。
复制包含 '\0' 的二进制数据。
复制固定长度缓冲区。
```

> [!tip] 记忆口诀
> **strcpy 认结尾零，memcpy 认字节数；字符串用 strcpy，内存块用 memcpy。**

---

# 09 | strcpy 常见错误

> [!abstract] 核心结论
> `strcpy` 常见错误包括目标空间不足、目标指针未初始化、修改字符串常量、源字符串没有 `'\0'`、源和目标内存重叠。

### ① 错误 1：目标空间不足

```c
char dest[5];

strcpy(dest, "hello");  // 错误
```

原因：

```text
"hello" 需要 6 个字符空间，包括 '\0'。
```

### ② 错误 2：目标指针未初始化

```c
char *dest;

strcpy(dest, "hello");  // 错误
```

原因：

```text
dest 没有指向可写内存。
```

### ③ 错误 3：目标是字符串常量

```c
char *dest = "hello";

strcpy(dest, "world");  // 错误
```

原因：

```text
字符串常量通常在只读区。
```

### ④ 错误 4：源没有 '\0'

```c
char src[3] = {'a', 'b', 'c'};
char dest[10];

strcpy(dest, src);  // 错误
```

原因：

```text
src 不是合法 C 字符串。
```

### ⑤ 错误 5：源和目标重叠

```c
char str[20] = "hello world";

strcpy(str + 2, str);  // 未定义行为
```

原因：

```text
strcpy 不适合处理内存重叠。
```

如果内存区域可能重叠，应该考虑：

```c
memmove
```

> [!tip] 记忆口诀
> **目标要够大，指针要有效，源串要有零，重叠别用 strcpy。**

---

# 10 | strcpy 总结

> [!abstract] 核心结论
> `strcpy` 的底层核心是“从源地址开始逐字节复制字符到目标地址，直到把 `'\0'` 也复制过去”。它简单但危险，因为它不检查目标空间大小，使用时必须自己保证目标空间足够。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>strcpy 核心总结：</strong>
<ul>
  <li><strong>头文件：</strong> <code>#include &lt;string.h&gt;</code>。</li>
  <li><strong>原型：</strong> <code>char *strcpy(char *dest, const char *src);</code></li>
  <li><strong>作用：</strong> 把 <code>src</code> 字符串复制到 <code>dest</code>。</li>
  <li><strong>复制内容：</strong> 包括字符串结尾的 <code>'\0'</code>。</li>
  <li><strong>返回值：</strong> 返回 <code>dest</code>。</li>
  <li><strong>目标要求：</strong> <code>dest</code> 必须指向足够大的可写空间。</li>
  <li><strong>源要求：</strong> <code>src</code> 必须是以 <code>'\0'</code> 结尾的合法字符串。</li>
  <li><strong>主要风险：</strong> 不检查目标空间大小，容易缓冲区溢出。</li>
  <li><strong>和 memcpy：</strong> <code>strcpy</code> 复制字符串，<code>memcpy</code> 复制指定字节数。</li>
  <li><strong>重叠问题：</strong> 源和目标区域重叠时，不应使用 <code>strcpy</code>。</li>
</ul>
</div>

### ② 最底层一句话

```text
strcpy = 从 src 开始复制字符到 dest，直到把字符串结束符 '\0' 也复制过去。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **strcpy 复制字符串，源串必须有零；目标必须够大，空间不够就越界。**