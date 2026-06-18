---
tags:
  - PLC
  - TIA_Portal
  - BasicPosControl
  - SINAMICS
  - 运动控制
  - EPos
aliases:
  - BasicPosControl
  - Basic Positioner
  - EPos
  - 基本定位控制
---

# 01｜BasicPosControl 是什么

> [!info] 核心结论
> **BasicPosControl 是用于控制 SINAMICS 驱动器 Basic Positioner / EPos 功能的定位控制对象或功能块，PLC 发命令，驱动器内部完成定位控制。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>图片识别</strong><br>
截图中的 <strong>BasicPosControl V3.1</strong> 属于西门子运动控制相关对象，常用于驱动器内部基本定位器控制。
</div>

## ① 分类/公式/规则

| 项目 | 说明 |
|---|---|
| **名称** | `BasicPosControl` |
| **版本** | `V3.1` |
| **中文理解** | 基本定位控制 |
| **控制对象** | SINAMICS 驱动器 Basic Positioner / EPos |
| **核心特点** | 定位控制主要在驱动器内部完成 |
| **PLC 作用** | 发送使能、回零、点动、定位、停止等命令 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
BasicPosControl 不是让 PLC 自己算运动轨迹，而是让 PLC 调用驱动器内部的定位功能。
</div>

## ② 参考表

| 对象 | 作用 | 重点 |
|---|---|---|
| **PLC** | 发控制命令 | Start、Stop、Home、Jog |
| **BasicPosControl** | 封装定位控制接口 | 控制字、状态字、位置、速度 |
| **SINAMICS 驱动器** | 执行定位控制 | Basic Positioner / EPos |
| **伺服电机** | 输出运动 | 位置、速度、转矩 |
| **编码器** | 反馈位置 | 回零、实际位置、跟随误差 |

## ③ 计算/选型示例

- **已知：** PLC 要控制一台 SINAMICS 驱动器做单轴定位  
- **公式：** 基本定位 = `PLC 命令 + 驱动器 EPos + 电机反馈`
- **计算：**
  - PLC 发使能命令
  - 驱动器进入就绪状态
  - PLC 发回零或定位命令
  - 驱动器内部执行运动控制
  - PLC 读取 Done、Busy、Error、当前位置
- **结论：** BasicPosControl 适合驱动器侧已启用 Basic Positioner 的定位场景。

> [!tip] 记忆口诀
> **PLC 发命令，驱动器算运动；BasicPosControl 是中间控制桥。**

---

# 02｜它和 TO_PositioningAxis 的区别

> [!info] 核心结论
> **TO_PositioningAxis 更偏 PLC 工艺对象控制轴，BasicPosControl 更偏驱动器内部 Basic Positioner / EPos 控制。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>选型判断</strong><br>
PLC 侧做完整运动控制，用 TO_PositioningAxis；驱动器侧用 EPos 做定位，用 BasicPosControl。
</div>

## ① 分类/公式/规则

| 对比项 | BasicPosControl | TO_PositioningAxis |
|---|---|---|
| **控制核心** | 驱动器内部定位器 | PLC 工艺对象 |
| **适合对象** | SINAMICS Basic Positioner / EPos | PLC 运动控制轴 |
| **PLC 负载** | 相对较低 | PLC 参与更多 |
| **参数位置** | 很多轴参数在驱动器中 | 轴参数在 TO 中配置 |
| **典型指令** | BasicPosControl 接口 | `MC_Power`、`MC_Home`、`MC_MoveAbsolute` |

## ② 参考表

| 需求 | 推荐方向 | 注意 |
|---|---|---|
| **简单单轴定位** | BasicPosControl | 驱动器需启用 EPos |
| **复杂运动控制** | TO_PositioningAxis | PLC 侧配置更完整 |
| **多轴同步** | 运动控制 TO | 需看 CPU 和工艺对象支持 |
| **驱动器内部定位表** | Basic Positioner / EPos | 看驱动器功能 |
| **PLCopen 标准轴控** | TO + MC 指令 | 程序结构更统一 |

## ③ 计算/选型示例

- **已知：** 驱动器已经配置了 Basic Positioner，PLC 只需要下发目标位置  
- **公式：** 驱动器内部定位已启用 → BasicPosControl 更合适  
- **计算：**
  - 定位曲线由驱动器处理
  - PLC 只发送目标位置和控制命令
  - PLC 读取运行状态和实际位置
