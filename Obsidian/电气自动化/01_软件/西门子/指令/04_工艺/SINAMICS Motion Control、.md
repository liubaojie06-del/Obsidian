---
tags:
  - PLC
  - TIA_Portal
  - SINAMICS
  - Motion_Control
  - 定位控制
  - 基本定位器
  - 西门子
aliases:
  - BasicPosControl
  - Basic Position Control
  - 基本定位器
  - SINAMICS Motion Control
---

# 01 BasicPosControl｜基本定位器

> [!info] 核心结论
> **BasicPosControl 用于控制 SINAMICS 驱动完成基本定位动作，例如回零、点动、绝对定位、相对定位和状态监控。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#173B63;">功能定位</strong><br>
适合做简单轴定位控制，例如推料、升降、横移、挡板定位、旋转分度等。
</div>

## ① 分类/公式/规则

| 功能 | 说明 |
|---|---|
| 使能驱动 | 让伺服/变频器进入可运行状态 |
| 点动 Jog | 手动正转/反转调试 |
| 回零 Homing | 建立机械零点或参考点 |
| 绝对定位 | 移动到指定坐标 |
| 相对定位 | 在当前位置基础上移动指定距离 |
| 停止 Stop | 正常减速停止 |
| 急停/故障 | 快速停机并输出错误状态 |

<div class="card orange" style="background:#FFF7F2;border-left:6px solid #FF6B35;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#FF6B35;">定位核心公式</strong><br><br>

位移误差：

$$
e = Position_{Target} - Position_{Actual}
$$

粗略运行时间：

$$
t \approx \frac{|S|}{v}
$$

其中：  
`S` 为移动距离，`v` 为设定速度。实际时间还要考虑加减速，需按驱动参数校核。
</div>

| 规则 | 说明 |
|---|---|
| 先使能 | 轴未 Ready 不允许定位 |
| 先回零 | 没有参考点时绝对定位不可靠 |
| 先低速调试 | 初次运行必须低速、短距离测试 |
| 先限位保护 | 软件限位 + 硬件限位都要确认 |
| 参数校核 | 单位、方向、速度、加速度需按厂家手册校核 |

## ② 参考表

| 参数 | 作用 |
|---|---|
| **Axis/Drive** | 关联的 SINAMICS 驱动或轴对象 |
| **Enable** | 功能块/驱动使能 |
| **Ready** | 驱动准备好 |
| **Mode** | 运行模式，如点动、回零、定位 |
| **Execute/Start** | 启动定位命令 |
| **Stop** | 停止命令 |
| **Reset** | 故障复位 |
| **TargetPosition** | 目标位置 |
| **ActualPosition** | 实际位置 |
| **Velocity** | 运行速度 |
| **Acceleration** | 加速度 |
| **Deceleration** | 减速度 |
| **Direction** | 运动方向 |
| **InPosition** | 到位信号 |
| **Busy** | 正在运行 |
| **Done** | 命令完成 |
| **Error** | 错误标志 |
| **Status** | 状态码，需按厂家手册解析 |
| **Version** | 截图显示：BasicPosControl V3.1 |

> [!warning] 注意
> 截图显示库目录为 **SINAMICS Motion Control V3.2**，功能块 **BasicPosControl V3.1**。实际接口参数、单位、状态码、报警码需按对应版本手册校核。

## ③ 计算/选型示例

- 已知：
  - 当前实际位置：`ActualPosition = 120 mm`
  - 目标位置：`TargetPosition = 500 mm`
  - 设定速度：`Velocity = 100 mm/s`
  - 暂不考虑加减速时间

- 公式：

$$
S = Position_{Target} - Position_{Actual}
$$

$$
t \approx \frac{|S|}{v}
$$

- 计算：

$$
S = 500 - 120 = 380 mm
$$

$$
t \approx \frac{380}{100} = 3.8 s
$$

- 结论：
  - 轴需要正向移动 **380 mm**。
  - 理论匀速运行时间约 **3.8 s**。
  - 实际运行时间会因加速、减速、负载惯量而变长，需现场校核。

<div class="card green" style="background:#F4FBF7;border-left:6px solid #27AE60;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#27AE60;">选型口诀</strong><br>
先使能，再回零；给位置，配速度；看 Busy，等 Done；有 Error，先 Reset。
</div>

> [!tip] 记忆口诀
> **定位三件套：位置、速度、加减速；运行三信号：Busy、Done、Error。**

---

# 02 BasicPosControl｜常用定位模式

> [!info] 核心结论
> **基本定位器的核心是根据不同运动模式，把目标位置、速度和方向转换成驱动可执行的定位命令。**

<div class="card purple" style="background:#FAF5FF;border-left:6px solid #9B59B6;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#9B59B6;">模式理解</strong><br>
点动用于调试，回零用于建立坐标，绝对定位用于去指定点，相对定位用于走固定距离。
</div>

