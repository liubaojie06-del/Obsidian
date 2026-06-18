---
tags: [C语言, sizeof, 内存大小, 数据类型, 编程基础]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | sizeof：查看数据在内存中占多少字节

> [!abstract] 核心结论
> `sizeof` 是 C 语言中的运算符，用来计算数据类型、变量、数组、结构体在内存中占用的字节数。它不是函数，而是编译器提供的运算能力。

### ① 底层原理：sizeof 到底算的是什么

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>sizeof 的本质：</strong>
<ul>
  <li><strong>sizeof 是运算符：</strong> 它不是函数，不需要头文件支持。</li>
  <li><strong>sizeof 计算字节数：</strong> 返回对象或类型在内存中占用的字节大小。</li>
  <li><strong>sizeof 的结果类型：</strong> 返回值类型是 <code>size_t</code>，通常用 <code>%zu</code> 输出。</li>
  <li><strong>多数情况在编译期完成：</strong> 编译器根据类型直接推导大小。</li>
  <li><strong>sizeof 不关心变量的值：</strong> 它关心的是类型占多大空间。</li>
</ul>
</div>

### ② 基本语法

```c
sizeof(类型)
sizeof(变量)
sizeof 表达式
```

常见写法：

```c
sizeof(int)
sizeof(double)
sizeof(a)
sizeof arr
```

推荐写法：

```c
sizeof(int)
sizeof(a)
sizeof(arr)
```

说明：

```text
对类型使用 sizeof 时，必须加括号。
对变量使用 sizeof 时，可以不加括号，但推荐加括号，统一清晰。
```

---

# 02 | sizeof 计算基本数据类型大小

> [!abstract] 核心结论
> 不同数据类型在内存中占用的字节数不同。`sizeof` 可以直接查看这些类型在当前编译环境下的大小。

### ① 示例代码

```c
#include <stdio.h>

int main() {
    printf("char   = %zu\n", sizeof(char));
    printf("short  = %zu\n", sizeof(short));
    printf("int    = %zu\n", sizeof(int));
    printf("long   = %zu\n", sizeof(long));
    printf("float  = %zu\n", sizeof(float));
    printf("double = %zu\n", sizeof(double));

    return 0;
}
```

可能输出：

```text
char   = 1
short  = 2
int    = 4
long   = 8
float  = 4
double = 8
```

说明：

```text
不同系统、不同编译器下，部分类型大小可能不同。
所以不要死记所有类型大小，要学会用 sizeof 查看。
```

### ② 常见数据类型大小理解

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px;">
<strong>常见大小规律：</strong>
<ul>
  <li><strong>char：</strong> 永远是 1 字节。</li>
  <li><strong>short：</strong> 常见是 2 字节。</li>
  <li><strong>int：</strong> 常见是 4 字节。</li>
  <li><strong>float：</strong> 常见是 4 字节。</li>
  <li><strong>double：</strong> 常见是 8 字节。</li>
  <li><strong>指针：</strong> 32 位环境常见 4 字节，64 位环境常见 8 字节。</li>
</ul>
</div>

---

# 03 | sizeof 计算变量大小

> [!abstract] 核心结论
> 对变量使用 `sizeof` 时，计算的是这个变量对应数据类型所占的内存大小，而不是变量当前值的大小。

### ① 示例代码

```c
#include <stdio.h>

int main() {
    int a = 10;
    double b = 3.14;
    char c = 'A';

    printf("%zu\n", sizeof(a));
    printf("%zu\n", sizeof(b));
    printf("%zu\n", sizeof(c));

    return 0;
}
```

可能输出：

```text
4
8
1
```

### ② sizeof 不看变量值

```c
#include <stdio.h>

int main() {
    int a = 1;
    int b = 1000000;

    printf("%zu\n", sizeof(a));
    printf("%zu\n", sizeof(b));

    return 0;
}
```

输出：

```text
4
4
```

说明：

```text
a 和 b 的值不同。
但是它们都是 int 类型。
所以 sizeof(a) 和 sizeof(b) 的结果一样。
```

---

# 04 | sizeof 和数组

> [!abstract] 核心结论
> 对数组名使用 `sizeof` 时，得到的是整个数组占用的总字节数，而不是数组首元素的大小。这是 `sizeof` 最常用的地方之一。

### ① 计算数组总大小

```c
#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};

    printf("%zu\n", sizeof(arr));

    return 0;
}
```

可能输出：

```text
20
```

说明：

```text
arr 有 5 个 int 元素。
每个 int 常见占 4 字节。
所以整个数组占 5 × 4 = 20 字节。
```

### ② 计算数组元素个数

```c
#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};

    int len = sizeof(arr) / sizeof(arr[0]);

    printf("%d\n", len);

    return 0;
}
```

输出：