- **结论：** 这种场景优先考虑 BasicPosControl。

> [!tip] 记忆口诀
> **PLC 控轴看 TO，驱动器控轴看 BasicPosControl。**

---

# 03｜典型控制功能

> [!info] 核心结论
> **BasicPosControl 常见功能包括使能、回零、点动、绝对定位、相对定位、速度运行、停止和故障复位。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>控制流程</strong><br>
Enable → Home → Jog / Move → Monitor → Stop / Reset
</div>

## ① 分类/公式/规则

| 功能 | 中文含义 | 作用 |
|---|---|---|
| **Enable** | 使能 | 让驱动器进入可运行状态 |
| **Home** | 回零 | 建立坐标参考 |
| **Jog** | 点动 | 手动正反方向移动 |
| **MoveAbs** | 绝对定位 | 到指定坐标 |
| **MoveRel** | 相对定位 | 在当前位置基础上移动 |
| **Velocity** | 速度运行 | 按指定速度连续运行 |
| **Stop** | 停止 | 停止当前运动 |
| **Reset** | 复位 | 清除故障状态 |

## ② 参考表

| 任务 | 常用功能 | 注意 |
|---|---|---|
| **调试方向** | Jog | 先低速点动 |
| **建立坐标** | Home | 增量轴通常需要 |
| **去固定位置** | MoveAbs | 需已回零 |
| **再走一段距离** | MoveRel | 基于当前位置 |
| **异常停止** | Stop | 按减速度停止 |
| **报警恢复** | Reset | 先查故障原因 |

## ③ 计算/选型示例

- **已知：** 滑台当前位置 `20mm`，需要再向前走 `30mm`  
- **公式：** 目标位置 = `当前位置 + 相对位移`
- **计算：**
  - `20 + 30 = 50mm`
- **结论：** 可以使用相对定位，执行后目标位置约为 `50mm`。

> [!tip] 记忆口诀
> **先使能，再回零；先点动确认方向，再定位运行。**

---

# 04｜关键参数

> [!info] 核心结论
> **BasicPosControl 的关键参数通常围绕目标位置、速度、加速度、减速度、模式、状态和错误码展开。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>参数口诀</strong><br>
位置定去哪，速度定多快，加减速定稳不稳，状态码定错在哪。
</div>

## ① 分类/公式/规则

| 参数 | 中文含义 | 作用 |
|---|---|---|
| **Position** | 目标位置 | 绝对/相对定位目标 |
| **Velocity** | 速度 | 运动快慢 |
| **Acceleration** | 加速度 | 启动斜率 |
| **Deceleration** | 减速度 | 停止斜率 |
| **Mode** | 控制模式 | 回零、点动、定位等 |
| **ActPosition** | 实际位置 | 驱动器反馈 |
| **ActVelocity** | 实际速度 | 当前速度 |
| **Error / Status** | 错误状态 | 排查故障 |

> [!warning]
> 不同 BasicPosControl 版本、TIA Portal 版本和驱动器类型中，参数名称、数据类型和含义可能不同，必须以当前块接口和厂家手册为准。

## ② 参考表

| 参数类型 | 常见错误 | 处理 |
|---|---|---|
| **位置单位** | mm、degree、LU 混乱 | 统一工程单位 |
| **速度单位** | 单位不一致 | 查驱动器/块说明 |
| **加速度过大** | 抖动、过流 | 降低加速度 |
| **减速度过大** | 过压、冲击 | 降低减速度 |
| **状态码未解析** | 故障原因不清 | 对照手册查码 |

## ③ 计算/选型示例

- **已知：**
  - 目标速度：`200 mm/s`
  - 加速时间：`0.5 s`
- **公式：** 加速度 = `速度 ÷ 时间`
- **计算：**
  - `200 ÷ 0.5 = 400 mm/s²`
- **结论：** 初始加速度可按 `400 mm/s²` 估算，最终需按机械负载和驱动器能力校核。

> [!tip] 记忆口诀
> **参数先保守，轴动再优化；速度别猛，加减速别硬。**

---

# 05｜PROFINET 报文与数据映射

> [!info] 核心结论
> **BasicPosControl 需要和驱动器报文、PZD 数据、控制字、状态字正确匹配，否则 PLC 命令无法被驱动器正确识别。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>通信链路</strong><br>
PLC 变量 → BasicPosControl → PZD 输出区 → 驱动器 → PZD 输入区 → PLC 状态反馈
</div>

