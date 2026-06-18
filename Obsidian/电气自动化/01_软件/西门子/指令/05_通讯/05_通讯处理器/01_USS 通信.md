---
tags:
  - PLC
  - TIA_Portal
  - USS通信
  - 变频器通信
  - 驱动器
  - 参数读写
  - 数据交换
  - 西门子
aliases:
  - USS 通信
  - USS Communication
  - USS_Port_Scan
  - USS_Drive_Control
  - USS_Read_Param
  - USS_Write_Param
  - 驱动器数据交换
  - USS 参数读写
---
## 01 `USS_Port_Scan` | 通过 USS 网络进行通信

> [!info] 核心结论
> **USS_Port_Scan** 用于扫描和管理 USS 网络通信，是 PLC 与多个 USS 驱动器通信的基础入口。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V5.1</strong><br>
指令版本：<strong>V5.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS 通信** |
| 指令名称 | **USS_Port_Scan** |
| 功能描述 | **通过 USS 网络进行通信** |
| 版本 | **V5.1** |
| 核心作用 | 管理 USS 网络通信扫描 |
| 使用重点 | 通信端口、波特率、站地址、驱动器数量需按实际硬件和驱动器手册校核 |

### ② 参考表

| 参数/概念 | 说明 |
|---|---|
| USS 网络 | PLC 与驱动器之间的通信网络 |
| 端口参数 | 波特率、校验、通信口配置 |
| 站地址 | 每台驱动器需有唯一地址 |
| 扫描周期 | 影响通信响应速度 |
| 通信状态 | 需监控错误码、忙状态和完成状态 |

### ③ 计算/选型示例

- 已知：PLC 需要通过 USS 网络控制 3 台变频器
- 公式/规则：多驱动器通信前，先建立 USS 网络扫描
- 操作：使用 **USS_Port_Scan** 配置通信口和站点扫描
- 结论：USS 网络通信建立后，才能进行控制和参数读写

> [!tip] 记忆口诀
> **USS 先扫网，站号端口别搞乱。**


## 02 `USS_Drive_Control` | 与驱动器进行数据交换

> [!info] 核心结论
> **USS_Drive_Control** 用于 PLC 与驱动器进行控制字、状态字、设定值和实际值等数据交换。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V5.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS 通信** |
| 指令名称 | **USS_Drive_Control** |
| 功能描述 | **与驱动器进行数据交换** |
| 版本 | **V5.0** |
| 核心作用 | 与驱动器交换控制和运行数据 |
| 使用重点 | 控制字、状态字、速度给定、反馈值需按驱动器参数和报文格式校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
控制驱动器时，一般要同时关注：<strong>控制字、状态字、给定值、实际值</strong>。
</div>

### ② 参考表

| 数据类型 | 常见用途 |
|---|---|
| 控制字 | 启动、停止、复位、使能 |
| 状态字 | 运行、故障、就绪、报警 |
| 速度给定 | PLC 下发目标频率/速度 |
| 实际速度 | 驱动器反馈当前运行速度 |
| 故障信息 | 用于报警和诊断 |

### ③ 计算/选型示例

- 已知：PLC 需要启动变频器并给定 30 Hz 运行频率
- 公式/规则：控制运行用 **USS_Drive_Control**
- 操作：发送控制字和速度给定，同时读取状态字和实际值
- 结论：驱动器可按 PLC 指令运行，并反馈当前状态

> [!tip] 记忆口诀
> **控驱动看四样：控制字、状态字、给定值、反馈值。**


## 03 `USS_Read_Param` | 从驱动器读取数据

> [!info] 核心结论
> **USS_Read_Param** 用于从驱动器读取参数或数据，适合读取频率、故障码、参数值和运行信息。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V5.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS 通信** |
| 指令名称 | **USS_Read_Param** |
| 功能描述 | **从驱动器读取数据** |
| 版本 | **V5.0** |
| 核心作用 | 读取驱动器参数数据 |
| 使用重点 | 参数号、索引号、数据类型和返回状态需按驱动器手册校核 |

