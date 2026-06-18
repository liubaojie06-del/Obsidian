---
tags:
  - PLC
  - TIA_Portal
  - 运动控制
  - Technology_Object
  - TO_PositioningAxis
  - 定位轴
aliases:
  - TO_PositioningAxis
  - 定位轴工艺对象
  - Positioning Axis
---

# 01｜TO_PositioningAxis 是什么

> [!info] 核心结论
> **TO_PositioningAxis 是 TIA Portal 中的“定位轴工艺对象”，用于把伺服轴、步进轴、变频器轴封装成可用运动控制指令控制的轴对象。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>图片识别</strong><br>
截图中的 <strong>TO_PositioningAxis V8.0</strong> 表示一个定位轴 Technology Object，用于配置轴参数、驱动接口、编码器、限位、回零、运动控制等内容。
</div>

## ① 分类/公式/规则

| 项目 | 说明 |
|---|---|
| **英文名称** | `TO_PositioningAxis` |
| **中文含义** | 定位轴工艺对象 |
| **版本** | `V8.0` |
| **所属类别** | TIA Portal 运动控制 / Technology Object |
| **核心作用** | 建立一个可被 PLCopen 运动控制指令调用的轴对象 |
| **常见搭配** | `MC_Power`、`MC_Home`、`MC_MoveAbsolute`、`MC_MoveRelative`、`MC_Stop` |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
TO_PositioningAxis 就是 PLC 里的“轴档案”：里面记录这根轴怎么接、怎么动、怎么算位置、怎么回零。
</div>

## ② 参考表

| 组成 | 作用 | 重点 |
|---|---|---|
| **驱动器接口** | 连接伺服/步进/驱动器 | PTO、PROFINET、报文 |
| **编码器接口** | 位置反馈 | 增量式/绝对值 |
| **机械参数** | 脉冲与位移换算 | 导程、减速比、单位 |
| **限位参数** | 保护轴运动范围 | 软件限位/硬件限位 |
| **回零参数** | 建立坐标原点 | 原点开关、Z 相、绝对值 |
| **动态参数** | 控制速度与加速度 | 速度、加速度、减速度、加加速度 |

## ③ 计算/选型示例

- **已知：** PLC 要控制一根伺服滑台做绝对定位  
- **公式：** 定位轴控制 = `TO轴对象 + 运动控制指令 + 驱动器/编码器参数`
- **计算：**
  - 创建 `TO_PositioningAxis`
  - 绑定实际驱动器或脉冲输出
  - 设置机械比例和单位
  - 使用 `MC_Power` 使能轴
  - 使用 `MC_Home` 回零
  - 使用 `MC_MoveAbsolute` 定位
- **结论：** 有了 TO_PositioningAxis，PLC 程序可以用标准运动控制指令控制轴运动。

> [!tip] 记忆口诀
> **先建轴对象，再配机械量；先使能回零，再定位运行。**

---

# 02｜它在运动控制里的位置

> [!info] 核心结论
> **TO_PositioningAxis 位于 PLC 程序和实际驱动器之间，负责把运动指令转换成轴运动所需的控制关系。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>系统链路</strong><br>
PLC 运动指令 → TO_PositioningAxis → 驱动器 → 电机 → 机械负载 → 编码器反馈
</div>

## ① 分类/公式/规则

| 层级 | 对象 | 作用 |
|---|---|---|
| **程序层** | `MC_` 运动控制指令 | 发出使能、回零、定位等命令 |
| **工艺对象层** | `TO_PositioningAxis` | 保存轴参数并协调控制 |
| **驱动层** | 伺服驱动器 / 步进驱动器 | 执行运动命令 |
| **执行层** | 电机 / 丝杆 / 同步带 | 产生实际运动 |
| **反馈层** | 编码器 / 原点开关 / 限位 | 反馈位置与状态 |

## ② 参考表

| 信号方向 | 内容 | 说明 |
|---|---|---|
| **PLC → TO** | 运动控制命令 | 使能、回零、移动 |
| **TO → 驱动器** | 给定值 | 位置、速度、控制字 |
| **驱动器 → TO** | 实际值 | 位置、速度、状态字 |
| **现场 → TO** | 限位/原点 | 安全与坐标建立 |
| **TO → PLC** | 轴状态 | Busy、Done、Error、Position |

## ③ 计算/选型示例

- **已知：** 伺服轴通过 PROFINET 接入 PLC  
- **公式：** PROFINET 轴 = `驱动报文 + TO轴对象 + MC指令`
- **计算：**
  - 先在设备组态中添加驱动器
  - 配置 PROFINET 报文
  - 创建 `TO_PositioningAxis`
  - 在 TO 中关联该驱动器
  - 程序中调用 MC 指令控制轴