## ① 分类/公式/规则

| 数据 | 方向 | 作用 |
|---|---|---|
| **控制字** | PLC → 驱动器 | 使能、启动、复位 |
| **状态字** | 驱动器 → PLC | 就绪、运行、故障 |
| **目标位置** | PLC → 驱动器 | 定位目标 |
| **目标速度** | PLC → 驱动器 | 运动速度 |
| **实际位置** | 驱动器 → PLC | 当前坐标 |
| **实际速度** | 驱动器 → PLC | 当前速度 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点公式</strong><br>
PZD 字节数 = PZD 数量 × 2 Byte
</div>

## ② 参考表

| 检查项 | 为什么重要 |
|---|---|
| **报文号** | 决定每个 Word 的含义 |
| **PZD 长度** | 决定 I/O 地址占用 |
| **输入输出方向** | 防止读写反 |
| **字节序** | 防止数值解析错误 |
| **控制字位定义** | 防止无法使能 |
| **状态字位定义** | 判断运行和故障 |

## ③ 计算/选型示例

- **已知：** 报文为 `PZD-12/12`
- **公式：** 单方向字节数 = `12 × 2 Byte`
- **计算：**
  - `12 × 2 = 24 Byte`
  - PLC 输出区约 `24 Byte`
  - PLC 输入区约 `24 Byte`
- **结论：** 程序中必须按对应报文结构建立 I/O 映射，不能随意猜地址。

> [!tip] 记忆口诀
> **报文定结构，PZD 定长度；控制字写出去，状态字读回来。**

---

# 06｜典型使用流程

> [!info] 核心结论
> **使用 BasicPosControl 前，要先配置驱动器 Basic Positioner，再配置 PROFINET 报文和 PLC 程序接口。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>流程口诀</strong><br>
先配驱动器，再配报文；先点动确认，再定位运行。
</div>

## ① 分类/公式/规则

| 步骤 | 内容 | 重点 |
|---|---|---|
| **1** | 配置驱动器 Basic Positioner | 启用 EPos / 基本定位 |
| **2** | 配置机械参数 | 单位、导程、减速比 |
| **3** | 配置回零和限位 | 防止坐标错误和撞机 |
| **4** | 配置 PROFINET 报文 | PZD 数据匹配 |
| **5** | 调用 BasicPosControl | 连接控制和状态变量 |
| **6** | 低速点动测试 | 确认方向 |
| **7** | 回零和定位测试 | 逐步验证 |

## ② 参考表

| 调试动作 | 目的 |
|---|---|
| **先手动点动** | 确认方向和使能 |
| **再回零** | 建立坐标 |
| **小距离定位** | 验证比例 |
| **逐步加速度** | 防止冲击 |
| **监控状态字** | 判断驱动状态 |
| **记录错误码** | 便于排故 |

## ③ 计算/选型示例

- **已知：** 第一次调试滑台轴  
- **公式：** 安全调试 = `低速 + 小位移 + 限位确认`
- **计算：**
  - 点动速度先设低
  - 目标位置先设小距离
  - 确认正负方向与坐标一致
  - 再放大行程和速度
- **结论：** 初次调试 BasicPosControl 时，不能直接高速长距离定位。

> [!tip] 记忆口诀
> **新轴先慢动，小距离先试；方向对了，才敢跑远。**

---

# 07｜适合与不适合场景

> [!info] 核心结论
> **BasicPosControl 适合驱动器内部 Basic Positioner 的单轴定位，不适合复杂多轴插补或 PLC 侧高级运动控制。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>选型判断</strong><br>
简单定位给驱动器做，复杂运动给 PLC 工艺对象做。
</div>

## ① 分类/公式/规则

| 场景 | 是否适合 |
|---|---|
| **单轴点到点定位** | 适合 |
| **滑台往返定位** | 适合 |
| **驱动器内置定位表** | 适合 |
| **简单送料轴** | 适合 |
| **复杂多轴同步** | 不优先 |
| **电子凸轮/插补** | 不适合或需专用 TO |
| **纯开关设备** | 不适合 |

## ② 参考表

| 需求 | 推荐 |
|---|---|
| **驱动器内部定位** | BasicPosControl |
| **PLC 标准运动控制轴** | TO_PositioningAxis |
| **固定多步运动** | TO_CommandTable |
| **多轴同步** | 同步/凸轮/插补类工艺对象 |
| **简单启停电机** | FB 电机控制 |
| **温度闭环** | PID_Temp / PID_Compact |

