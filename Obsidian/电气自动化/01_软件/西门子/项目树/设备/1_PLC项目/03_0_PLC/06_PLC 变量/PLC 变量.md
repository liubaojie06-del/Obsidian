---
tags:
  - PLC
  - TIA_Portal
  - PLC变量
  - 变量表
  - 地址分配
  - 程序结构
aliases:
  - PLC Tags
  - PLC变量表
  - TIA变量
  - Tag Table
---

# 01｜PLC 变量是什么

> [!info] 核心结论
> **PLC 变量是 TIA Portal 中用于给输入、输出、存储区、DB 数据等地址起“符号名”的管理入口，让程序更易读、更易维护。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>图片识别</strong><br>
截图中的 <strong>PLC 变量</strong> 是 TIA Portal 项目树中的变量管理区域，用于建立和管理 PLC Tag。
</div>

## ① 分类/公式/规则

| 项目 | 说明 |
|---|---|
| **中文名称** | PLC 变量 |
| **英文理解** | PLC Tags |
| **核心作用** | 给 PLC 地址起符号名 |
| **常见内容** | 输入点、输出点、中间位、模拟量、通信字 |
| **程序作用** | 程序中优先使用变量名，而不是裸地址 |
| **典型对象** | `I0.0`、`Q0.0`、`M10.0`、`IW64`、`QW80` |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
PLC 变量就是给地址贴标签：让 <code>I0.0</code> 变成 <code>StartButton</code>，程序一看就懂。
</div>

## ② 参考表

| 地址 | 变量名示例 | 中文含义 |
|---|---|---|
| **I0.0** | `Start_PB` | 启动按钮 |
| **I0.1** | `Stop_PB` | 停止按钮 |
| **Q0.0** | `Motor_Run` | 电机运行输出 |
| **M0.0** | `AutoMode` | 自动模式 |
| **IW64** | `Pressure_Raw` | 压力原始值 |
| **QW80** | `Valve_AO` | 阀门模拟量输出 |

## ③ 计算/选型示例

- **已知：** 启动按钮接在 PLC 输入点 `I0.0`
- **公式：** 物理地址 + 符号名 = PLC 变量
- **计算：**
  - 地址：`I0.0`
  - 变量名：`Start_PB`
  - 数据类型：`Bool`
  - 注释：启动按钮
- **结论：** 程序中使用 `Start_PB` 比直接写 `I0.0` 更清晰。

> [!tip] 记忆口诀
> **地址是硬件位置，变量名是工程语言。**

---

# 02｜PLC 变量表

> [!info] 核心结论
> **PLC 变量表是集中管理变量名、地址、数据类型、注释的地方，是 PLC 项目的“信号清单”。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>工程理解</strong><br>
变量表相当于电气图纸和 PLC 程序之间的桥：图纸给地址，程序用变量名。
</div>

## ① 分类/公式/规则

| 列名 | 作用 |
|---|---|
| **名称** | 变量符号名 |
| **数据类型** | Bool、Int、Real、Word 等 |
| **地址** | 对应 PLC 地址 |
| **注释** | 说明变量用途 |
| **可访问性** | 是否供 HMI、通信等访问 |
| **保持性** | 是否断电保持，需按 CPU 支持校核 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>命名规则</strong><br>
变量名要表达对象 + 功能 + 状态，例如 <code>Motor1_RunFB</code>、<code>CylA_ExtendCmd</code>。
</div>

## ② 参考表

| 变量类别 | 命名示例 | 说明 |
|---|---|---|
| **按钮输入** | `Start_PB` | PB = Push Button |
| **传感器输入** | `Sensor_Home` | 原点传感器 |
| **电机输出** | `Motor_RunCmd` | 电机运行命令 |
| **阀门输出** | `Valve_OpenCmd` | 开阀命令 |
| **报警信号** | `Alarm_EStop` | 急停报警 |
| **模拟量** | `Temp_Raw` / `Temp_Real` | 原始值 / 工程量 |

## ③ 计算/选型示例

- **已知：** 电机有运行输出和运行反馈
- **公式：** 命令和反馈要分开命名
- **计算：**
  - 输出命令：`Motor1_RunCmd` → `Q0.0`
  - 运行反馈：`Motor1_RunFB` → `I0.2`