## ① 分类/公式/规则

| 模式 | 适用场景 |
|---|---|
| Jog 正向 | 手动向正方向移动 |
| Jog 反向 | 手动向反方向移动 |
| Homing 回零 | 找机械原点/参考点 |
| Absolute 绝对定位 | 去固定坐标点 |
| Relative 相对定位 | 当前位置再走一段距离 |
| Stop 停止 | 减速停止当前运动 |
| Reset 复位 | 清除故障或状态 |

<div class="card orange" style="background:#FFF7F2;border-left:6px solid #FF6B35;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#FF6B35;">模式判断口诀</strong><br><br>

- 要调试：用 **Jog**  
- 要找零：用 **Homing**  
- 要去坐标：用 **Absolute**  
- 要走距离：用 **Relative**
</div>

## ② 参考表

| 信号 | 重点 |
|---|---|
| **JogPlus** | 正向点动 |
| **JogMinus** | 反向点动 |
| **Home** | 回零启动 |
| **MoveAbs** | 绝对定位 |
| **MoveRel** | 相对定位 |
| **CommandPosition** | 指令位置 |
| **CommandVelocity** | 指令速度 |
| **LimitPositive** | 正限位 |
| **LimitNegative** | 负限位 |
| **HomeDone** | 回零完成 |
| **InPosition** | 定位完成 |
| **FaultActive** | 故障存在 |

## ③ 计算/选型示例

- 已知：
  - 当前坐标：`200 mm`
  - 相对移动距离：`-50 mm`
  - 运行模式：相对定位

- 公式：

$$
Position_{New} = Position_{Actual} + Distance_{Relative}
$$

- 计算：

$$
Position_{New} = 200 + (-50) = 150 mm
$$

- 结论：
  - 相对定位 `-50 mm` 后，理论目标位置为 **150 mm**。
  - 负方向是否正确，需要结合电机方向、机械方向和编码器方向校核。

> [!tip] 记忆口诀
> **绝对看坐标，相对看距离；点动看方向，回零定基准。**

---

# 03 BasicPosControl｜调试流程

> [!info] 核心结论
> **BasicPosControl 调试应遵循“硬件确认 → 驱动使能 → 低速点动 → 回零 → 小距离定位 → 正式运行”的顺序。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#173B63;">调试原则</strong><br>
第一次上电不要直接跑目标位置，必须先确认方向、限位、速度、急停和回零逻辑。
</div>

## ① 分类/公式/规则

| 步骤 | 检查内容 |
|---|---|
| 01 硬件检查 | 电源、抱闸、编码器、限位、急停 |
| 02 通讯检查 | PLC 与 SINAMICS 通讯正常 |
| 03 驱动 Ready | 无故障，允许使能 |
| 04 低速点动 | 确认正反方向 |
| 05 回零测试 | 确认参考点可靠 |
| 06 小距离定位 | 确认位置单位和比例 |
| 07 正式运行 | 逐步提高速度和距离 |

<div class="card orange" style="background:#FFF7F2;border-left:6px solid #FF6B35;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#FF6B35;">安全规则</strong><br><br>

初次调试建议：  
低速度、短距离、手动监控、急停有效、限位有效。
</div>

## ② 参考表

| 项目 | 校核重点 |
|---|---|
| **机械方向** | 正方向是否符合工艺 |
| **编码器方向** | 实际位置变化方向是否正确 |
| **电子齿轮比** | 脉冲/位置单位是否正确 |
| **软件限位** | 正负极限是否合理 |
| **硬件限位** | 接线和触发逻辑是否正确 |
| **回零方式** | 原点开关、零脉冲、硬限位等 |
| **速度限制** | 是否超过机械允许速度 |
| **加减速** | 是否冲击过大 |
| **抱闸逻辑** | 释放和吸合时序是否正确 |

## ③ 计算/选型示例

- 已知：
  - 丝杆导程：`10 mm/rev`
  - 电机编码器：`10000 count/rev`
  - 目标移动距离：`25 mm`

- 公式：

$$
Count = \frac{Distance}{Lead} \times CountPerRev
$$

- 计算：

$$
Count = \frac{25}{10} \times 10000
$$

$$
Count = 25000
$$

- 结论：
  - 移动 `25 mm` 对应 **25000 count**。
  - 若系统内部单位不是 count，而是 LU、mm、degree 等，需要按轴配置换算。

<div class="card green" style="background:#F4FBF7;border-left:6px solid #27AE60;border-radius:14px;padding:14px;margin:12px 0;">
<strong style="color:#27AE60;">调试口诀</strong><br>
先看方向，再看单位；先跑一点，再跑全程。
</div>

> [!tip] 记忆口诀
> **方向不明不高速，限位不通不运行，回零不稳不自动。**