## ③ 计算/选型示例

- **已知：** 一条轴只需要到 A 点、B 点、回原点  
- **公式：** 简单点到点定位 → BasicPosControl 可满足  
- **计算：**
  - A 点：绝对定位
  - B 点：绝对定位
  - 原点：回零或回到 0
- **结论：** 这种简单定位轴适合 BasicPosControl。

> [!tip] 记忆口诀
> **点到点定位用 Basic，多轴复杂运动用 TO。**

---

# 08｜常见故障排查

> [!info] 核心结论
> **BasicPosControl 故障排查要按：PROFINET 在线、驱动器就绪、报文匹配、使能状态、回零状态、限位状态、错误码的顺序检查。**

<div class="card red" style="background:#FFF4F3;border-left:6px solid #E74C3C;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>排查顺序</strong><br>
网络 → 报文 → 驱动器 → 使能 → 回零 → 限位 → 状态字 → 错误码。
</div>

## ① 分类/公式/规则

| 问题 | 常见原因 |
|---|---|
| **轴不使能** | 安全回路、驱动报警、控制字错误 |
| **点动不动** | 模式错误、方向信号错误 |
| **不能定位** | 未回零、目标超限 |
| **位置不准** | 机械参数或单位错误 |
| **速度不对** | 单位、比例或驱动参数错误 |
| **一启动报警** | 加速度过大、负载卡滞、限位触发 |
| **状态不更新** | PZD 映射或报文错误 |

## ② 参考表

| 现象 | 排查方向 | 解决建议 |
|---|---|---|
| **PLC 能在线但轴不动** | 控制字/使能/驱动状态 | 查状态字 |
| **Done 不出现** | 未到位或 Error | 查实际位置和错误码 |
| **方向反了** | 方向参数/机械参数 | 低速点动校正 |
| **移动距离不对** | 导程/减速比/单位 | 校核机械参数 |
| **报文数据错乱** | PZD 地址不匹配 | 查报文和 I/O 地址 |
| **回零失败** | 原点开关/方向/速度 | 查 Home 参数 |

## ③ 计算/选型示例

- **已知：** 命令移动 `100mm`，实际只移动 `50mm`
- **公式：** 实际/目标比例 = `50 ÷ 100 = 0.5`
- **计算：**
  - 实际位移只有目标的一半
  - 可能是导程、减速比、电子齿轮或单位设置错误
- **结论：** 位置比例错误时，优先检查机械参数和驱动器内部定位设置。

> [!tip] 记忆口诀
> **不动查使能，跑偏查参数，报警查状态字。**

---

# 09｜一页速记总卡

> [!info] 核心结论
> **BasicPosControl 的核心价值是：PLC 用简单接口控制驱动器内部 Basic Positioner，实现点到点定位。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>总口诀</strong><br>
Basic 管基本定位，驱动器管运动曲线；PLC 发命令，状态字看结果。
</div>

## ① 分类/公式/规则

| 主轴 | 关键词 |
|---|---|
| **对象** | `BasicPosControl V3.1` |
| **用途** | 驱动器内部基本定位控制 |
| **功能** | 使能、回零、点动、定位、停止、复位 |
| **通信** | PROFINET 报文 / PZD |
| **核心数据** | 控制字、状态字、位置、速度 |
| **诊断** | Busy、Done、Error、Status |

## ② 参考表

| 需求 | 推荐 |
|---|---|
| **简单定位轴** | BasicPosControl |
| **标准 PLC 运动轴** | TO_PositioningAxis |
| **固定多步动作** | TO_CommandTable |
| **多轴同步** | 高级运动控制 TO |
| **普通电机启停** | FB 控制 |
| **温度压力闭环** | PID 控制 |

## ③ 计算/选型示例

- **已知：** 驱动器启用了 Basic Positioner，PLC 要控制轴到 `250mm`
- **公式：** 定位控制 = `使能 + 回零 + 目标位置 + 启动命令`
- **计算：**
  - 先确认驱动器 Ready
  - 执行 Enable
  - 执行 Home
  - 写入目标位置 `250mm`
  - 发出启动定位命令
  - 监控 Done / Error
- **结论：** BasicPosControl 适合这种由 PLC 下发目标、由驱动器完成定位的控制方式。

> [!tip] 记忆口诀
> **先配 EPos，再配报文；先使能回零，再定位运行。**