- **结论：** `Cmd` 表示 PLC 发出的命令，`FB` 表示现场返回的反馈，变量更清晰。

> [!tip] 记忆口诀
> **命令叫 Cmd，反馈叫 FB；名字写清楚，调试少迷路。**

---

# 03｜常见地址区

> [!info] 核心结论
> **PLC 变量常用地址区包括 I 输入区、Q 输出区、M 存储区、DB 数据块和外设地址区。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>地址口诀</strong><br>
I 看输入，Q 管输出，M 做中间，DB 存数据。
</div>

## ① 分类/公式/规则

| 地址区 | 中文含义 | 示例 |
|---|---|---|
| **I** | 输入区 | `I0.0`、`IW64` |
| **Q** | 输出区 | `Q0.0`、`QW80` |
| **M** | 存储区 | `M0.0`、`MW10` |
| **DB** | 数据块 | `DB1.DBX0.0`、`DB1.DBW2` |
| **PI / PQ** | 外设输入/输出 | 直接访问外设 |

## ② 参考表

| 数据宽度 | 含义 | 示例 |
|---|---|---|
| **Bit** | 单个位 | `I0.0` |
| **Byte** | 8 位 | `IB0` |
| **Word** | 16 位 | `IW64` |
| **DWord** | 32 位 | `ID100` |
| **Real** | 浮点数 | 通常放 DB 或按地址解释 |

## ③ 计算/选型示例

- **已知：** 一个 8 点 DI 模块起始地址为 `I0.0`
- **公式：** 第 n 个点 = 起始位 + 点号偏移
- **计算：**
  - 第 1 点：`I0.0`
  - 第 2 点：`I0.1`
  - 第 8 点：`I0.7`
- **结论：** 一个字节可包含 8 个 Bool 输入点。

> [!tip] 记忆口诀
> **点信号按位找，模拟量按字读。**

---

# 04｜数据类型

> [!info] 核心结论
> **PLC 变量的数据类型必须与信号含义和地址宽度匹配，否则容易出现数值错误、地址冲突或程序异常。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点规则</strong><br>
开关量用 Bool，状态字用 Word，计数用 DInt，工程量用 Real。
</div>

## ① 分类/公式/规则

| 数据类型 | 中文含义 | 常见用途 |
|---|---|---|
| **Bool** | 布尔量 | 按钮、传感器、输出点 |
| **Byte** | 字节 | 通信数据 |
| **Word** | 字 | 控制字、状态字 |
| **Int** | 整数 | 小范围数值 |
| **DInt** | 双整数 | 计数、位置 |
| **Real** | 浮点数 | 温度、压力、速度 |
| **Time** | 时间 | 定时参数 |
| **String** | 字符串 | 条码、产品号 |

## ② 参考表

| 信号 | 推荐类型 | 注意 |
|---|---|---|
| **启动按钮** | `Bool` | 单点输入 |
| **电机状态字** | `Word` | 位定义要清楚 |
| **编码器计数** | `DInt` | 注意正负方向 |
| **温度工程量** | `Real` | 单位要注明 |
| **Modbus寄存器** | `Word` / `Array of Word` | 字节序需校核 |
| **条码数据** | `String` / `Array of Byte` | 长度要固定 |

## ③ 计算/选型示例

- **已知：** 模拟量输入原始值为 `0~27648`
- **公式：** 模拟量原始值常用整数，工程量常用 Real
- **计算：**
  - 原始值：`Temp_Raw` → `Int`
  - 换算后：`Temp_Real` → `Real`
- **结论：** 原始采集值和工程量最好分开建变量，便于调试。

> [!tip] 记忆口诀
> **原始值看采集，工程量看现场。**

---

# 05｜PLC 变量与 DB 变量区别

> [!info] 核心结论
> **PLC 变量多用于直接地址和全局标签，DB 变量更适合结构化数据、参数、配方、状态和通信缓冲区。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
PLC 变量像“地址标签表”，DB 变量像“数据仓库里的变量”。
</div>

## ① 分类/公式/规则

