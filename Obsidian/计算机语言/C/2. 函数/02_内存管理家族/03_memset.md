---
tags: [C语言, memset, 内存函数, string.h, 内存初始化, 清零, 字节操作, 指针]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | memset：按字节设置一段内存

> [!abstract] 核心结论
> `memset` 是 C 语言中用于“按字节填充内存”的函数。它可以把一段连续内存中的每个字节都设置成指定值，常用于清空数组、清空结构体、初始化堆区内存等场景。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>memset 的本质：</strong>
<ul>
  <li><strong>作用：</strong>把一段连续内存按字节设置成指定值。</li>
  <li><strong>单位：</strong>不是按 int、float、结构体成员设置，而是按 <code>byte</code> 设置。</li>
  <li><strong>头文件：</strong>需要包含 <code>&lt;string.h&gt;</code>。</li>
  <li><strong>常用场景：</strong>数组清零、结构体清零、堆区内存初始化、字符缓冲区清空。</li>
  <li><strong>核心风险：</strong>误以为它能按元素赋值，或者字节数写错导致越界。</li>
</ul>
</div>

### ② 函数原型

```c
#include <string.h>

void *memset(void *s, int c, size_t n);
```

参数含义：

```text
s：
要设置的内存起始地址。

c：
要填充的值，但最终只取低 8 位作为一个字节写入。

n：
要设置的字节数。

返回值：
返回 s，也就是原来的内存起始地址。
```

### ③ 使用场景

| 写法 | 含义 |
| :--- | :--- |
| `memset(arr, 0, sizeof(arr))` | 清空数组 |
| `memset(&stu, 0, sizeof(stu))` | 清空结构体 |
| `memset(p, 0, size)` | 清空堆区空间 |
| `memset(buf, '\0', len)` | 清空字符缓冲区 |
| `memset(buf, 'A', len)` | 把字符数组填充为 `'A'` |

> [!tip] 记忆口诀
> **memset 是刷内存，一刷就是 n 个字节。**

---

# 02 | memset 清空数组

> [!abstract] 核心结论
> `memset(arr, 0, sizeof(arr))` 是清空数组最常见的写法。它会把数组占用的所有字节都设置为 `0`。

### ① 清空 int 数组

```c
#include <stdio.h>
#include <string.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};

    memset(arr, 0, sizeof(arr));

    for (int i = 0; i < 5; i++) {
        printf("%d ", arr[i]);
    }

    return 0;
}
```

输出：

```text
0 0 0 0 0
```

### ② 底层理解

```c
memset(arr, 0, sizeof(arr));
```

含义：

```text
arr：
数组首地址。

0：
每个字节都写成 0x00。

sizeof(arr)：
整个数组占用的总字节数。
```

如果：

```c
int arr[5];
```

并且一个 `int` 是 4 字节：

```text
sizeof(arr) = 5 * 4 = 20 字节
```

所以 `memset` 会清空：

```text
20 个字节。
```

### ③ 字符数组清空

```c
char buf[100];

memset(buf, 0, sizeof(buf));
```

等价理解：

```text
把 buf 中的每个字符位置都变成 '\0'。
```

### ④ 注意数组传参时 sizeof 问题

```c
void clear_array(int arr[]) {
    memset(arr, 0, sizeof(arr));  // 错误
}
```

问题：

```text
函数参数中的 arr 会退化成指针。
sizeof(arr) 得到的是指针大小，不是整个数组大小。
```

正确：

```c
void clear_array(int arr[], int n) {
    memset(arr, 0, sizeof(int) * n);
}
```

### ⑤ 重点

```text
在数组定义所在作用域里，sizeof(arr) 才是整个数组大小。
数组传进函数后，sizeof(arr) 通常不是数组总大小。
```

> [!tip] 记忆口诀
> **数组本地 sizeof 是整体，传参以后变指针。**

---

# 03 | memset 清空结构体

> [!abstract] 核心结论
> `memset(&结构体变量, 0, sizeof(结构体变量))` 可以把结构体占用的内存全部清零，常用于初始化结构体变量。

### ① 示例代码

