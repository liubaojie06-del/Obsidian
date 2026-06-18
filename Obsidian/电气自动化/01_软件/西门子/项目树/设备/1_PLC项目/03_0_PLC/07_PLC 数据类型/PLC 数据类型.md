---
tags:
  - PLC
  - TIA_Portal
  - PLC数据类型
  - 数据类型
  - 西门子
aliases:
  - PLC Data Types
  - TIA数据类型
  - Siemens数据类型
  - PLC变量类型
---

# 01｜PLC 数据类型是什么

> [!info] 核心结论
> **PLC 数据类型用于规定变量能存什么数据、占多少空间、怎么参与运算，是 PLC 编程的基础语法。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>图片识别</strong><br>
截图中的 <strong>PLC 数据类型</strong> 是 TIA Portal 项目树中用于管理系统数据类型、用户自定义类型 UDT、结构体类型等内容的入口。
</div>

## ① 分类/公式/规则

| 分类 | 代表类型 | 用途 |
|---|---|---|
| **位类型** | `Bool` | 开关量、状态位 |
| **整数类型** | `Int`、`DInt`、`UInt` | 计数、编号、位置 |
| **浮点类型** | `Real`、`LReal` | 温度、压力、速度 |
| **位串类型** | `Byte`、`Word`、`DWord` | 控制字、状态字、通信 |
| **时间类型** | `Time`、`Date`、`DTL` | 定时、时间戳 |
| **字符类型** | `Char`、`String` | 条码、产品号 |
| **复合类型** | `Array`、`Struct`、`UDT` | 成组数据、标准模板 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
数据类型就是变量的“容器规格”：放开关量用 Bool，放工程量用 Real，放通信报文用 Byte 数组。
</div>

## ② 参考表

| 需求 | 推荐类型 | 说明 |
|---|---|---|
| **按钮/传感器** | `Bool` | 单个位 |
| **模拟量原始值** | `Int` / `Word` | 看模块格式 |
| **温度/压力工程量** | `Real` | 带小数 |
| **控制字/状态字** | `Word` | 16 位 |
| **通信缓冲区** | `Array of Byte` | 按字节收发 |
| **设备参数包** | `Struct` / `UDT` | 结构化管理 |

## ③ 计算/选型示例

- **已知：** 要保存一个温度值 `36.5℃`
- **公式：** 带小数工程量 → 选 `Real`
- **计算：**
  - `Bool` 只能表示真/假
  - `Int` 只能表示整数
  - `Real` 可保存小数
- **结论：** 温度、压力、流量这类工程量优先用 `Real`。

> [!tip] 记忆口诀
> **开关用 Bool，整数用 Int，小数用 Real，通信用 Byte。**

---

# 02｜位类型 Bool

> [!info] 核心结论
> **Bool 是最基础的 PLC 数据类型，只表示两种状态：TRUE 或 FALSE。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
Bool 就是一个开关：不是 1，就是 0。
</div>

## ① 分类/公式/规则

| 状态 | 含义 | PLC 表示 |
|---|---|---|
| **TRUE** | 条件成立 / 有信号 | `1` |
| **FALSE** | 条件不成立 / 无信号 | `0` |

## ② 参考表

| 场景 | 变量名示例 | 类型 |
|---|---|---|
| **启动按钮** | `Start_PB` | `Bool` |
| **停止按钮** | `Stop_PB` | `Bool` |
| **电机运行反馈** | `Motor_RunFB` | `Bool` |
| **阀门开到位** | `Valve_OpenFB` | `Bool` |
| **报警标志** | `EStop_Alarm` | `Bool` |
| **自动模式** | `AutoMode` | `Bool` |

## ③ 计算/选型示例

- **已知：** 急停按钮只有按下/未按下两种状态
- **公式：** 两态信号 → `Bool`
- **计算：**
  - 按下：`TRUE`
  - 未按下：`FALSE`
- **结论：** 急停、限位、传感器、输出线圈都适合用 `Bool`。

> [!tip] 记忆口诀
> **只有开和关，Bool 最简单。**

---

# 03｜整数类型

> [!info] 核心结论
> **整数类型用于保存没有小数的数值，例如计数、编号、脉冲数、状态码。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>选型口诀</strong><br>
小整数用 Int，大计数用 DInt，超大累计用 LInt；不允许负数就用无符号类型。
</div>

## ① 分类/公式/规则

