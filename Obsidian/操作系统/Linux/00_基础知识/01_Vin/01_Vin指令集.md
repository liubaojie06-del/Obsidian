---
tags:
  - 工具效率
  - Linux
  - Vim
  - 高阶盲打
  - 程序员利器
指令网站: https://www.runoob.com/linux/linux-vim.html
date: 2026-05-23
cssclasses:
  - cards
  - clean-embeds
---

# 01 | 模式切换与多维导航

> [!abstract] 核心结论
> Vim 的核心不是“输入文字”，而是通过普通模式、插入模式、可视模式、末行模式，把移动、编辑、选择、命令彻底分离，让手指始终停留在主键盘区。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #173B63; color: #333; margin-bottom: 10px;">
<strong>Vim 的模式系统：</strong>
<ul>
  <li><strong>普通模式：</strong> 默认状态，用于移动、删除、复制、粘贴、跳转。</li>
  <li><strong>插入模式：</strong> 真正输入文字的状态。</li>
  <li><strong>可视模式：</strong> 用于选择字符、行、列块。</li>
  <li><strong>末行模式：</strong> 用于保存、退出、替换、配置、执行命令。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `i` | 在光标前插入 |
| `a` | 在光标后插入 |
| `I` | 在当前行第一个非空字符前插入 |
| `A` | 在当前行末尾插入 |
| `o` | 在当前行下方新开一行 |
| `O` | 在当前行上方新开一行 |
| `Esc` | 退出插入 / 可视 / 命令状态 |
| `Ctrl + [` | 等价于 `Esc` |
| `h` | 左移 |
| `j` | 下移 |
| `k` | 上移 |
| `l` | 右移 |
| `w` | 跳到下一个小单词开头 |
| `b` | 跳到上一个小单词开头 |
| `e` | 跳到当前 / 下一个小单词结尾 |
| `W` | 按空格分隔，跳到下一个大单词 |
| `B` | 按空格分隔，跳到上一个大单词 |
| `E` | 按空格分隔，跳到大单词结尾 |
| `0` | 跳到行首 |
| `^` | 跳到当前行第一个非空字符 |
| `$` | 跳到行尾 |
| `g_` | 跳到当前行最后一个非空字符 |
| `gg` | 跳到文件第一行 |
| `G` | 跳到文件最后一行 |
| `125G` | 跳到第 125 行 |
| `H` | 跳到当前屏幕顶部 |
| `M` | 跳到当前屏幕中部 |
| `L` | 跳到当前屏幕底部 |
| `Ctrl + d` | 向下滚动半屏 |
| `Ctrl + u` | 向上滚动半屏 |
| `Ctrl + f` | 向下滚动一屏 |
| `Ctrl + b` | 向上滚动一屏 |
| `f=` | 向右跳到当前行下一个 `=` |
| `F=` | 向左跳到当前行上一个 `=` |
| `t,` | 向右跳到逗号前一个字符 |
| `T,` | 向左跳到逗号后一个字符 |
| `;` | 重复上一次 `f/F/t/T` |
| `,` | 反向重复上一次 `f/F/t/T` |

### ③ 使用场景

| 指令 | 目标范围 | 效果 |
| :--- | :--- | :--- |
| `A` | 当前行末尾 | 直接追加内容 |
| `I` | 当前行开头 | 直接修改缩进后的首字符前 |
| `W` / `B` | 大单词 | 跳过复杂变量名 |
| `0` / `$` | 行首 / 行尾 | 快速定位整行两端 |
| `gg` / `G` | 文件首尾 | 大文件快速穿梭 |
| `f` + 字符 | 当前行 | 精准跳到指定字符 |

> [!tip] 记忆口诀
> **小写细走，大写大跨；`A` 到行尾，`I` 到行首；`gg` 到天，`G` 到地；`f` 加字符行内飞。**

---

# 02 | 删除、修改、复制、粘贴与撤销

> [!abstract] 核心结论
> Vim 的编辑动作遵循“动词 + 范围”的组合语法。删除、修改、复制并不是孤立快捷键，而是一套可自由组合的文本操作系统。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>核心动词：</strong>
<ul>
  <li><strong>d：</strong> delete，删除并进入寄存器，本质是剪切。</li>
  <li><strong>c：</strong> change，删除目标后立刻进入插入模式。</li>
  <li><strong>y：</strong> yank，复制目标到寄存器。</li>
  <li><strong>p / P：</strong> paste，粘贴到后方 / 前方。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `x` | 删除当前字符 |