```text
5
```

公式：

```text
数组元素个数 = 数组总字节数 / 单个元素字节数
```

推荐写法：

```c
int len = sizeof(arr) / sizeof(arr[0]);
```

不要写死：

```c
int len = 5;
```

原因：

```text
数组长度以后发生变化时，sizeof 公式会自动跟着变。
写死数字容易出错。
```

---

# 05 | sizeof 和字符串

> [!abstract] 核心结论
> 字符串数组使用 `sizeof` 时，会把末尾隐藏的 `'\0'` 也计算进去。字符串指针使用 `sizeof` 时，得到的是指针变量本身的大小。

### ① 字符数组字符串

```c
#include <stdio.h>

int main() {
    char str[] = "abc";

    printf("%zu\n", sizeof(str));

    return 0;
}
```

输出：

```text
4
```

说明：

```text
"abc" 实际存储为：
'a' 'b' 'c' '\0'

所以 char str[] = "abc"; 占 4 个字节。
```

### ② 字符串常量

```c
#include <stdio.h>

int main() {
    printf("%zu\n", sizeof("abc"));

    return 0;
}
```

输出：

```text
4
```

说明：

```text
sizeof("abc") 也会计算末尾的 '\0'。
```

### ③ 字符指针

```c
#include <stdio.h>

int main() {
    char *p = "abc";

    printf("%zu\n", sizeof(p));

    return 0;
}
```

64 位环境常见输出：

```text
8
```

说明：

```text
p 是指针变量。
sizeof(p) 计算的是指针本身的大小。
它不是字符串 "abc" 的长度。
```

---

# 06 | sizeof 和 strlen 的区别

> [!abstract] 核心结论
> `sizeof` 计算内存占用字节数，`strlen` 计算字符串有效字符个数。`sizeof` 会计算 `'\0'`，`strlen` 不计算 `'\0'`。

### ① 示例代码

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[] = "abc";

    printf("sizeof = %zu\n", sizeof(str));
    printf("strlen = %zu\n", strlen(str));

    return 0;
}
```

输出：

```text
sizeof = 4
strlen = 3
```

### ② 核心区别

```text
sizeof(str)：
计算整个数组占多少字节。
包含末尾 '\0'。

strlen(str)：
从字符串开头数到 '\0' 前面为止。
不包含末尾 '\0'。
```

图示：

```text
str 数组内容：
┌─────┬─────┬─────┬─────┐
│ 'a' │ 'b' │ 'c' │'\0' │
└─────┴─────┴─────┴─────┘

sizeof(str) = 4
strlen(str) = 3
```

### ③ 指针场景对比

```c
#include <stdio.h>
#include <string.h>

int main() {
    char *p = "abc";

    printf("sizeof = %zu\n", sizeof(p));
    printf("strlen = %zu\n", strlen(p));

    return 0;
}
```

64 位环境常见输出：

```text
sizeof = 8
strlen = 3
```

说明：

```text
sizeof(p) 计算的是指针变量大小。
strlen(p) 会沿着 p 指向的字符串往后数有效字符。
```

---

# 07 | sizeof 和指针

> [!abstract] 核心结论
> 对指针变量使用 `sizeof`，得到的是指针本身占多少字节，而不是指针指向的数据占多少字节。

### ① 基本示例

```c
#include <stdio.h>

int main() {
    int *p1;
    double *p2;
    char *p3;

    printf("%zu\n", sizeof(p1));
    printf("%zu\n", sizeof(p2));
    printf("%zu\n", sizeof(p3));

    return 0;
}
```

64 位环境常见输出：

```text
8
8
8
```

说明：

```text
指针保存的是地址。
同一个平台下，不同类型指针的大小通常一样。
64 位环境地址常见占 8 字节。
```

### ② 指针指向的数据大小

```c
#include <stdio.h>

int main() {
    int a = 10;
    int *p = &a;

    printf("%zu\n", sizeof(p));
    printf("%zu\n", sizeof(*p));

    return 0;
}
```

64 位环境常见输出：

```text
8
4
```

说明：

```text
sizeof(p)：
计算指针变量 p 自己的大小。

sizeof(*p)：
计算 p 指向的数据类型大小。
p 是 int*，所以 *p 是 int。
```

---

# 08 | sizeof 和函数参数中的数组退化

> [!abstract] 核心结论
> 数组作为函数参数传递时，会退化成指针。此时在函数内部对参数使用 `sizeof`，得到的是指针大小，不是整个数组大小。

### ① 错误示例

```c
#include <stdio.h>

void print_size(int arr[]) {
    printf("%zu\n", sizeof(arr));
}