| 类型 | 位宽 | 是否有符号 | 常见用途 |
|---|---:|---|---|
| **SInt** | 8 bit | 有符号 | 小范围数值 |
| **USInt** | 8 bit | 无符号 | 小编号 |
| **Int** | 16 bit | 有符号 | 普通整数 |
| **UInt** | 16 bit | 无符号 | 正整数、寄存器 |
| **DInt** | 32 bit | 有符号 | 计数、位置 |
| **UDInt** | 32 bit | 无符号 | 大范围正整数 |
| **LInt** | 64 bit | 有符号 | 大累计 |
| **ULInt** | 64 bit | 无符号 | 超大累计 |

## ② 参考表

| 需求 | 推荐类型 | 注意 |
|---|---|---|
| **普通计数** | `Int` / `DInt` | 范围要够 |
| **编码器位置** | `DInt` | 可能有正负方向 |
| **Modbus寄存器** | `UInt` / `Word` | 看寄存器定义 |
| **产品累计数** | `DInt` / `UDInt` | 防止溢出 |
| **设备编号** | `UInt` | 不需要负数 |
| **大产量累计** | `LInt` | 需按 CPU 支持校核 |

## ③ 计算/选型示例

- **已知：** 产量计数最大可能到 `100000`
- **公式：** `Int` 最大范围不够 → 选 `DInt`
- **计算：**
  - `Int` 常见范围约为 `-32768 ~ 32767`
  - `100000` 超过 `Int` 正范围
  - `DInt` 更合适
- **结论：** 大于 32767 的计数不要随便用 `Int`，优先用 `DInt`。

> [!tip] 记忆口诀
> **计数先看最大值，范围不够会溢出。**

---

# 04｜浮点类型 Real / LReal

> [!info] 核心结论
> **浮点类型用于保存带小数的工程量，是模拟量换算、PID 控制、速度计算中最常用的数据类型。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点规则</strong><br>
温度、压力、流量、速度、比例、百分比这类工程量，通常优先用 <code>Real</code>。
</div>

## ① 分类/公式/规则

| 类型 | 位宽 | 精度 | 常见用途 |
|---|---:|---|---|
| **Real** | 32 bit | 普通浮点 | 工程量、PID |
| **LReal** | 64 bit | 双精度浮点 | 高精度计算 |

## ② 参考表

| 工程量 | 变量名示例 | 推荐类型 |
|---|---|---|
| **温度** | `Temp_Real` | `Real` |
| **压力** | `Pressure_Real` | `Real` |
| **流量** | `Flow_Real` | `Real` |
| **速度** | `Speed_Real` | `Real` |
| **比例系数** | `ScaleFactor` | `Real` |
| **高精计算** | `PreciseValue` | `LReal` |

## ③ 计算/选型示例

- **已知：**
  - 模拟量原始值：`13824`
  - 满量程：`27648`
  - 工程量范围：`0~100.0℃`
- **公式：** 工程量 = `Raw ÷ 27648 × 100.0`
- **计算：**
  - `13824 ÷ 27648 × 100.0 = 50.0℃`
- **结论：** 换算后的温度应保存为 `Real`。

> [!tip] 记忆口诀
> **原始值用整数，工程量用 Real。**

---

# 05｜位串类型 Byte / Word / DWord

> [!info] 核心结论
> **位串类型本质上是一组二进制位，常用于控制字、状态字、通信报文、位操作。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
Word 不是普通数字思维，而是 16 个状态位打包在一起。
</div>

## ① 分类/公式/规则

| 类型 | 位数 | 字节数 | 常见用途 |
|---|---:|---:|---|
| **Byte** | 8 bit | 1 Byte | 通信字节 |
| **Word** | 16 bit | 2 Byte | 控制字、状态字 |
| **DWord** | 32 bit | 4 Byte | 双字状态、位掩码 |
| **LWord** | 64 bit | 8 Byte | 大位串 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点公式</strong><br>
1 Byte = 8 bit；1 Word = 2 Byte = 16 bit；1 DWord = 4 Byte = 32 bit
</div>

## ② 参考表

| 场景 | 推荐类型 | 说明 |
|---|---|---|
| **Modbus 单寄存器** | `Word` | 16 bit |
| **PROFINET 控制字** | `Word` | 常见驱动控制 |
| **状态字解析** | `Word` | 按位判断 |
| **TCP 原始报文** | `Array of Byte` | 按字节收发 |
| **位掩码判断** | `Word` / `DWord` | 位操作方便 |