| 对比项 | PLC 变量 | DB 变量 |
|---|---|---|
| **主要用途** | 地址命名 | 数据组织 |
| **常见地址** | I、Q、M、IW、QW | DB 内部变量 |
| **适合内容** | 现场点位、全局标志 | 参数、状态、配方 |
| **结构化能力** | 一般 | 强 |
| **HMI 访问** | 可以 | 更常用 |

## ② 参考表

| 数据 | 推荐位置 | 原因 |
|---|---|---|
| **按钮输入** | PLC 变量 | 对应物理地址 |
| **电机输出** | PLC 变量 | 对应物理输出 |
| **设备参数** | DB | 结构化管理 |
| **报警列表** | DB | 批量管理 |
| **通信报文** | DB | 数组/结构更方便 |
| **中间计算** | Temp / DB | 看是否需要保存 |

## ③ 计算/选型示例

- **已知：** HMI 需要设置一台电机的速度、加速度、模式
- **公式：** 多个相关参数 → 放 DB 更清晰
- **计算：**
  - `DB_MotorPara.SpeedSet`
  - `DB_MotorPara.AccSet`
  - `DB_MotorPara.Mode`
- **结论：** 成组参数不建议散放在 M 区，放 DB 更易维护。

> [!tip] 记忆口诀
> **硬件点位放变量表，成组数据放 DB。**

---

# 06｜变量命名规范

> [!info] 核心结论
> **变量命名应统一、清晰、可读，最好能从名称看出设备、功能、方向和状态。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>命名口诀</strong><br>
对象在前，功能在后；命令写 Cmd，反馈写 FB，报警写 Alm。
</div>

## ① 分类/公式/规则

| 后缀 | 含义 | 示例 |
|---|---|---|
| **Cmd** | 命令 | `Motor1_RunCmd` |
| **FB** | 反馈 | `Motor1_RunFB` |
| **Alm** | 报警 | `Motor1_OverloadAlm` |
| **Req** | 请求 | `Send_Req` |
| **Done** | 完成 | `Move_Done` |
| **Busy** | 忙碌 | `Send_Busy` |
| **Err** | 错误 | `Axis_Err` |
| **Raw** | 原始值 | `Pressure_Raw` |
| **Real** | 工程量 | `Pressure_Real` |

## ② 参考表

| 不推荐 | 推荐 | 原因 |
|---|---|---|
| **M0.0** | `AutoMode` | 可读性高 |
| **Start** | `Line1_StartPB` | 对象明确 |
| **MotorOn** | `Motor1_RunCmd` | 命令明确 |
| **Temp1** | `Tank1_TempReal` | 单位和对象清楚 |
| **Alarm1** | `EStop_Alm` | 报警含义清楚 |

## ③ 计算/选型示例

- **已知：** 一条线有两台电机，每台都有启动命令和运行反馈
- **公式：** 对象编号 + 功能后缀
- **计算：**
  - `Motor1_RunCmd`
  - `Motor1_RunFB`
  - `Motor2_RunCmd`
  - `Motor2_RunFB`
- **结论：** 按对象统一命名，后期扩展更清晰。

> [!tip] 记忆口诀
> **变量名能自解释，程序调试省一半。**

---

# 07｜变量表导入导出

> [!info] 核心结论
> **PLC 变量表通常可以导入导出，适合从电气 I/O 表、Excel 清单、标准模板中批量生成变量。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>工程价值</strong><br>
变量表批量导入可以减少手工录入错误，适合大型项目和标准化开发。
</div>

## ① 分类/公式/规则

| 操作 | 作用 |
|---|---|
| **导出变量表** | 备份变量和地址 |
| **导入变量表** | 批量建立变量 |
| **复制到 Excel** | 和电气图纸核对 |
| **按模板生成** | 保持命名规范 |
| **版本管理** | 记录变量变化 |

## ② 参考表

| 项目 | 导入前检查 |
|---|---|
| **变量名** | 是否重复 |
| **地址** | 是否冲突 |
| **数据类型** | 是否匹配 |
| **注释** | 是否清楚 |
| **设备编号** | 是否对应图纸 |
| **备用点** | 是否预留 |

