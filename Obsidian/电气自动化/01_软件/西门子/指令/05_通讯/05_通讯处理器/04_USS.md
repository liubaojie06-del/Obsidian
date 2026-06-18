---
tags:
  - PLC
  - TIA_Portal
  - USS
  - USS通信
  - 变频器通信
  - 驱动器
  - 参数读写
  - 西门子
aliases:
  - USS
  - USS_PORT
  - USS_DRV
  - USS_RPM
  - USS_WPM
  - USS 驱动器通信
  - USS 参数读写
---
## 01 `USS_PORT` | 编辑通过 USS 网络执行的通信

> [!info] 核心结论
> **USS_PORT** 用于配置和管理 USS 网络通信，是 PLC 与 USS 驱动器通信前的基础指令。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V1.1</strong><br>
指令版本：<strong>V1.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS** |
| 指令名称 | **USS_PORT** |
| 功能描述 | **编辑通过 USS 网络执行的通信** |
| 版本 | **V1.1** |
| 核心作用 | 建立 / 管理 USS 网络通信 |
| 使用重点 | 端口、波特率、站地址、驱动器数量需按实际硬件和驱动器手册校核 |

### ② 参考表

| 参数/概念 | 说明 |
|---|---|
| 通信端口 | PLC 与驱动器连接的串口或通信模块 |
| 波特率 | PLC 与驱动器必须一致 |
| USS 地址 | 每台驱动器地址必须唯一 |
| 扫描通信 | 用于周期性与驱动器交换数据 |
| 通信状态 | 需监控忙、完成、错误等状态 |

### ③ 计算/选型示例

- 已知：PLC 需要通过 USS 网络控制 2 台变频器
- 公式/规则：通信前先配置 USS 网络和端口参数
- 操作：使用 **USS_PORT** 设置通信端口、波特率和站地址
- 结论：USS 通信基础建立后，才能继续使用驱动控制和参数读写指令

> [!tip] 记忆口诀
> **USS 先配 PORT，端口站号别搞错。**


## 02 `USS_DRV` | 与驱动器交换数据

> [!info] 核心结论
> **USS_DRV** 用于 PLC 与驱动器交换运行控制数据，常用于启停、速度给定、状态反馈等控制场景。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V1.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS** |
| 指令名称 | **USS_DRV** |
| 功能描述 | **与驱动器交换数据** |
| 版本 | **V1.1** |
| 核心作用 | 与驱动器进行控制和状态数据交换 |
| 使用重点 | 控制字、状态字、给定值、实际值需按驱动器报文格式校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
控制驱动器重点看四个量：<strong>控制字、状态字、速度给定、速度反馈</strong>。
</div>

### ② 参考表

| 数据类型 | 常见用途 |
|---|---|
| 控制字 | 启动、停止、复位、使能 |
| 状态字 | 就绪、运行、故障、报警 |
| 给定值 | 速度、频率或转速设定 |
| 实际值 | 当前速度、频率或反馈值 |
| 故障状态 | 用于 HMI 报警和诊断 |

### ③ 计算/选型示例

- 已知：PLC 需要启动变频器，并给定运行频率 `30 Hz`
- 公式/规则：驱动器运行数据交换用 **USS_DRV**
- 操作：通过 **USS_DRV** 发送控制字和速度给定，同时读取状态字和实际值
- 结论：PLC 可控制驱动器运行，并实时获取驱动器状态

> [!tip] 记忆口诀
> **控驱动用 USS_DRV，发给定，读反馈。**


## 03 `USS_RPM` | 从驱动器读出参数

> [!info] 核心结论
> **USS_RPM** 用于从 USS 驱动器中读取参数，适合读取故障码、运行参数和配置数据。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V1.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS** |
| 指令名称 | **USS_RPM** |
| 功能描述 | **从驱动器读出参数** |
| 版本 | **V1.1** |
| 核心作用 | 读取驱动器参数 |
| 使用重点 | 参数号、索引、数据类型、返回状态需按驱动器手册校核 |

### ② 参考表

| 读取内容 | 说明 |
|---|---|
| 参数值 | 读取驱动器内部设定 |
| 故障码 | 用于报警和诊断 |
| 运行数据 | 如频率、电流、电压等 |
| 配置数据 | 读取驱动器当前配置 |
| 返回状态 | 判断读取是否成功 |

### ③ 计算/选型示例

- 已知：HMI 需要显示变频器当前故障码
- 公式/规则：从驱动器读取参数用 **USS_RPM**
- 操作：填写对应参数号和索引，触发读取
- 结论：PLC 获得驱动器参数值，可用于显示或报警判断

> [!tip] 记忆口诀
> **RPM 是读参数，想看驱动先读出。**


## 04 `USS_WPM` | 更改驱动器中的参数

> [!info] 核心结论
> **USS_WPM** 用于向 USS 驱动器写入或修改参数，适合更改设定值、配置参数和维护参数。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V1.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS** |
| 指令名称 | **USS_WPM** |
| 功能描述 | **更改驱动器中的参数** |
| 版本 | **V1.1** |
| 核心作用 | 写入 / 修改驱动器参数 |
| 使用重点 | 写入前必须确认参数权限、范围、数据类型和运行状态 |

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">安全提醒</strong><br>
写驱动器参数前，先确认该参数是否允许在线修改，避免影响设备运行。
</div>

### ② 参考表

| 写入内容 | 说明 |
|---|---|
| 速度/频率设定 | 修改运行给定或相关参数 |
| 驱动器配置 | 修改内部参数 |
| 维护参数 | 需权限和确认 |
| 控制相关参数 | 必须加联锁保护 |
| 风险校核 | 参数范围、写入时机、掉电保持需确认 |

### ③ 计算/选型示例

- 已知：需要把变频器某参数改为新设定值
- 公式/规则：向驱动器写参数用 **USS_WPM**
- 操作：填写参数号、索引和写入值，确认范围后执行
- 结论：驱动器参数被更新，后续运行按新参数执行

> [!tip] 记忆口诀
> **WPM 是写参数，写前校核别手快。**


## 05 USS | 选型速记

> [!info] 核心结论
> USS 指令的核心是：**先用 USS_PORT 建通信，再用 USS_DRV 控驱动，读参数用 USS_RPM，写参数用 USS_WPM。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
PORT 管通信，DRV 控驱动；RPM 读参数，WPM 写参数。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| USS 网络通信 | **USS_PORT** |
| 驱动器数据交换 | **USS_DRV** |
| 读取驱动器参数 | **USS_RPM** |
| 修改驱动器参数 | **USS_WPM** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 配置 USS 通信网络 | **USS_PORT** |
| 控制变频器启停 | **USS_DRV** |
| 下发速度 / 频率给定 | **USS_DRV** |
| 读取驱动器状态 | **USS_DRV / USS_RPM** |
| 读取驱动器参数 | **USS_RPM** |
| 修改驱动器参数 | **USS_WPM** |
| 读取故障码 | **USS_RPM** |
| 多台驱动器通信 | 先校核站地址和端口配置 |

### ③ 计算/选型示例

- 已知：PLC 要控制变频器运行，并在 HMI 上显示故障码
- 公式/规则：通信先建立，控制和参数读写分开处理
- 操作：先用 **USS_PORT** 建立通信；用 **USS_DRV** 控制启停和速度；用 **USS_RPM** 读取故障码；需要修改参数时用 **USS_WPM**
- 结论：这是典型的 USS 驱动器通信控制流程

> [!tip] 记忆口诀
> **USS 四步记：PORT 建网，DRV 控制，RPM 读取，WPM 写入。**