## ③ 计算/选型示例

- **已知：** 驱动器状态字是 16 位
- **公式：** 16 位状态 → `Word`
- **计算：**
  - Bit0：Ready
  - Bit1：Running
  - Bit3：Fault
  - 16 个状态位合成一个 `Word`
- **结论：** 驱动器控制字和状态字通常用 `Word`。

> [!tip] 记忆口诀
> **通信看 Byte，驱动看 Word，状态按位拆。**

---

# 06｜时间与日期类型

> [!info] 核心结论
> **时间类型用于表示定时长度、日期、时刻和时间戳，常用于定时、记录、报警、班次统计。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>工程理解</strong><br>
定时器用 Time，生产记录用日期时间，报警追溯用时间戳。
</div>

## ① 分类/公式/规则

| 类型 | 中文含义 | 示例用途 |
|---|---|---|
| **Time** | 时间长度 | 延时、周期 |
| **LTime** | 长时间长度 | 更大范围时间 |
| **Date** | 日期 | 生产日期 |
| **Time_Of_Day** | 当天时刻 | 班次切换 |
| **Date_And_Time** | 日期+时间 | 时间戳 |
| **DTL** | 日期时间结构 | S7-1200/1500 常用 |

## ② 参考表

| 需求 | 推荐类型 | 示例 |
|---|---|---|
| **延时 5 秒** | `Time` | `T#5s` |
| **定时 100ms** | `Time` | `T#100ms` |
| **记录日期** | `Date` | 生产日期 |
| **记录报警时间** | `DTL` | 年月日时分秒 |
| **每天 8 点动作** | `Time_Of_Day` | 班次任务 |
| **长周期累计** | `LTime` | 需按 CPU 支持校核 |

## ③ 计算/选型示例

- **已知：** 电机启动后延时 `3s` 再检测运行反馈
- **公式：** 延时参数 → `Time`
- **计算：**
  - 延时设定：`T#3s`
  - 定时器到时后判断反馈
- **结论：** 这种延时逻辑适合用 `Time` 类型。

> [!tip] 记忆口诀
> **延时用 Time，追溯用时间戳。**

---

# 07｜字符与字符串类型

> [!info] 核心结论
> **字符和字符串类型用于保存文本信息，例如条码、产品编号、工单号、批次号。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
String 用来存一串字符，Byte 数组用来存原始报文。
</div>

## ① 分类/公式/规则

| 类型 | 中文含义 | 常见用途 |
|---|---|---|
| **Char** | 单个字符 | 单字符标志 |
| **WChar** | 宽字符 | Unicode 字符 |
| **String** | 字符串 | 条码、名称 |
| **WString** | 宽字符串 | 多语言文本 |

## ② 参考表

| 内容 | 推荐类型 | 注意 |
|---|---|---|
| **12 位条码** | `String` / `Array of Byte` | 看通信格式 |
| **产品编号** | `String` | 长度固定 |
| **ASCII 报文** | `Array of Byte` | 更适合通信 |
| **HMI 显示文本** | `String` | 注意最大长度 |
| **中文文本** | `WString` | 需按显示和编码校核 |

## ③ 计算/选型示例

- **已知：** 扫码枪发送 20 个 ASCII 字符
- **公式：** ASCII 1 字符 = 1 Byte
- **计算：**
  - 20 个字符 = `20 Byte`
  - 可用 `String[20]`
  - 也可用 `Array[0..19] of Byte`
- **结论：** 如果要做通信原始接收，优先用 Byte 数组；如果要显示文本，可转成 String。

> [!tip] 记忆口诀
> **通信先 Byte，显示再 String。**

---

# 08｜数组 Array

> [!info] 核心结论
> **Array 用于保存一组相同类型的数据，适合通信缓冲区、多通道模拟量、报警列表、配方数组。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点公式</strong><br>
数组总大小 = 元素数量 × 单个元素大小
</div>

## ① 分类/公式/规则

| 数组示例 | 含义 |
|---|---|
| `Array[0..9] of Byte` | 10 个字节 |
| `Array[1..16] of Bool` | 16 个布尔量 |
| `Array[0..7] of Real` | 8 个浮点数 |
| `Array[0..19] of Word` | 20 个寄存器 |

## ② 参考表