## ③ 计算/选型示例

- **已知：** 电气图纸中有 64 个 DI 点位
- **公式：** 大量点位 → 批量变量表
- **计算：**
  - 从图纸整理名称、地址、注释
  - 按 TIA 变量表格式整理
  - 导入 PLC 变量
  - 编译检查重复地址
- **结论：** 点位多时，批量导入比手工新建更可靠。

> [!tip] 记忆口诀
> **点位多别手敲，变量表批量导。**

---

# 08｜常见错误与排查

> [!info] 核心结论
> **PLC 变量常见问题包括地址重复、类型错误、变量未下载、命名混乱、I/Q 方向写反、HMI 变量不同步。**

<div class="card red" style="background:#FFF4F3;border-left:6px solid #E74C3C;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>避坑提醒</strong><br>
变量名只是符号，真正对应现场的是地址；变量名写得再好，地址错了也会读错信号。
</div>

## ① 分类/公式/规则

| 问题 | 常见原因 |
|---|---|
| **变量不变化** | 地址写错 / 没有实际信号 |
| **输出不动作** | Q 地址错 / 输出模块无电 |
| **数值异常** | 数据类型不匹配 |
| **地址冲突** | 两个变量用了同一地址 |
| **HMI 显示错误** | HMI 变量未更新 |
| **程序可读性差** | 命名无规则 |

## ② 参考表

| 现象 | 排查方向 | 解决建议 |
|---|---|---|
| **按钮按下无反应** | 在线监控 I 地址 | 查接线和地址 |
| **电机输出错位** | 查 Q 地址 | 核对图纸 |
| **模拟量乱跳** | 查类型和量程 | 校核模块组态 |
| **变量红色报错** | 地址/类型非法 | 修改变量定义 |
| **HMI 不同步** | 变量路径改变 | 重新同步 HMI 变量 |
| **通信读错** | 字节序/地址 | 查映射表 |

## ③ 计算/选型示例

- **已知：** 程序读取 `Start_PB`，变量地址是 `I0.0`，但按钮实际接在 `I0.1`
- **公式：** 程序读变量 = 实际读取变量绑定地址
- **计算：**
  - 程序读取：`Start_PB`
  - `Start_PB` 绑定：`I0.0`
  - 实际按钮：`I0.1`
- **结论：** 程序不会响应按钮，应修改变量地址或现场接线。

> [!tip] 记忆口诀
> **变量不对先查地址，地址不对程序白写。**

---

# 09｜一页速记总卡

> [!info] 核心结论
> **PLC 变量的核心价值是把硬件地址变成有意义的符号名，让程序、图纸、HMI、调试都更统一。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>总口诀</strong><br>
I 是输入，Q 是输出，M 是中间，DB 存数据；变量名写清楚，程序才专业。
</div>

## ① 分类/公式/规则

| 主轴 | 关键词 |
|---|---|
| **对象** | PLC 变量 |
| **用途** | 地址符号化 |
| **常见地址** | I、Q、M、DB |
| **常见类型** | Bool、Word、DInt、Real |
| **管理方式** | 变量表 |
| **核心风险** | 地址错、类型错、命名乱 |

## ② 参考表

| 需求 | 推荐做法 |
|---|---|
| **现场输入点** | 建 PLC 变量 |
| **现场输出点** | 建 PLC 变量 |
| **模拟量原始值** | 建 `Raw` 变量 |
| **工程量数值** | 放 DB 或变量 |
| **设备参数** | 放 DB |
| **通信缓冲区** | 放 DB 数组 |
| **HMI 交互** | DB + 清晰变量名 |

## ③ 计算/选型示例

- **已知：** 要给一台电机建立基础变量
- **公式：** 电机变量 = 命令 + 反馈 + 报警 + 状态
- **计算：**
  - `Motor1_RunCmd` → `Q0.0`
  - `Motor1_RunFB` → `I0.0`
  - `Motor1_FaultFB` → `I0.1`
  - `Motor1_Ready` → `M0.0`
- **结论：** 变量按功能分清，程序结构会更清楚。

> [!tip] 记忆口诀
> **硬件信号先建变量，程序逻辑再用名字。**