| `X` | 删除光标前一个字符 |
| `dd` | 删除当前整行 |
| `3dd` | 删除当前行开始的 3 行 |
| `dw` | 删除一个单词 |
| `d$` | 删除到行尾 |
| `d0` | 删除到行首 |
| `D` | 等价于 `d$`，删除到行尾 |
| `cw` | 修改一个单词 |
| `cc` | 修改整行 |
| `C` | 修改到行尾 |
| `s` | 删除当前字符并进入插入模式 |
| `S` | 删除当前整行并进入插入模式 |
| `rX` | 把当前字符替换成 `X` |
| `R` | 进入连续替换模式 |
| `yy` | 复制当前整行 |
| `3yy` | 复制 3 行 |
| `yw` | 复制一个单词 |
| `y$` | 复制到行尾 |
| `y0` | 复制到行首 |
| `p` | 粘贴到光标后 / 当前行下方 |
| `P` | 粘贴到光标前 / 当前行上方 |
| `u` | 撤销 |
| `Ctrl + r` | 反撤销 |
| `.` | 重复上一次修改动作 |

### ③ 使用场景

| 指令 | 行为 | 适合场景 |
| :--- | :--- | :--- |
| `dd` | 剪切整行 | 移动代码行 |
| `cw` | 改一个词 | 修改变量名或数值 |
| `cc` | 改整行 | 重写当前行 |
| `yy` | 复制整行 | 复用配置 / 代码 |
| `p` | 粘贴 | 移动或复制文本 |
| `.` | 重复上次动作 | 批量做同类修改 |

> [!tip] 记忆口诀
> **`d` 是剪切，`c` 是改写，`y` 是复制，`p` 是贴回；点号一按，重复上回。**

---

# 03 | 文本对象与结构化编辑

> [!abstract] 核心结论
> 文本对象让 Vim 从字符级编辑升级为结构级编辑，可以直接操作单词、括号、引号、标签、段落等完整语义块。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #9B59B6; color: #333; margin-bottom: 10px;">
<strong>核心公式：</strong>
<br>
<code>[动词] + [i / a] + [对象]</code>
<ul>
  <li><strong>i = inner：</strong> 只处理内部内容，不包含边界符。</li>
  <li><strong>a = around：</strong> 连同边界符一起处理。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `diw` | 删除当前单词内部 |
| `ciw` | 修改当前单词 |
| `yiw` | 复制当前单词 |
| `daw` | 删除当前单词及周围空格 |
| `di"` | 删除双引号内部 |
| `ci"` | 修改双引号内部 |
| `yi"` | 复制双引号内部 |
| `da"` | 删除双引号及内部内容 |
| `ca"` | 修改双引号及内部内容 |
| `di'` | 删除单引号内部 |
| `ci'` | 修改单引号内部 |
| `yi'` | 复制单引号内部 |
| `di(` | 删除小括号内部 |
| `ci(` | 修改小括号内部 |
| `yi(` | 复制小括号内部 |
| `da(` | 删除小括号及内部内容 |
| `di[` | 删除中括号内部 |
| `ci[` | 修改中括号内部 |
| `yi[` | 复制中括号内部 |
| `di{` | 删除大括号内部 |
| `ci{` | 修改大括号内部 |
| `yi{` | 复制大括号内部 |
| `da{` | 删除大括号及内部内容 |
| `dit` | 删除 HTML/XML 标签内部 |
| `cit` | 修改 HTML/XML 标签内部 |
| `yit` | 复制 HTML/XML 标签内部 |
| `dat` | 删除整个标签及其内容 |
| `dap` | 删除当前段落 |
| `cap` | 修改当前段落 |
| `yap` | 复制当前段落 |

### ③ 使用场景

| 指令 | 操作对象 | 生产力效果 |
| :--- | :--- | :--- |
| `ci"` | 字符串内部 | 快速修改字符串 |
| `ci(` | 函数参数 | 快速重写参数 |
| `yi{` | 代码块内部 | 复制函数体 / 配置块 |
| `da(` | 括号整体 | 连括号一起删除 |
| `cit` | 标签内部 | 修改 HTML 文案 |

> [!tip] 记忆口诀
> **动词修饰名词配，`i` 只吃内部，`a` 连壳包围；括号引号加标签，结构编辑不掉队。**

---

# 04 | 可视模式、列块编辑与批量修改