- **结论：** TO_PositioningAxis 是运动控制程序和驱动器硬件之间的“桥”。

> [!tip] 记忆口诀
> **驱动器负责动，TO 负责管，MC 指令负责发命令。**

---

# 03｜常用运动控制指令

> [!info] 核心结论
> **TO_PositioningAxis 通常配合 PLCopen 风格的 MC 指令使用，常见流程是使能、回零、移动、停止、复位。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>控制流程口诀</strong><br>
Power 先上电，Home 找原点，Move 去位置，Stop 停下来，Reset 清故障。
</div>

## ① 分类/公式/规则

| 指令 | 中文含义 | 作用 |
|---|---|---|
| **MC_Power** | 轴使能 | 让轴进入可运动状态 |
| **MC_Home** | 回零 | 建立机械坐标原点 |
| **MC_MoveAbsolute** | 绝对定位 | 移动到指定坐标 |
| **MC_MoveRelative** | 相对定位 | 在当前位置基础上移动指定距离 |
| **MC_MoveVelocity** | 速度运行 | 按指定速度连续运行 |
| **MC_Stop** | 停止轴 | 按减速度停止 |
| **MC_Halt** | 暂停运动 | 可控停止 |
| **MC_Reset** | 复位错误 | 清除轴错误状态 |

## ② 参考表

| 任务 | 推荐指令 | 注意 |
|---|---|---|
| **伺服上使能** | `MC_Power` | 先确认安全条件 |
| **建立零点** | `MC_Home` | 增量轴通常需要 |
| **走到 100mm** | `MC_MoveAbsolute` | 需已回零 |
| **再走 20mm** | `MC_MoveRelative` | 基于当前位置 |
| **连续转动** | `MC_MoveVelocity` | 注意停止逻辑 |
| **故障恢复** | `MC_Reset` | 故障原因也要处理 |

## ③ 计算/选型示例

- **已知：** 滑台需要移动到 `100.0 mm`
- **公式：** 目标位置已知 → 绝对定位
- **计算：**
  - `MC_Power.Enable = TRUE`
  - `MC_Home` 完成回零
  - `MC_MoveAbsolute.Position = 100.0`
  - 监控 `Done / Busy / Error`
- **结论：** 指定坐标定位应使用 `MC_MoveAbsolute`。

> [!tip] 记忆口诀
> **绝对位置用 Absolute，相对距离用 Relative，连续速度用 Velocity。**

---

# 04｜机械参数与单位换算

> [!info] 核心结论
> **TO_PositioningAxis 的机械参数决定 PLC 程序中的位置单位如何换算成电机转动或脉冲数量。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点公式</strong><br>
每毫米脉冲数 = 每转脉冲数 ÷ 每转机械位移
</div>

## ① 分类/公式/规则

| 参数 | 含义 | 作用 |
|---|---|---|
| **工程单位** | mm、degree、rev 等 | 程序中使用的单位 |
| **电机每转脉冲数** | 脉冲控制时使用 | 决定分辨率 |
| **丝杆导程** | 电机一圈移动距离 | 位移换算 |
| **减速比** | 电机与负载转速比 | 影响位置换算 |
| **编码器分辨率** | 每转反馈计数 | 影响反馈精度 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>换算规则</strong><br>
机械参数配错，轴不是不能动，而是会“动错距离”。
</div>

## ② 参考表

| 机构 | 关键参数 | 常见错误 |
|---|---|---|
| **丝杆轴** | 导程、减速比 | 实际距离不对 |
| **同步带轴** | 轮径、齿距、减速比 | 比例偏差 |
| **旋转轴** | 一圈角度、减速比 | 角度不准 |
| **编码器轴** | 分辨率、方向 | 位置反馈反向 |
| **PTO轴** | 脉冲当量 | 脉冲数不匹配 |

## ③ 计算/选型示例

- **已知：**
  - 电机每转指令脉冲：`10000 pulse/rev`
  - 丝杆导程：`10 mm/rev`
  - 目标位移：`50 mm`
- **公式：**
  - 每毫米脉冲数 = `10000 ÷ 10`
  - 总脉冲数 = `目标位移 × 每毫米脉冲数`
- **计算：**
  - 每毫米脉冲数 = `1000 pulse/mm`
  - 总脉冲数 = `50 × 1000 = 50000 pulse`
- **结论：** 移动 `50mm` 对应 `50000` 个脉冲，TO 中机械参数必须与实际机构一致。

