---
type: prompt-template
category: Obsidian
note_type: Linux命令笔记
tags:
  - prompt-template
  - Obsidian
  - Linux
created: 2026-06-21
updated: 2026-06-21
---

# Linux 命令笔记提示词

## 适用场景

用于整理 Linux 命令、Shell 指令、GCC/Vim 等工具命令笔记。

## 对应笔记类型

命令速查、Linux 基础指令、工具使用教程。

## 使用前准备

- 提供命令名称或主题。
- 提供示例场景。
- 提供已有命令笔记作为参考。

## 完整提示词

```text
请帮我生成一篇 Obsidian Linux 命令笔记。

命令或主题：
使用场景：
参考资料：
相关已有笔记：

请模仿我现有 Linux 指令笔记风格：
1. 使用 frontmatter：tags、type: 知识卡片、date、cssclasses: [cards, clean-embeds]。
2. 开头使用 `> [!abstract] 核心结论`。
3. 解释命令底层作用：它操作文件、目录、进程、权限、网络还是系统环境。
4. 给出基本语法：
   ```bash
   命令 [选项] [参数]
   ```
5. 用表格整理常用选项。
6. 给出 3-8 个真实使用示例。
7. 标明常见错误和危险操作，使用 `> [!warning]`。
8. 给出记忆口诀，使用 `> [!tip] 记忆口诀`。
9. 如果适合，加入相关命令双链。
10. 不要只列命令，要说明什么时候用、为什么这么用。

请输出完整 Markdown。
```

## 使用方法

适合整理 Linux、Vim、GCC、Shell 命令。

## 输出格式要求

- 必须有命令格式代码块。
- 必须有选项表。
- 必须有常见错误。

## 效果记录

| 日期 | 使用场景 | 效果评分 | 问题 | 优化记录 |
| -- | ---- | ---- | -- | ---- |