> [!abstract] 核心结论
> 可视模式负责选择文本，列块模式负责纵向批量操作。它让 Vim 可以一次修改多行开头、变量列、配置列和注释列。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #E67E22; color: #333; margin-bottom: 10px;">
<strong>三种可视选择：</strong>
<ul>
  <li><strong>v：</strong> 字符级选择。</li>
  <li><strong>V：</strong> 整行级选择。</li>
  <li><strong>Ctrl + v：</strong> 列块级选择，适合多行同列批量编辑。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `v` | 字符选择 |
| `V` | 行选择 |
| `Ctrl + v` | 列块选择 |
| `d` | 删除选中内容 |
| `y` | 复制选中内容 |
| `c` | 修改选中内容 |
| `>` | 右缩进 |
| `<` | 左缩进 |
| `=` | 自动缩进 |
| `I` | 在列块前插入 |
| `A` | 在列块后追加 |
| `Esc` | 让列块修改生效到所有选中行 |

### ③ 使用场景

| 操作目标 | 操作流程 |
| :--- | :--- |
| 多行前面批量加注释 | `Ctrl + v` → `j/k` 选择多行 → `I` → 输入 `//` → `Esc` |
| 多行前面批量取消注释 | `Ctrl + v` → 选择注释列 → `d` |
| 多行整体右移 | `V` 选中多行 → `>` |
| 多行整体左移 | `V` 选中多行 → `<` |
| 多行复制 | `V` 选中多行 → `y` → `p` |

> [!tip] 记忆口诀
> **字符选 `v`，整行选 `V`，列块按住 `Ctrl + v`；选好一列大写 `I`，打完字符按 `Esc`。**

---

# 05 | 搜索、替换与正则清洗

> [!abstract] 核心结论
> Vim 的搜索和替换让编辑从“手工找字”升级为“规则化清洗”。通过 `/`、`?`、`n/N`、`:%s`，可以快速定位并批量重构文本。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #C0392B; color: #333; margin-bottom: 10px;">
<strong>搜索替换闭环：</strong>
<ul>
  <li><strong>/keyword：</strong> 向下搜索。</li>
  <li><strong>?keyword：</strong> 向上搜索。</li>
  <li><strong>n / N：</strong> 顺向 / 反向跳到下一个结果。</li>
  <li><strong>:%s/旧/新/g：</strong> 全文替换。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `/error` | 向下搜索 `error` |
| `?timeout` | 向上搜索 `timeout` |
| `n` | 跳到下一个匹配项 |
| `N` | 跳到上一个匹配项 |
| `*` | 搜索当前光标所在单词 |
| `#` | 反向搜索当前光标所在单词 |
| `:noh` | 清除搜索高亮 |
| `:set hlsearch` | 开启搜索高亮 |
| `:set incsearch` | 输入搜索时实时跳转 |
| `:set ignorecase` | 搜索忽略大小写 |
| `:set smartcase` | 出现大写时自动区分大小写 |
| `:s/foo/bar/` | 当前行替换第一个 `foo` |
| `:s/foo/bar/g` | 当前行替换所有 `foo` |
| `:%s/foo/bar/g` | 全文替换所有 `foo` |
| `:%s/foo/bar/gc` | 全文替换，逐个确认 |
| `:20,50s/old/new/g` | 只替换第 20 到 50 行 |
| `:'<,'>s/old/new/g` | 只替换可视模式选中范围 |
| `:%s/\s\+$//g` | 删除每行末尾多余空格 |
| `:%s/^/# /` | 每行行首添加 `#` |
| `:%s/^# //` | 删除每行开头的 `# ` |
| `:%s/\r//g` | 清理 Windows 回车符 |

### ③ 使用场景

| 指令 | 行为 | 安全等级 |
| :--- | :--- | :--- |
| `/word` | 向下查找 | ⭐⭐⭐⭐⭐ |
| `*` | 搜索当前词 | ⭐⭐⭐⭐⭐ |
| `:%s/a/b/g` | 全文替换 | ⭐⭐⭐ |
| `:%s/a/b/gc` | 全文确认替换 | ⭐⭐⭐⭐⭐ |
| `:20,50s/a/b/g` | 局部替换 | ⭐⭐⭐⭐ |

> [!tip] 记忆口诀
> **斜杠向下问号上，`n` 追下个 `N` 回望；替换加 `%` 管全文，带上 `c` 才稳当。**

---

# 06 | 寄存器、系统剪贴板与跨软件搬运