> [!tip] 记忆口诀
> **一圈走多少，导程说了算；参数配不准，位置全跑偏。**

---

# 05｜回零与参考点

> [!info] 核心结论
> **回零是让定位轴建立机械坐标系的过程，增量轴通常必须回零，绝对值轴可根据配置直接读取位置。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
没回零的轴，只知道自己动了多少；回零后，才知道自己在哪里。
</div>

## ① 分类/公式/规则

| 回零方式 | 说明 | 适合场景 |
|---|---|---|
| **原点开关回零** | 找到外部 Home 信号 | 常规滑台 |
| **限位回零** | 利用正/负限位 | 简单设备 |
| **Z 相回零** | 用编码器零点精修 | 高重复性 |
| **绝对值定位** | 上电直接读位置 | 绝对值编码器 |
| **手动设零** | 当前点设为零点 | 调试/特殊工艺 |

## ② 参考表

| 参数 | 作用 | 注意 |
|---|---|---|
| **Home 方向** | 往哪边找原点 | 方向错会撞限位 |
| **Home 速度** | 回零速度 | 太快易过冲 |
| **Home 偏移** | 原点后偏移量 | 建立工作零点 |
| **限位开关** | 防止越界 | 必须校验接线 |
| **参考状态** | 是否已回零 | 未回零禁止绝对定位 |

## ③ 计算/选型示例

- **已知：** 增量式编码器滑台每次上电后位置丢失  
- **公式：** 增量式轴上电后 → 需要回零  
- **计算：**
  - 执行 `MC_Power`
  - 执行 `MC_Home`
  - 原点完成后，轴状态变为已参考
  - 再执行绝对定位
- **结论：** 增量轴未回零前，不应直接执行绝对定位。

> [!tip] 记忆口诀
> **增量先回零，绝对可直读；没参考，不定位。**

---

# 06｜限位与安全保护

> [!info] 核心结论
> **定位轴必须设置软件限位、硬件限位和急停/安全逻辑，防止轴越界、撞机或失控。**

<div class="card red" style="background:#FFF4F3;border-left:6px solid #E74C3C;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>避坑提醒</strong><br>
调试运动轴前，先确认方向、限位、急停和低速点动，不能一上来高速定位。
</div>

## ① 分类/公式/规则

| 保护类型 | 作用 | 注意 |
|---|---|---|
| **软件正限位** | 限制最大坐标 | 需已回零 |
| **软件负限位** | 限制最小坐标 | 坐标系正确 |
| **硬件正限位** | 现场物理保护 | 接线必须可靠 |
| **硬件负限位** | 现场物理保护 | 方向要校验 |
| **急停/STO** | 安全停止 | 需按安全规范校核 |
| **跟随误差监控** | 防止轴失控 | 参数需调试 |

## ② 参考表

| 故障 | 可能原因 | 处理 |
|---|---|---|
| **轴撞限位** | 方向错、限位未生效 | 低速调试方向 |
| **软件限位无效** | 未回零或参数错误 | 检查参考状态 |
| **跟随误差大** | 负载过大/参数不当 | 查机械和伺服增益 |
| **急停后无法运动** | 安全回路未恢复 | 检查 STO/使能 |
| **限位信号反了** | 常开常闭配置错 | 在线监控限位点 |

## ③ 计算/选型示例

- **已知：** 机械行程为 `0~500mm`
- **公式：** 软件限位应小于机械极限并留安全余量
- **计算：**
  - 机械最小：`0mm`
  - 机械最大：`500mm`
  - 可设置软件限位：`5mm ~ 495mm`
- **结论：** 软件限位要留安全余量，避免运动到机械硬极限。

> [!tip] 记忆口诀
> **先低速，后高速；先限位，后定位。**

---

# 07｜动态参数

> [!info] 核心结论
> **动态参数决定轴运动的快慢和平稳性，核心包括速度、加速度、减速度和加加速度。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>动态口诀</strong><br>
速度管快慢，加速度管起停，加加速度管柔顺。
</div>

## ① 分类/公式/规则

| 参数 | 中文含义 | 作用 |
|---|---|---|
| **Velocity** | 速度 | 运动快慢 |
| **Acceleration** | 加速度 | 启动过程 |
| **Deceleration** | 减速度 | 停止过程 |
| **Jerk** | 加加速度 | 平滑程度 |
| **Torque Limit** | 转矩限制 | 防止过载 |
| **Following Error** | 跟随误差 | 监控实际位置偏差 |

## ② 参考表