```c
#include <stdio.h>
#include <string.h>

typedef struct {
    int id;
    char name[32];
    int age;
} Student;

int main() {
    Student stu = {1, "Tom", 18};

    memset(&stu, 0, sizeof(stu));

    printf("id = %d\n", stu.id);
    printf("name = %s\n", stu.name);
    printf("age = %d\n", stu.age);

    return 0;
}
```

输出：

```text
id = 0
name =
age = 0
```

### ② 底层理解

```c
memset(&stu, 0, sizeof(stu));
```

含义：

```text
&stu：
结构体变量的起始地址。

0：
每个字节写成 0x00。

sizeof(stu)：
整个结构体占用的字节数。
```

### ③ 清零后的效果

```text
int 成员通常变为 0。
char 数组成员全部变为 '\0'。
指针成员通常变为空指针表现。
```

### ④ 注意

对于普通 C 结构体：

```c
typedef struct {
    int id;
    char name[32];
    int age;
} Student;
```

用 `memset` 清零通常没问题。

但如果结构体中包含复杂资源，例如：

```text
已经 malloc 的指针。
文件指针。
需要特殊释放的资源。
```

直接 `memset` 可能会把地址覆盖掉，导致资源丢失或内存泄漏。

### ⑤ 更安全的习惯

如果结构体里有堆指针：

```c
typedef struct {
    char *name;
    int age;
} Person;
```

应该先释放资源：

```c
free(person.name);
person.name = NULL;
```

再考虑清空结构体。

> [!tip] 记忆口诀
> **普通结构体可清零，有资源指针先释放。**

---

# 04 | memset 初始化堆区内存

> [!abstract] 核心结论
> `malloc` 申请的堆区内存内容是不确定的，如果希望初始值为 0，可以在 `malloc` 后使用 `memset` 清零，或者直接使用 `calloc`。

### ① malloc 后清零

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    int n = 5;

    int *arr = malloc(sizeof(int) * n);

    if (arr == NULL) {
        return 1;
    }

    memset(arr, 0, sizeof(int) * n);

    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }

    free(arr);
    arr = NULL;

    return 0;
}
```

输出：

```text
0 0 0 0 0
```

### ② 底层理解

```c
int *arr = malloc(sizeof(int) * n);
```

这里：

```text
arr 是局部指针变量，通常在栈区。
malloc 申请的空间在堆区。
```

```c
memset(arr, 0, sizeof(int) * n);
```

这里：

```text
从 arr 指向的堆区首地址开始。
连续清零 sizeof(int) * n 个字节。
```

### ③ calloc 替代写法

```c
int *arr = calloc(n, sizeof(int));
```

等价理解：

```text
申请 n 个 int 的堆空间，并把内存清零。
```

### ④ malloc + memset 对比 calloc

| 写法 | 作用 |
| :--- | :--- |
| `malloc(size)` | 只申请，不清零 |
| `malloc(size) + memset(p, 0, size)` | 申请后手动清零 |
| `calloc(n, size)` | 申请并自动清零 |

### ⑤ 重点

```text
malloc 后如果马上要清零，可以用 memset。
如果只是申请零初始化数组，可以直接用 calloc。
```

> [!tip] 记忆口诀
> **malloc 不清零，memset 帮它清；calloc 是申请加清零。**

---

# 05 | memset 是按字节赋值，不是按元素赋值

> [!abstract] 核心结论
> `memset` 最容易犯的错误是把它当成“给数组每个元素赋值”的函数。实际上它是给每个字节赋值，不是给每个 `int`、`float`、结构体成员赋值。

### ① 错误理解

```c
int arr[5];

memset(arr, 1, sizeof(arr));
```

很多初学者以为：

```text
arr[0] = 1
arr[1] = 1
arr[2] = 1
arr[3] = 1
arr[4] = 1
```

实际不是。

### ② 为什么不是 1

`memset(arr, 1, sizeof(arr))` 会把每个字节设置成：

```text
0x01
```

如果一个 `int` 占 4 字节，那么每个 `int` 的内存可能变成：

```text
01 01 01 01
```

对应整数可能是：

```text
0x01010101
```

十进制常见是：

```text
16843009
```

### ③ 示例代码

```c
#include <stdio.h>
#include <string.h>

