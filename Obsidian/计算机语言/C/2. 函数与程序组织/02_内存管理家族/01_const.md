---
tags: [C语言, const, 常量, 编程基础]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | const：常量修饰符

> [!abstract] 核心结论
> `const` 用于修饰变量，表示其值在初始化后不可修改，是编译时的一种约束。它可以修饰普通变量、指针、数组、函数参数等，防止意外修改。

### ① 基本用法

```c
const int a = 10;  // a 的值不可改变
```

访问：

```c
printf("%d\n", a);
```

修改：

```c
a = 20;  // 错误，编译器报错
```

---

# 02 | const 与指针

### ① 指针本身不可变

```c
int value = 10;
int value2 = 20;
int * const p = &value; // 指针本身不可变
```

含义：

```text
p 指向固定地址 &value，不能指向别处。
*p 可以修改 value 内容。
```

修改：

```c
*p = 30;   // 正确，修改 value
p = &value2; // 错误，指针不能改变
```

### ② 指针指向的内容不可变

```c
const int *p = &value; // 指针可变，内容不可变
```

含义：

```text
*p 不能修改内容
p 可以指向别的 int 变量
```

---

# 03 | 指针自身和指向内容都不可变

```c
const int * const p = &value;
```

含义：

```text
p 指向固定地址，且地址内容不可修改
```

---

# 04 | const 与函数参数

> [!abstract] 核心结论
> 函数参数加 `const` 可以防止函数意外修改传入值，同时增强代码可读性。

```c
void print_value(const int *p) {
    printf("%d\n", *p);
    //*p = 10; // 错误，不能修改
}
```

适合：

```text
传递指针参数但不希望函数修改内容
```

---

# 05 | const 与数组

```c
const int arr[3] = {1, 2, 3};
```

特点：

```text
数组内容不可修改
arr[0] = 10; // 错误
```

常用于：

```text
保存配置、字符串常量、固定数据
```

---

# 06 | const 与字符串常量

```c
const char *str = "Hello";
```

特点：

```text
字符串本身在只读区，不能修改
*str = 'h'; // 错误
```

安全写法：

```text
const char *str = "Hello"; // 推荐
```

---

# 07 | 常见错误

1. 忘记加 `const` 修改只读区域：

```c
char *str = "Hello";
str[0] = 'h'; // 未定义行为
```

2. 误用指针修饰：

```c
int * const p = &a;
*p = 20; // 对
p = &b;  // 错
```

3. const 与数组函数传参：

```c
void func(const int arr[], int len); // 防止修改数组
```

---

# 08 | 总结

> [!abstract] 核心结论
> `const` 是编译期约束，保护变量、指针、数组或函数参数不被修改。用好 `const` 可以减少错误、提高代码可读性和安全性。

### 记忆口诀

```text
const 修饰值不可改，
指针修饰地址也能锁，
函数参数加 const，
保护传入不被动。
```