> [!abstract] 核心结论
> Vim 的剪贴板不是一个，而是一组寄存器。掌握无名寄存器、命名寄存器和系统剪贴板，才能在 Vim 内部、文件之间、软件之间自由搬运文本。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #16A085; color: #333; margin-bottom: 10px;">
<strong>寄存器分类：</strong>
<ul>
  <li><strong>无名寄存器 <code>"</code>：</strong> 默认删除、复制、粘贴都使用它。</li>
  <li><strong>命名寄存器 <code>"a</code> 到 <code>"z</code>：</strong> 可以手动指定文本仓库。</li>
  <li><strong>系统剪贴板 <code>"+</code>：</strong> 与操作系统剪贴板互通。</li>
  <li><strong>查看寄存器：</strong> 使用 <code>:reg</code> 查看当前寄存器内容。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `yy` | 复制当前行到默认寄存器 |
| `dd` | 剪切当前行到默认寄存器 |
| `p` | 从默认寄存器粘贴 |
| `"ayy` | 把当前行复制到 `a` 寄存器 |
| `"ap` | 从 `a` 寄存器粘贴 |
| `"bdd` | 把当前行剪切到 `b` 寄存器 |
| `"bp` | 从 `b` 寄存器粘贴 |
| `"+yy` | 复制当前行到系统剪贴板 |
| `"+y` | 复制选中内容到系统剪贴板 |
| `"+p` | 从系统剪贴板粘贴 |
| `"+dd` | 剪切当前行到系统剪贴板 |
| `:reg` | 查看所有寄存器 |
| `:reg a` | 查看 `a` 寄存器 |
| `:reg +` | 查看系统剪贴板寄存器 |

### ③ 使用场景

| 指令 | 操作对象 | 生产用途 |
| :--- | :--- | :--- |
| `yy` | 当前行 | 快速复制配置行 |
| `"ayy` | a 寄存器 | 暂存关键代码 |
| `"ap` | a 寄存器 | 粘贴指定仓库内容 |
| `"+y` | 系统剪贴板 | 从 Vim 复制到浏览器 |
| `"+p` | 系统剪贴板 | 从外部软件粘贴进 Vim |

> [!tip] 记忆口诀
> **默认复制进无名，命名仓库双引领；加号连通系统板，跨界搬运不费劲。**

---

# 07 | 多文件、Buffer、窗口与标签页

> [!abstract] 核心结论
> Vim 的多文件管理分为三层：Buffer 是已打开文件，Window 是显示文件的视口，Tab 是窗口布局集合。理解这三层，Vim 才真正成为工程级编辑器。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2980B9; color: #333; margin-bottom: 10px;">
<strong>三层抽象：</strong>
<ul>
  <li><strong>Buffer：</strong> Vim 已经加载进内存的文件。</li>
  <li><strong>Window：</strong> 当前屏幕上显示 Buffer 的区域。</li>
  <li><strong>Tab：</strong> 一组 Window 布局，不等于浏览器式单文件标签。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `:e main.py` | 打开 `main.py` |
| `:ls` | 查看所有 Buffer |
| `:bnext` | 切到下一个 Buffer |
| `:bprev` | 切到上一个 Buffer |
| `:b 3` | 切到编号为 3 的 Buffer |
| `:bd` | 关闭当前 Buffer |
| `:split` | 水平分屏 |
| `:sp` | 水平分屏简写 |
| `:vsplit` | 垂直分屏 |
| `:vsp` | 垂直分屏简写 |
| `Ctrl + w + w` | 在窗口间循环切换 |
| `Ctrl + w + h` | 切到左侧窗口 |
| `Ctrl + w + j` | 切到下方窗口 |
| `Ctrl + w + k` | 切到上方窗口 |
| `Ctrl + w + l` | 切到右侧窗口 |
| `Ctrl + w + =` | 所有窗口等宽等高 |
| `Ctrl + w + _` | 当前窗口高度最大化 |
| `Ctrl + w + \|` | 当前窗口宽度最大化 |
| `:tabnew` | 新建标签页 |
| `:tabedit a.py` | 在新标签页打开 `a.py` |
| `:tabnext` | 下一个标签页 |
| `:tabprev` | 上一个标签页 |
| `:tabclose` | 关闭当前标签页 |

### ③ 使用场景

