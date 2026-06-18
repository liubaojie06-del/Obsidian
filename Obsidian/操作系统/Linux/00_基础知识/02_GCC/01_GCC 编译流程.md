---
tags: [GCC, 编译器, C语言, Linux, 编译流程, 基础知识]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | GCC 编译流程：从源码到可执行文件

> [!abstract] 核心结论
> GCC 编译并不是一步完成的，底层会经历“预处理 → 编译 → 汇编 → 链接”四个阶段。平时一条 `gcc main.c -o main` 命令，其实是把这四步自动串起来执行。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px;">
<strong>GCC 四阶段编译模型：</strong>
<ul>
  <li><strong>预处理：</strong> 展开头文件、宏定义、条件编译，生成 <code>.i</code> 文件。</li>
  <li><strong>编译：</strong> 把预处理后的 C 代码转换成汇编代码，生成 <code>.s</code> 文件。</li>
  <li><strong>汇编：</strong> 把汇编代码转换成机器码目标文件，生成 <code>.o</code> 文件。</li>
  <li><strong>链接：</strong> 把目标文件和库函数连接起来，生成最终可执行文件。</li>
</ul>
</div>

### ② 总流程图

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px; line-height: 1.9;">

<strong>main.c</strong>：C 源代码  
<br>
⬇️ 预处理：展开 <code>#include</code>、<code>#define</code>  
<br>
<strong>main.i</strong>：预处理后的 C 代码  
<br>
⬇️ 编译：C 代码转换成汇编  
<br>
<strong>main.s</strong>：汇编代码  
<br>
⬇️ 汇编：汇编代码转换成机器码  
<br>
<strong>main.o</strong>：目标文件  
<br>
⬇️ 链接：合并目标文件和库函数  
<br>
<strong>main</strong>：可执行文件  
<br>
⬇️ 运行  
<br>
<strong>./main</strong>

</div>

### ③ 一步完成编译

**从源码直接生成可执行文件：**

```bash
gcc main.c -o main
```

**运行程序：**

```bash
./main
```

**不指定输出文件名时，默认生成 `a.out`：**

```bash
gcc main.c
./a.out
```

### ④ 分阶段编译命令

**第 1 步：预处理**

```bash
gcc -E main.c -o main.i
```

生成：

```text
main.i
```

作用：展开 `#include`、`#define`、条件编译等内容。

---

**第 2 步：编译**

```bash
gcc -S main.i -o main.s
```

生成：

```text
main.s
```

作用：把 C 代码转换成汇编代码。

---

**第 3 步：汇编**

```bash
gcc -c main.s -o main.o
```

生成：

```text
main.o
```

作用：把汇编代码转换成机器码目标文件。

---

**第 4 步：链接**

```bash
gcc main.o -o main
```

生成：

```text
main
```

作用：把目标文件和库函数链接成最终可执行文件。

### ⑤ 每个文件的含义

**`main.c`**

```text
程序员写的 C 源代码。
```

**`main.i`**

```text
预处理后的 C 代码，头文件和宏已经被展开。
```

**`main.s`**

```text
汇编代码。
```

**`main.o`**

```text
目标文件，里面是机器码，但还不能直接运行。
```

**`main`**

```text
最终可执行文件，可以用 ./main 运行。
```

### ⑥ 示例程序

创建文件：

```bash
vim main.c
```

写入代码：

```c
#include <stdio.h>

#define MSG "Hello, GCC Compile Flow!"

int main() {
    printf("%s\n", MSG);
    return 0;
}
```

保存后，一步编译运行：

```bash
gcc main.c -o main
./main
```

输出结果：

```text
Hello, GCC Compile Flow!
```

### ⑦ 完整手动编译流程

**1. 预处理**

```bash
gcc -E main.c -o main.i
```

**2. 编译成汇编**

```bash
gcc -S main.i -o main.s
```

**3. 汇编成目标文件**

```bash
gcc -c main.s -o main.o
```

**4. 链接成可执行文件**

```bash
gcc main.o -o main
```

**5. 运行程序**

```bash
./main
```

### ⑧ 多文件编译流程

项目结构：

```text
project/
├── main.c
├── add.c
└── add.h
```

### ⑨ 头文件 add.h

```c
#ifndef ADD_H
#define ADD_H

int add(int a, int b);

#endif
```

### ⑩ 函数实现 add.c

```c
#include "add.h"

int add(int a, int b) {
    return a + b;
}
```

### ⑪ 主程序 main.c

```c
#include <stdio.h>
#include "add.h"

int main() {
    printf("%d\n", add(3, 5));
    return 0;
}
```

### ⑫ 多文件一步编译

```bash
gcc main.c add.c -o main
```

运行：

```bash
./main
```

输出：

```text
8
```

### ⑬ 多文件分步编译

**1. 编译主程序为目标文件**

```bash
gcc -c main.c -o main.o
```

**2. 编译函数实现为目标文件**

```bash
gcc -c add.c -o add.o
```

**3. 链接多个目标文件**

```bash
gcc main.o add.o -o main
```

**4. 运行程序**

```bash
./main
```

### ⑭ 常见错误理解

**错误 1：**

```text
undefined reference to `add'
```

原因：

```text
链接时没有带上 add.o 或 add.c。
```

解决：

```bash
gcc main.o add.o -o main
```

或者：

```bash
gcc main.c add.c -o main
```

---

**错误 2：**

```text
add.h: No such file or directory
```

原因：

```text
找不到头文件。
```

解决：

```bash
gcc main.c add.c -I./include -o main
```

如果头文件就在当前目录，一般直接这样即可：

```bash
gcc main.c add.c -o main
```

---

**错误 3：**

```text
Permission denied
```

原因：

```text
文件没有执行权限。
```

解决：

```bash
chmod +x main
./main
```

---

**错误 4：**

```text
command not found: gcc
```

原因：

```text
GCC 没有安装，或者环境变量异常。
```

解决：

```bash
gcc --version
```

没有版本信息就先安装 GCC。

---

**错误 5：**

```text
No such file or directory
```

原因：

```text
当前目录没有这个文件，或者文件名写错了。
```

解决：

```bash
ls
pwd
```

### ⑮ 推荐日常编译命令

**编译单个 C 文件：**

```bash
gcc main.c -o main -Wall -Wextra -g
```

**编译多个 C 文件：**

```bash
gcc main.c add.c -o main -Wall -Wextra -g
```

**只生成目标文件：**

```bash
gcc -c main.c -o main.o
```

**链接多个目标文件：**

```bash
gcc main.o add.o -o main
```

**编译并立即运行：**

```bash
gcc main.c -o main && ./main
```

**在 Vim 中保存、编译、运行：**

```vim
:w | !gcc % -o main && ./main
```

### ⑯ 编译流程记忆版

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px; line-height: 1.9;">

<strong>源码 main.c</strong>  
<br>
⬇️  
<br>
<strong>预处理 main.i</strong>  
<br>
⬇️  
<br>
<strong>编译 main.s</strong>  
<br>
⬇️  
<br>
<strong>汇编 main.o</strong>  
<br>
⬇️  
<br>
<strong>链接 main</strong>  
<br>
⬇️  
<br>
<strong>运行 ./main</strong>

</div>

> [!tip] 记忆口诀
> **源码先预处理，编译变汇编；汇编成目标，链接才运行。单文件一条命令，多文件先 `.o` 后链接。**