### ② 参考表

| 读取内容 | 说明 |
|---|---|
| 参数值 | 读取驱动器内部参数 |
| 故障码 | 读取故障或报警信息 |
| 运行数据 | 读取频率、电流、电压等 |
| 配置数据 | 读取驱动器设置 |
| 状态反馈 | 判断读取是否成功 |

### ③ 计算/选型示例

- 已知：需要读取变频器当前故障码
- 公式/规则：驱动器参数读取用 **USS_Read_Param**
- 操作：填写对应参数号和索引，触发读取
- 结论：PLC 获得驱动器参数值，可用于 HMI 显示或报警诊断

> [!tip] 记忆口诀
> **想看驱动参数，用 Read_Param 读出来。**


## 04 `USS_Write_Param` | 更改驱动器中的数据

> [!info] 核心结论
> **USS_Write_Param** 用于向驱动器写入参数或数据，适合修改设定、配置或运行参数。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V5.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **USS 通信** |
| 指令名称 | **USS_Write_Param** |
| 功能描述 | **更改驱动器中的数据** |
| 版本 | **V5.0** |
| 核心作用 | 写入驱动器参数数据 |
| 使用重点 | 写入参数前必须确认权限、范围、数据类型和设备运行状态 |

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">安全提醒</strong><br>
写驱动器参数前，要确认该参数是否允许在线修改，避免影响设备运行。
</div>

### ② 参考表

| 写入内容 | 说明 |
|---|---|
| 速度/频率设定 | 修改运行给定值 |
| 参数配置 | 修改驱动器内部参数 |
| 控制相关数据 | 需配合安全联锁 |
| 维护参数 | 需权限和确认 |
| 风险校核 | 参数范围和写入时机必须确认 |

### ③ 计算/选型示例

- 已知：需要把驱动器某参数改为新设定值
- 公式/规则：驱动器参数写入用 **USS_Write_Param**
- 操作：填写参数号、索引和写入值，确认范围后执行写入
- 结论：驱动器参数被更新，后续运行按新参数执行

> [!tip] 记忆口诀
> **写参数要谨慎，先查范围再写入。**


## 05 USS 通信 | 选型速记

> [!info] 核心结论
> USS 通信的核心是：**先用 USS_Port_Scan 建立通信，再用 Drive_Control 控制驱动器，参数读取用 Read，参数修改用 Write。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
扫网用 Port_Scan，控制用 Drive_Control；读参 Read_Param，写参 Write_Param。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| USS 网络通信 | **USS_Port_Scan** |
| 驱动器控制交换 | **USS_Drive_Control** |
| 读取驱动器参数 | **USS_Read_Param** |
| 写入驱动器参数 | **USS_Write_Param** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 建立 USS 网络通信 | **USS_Port_Scan** |
| 控制变频器启停 | **USS_Drive_Control** |
| 下发速度/频率给定 | **USS_Drive_Control** |
| 读取驱动器状态 | **USS_Drive_Control / USS_Read_Param** |
| 读取驱动器参数 | **USS_Read_Param** |
| 修改驱动器参数 | **USS_Write_Param** |
| 读取故障码 | **USS_Read_Param** |
| 多台驱动器通信 | 先校核站地址和扫描配置 |

### ③ 计算/选型示例

- 已知：PLC 要控制变频器运行，并在 HMI 上显示故障码
- 公式/规则：控制运行用 **USS_Drive_Control**，读取故障码用 **USS_Read_Param**
- 操作：先用 **USS_Port_Scan** 建立通信，再用 **USS_Drive_Control** 控制启停和速度，最后用 **USS_Read_Param** 读取故障信息
- 结论：这是典型的 USS 驱动器通信控制流程

> [!tip] 记忆口诀
> **USS 三步走：先扫网，再控驱动，读写参数看需求。**