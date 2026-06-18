---
tags:
  - PLC
  - TIA_Portal
  - SINAMICS
  - 驱动控制
  - 速度控制
  - 位置控制
  - 参数读写
  - Infeed
  - 西门子
aliases:
  - SINAMICS
  - SinaPos
  - SinaSpeed
  - SinaPara
  - SinaParaS
  - SinaInfeed
  - SINAMICS 驱动控制
  - SINAMICS 参数读写
---

## 01 `SinaPos` | 标准报文 111 中位置控制

> [!info] 核心结论
> **SinaPos** 用于通过 SINAMICS 标准报文 111 实现位置控制，适合伺服定位、轴运动和点位控制场景。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V2.2</strong><br>
指令版本：<strong>V2.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SINAMICS** |
| 指令名称 | **SinaPos** |
| 功能描述 | **标准报文 111 中位置控制** |
| 版本 | **V2.1** |
| 核心作用 | 控制 SINAMICS 驱动进行定位运动 |
| 使用重点 | 报文类型、轴使能、目标位置、速度、加减速需按实际驱动手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
位置控制重点看：<strong>使能、目标位置、速度、到位状态、故障反馈</strong>。
</div>

### ② 参考表

| 参数/状态 | 说明 |
|---|---|
| 目标位置 | 轴需要运动到的位置 |
| 目标速度 | 运动过程中的速度限制 |
| 加减速 | 控制启动和停止平滑性 |
| 使能信号 | 驱动允许运动的前提 |
| 到位信号 | 判断定位是否完成 |
| 故障状态 | 用于报警和安全处理 |

### ③ 计算/选型示例

- 已知：伺服轴需要移动到 `100.0 mm`
- 公式/规则：位置控制选择 **SinaPos**
- 操作：设置目标位置、速度、加减速，并确认驱动使能
- 结论：轴按设定参数运动到目标位置

> [!tip] 记忆口诀
> **定位找 SinaPos，位置速度一起控。**


## 02 `SinaSpeed` | 标准报文 1 中转速控制

> [!info] 核心结论
> **SinaSpeed** 用于通过 SINAMICS 标准报文 1 实现速度控制，适合变频器、主轴、电机转速给定场景。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
指令版本：<strong>V1.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SINAMICS** |
| 指令名称 | **SinaSpeed** |
| 功能描述 | **标准报文 1 中转速控制** |
| 版本 | **V1.0** |
| 核心作用 | 控制 SINAMICS 驱动转速 |
| 使用重点 | 控制字、状态字、速度给定、速度反馈需按实际报文校核 |

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">重点公式</strong><br>
速度控制核心 = 控制字 + 速度给定 + 状态字 + 实际速度
</div>

### ② 参考表

| 参数/状态 | 说明 |
|---|---|
| 控制字 | 启动、停止、复位、使能 |
| 状态字 | 就绪、运行、故障、报警 |
| 速度给定 | PLC 下发的目标转速 |
| 实际速度 | 驱动反馈的当前转速 |
| 故障反馈 | 用于报警和联锁处理 |

### ③ 计算/选型示例

- 已知：电机需要以 `1500 rpm` 运行
- 公式/规则：转速控制选择 **SinaSpeed**
- 操作：下发使能和速度给定，同时读取状态字和实际速度
- 结论：驱动按目标转速运行，PLC 可监控当前速度状态

> [!tip] 记忆口诀
> **调转速用 SinaSpeed，给定反馈都要看。**


## 03 `SinaPara` | 来自/至 SINAMICS S/G 的参数访问

> [!info] 核心结论
> **SinaPara** 用于对 SINAMICS S/G 驱动进行参数读写，适合读取驱动参数、修改设定和做维护诊断。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
指令版本：<strong>V1.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SINAMICS** |
| 指令名称 | **SinaPara** |
| 功能描述 | **来自/至 SINAMICS S/G 的参数访问** |
| 版本 | **V1.1** |
| 核心作用 | 读取/写入 SINAMICS 参数 |
| 说明 | 截图描述有省略，完整参数结构需按实际 SINAMICS 手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">安全提醒</strong><br>
写驱动参数前必须确认：<strong>参数号、索引、数据类型、写入权限、是否允许在线修改</strong>。
</div>

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 读取参数 | 读取驱动内部参数值 |
| 修改参数 | 写入新的设定或配置 |
| 故障诊断 | 读取报警、故障或状态相关参数 |
| 调试维护 | 查看驱动配置和运行数据 |
| 风险提醒 | 写错参数可能影响设备运行 |

### ③ 计算/选型示例

- 已知：HMI 需要读取驱动器某个参数用于显示
- 公式/规则：SINAMICS 参数访问用 **SinaPara**
- 操作：填写参数号、索引和访问方向
- 结论：PLC 可读取或写入驱动参数，用于显示、维护或调整