int main() {
    int nums[5] = {1, 2, 3, 4, 5};

    print_size(nums);

    return 0;
}
```

64 位环境常见输出：

```text
8
```

原因：

```text
函数参数 int arr[] 本质上等价于 int *arr。
所以 sizeof(arr) 得到的是指针大小。
不是原数组大小。
```

### ② 正确做法：长度单独传进去

```c
#include <stdio.h>

void print_array(int arr[], int len) {
    for (int i = 0; i < len; i++) {
        printf("%d\n", arr[i]);
    }
}

int main() {
    int nums[5] = {1, 2, 3, 4, 5};

    int len = sizeof(nums) / sizeof(nums[0]);

    print_array(nums, len);

    return 0;
}
```

说明：

```text
数组长度应该在数组还没有退化成指针之前计算。
也就是在 main 函数里计算，再传给函数。
```

---

# 09 | sizeof 和结构体

> [!abstract] 核心结论
> 结构体的 `sizeof` 不一定等于所有成员大小的简单相加，因为编译器会进行内存对齐，以提高 CPU 访问效率。

### ① 基本示例

```c
#include <stdio.h>

struct Student {
    int age;
    char grade;
};

int main() {
    struct Student s;

    printf("%zu\n", sizeof(s));

    return 0;
}
```

可能输出：

```text
8
```

为什么不是 5：

```text
int age 常见占 4 字节。
char grade 占 1 字节。
理论相加是 5 字节。

但为了内存对齐，编译器可能补 3 个字节。
所以结构体整体可能占 8 字节。
```

### ② 内存对齐理解

```text
struct Student {
    int age;     // 4 字节
    char grade; // 1 字节
};
```

内存可能这样排：

```text
┌────┬────┬────┬────┐
│ age 占 4 字节       │
├────┼────┼────┼────┤
│grade│补齐│补齐│补齐│
└────┴────┴────┴────┘

总大小 = 8 字节
```

### ③ 成员顺序会影响结构体大小

```c
#include <stdio.h>

struct A {
    char c;
    int i;
    char d;
};

struct B {
    int i;
    char c;
    char d;
};

int main() {
    printf("%zu\n", sizeof(struct A));
    printf("%zu\n", sizeof(struct B));

    return 0;
}
```

可能输出：

```text
12
8
```

说明：

```text
成员顺序不同，内存补齐方式不同。
结构体大小也可能不同。
```

---

# 10 | sizeof 的常见错误与总结

> [!abstract] 核心结论
> `sizeof` 最容易出错的地方是数组和指针混淆、字符串长度和内存大小混淆、函数参数中的数组退化。

### ① 常见错误

**错误 1：把 sizeof 当函数理解**

```c
sizeof(int)
sizeof(a)
```

说明：

```text
sizeof 不是函数。
它是运算符。
```

---

**错误 2：用 sizeof 计算字符串长度**

```c
char *p = "hello";

printf("%zu\n", sizeof(p));
```

问题：

```text
sizeof(p) 得到的是指针大小，不是字符串长度。
```

正确：

```c
#include <string.h>

printf("%zu\n", strlen(p));
```

---

**错误 3：在函数参数里计算数组长度**

```c
void test(int arr[]) {
    int len = sizeof(arr) / sizeof(arr[0]);
}
```

问题：

```text
arr 在函数参数中已经退化成 int*。
sizeof(arr) 是指针大小，不是数组总大小。
```

正确：

```c
void test(int arr[], int len) {
    // 使用外部传进来的 len
}
```

---

**错误 4：忽略字符串末尾的 '\0'**

```c
char str[] = "abc";

printf("%zu\n", sizeof(str));
```

结果：

```text
4
```

说明：

```text
不是 3，因为末尾还有隐藏的 '\0'。
```

---

**错误 5：结构体大小直接相加**

```c
struct Student {
    int age;
    char grade;
};
```

错误理解：

```text
sizeof(struct Student) = 4 + 1 = 5
```

正确理解：

```text
结构体存在内存对齐，结果可能是 8。
```

### ② sizeof 总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>sizeof 核心总结：</strong>
<ul>
  <li><strong>sizeof 是运算符：</strong> 不是函数。</li>
  <li><strong>sizeof 返回字节数：</strong> 结果类型是 <code>size_t</code>。</li>
  <li><strong>基本类型：</strong> 计算该类型占多少字节。</li>
  <li><strong>数组名：</strong> 在数组未退化时，计算整个数组大小。</li>
  <li><strong>指针变量：</strong> 计算指针本身大小。</li>
  <li><strong>字符串数组：</strong> 会包含末尾 <code>'\0'</code>。</li>
  <li><strong>结构体：</strong> 可能因为内存对齐产生补齐字节。</li>
</ul>
</div>

> [!tip] 记忆口诀
> **sizeof 看空间，不看数值长短；数组算整体，指针算地址；字符串带零尾，结构体有对齐。**