| 参数设置 | 过大风险 | 过小影响 |
|---|---|---|
| **速度过大** | 机械冲击、跟随误差 | 节拍慢 |
| **加速度过大** | 过流、抖动、打滑 | 起步慢 |
| **减速度过大** | 过压、冲击 | 停止慢 |
| **Jerk 过大** | 冲击明显 | 响应慢 |
| **误差阈值过小** | 易报警 | 保护不敏感 |

## ③ 计算/选型示例

- **已知：**
  - 目标速度：`500 mm/s`
  - 加速时间：`0.5 s`
- **公式：** 加速度 = `速度 ÷ 时间`
- **计算：**
  - `a = 500 ÷ 0.5 = 1000 mm/s²`
- **结论：** 若轴启动冲击大，可以适当降低加速度或增加 Jerk 平滑，需按机械和驱动器能力校核。

> [!tip] 记忆口诀
> **轴跑得快看速度，轴抖不抖看加速度和刚性。**

---

# 08｜常见状态与错误

> [!info] 核心结论
> **定位轴运行时要重点监控使能状态、回零状态、运动状态、到位状态和错误状态。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>监控口诀</strong><br>
Power 看使能，Home 看参考，Busy 看运动，Done 看完成，Error 查故障。
</div>

## ① 分类/公式/规则

| 状态 | 含义 |
|---|---|
| **Enabled** | 轴已使能 |
| **Homed / Referenced** | 已建立参考点 |
| **Busy** | 指令正在执行 |
| **Done** | 指令完成 |
| **Error** | 指令或轴出错 |
| **ErrorID / Status** | 错误编号或状态码 |

## ② 参考表

| 现象 | 可能原因 | 排查方向 |
|---|---|---|
| **轴不使能** | 驱动报警、安全回路未满足 | 查 `MC_Power` 和驱动器 |
| **不能绝对定位** | 未回零 | 查 Home 状态 |
| **一动就报警** | 方向/限位/负载问题 | 低速点动检查 |
| **位置跑偏** | 机械参数错误 | 查导程和脉冲当量 |
| **Done 不出来** | 未到位或参数不满足 | 查 Busy/Error |
| **跟随误差报警** | 负载大或调试不当 | 查机械和驱动参数 |

## ③ 计算/选型示例

- **已知：** `MC_MoveAbsolute` 一直 Busy，不 Done  
- **公式：** 不完成 = 未到位 / 被中断 / 有错误 / 参数不合理  
- **计算：**
  - 查是否有 `Error`
  - 查目标位置是否超限
  - 查轴是否已回零
  - 查驱动器是否实际在动
- **结论：** 运动指令不完成时，要同时看 MC 指令状态和 TO 轴状态。

> [!tip] 记忆口诀
> **不动看 Power，不准看 Home，跑偏看机械参数，报警看 ErrorID。**

---

# 09｜一页速记总卡

> [!info] 核心结论
> **TO_PositioningAxis 的核心就是：把驱动器、电机、编码器、机械参数封装成一个 PLC 可控制的定位轴对象。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>总口诀</strong><br>
TO 建轴，MC 控轴；Power 使能，Home 回零，Move 定位，Reset 清故障。
</div>

## ① 分类/公式/规则

| 主轴 | 关键词 |
|---|---|
| **对象** | 定位轴工艺对象 |
| **版本** | `V8.0` |
| **硬件** | 驱动器、电机、编码器 |
| **参数** | 单位、导程、减速比、限位 |
| **指令** | `MC_Power`、`MC_Home`、`MC_MoveAbsolute` |
| **诊断** | Axis 状态、ErrorID、驱动器报警 |

## ② 参考表

| 需求 | 重点 |
|---|---|
| **轴能动** | 绑定驱动器 / 输出接口 |
| **轴动得准** | 机械参数正确 |
| **轴能定位** | 已回零 / 已参考 |
| **轴不撞机** | 限位和安全有效 |
| **轴运行平稳** | 动态参数合理 |
| **轴故障可查** | 监控 ErrorID 和状态 |

## ③ 计算/选型示例

- **已知：** 要做一根伺服定位轴  
- **公式：** 伺服定位轴 = `TO_PositioningAxis + 伺服驱动器 + 机械参数 + MC指令`
- **计算：**
  - 在工艺对象中新建 `TO_PositioningAxis`
  - 绑定驱动器
  - 设置单位、导程、限位和动态参数
  - 程序中依次调用 `MC_Power → MC_Home → MC_MoveAbsolute`
- **结论：** TO_PositioningAxis 是 TIA Portal 中做定位控制的核心配置对象。

> [!tip] 记忆口诀
> **先组态轴，再写指令；先回零，再定位；先安全，再高速。**