> [!tip] 记忆口诀
> **查参改参用 SinaPara，写前先核参数号。**


## 04 `SinaParaS` | 来自/至 SINAMICS S/G 的参数访问

> [!info] 核心结论
> **SinaParaS** 用于 SINAMICS S/G 参数访问，适合参数读写的结构化或简化应用场景，具体差异需按实际手册校核。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
指令版本：<strong>V1.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SINAMICS** |
| 指令名称 | **SinaParaS** |
| 功能描述 | **来自/至 SINAMICS S/G 的参数访问** |
| 版本 | **V1.1** |
| 核心作用 | 读取/写入 SINAMICS 参数 |
| 说明 | 与 SinaPara 的具体使用差异需按实际软件帮助/厂家手册校核 |

### ② 参考表

| 对比项 | SinaPara / SinaParaS |
|---|---|
| 功能方向 | 均用于 SINAMICS 参数访问 |
| 使用对象 | SINAMICS S/G 驱动 |
| 典型用途 | 参数读取、参数写入、维护诊断 |
| 差异说明 | 需按实际库版本和手册确认 |
| 风险提醒 | 参数写入前必须校核权限和范围 |

### ③ 计算/选型示例

- 已知：需要对 SINAMICS 驱动进行参数访问，但项目使用的是 SinaParaS 标准块
- 公式/规则：按项目库选择对应参数访问块
- 操作：使用 **SinaParaS**，配置参数号、索引和读写方向
- 结论：可完成驱动参数读取或写入

> [!tip] 记忆口诀
> **Para 管参数，ParaS 也管参；区别细节看手册。**


## 05 `SinaInfeed` | 标准报文 370 中控制 Infeed

> [!info] 核心结论
> **SinaInfeed** 用于通过标准报文 370 控制 SINAMICS Infeed 进线单元，适合驱动系统供电单元的启停和状态监控。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
指令版本：<strong>V1.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SINAMICS** |
| 指令名称 | **SinaInfeed** |
| 功能描述 | **标准报文 370 中控制 Infeed** |
| 版本 | **V1.0** |
| 核心作用 | 控制 SINAMICS 进线单元 |
| 说明 | 截图描述有省略，完整报文和参数需按实际 SINAMICS 手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">重点规则</strong><br>
Infeed 是驱动系统供电入口，控制前要确认：<strong>电源状态、使能条件、故障状态、安全联锁</strong>。
</div>

### ② 参考表

| 参数/状态 | 说明 |
|---|---|
| 使能条件 | 允许进线单元投入运行 |
| 运行状态 | 判断 Infeed 是否正常运行 |
| 故障状态 | 检测进线单元报警/故障 |
| DC 母线状态 | 需结合实际系统监控 |
| 安全联锁 | 上电、断电、急停逻辑需校核 |

### ③ 计算/选型示例

- 已知：驱动系统上电后，需要控制 Infeed 投入运行
- 公式/规则：进线单元控制用 **SinaInfeed**
- 操作：确认安全条件和电源状态后，发送控制命令并读取反馈状态
- 结论：Infeed 正常投入后，后续驱动轴才具备运行条件

> [!tip] 记忆口诀
> **驱动先有电，Infeed 先上线。**


## 06 SINAMICS | 选型速记

> [!info] 核心结论
> SINAMICS 指令选型先看控制对象：**定位用 SinaPos，调速用 SinaSpeed，参数访问用 SinaPara/SinaParaS，进线单元用 SinaInfeed。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
位置 Pos，速度 Speed；参数 Para，进线 Infeed。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 位置控制 | **SinaPos** |
| 速度控制 | **SinaSpeed** |
| 参数访问 | **SinaPara / SinaParaS** |
| 进线单元控制 | **SinaInfeed** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 控制伺服轴定位 | **SinaPos** |
| 控制电机转速 | **SinaSpeed** |
| 读取驱动参数 | **SinaPara / SinaParaS** |
| 写入驱动参数 | **SinaPara / SinaParaS** |
| 控制进线单元 | **SinaInfeed** |
| 驱动状态监控 | 根据报文读取状态字/反馈值 |
| 驱动故障诊断 | 结合参数访问和状态字判断 |

### ③ 计算/选型示例

- 已知：一套 SINAMICS 系统中，进线单元要先投入，伺服轴再做定位，HMI 还要读取驱动参数
- 公式/规则：进线用 Infeed，定位用 Pos，参数用 Para
- 操作：先用 **SinaInfeed** 控制供电单元，再用 **SinaPos** 控制轴定位，最后用 **SinaPara** 读取参数用于显示
- 结论：这是典型的 SINAMICS 驱动系统控制流程

> [!tip] 记忆口诀
> **先 Infeed 供电，再 Pos/Speed 控轴；参数维护找 Para。**