int main() {
    int arr[3];

    memset(arr, 1, sizeof(arr));

    printf("%d\n", arr[0]);
    printf("%d\n", arr[1]);
    printf("%d\n", arr[2]);

    return 0;
}
```

可能输出：

```text
16843009
16843009
16843009
```

### ④ 正确给 int 数组赋 1

```c
for (int i = 0; i < 3; i++) {
    arr[i] = 1;
}
```

### ⑤ memset 适合设置什么值

常用安全值：

```text
0：
最常用，清零。

-1：
在二进制补码机器上常用于把所有字节设为 0xFF，int 可能表现为 -1。
但也要理解它仍然是按字节设置。
```

> [!tip] 记忆口诀
> **memset 清零最稳，设 1 不是元素等于 1。**

---

# 06 | memset 的第三个参数是字节数

> [!abstract] 核心结论
> `memset` 的第三个参数 `n` 表示要设置多少个字节，不是元素个数。数组、结构体、堆空间使用时都要传入正确的字节数。

### ① 错误示例

```c
int arr[10];

memset(arr, 0, 10);
```

问题：

```text
只清零 10 个字节。
如果 int 是 4 字节，arr 总共 40 字节。
这样只清了前 2 个半 int。
```

### ② 正确写法

```c
int arr[10];

memset(arr, 0, sizeof(arr));
```

或者：

```c
memset(arr, 0, sizeof(int) * 10);
```

### ③ 堆数组正确写法

```c
int n = 10;

int *arr = malloc(sizeof(int) * n);

if (arr != NULL) {
    memset(arr, 0, sizeof(int) * n);
}
```

### ④ 字符数组

```c
char buf[100];

memset(buf, 0, sizeof(buf));
```

这里刚好：

```text
char 是 1 字节。
所以字节数和元素个数相同。
```

### ⑤ 重点

```text
第三个参数永远是字节数。
不是元素个数。
不是数组长度。
```

> [!tip] 记忆口诀
> **memset 第三个参数问的是字节，不是几个元素。**

---

# 07 | memset 和字符串缓冲区

> [!abstract] 核心结论
> `memset` 常用来清空字符数组或字符串缓冲区。把缓冲区全部设置为 `'\0'` 后，它就相当于一个空字符串。

### ① 清空字符数组

```c
#include <stdio.h>
#include <string.h>

int main() {
    char buf[100] = "hello";

    memset(buf, 0, sizeof(buf));

    printf("buf = [%s]\n", buf);

    return 0;
}
```

输出：

```text
buf = []
```

### ② 设置字符内容

```c
char buf[10];

memset(buf, 'A', sizeof(buf));
```

此时：

```text
buf 的 10 个字节都是 'A'。
```

注意：

```text
这不一定是合法字符串。
因为没有自动追加 '\0'。
```

### ③ 构造字符串要留结尾

```c
char buf[10];

memset(buf, 'A', sizeof(buf) - 1);
buf[9] = '\0';

printf("%s\n", buf);
```

输出：

```text
AAAAAAAAA
```

### ④ 清空输入缓冲区变量

```c
char input[256];

memset(input, 0, sizeof(input));
```

适合：

```text
每次重新接收输入前清空旧内容。
```

### ⑤ 重点

```text
字符数组不等于字符串。
字符串必须有 '\0' 结尾。
memset 不会自动帮你加字符串结束符。
```

> [!tip] 记忆口诀
> **buf 清零是空串，填字符要留反斜零。**

---

# 08 | memset 和结构体数组

> [!abstract] 核心结论
> `memset` 可以一次性清空结构体数组，把每个结构体对象的所有字节都设置为 0，常用于初始化学生表、设备表、缓存表等。

### ① 示例代码

```c
#include <stdio.h>
#include <string.h>

typedef struct {
    int id;
    char name[32];
    int age;
} Student;

int main() {
    Student students[3] = {
        {1, "Tom", 18},
        {2, "Jack", 19},
        {3, "Lucy", 17}
    };

    memset(students, 0, sizeof(students));

    for (int i = 0; i < 3; i++) {
        printf("%d %s %d\n",
               students[i].id,
               students[i].name,
               students[i].age);
    }

    return 0;
}
```

输出：

```text
0  0
0  0
0  0
```

### ② 底层理解

```c
memset(students, 0, sizeof(students));
```

含义：

```text
students：
结构体数组首地址。