| 场景 | 推荐数组 |
|---|---|
| **TCP 发送区** | `Array of Byte` |
| **Modbus 寄存器** | `Array of Word` |
| **多路温度** | `Array of Real` |
| **报警位集合** | `Array of Bool` |
| **配方参数组** | `Array of Struct` |
| **RFID 原始数据** | `Array of Byte` |

## ③ 计算/选型示例

- **已知：** Modbus 需要保存 20 个保持寄存器
- **公式：** 1 个寄存器 = 1 Word = 2 Byte
- **计算：**
  - `20 × 2 = 40 Byte`
  - 建议类型：`Array[0..19] of Word`
- **结论：** Modbus 寄存器映射适合用 Word 数组。

> [!tip] 记忆口诀
> **同类数据一大排，Array 管起来。**

---

# 09｜结构体 Struct 与 UDT

> [!info] 核心结论
> **Struct 和 UDT 用于把多个不同类型的数据打包成一个结构，适合做设备模板、参数包、通信数据包。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
Struct 是一组变量的组合，UDT 是可以重复使用的结构模板。
</div>

## ① 分类/公式/规则

| 类型 | 中文含义 | 作用 |
|---|---|---|
| **Struct** | 结构体 | 将不同类型变量组合 |
| **UDT** | 用户自定义类型 | 可复用的数据结构模板 |
| **Nested Struct** | 嵌套结构 | 复杂设备数据 |
| **Array of UDT** | UDT 数组 | 多设备统一管理 |

## ② 参考表

| UDT 示例 | 包含内容 |
|---|---|
| **UDT_Motor** | Cmd、FB、Alarm、Status |
| **UDT_Valve** | OpenCmd、CloseCmd、OpenFB、CloseFB |
| **UDT_Axis** | Position、Velocity、Error |
| **UDT_Analog** | Raw、Real、HighLimit、LowLimit |
| **UDT_Comm** | SendBuf、RecvBuf、Status |

## ③ 计算/选型示例

- **已知：** 项目有 10 台电机，每台都有命令、反馈、报警、状态
- **公式：** 相同设备数据结构 → UDT + Array
- **计算：**
  - 创建 `UDT_Motor`
  - 创建 `Array[1..10] of UDT_Motor`
  - 每台电机占用一个数组元素
- **结论：** 多设备标准化管理时，UDT 非常好用。

> [!tip] 记忆口诀
> **单个组合用 Struct，重复模板用 UDT。**

---

# 10｜数据类型选型总卡

> [!info] 核心结论
> **数据类型选型的核心原则是：先看数据本质，再看范围、精度、是否成组、是否通信。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>总口诀</strong><br>
开关 Bool，计数 DInt，工程量 Real，状态字 Word，报文 Byte，设备包 UDT。
</div>

## ① 分类/公式/规则

| 数据本质 | 推荐类型 |
|---|---|
| **开关状态** | `Bool` |
| **小整数** | `Int` |
| **大计数** | `DInt` |
| **带小数工程量** | `Real` |
| **控制字/状态字** | `Word` |
| **原始通信报文** | `Array of Byte` |
| **多个同类数据** | `Array` |
| **设备数据包** | `Struct` / `UDT` |
| **时间参数** | `Time` |
| **文本信息** | `String` |

## ② 参考表

| 常见错误 | 后果 | 建议 |
|---|---|---|
| **用 Int 存大计数** | 溢出 | 改用 DInt |
| **用 Int 存小数** | 小数丢失 | 改用 Real |
| **通信直接用 Bool 数组** | 字节对齐麻烦 | 用 Byte/Word |
| **所有变量都放 M 区** | 项目混乱 | 用 DB / UDT |
| **String 长度不够** | 数据截断 | 预留长度 |
| **类型和模块不匹配** | 数值异常 | 查模块手册 |

## ③ 计算/选型示例

- **已知：** 要建立一个压力传感器数据结构
- **公式：** 模拟量对象 = 原始值 + 工程量 + 报警上下限
- **计算：**
  - `RawValue`：`Int`
  - `RealValue`：`Real`
  - `HighLimit`：`Real`
  - `LowLimit`：`Real`
  - `AlarmHigh`：`Bool`
  - `AlarmLow`：`Bool`
- **结论：** 传感器对象适合封装成 `Struct` 或 `UDT`，比散放变量更清晰。

> [!tip] 记忆口诀
> **类型选对，程序少错；范围先算，结构先定。**