| 指令 | 层级 | 使用场景 |
| :--- | :--- | :--- |
| `:e file` | Buffer | 打开新文件 |
| `:ls` | Buffer | 查看已加载文件 |
| `:bnext` | Buffer | 多文件轮换 |
| `:vsplit` | Window | 左右对照代码 |
| `Ctrl + w + h/j/k/l` | Window | 像光标一样切换窗口 |
| `:tabnew` | Tab | 保存一套独立布局 |

> [!tip] 记忆口诀
> **Buffer 是文件，Window 是窗口；Tab 管布局，别当网页瞅。**

---

# 08 | 宏录制、标记与重复自动化

> [!abstract] 核心结论
> Vim 的宏、标记和重复命令，让重复劳动变成可录制、可回放、可跳转的自动化流程，尤其适合批量格式化和规则化编辑。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #8E44AD; color: #333; margin-bottom: 10px;">
<strong>三种自动化能力：</strong>
<ul>
  <li><strong>宏：</strong> 把一串按键录制下来，再批量重放。</li>
  <li><strong>标记：</strong> 给当前位置打书签，之后快速跳回。</li>
  <li><strong>重复：</strong> 用 <code>.</code> 重复上一次修改动作。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `qa` | 开始录制到 `a` 寄存器 |
| `q` | 停止录制 |
| `@a` | 执行 `a` 宏 |
| `@@` | 重复执行上一次宏 |
| `10@a` | 连续执行 10 次 `a` 宏 |
| `ma` | 在当前位置设置标记 `a` |
| `` `a `` | 精确跳回标记 `a` 的光标位置 |
| `'a` | 跳回标记 `a` 所在行 |
| `mA` | 设置跨文件标记 `A` |
| `` `A `` | 跨文件跳回标记 `A` |
| `:marks` | 查看所有标记 |
| `.` | 重复上一次修改动作 |
| `5.` | 重复上一次修改动作 5 次 |

### ③ 使用场景

| 场景 | 操作思路 |
| :--- | :--- |
| 批量修改相似行 | 先用 `qa` 录一行操作，再用 `10@a` 批量执行 |
| 重复执行刚才的修改 | 使用 `.` |
| 回到刚才的重要位置 | 使用 `ma` 标记，再用 `` `a `` 跳回 |
| 跨文件记录入口函数 | 使用 `mA`，再用 `` `A `` 回跳 |
| 批量格式化固定结构文本 | 宏录制 + 数字前缀执行 |

> [!tip] 记忆口诀
> **`q` 开录像进仓库，`@` 键重放不跑路；`m` 键落锚定位置，点号重复上一步。**

---

# 09 | 折叠、缩进、格式化与外部命令

> [!abstract] 核心结论
> Vim 不只是编辑器，也是文本加工台。通过折叠、缩进、格式化和 Shell 联动，可以把复杂文件压成提纲，把混乱文本清洗成结构化内容。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #34495E; color: #333; margin-bottom: 10px;">
<strong>文本加工四件套：</strong>
<ul>
  <li><strong>折叠：</strong> 把长代码临时收起成结构提纲。</li>
  <li><strong>缩进：</strong> 用 <code>&gt;</code>、<code>&lt;</code>、<code>=</code> 调整代码层级。</li>
  <li><strong>格式化：</strong> 用 <code>gq</code> 重排文本段落。</li>
  <li><strong>Shell 联动：</strong> 用 <code>:!</code>、<code>:r !</code>、<code>:%!</code> 调用外部工具。</li>
</ul>
</div>

### ② 代码用法

| 指令 | 作用 |
| :--- | :--- |
| `zfap` | 折叠当前段落 |
| `zf%` | 从当前位置折叠到匹配括号 |
| `zo` | 打开当前折叠 |
| `zc` | 关闭当前折叠 |
| `za` | 切换当前折叠状态 |
| `zR` | 打开所有折叠 |
| `zM` | 关闭所有折叠 |
| `:set foldmethod=indent` | 按缩进折叠 |
| `:set foldmethod=syntax` | 按语法折叠 |
| `:set foldmethod=manual` | 手动折叠 |
| `>>` | 当前行右缩进 |
| `<<` | 当前行左缩进 |
| `3>>` | 当前行开始连续 3 行右缩进 |
| `>ip` | 缩进当前段落 |
| `>i{` | 缩进当前大括号内部 |
| `=G` | 从当前位置到文件末尾自动缩进 |
| `gg=G` | 全文自动缩进 |
| `gqap` | 格式化当前段落文本 |
| `:!ls` | 在 Vim 中执行 `ls` |
| `:!pwd` | 查看当前目录 |
| `:!python %` | 运行当前 Python 文件 |
| `:r !date` | 插入当前日期 |
| `:r !pwd` | 插入当前路径 |
| `:w !wc -l` | 统计当前文件行数 |
| `:%!sort` | 用 `sort` 对全文排序 |
| `:%!jq .` | 用 `jq` 格式化 JSON |

### ③ 使用场景

| 指令 | 行为 | 适用场景 |
| :--- | :--- | :--- |
| `za` | 开关当前折叠 | 快速查看函数细节 |
| `zM` | 全部折叠 | 生成代码大纲 |
| `gg=G` | 全文缩进 | 整理代码格式 |
| `gqap` | 段落排版 | 整理 Markdown / 注释 |
| `:%!jq .` | JSON 格式化 | 清洗接口返回 |
| `:r !date` | 读入命令结果 | 插入日期 / 系统信息 |

> [!tip] 记忆口诀
> **`z` 管折叠，大小于管缩进；等号排版，感叹号连 Shell。**

---

# 10 | 保存退出、配置文件与终极组合总表

> [!abstract] 核心结论
> Vim 的日常效率最终落在两件事上：熟练掌握保存退出，持续把高频习惯固化进 `.vimrc`。当“动词 + 对象 + 范围”成为肌肉记忆，Vim 才真正变成程序员利器。

### ① 底层原理

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #1ABC9C; color: #333; margin-bottom: 10px;">
<strong>Vim 最终心法：</strong>
<ul>
  <li><strong>保存退出：</strong> 负责文件生命周期。</li>
  <li><strong>.vimrc：</strong> 负责个人习惯固化。</li>
  <li><strong>组合语法：</strong> 负责无限扩展编辑能力。</li>
</ul>
</div>

### ② 保存退出

| 指令 | 作用 |
| :--- | :--- |
| `:w` | 保存 |
| `:q` | 退出 |
| `:wq` | 保存并退出 |
| `:x` | 保存并退出 |
| `:q!` | 不保存强制退出 |
| `:w filename` | 另存为 `filename` |
| `:wa` | 保存所有文件 |
| `:qa` | 退出所有窗口 |
| `:wqa` | 保存并退出所有窗口 |

### ③ 常用 `.vimrc` 配置

| 配置 | 作用 |
| :--- | :--- |
| `set number` | 显示绝对行号 |
| `set relativenumber` | 显示相对行号 |
| `set ruler` | 显示光标位置 |
| `set showcmd` | 显示正在输入的命令 |
| `set cursorline` | 高亮当前行 |
| `set hlsearch` | 搜索结果高亮 |
| `set incsearch` | 搜索时实时跳转 |
| `set ignorecase` | 搜索忽略大小写 |
| `set smartcase` | 有大写时自动区分大小写 |
| `set tabstop=4` | Tab 显示宽度为 4 |
| `set shiftwidth=4` | 自动缩进宽度为 4 |
| `set expandtab` | Tab 转为空格 |
| `set autoindent` | 自动继承上一行缩进 |
| `set smartindent` | 智能缩进 |
| `set encoding=utf-8` | 设置编码为 UTF-8 |
| `set fileencoding=utf-8` | 文件编码为 UTF-8 |
| `set backspace=indent,eol,start` | 让退格键更符合直觉 |
| `nnoremap <Space> :nohlsearch<CR>` | 空格清除搜索高亮 |
| `nnoremap <F5> :w<CR>:!python3 %<CR>` | F5 保存并运行当前 Python 文件 |

### ④ 终极组合总表

| 组合 | 含义 | 场景 |
| :--- | :--- | :--- |
| `dw` | 删除一个单词 | 删除变量 |
| `cw` | 修改一个单词 | 修改变量名 |
| `d$` | 删除到行尾 | 清理后半行 |
| `c$` | 修改到行尾 | 重写后半行 |
| `yy` | 复制整行 | 复制配置 |
| `dd` | 剪切整行 | 移动代码 |
| `ci"` | 修改引号内部 | 修改字符串 |
| `ci(` | 修改括号内部 | 修改参数 |
| `yi{` | 复制大括号内部 | 复制代码块 |
| `da(` | 删除括号及内容 | 删除整组参数 |
| `gg=G` | 全文自动缩进 | 整理代码 |
| `:%s/a/b/gc` | 全文确认替换 | 安全重构 |

> [!tip] 终极口诀
> **模式分工是根，动词对象是魂；移动不用鼠标，修改不用重敲；配置写进 vimrc，效率每天自动涨。**