sizeof(students)：
整个结构体数组占用的字节数。

0：
把所有字节都改成 0。
```

### ③ 堆区结构体数组

```c
Student *students = malloc(sizeof(Student) * 100);

if (students != NULL) {
    memset(students, 0, sizeof(Student) * 100);
}
```

### ④ 注意

如果结构体里包含指针：

```c
typedef struct {
    char *name;
    int age;
} Person;
```

直接：

```c
memset(persons, 0, sizeof(Person) * n);
```

会把指针清成空指针表现。

如果这些指针原本指向已申请的堆空间：

```text
先 memset 会丢失地址，导致内存泄漏。
```

### ⑤ 重点

```text
清空前要判断结构体里有没有需要释放的资源指针。
```

> [!tip] 记忆口诀
> **结构体数组可清零，有指针资源先处理。**

---

# 09 | memset 常见错误

> [!abstract] 核心结论
> `memset` 常见错误包括把第三个参数当元素个数、把它当成按元素赋值、对指针使用 `sizeof(p)`、忘记包含 `<string.h>`、覆盖掉结构体中的堆指针。

### ① 错误 1：第三个参数写成元素个数

```c
int arr[10];

memset(arr, 0, 10);
```

问题：

```text
只清 10 个字节，不是 10 个 int。
```

正确：

```c
memset(arr, 0, sizeof(arr));
```

### ② 错误 2：给 int 数组设置成 1

```c
int arr[10];

memset(arr, 1, sizeof(arr));
```

问题：

```text
每个字节是 0x01。
每个 int 不是正常的 1。
```

正确：

```c
for (int i = 0; i < 10; i++) {
    arr[i] = 1;
}
```

### ③ 错误 3：对指针使用 sizeof

```c
int *p = malloc(sizeof(int) * 10);

memset(p, 0, sizeof(p));  // 错误
```

问题：

```text
sizeof(p) 是指针大小。
不是堆数组大小。
```

正确：

```c
memset(p, 0, sizeof(int) * 10);
```

### ④ 错误 4：忘记头文件

```c
memset(buf, 0, sizeof(buf));
```

应包含：

```c
#include <string.h>
```

### ⑤ 错误 5：清空前丢失资源

```c
typedef struct {
    char *name;
} Person;

Person p;

p.name = malloc(100);

memset(&p, 0, sizeof(p));  // 危险
```

问题：

```text
p.name 原来保存的堆地址被清零。
这块堆空间再也找不到，造成内存泄漏。
```

正确：

```c
free(p.name);
p.name = NULL;

memset(&p, 0, sizeof(p));
```

> [!tip] 记忆口诀
> **sizeof 指针不是空间大小，memset 设 1 不是整数 1。**

---

# 10 | memset 总结

> [!abstract] 核心结论
> `memset` 的底层核心是“按字节写内存”。它最适合清零数组、结构体、堆区空间和字符缓冲区；但不能把它误当成按元素赋值函数，尤其不能用它给 `int` 数组正常赋值为 1。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>memset 核心总结：</strong>
<ul>
  <li><strong>头文件：</strong><code>#include &lt;string.h&gt;</code>。</li>
  <li><strong>函数原型：</strong><code>void *memset(void *s, int c, size_t n);</code></li>
  <li><strong>本质：</strong>按字节设置内存。</li>
  <li><strong>参数 s：</strong>要设置的内存起始地址。</li>
  <li><strong>参数 c：</strong>填充字节值，实际使用低 8 位。</li>
  <li><strong>参数 n：</strong>要设置的字节数。</li>
  <li><strong>最常用：</strong><code>memset(p, 0, size)</code> 清零。</li>
  <li><strong>适合：</strong>数组清零、结构体清零、堆空间清零、字符缓冲区清空。</li>
  <li><strong>不适合：</strong>给 int 数组按元素赋值为 1、2、3 等。</li>
  <li><strong>常见错误：</strong>把字节数写成元素个数，对指针误用 <code>sizeof</code>。</li>
</ul>
</div>

### ② 最底层一句话

```text
memset = 从某个地址开始，连续把 n 个字节都刷成同一个字节值。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **memset 按字节刷，清零最常用；第三参数是字节，设 1 不是整数 1。**