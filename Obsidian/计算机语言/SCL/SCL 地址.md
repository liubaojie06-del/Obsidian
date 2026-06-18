---
title: SCL 地址知识卡片
created: 2026-05-10
updated: 2026-05-10
tags:
  - SCL
  - PLC
  - 地址
  - 西门子PLC
  - TIA Portal
category: PLC编程
platform: Siemens TIA Portal
language: SCL
aliases:
  - SCL地址
  - PLC地址
  - 西门子地址
---

# 01｜I 输入地址

> [!NOTE] 卡片定位  
> `I` 表示输入地址，也叫 Input。  
> 它对应 PLC 的外部输入信号，例如按钮、接近开关、光电、限位、传感器开关量。

> [!IMPORTANT] 底层原理  
> PLC 每个扫描周期开始时，会先把现场输入模块的状态读取到输入映像区。  
> SCL 程序读取 `I` 地址时，通常读到的是输入映像区里的状态。

| 地址 | 含义 |
|---|---|
| `%I0.0` | 第 0 字节第 0 位输入 |
| `%I0.1` | 第 0 字节第 1 位输入 |
| `%IB0` | 输入字节 0 |
| `%IW0` | 输入字 0 |
| `%ID0` | 输入双字 0 |

> [!TIP] 使用场景  
> 读取现场输入信号，例如启动按钮、停止按钮、急停、限位、光电检测。

```scl
// 场景：读取启动按钮
// %I0.0：启动按钮输入
// StartButton：程序内部启动按钮变量

StartButton := %I0.0;

IF StartButton = TRUE THEN
    StartRequest := TRUE;
END_IF;
```

```scl
// 场景：光电传感器检测到产品后，计数加 1
// %I0.1：光电传感器
// ProductSensor：产品检测信号

ProductSensor := %I0.1;

IF ProductSensor = TRUE AND LastProductSensor = FALSE THEN
    ProductCount := ProductCount + 1;
END_IF;

LastProductSensor := ProductSensor;
```

> [!WARNING] 工程建议  
> 不建议在大型项目中到处直接写 `%I0.0`。  
> 更推荐先建立符号变量，例如 `StartButton`、`PhotoSensor`、`EmergencyStop`。

> [!IMPORTANT] 工控口诀  
> **现场输入看 `I`，按钮光电限位都从 `I` 进来。**

---

# 02｜Q 输出地址

> [!NOTE] 卡片定位  
> `Q` 表示输出地址，也叫 Output。  
> 它对应 PLC 的外部输出信号，例如继电器、接触器、电磁阀、指示灯、蜂鸣器。

> [!IMPORTANT] 底层原理  
> SCL 程序运行过程中会写入输出映像区。  
> PLC 扫描周期结束时，再把输出映像区的状态刷新到实际输出模块。

| 地址 | 含义 |
|---|---|
| `%Q0.0` | 第 0 字节第 0 位输出 |
| `%Q0.1` | 第 0 字节第 1 位输出 |
| `%QB0` | 输出字节 0 |
| `%QW0` | 输出字 0 |
| `%QD0` | 输出双字 0 |

> [!TIP] 使用场景  
> 控制现场执行元件，例如电机运行、电磁阀动作、报警灯、蜂鸣器。

```scl
// 场景：控制电机接触器
// MotorRun：程序内部运行命令
// %Q0.0：电机接触器输出

IF MotorRun = TRUE THEN
    %Q0.0 := TRUE;
ELSE
    %Q0.0 := FALSE;
END_IF;
```

```scl
// 场景：报警时打开红灯和蜂鸣器
// %Q0.1：红灯
// %Q0.2：蜂鸣器

IF GeneralAlarm = TRUE THEN
    %Q0.1 := TRUE;
    %Q0.2 := TRUE;
ELSE
    %Q0.1 := FALSE;
    %Q0.2 := FALSE;
END_IF;
```

> [!WARNING] 工程建议  
> 输出地址不要被多个程序段重复写入。  
> 一个输出最好只在一个统一位置最终赋值，避免互相覆盖。

> [!IMPORTANT] 工控口诀  
> **现场动作看 `Q`，电机阀灯蜂鸣器都从 `Q` 出去。**

---

# 03｜M 位存储地址

> [!NOTE] 卡片定位  
> `M` 表示存储器地址，也叫 Memory。  
> 它是 PLC 内部的全局存储区，常用于中间状态、辅助继电器、内部标志位。

> [!IMPORTANT] 底层原理  
> `M` 地址不直接连接现场硬件。  
> 它是 PLC 内部的一块公共存储区，多个程序块都可以访问。

| 地址 | 含义 |
|---|---|
| `%M0.0` | 第 0 字节第 0 位存储位 |
| `%M0.1` | 第 0 字节第 1 位存储位 |
| `%MB0` | 存储字节 0 |
| `%MW0` | 存储字 0 |
| `%MD0` | 存储双字 0 |

> [!TIP] 使用场景  
> 中间变量、状态保持、内部标志、启动保持、联锁状态。

```scl
// 场景：启动停止自保持
// %I0.0：启动按钮
// %I0.1：停止按钮
// %M10.0：电机运行保持位
// %Q0.0：电机输出

IF %I0.0 = TRUE THEN
    %M10.0 := TRUE;
END_IF;

IF %I0.1 = TRUE THEN
    %M10.0 := FALSE;
END_IF;

%Q0.0 := %M10.0;
```

```scl
// 场景：设备进入自动运行状态后，置位内部标志

IF Mode = 1 AND StartButton = TRUE AND FaultCode = 0 THEN
    %M20.0 := TRUE;
END_IF;

IF StopButton = TRUE OR FaultCode <> 0 THEN
    %M20.0 := FALSE;
END_IF;

AutoRunning := %M20.0;
```

> [!WARNING] 工程建议  
> `M` 是全局区域，容易被不同程序块重复使用。  
> 大型项目中更推荐使用 DB 变量替代大量 M 地址。

> [!IMPORTANT] 工控口诀  
> **中间状态用 `M`，但大型项目少用裸地址，多用符号名。**

---

# 04｜L 局部地址

> [!NOTE] 卡片定位  
> `L` 表示局部数据地址，也叫 Local。  
> 它属于当前程序块的临时局部数据区，常对应 `TEMP` 临时变量的底层存储区域。

> [!IMPORTANT] 底层原理  
> `L` 地址只在当前块调用期间有效。  
> 块执行结束后，局部数据区可能被其他块复用。  
> 所以 `L` 不适合做长期保存数据。

| 地址 | 含义 |
|---|---|
| `%L0.0` | 局部数据第 0 字节第 0 位 |
| `%LB0` | 局部字节 0 |
| `%LW0` | 局部字 0 |
| `%LD0` | 局部双字 0 |

> [!TIP] 使用场景  
> 临时计算、中间判断、只在当前 FC / FB 内部使用的短周期数据。

```scl
// 场景：在当前块内部临时判断启动允许
// 注意：工程中更推荐使用 TEMP 变量名，而不是直接写 %L 地址

%L0.0 := Mode = 1
         AND EmergencyStop = FALSE
         AND FaultCode = 0;

IF %L0.0 = TRUE AND StartButton = TRUE THEN
    MotorRun := TRUE;
ELSE
    MotorRun := FALSE;
END_IF;
```

更推荐写法：

```scl
// 场景：使用 TEMP 变量代替直接 L 地址
// StartPermit 是当前块 TEMP 区的临时变量

StartPermit := Mode = 1
               AND EmergencyStop = FALSE
               AND FaultCode = 0;

IF StartPermit = TRUE AND StartButton = TRUE THEN
    MotorRun := TRUE;
ELSE
    MotorRun := FALSE;
END_IF;
```

> [!WARNING] 使用风险  
> `L` 不是全局保持区。  
> 不要用 `L` 保存设备状态、报警状态、计数值、步序号。  
> 这些数据应该放到 `DB`、`STAT` 或保持型变量中。

> [!IMPORTANT] 工控口诀  
> **临时计算可用 `L`，长期保存别用 `L`。**  
> **SCL 项目优先写变量名，不要直接操作 `%L` 裸地址。**

---

# 05｜DB 数据块地址

> [!NOTE] 卡片定位  
> `DB` 表示数据块地址，也叫 Data Block。  
> 它是 PLC 中最常用的数据存储区，适合保存设备参数、状态、计数、报警、配方等数据。

> [!IMPORTANT] 底层原理  
> DB 是一块结构化存储区域。  
> FC、FB、OB 都可以访问 DB 中的数据。  
> FB 的背景数据块 Instance DB 还会保存 FB 的静态变量。

| 类型 | 说明 |
|---|---|
| 全局 DB | 多个程序块都能访问 |
| 背景 DB | FB 专用的数据存储区 |
| 优化 DB | 推荐用符号访问 |
| 非优化 DB | 可以使用绝对地址访问 |

> [!TIP] 使用场景  
> 保存工艺参数、HMI 参数、设备状态、报警信息、累计数量、配方数据。

```scl
// 场景：从全局 DB 读取速度设定
// 推荐符号访问

ConveyorSpeedSet := "DB_Conveyor".SpeedSet;

IF "DB_Conveyor".StartCmd = TRUE THEN
    ConveyorRun := TRUE;
END_IF;
```

```scl
// 场景：把当前产量写入 DB，供 HMI 显示

"DB_Production".CurrentCount := ProductCount;

IF ProductCount >= "DB_Production".TargetCount THEN
    "DB_Production".BatchFinish := TRUE;
ELSE
    "DB_Production".BatchFinish := FALSE;
END_IF;
```

> [!WARNING] 工程建议  
> TIA Portal 中推荐使用优化数据块和符号访问。  
> 不建议大量使用 `DB1.DBX0.0` 这类绝对地址，后期维护困难。

> [!IMPORTANT] 工控口诀  
> **参数状态放 `DB`，HMI 通讯最常用。**

---

# 06｜DBX 数据块位地址

> [!NOTE] 卡片定位  
> `DBX` 表示数据块中的位地址。  
> 它常用于访问 DB 中的 BOOL 位。

> [!IMPORTANT] 底层原理  
> `DBX` 精确到某个字节中的某一位。  
> 例如 `DB1.DBX0.0` 表示 DB1 第 0 字节第 0 位。

| 地址 | 含义 |
|---|---|
| `DB1.DBX0.0` | DB1 第 0 字节第 0 位 |
| `DB1.DBX0.1` | DB1 第 0 字节第 1 位 |
| `DB1.DBX1.0` | DB1 第 1 字节第 0 位 |

> [!TIP] 使用场景  
> 存放启动命令、停止命令、报警位、状态位、HMI 按钮位。

```scl
// 场景：HMI 在 DB1.DBX0.0 写入启动命令
// DB1.DBX0.1 写入停止命令
// Q0.0 控制输送线运行

IF DB1.DBX0.0 = TRUE THEN
    ConveyorRun := TRUE;
END_IF;

IF DB1.DBX0.1 = TRUE THEN
    ConveyorRun := FALSE;
END_IF;

%Q0.0 := ConveyorRun;
```

符号访问推荐写法：

```scl
// 场景：使用符号名代替 DBX 绝对地址

IF "DB_HMI".StartCmd = TRUE THEN
    ConveyorRun := TRUE;
END_IF;

IF "DB_HMI".StopCmd = TRUE THEN
    ConveyorRun := FALSE;
END_IF;
```

> [!WARNING] 工程建议  
> `DBX` 地址适合调试和兼容旧项目。  
> 新项目推荐用 DB 变量名访问，避免 DB 结构调整后地址错位。

> [!IMPORTANT] 工控口诀  
> **DB 里的 BOOL 位，看 `DBX`。**

---

# 07｜DBB 数据块字节地址

> [!NOTE] 卡片定位  
> `DBB` 表示数据块中的字节地址。  
> 一个字节等于 8 位。

> [!IMPORTANT] 底层原理  
> `DBB` 访问的是 DB 中连续 8 位数据。  
> 常用于 BYTE、CHAR、小范围状态字节。

| 地址 | 含义 |
|---|---|
| `DB1.DBB0` | DB1 第 0 字节 |
| `DB1.DBB1` | DB1 第 1 字节 |
| `DB1.DBB2` | DB1 第 2 字节 |

> [!TIP] 使用场景  
> 状态字节、通讯字节、设备编号、简单枚举值。

```scl
// 场景：读取通讯状态字节
// DB1.DBB10：通讯状态
// 0 正常，1 断线，2 超时，3 数据错误

CommState := DB1.DBB10;

IF CommState = 0 THEN
    CommOK := TRUE;
ELSE
    CommOK := FALSE;
END_IF;
```

```scl
// 场景：写入设备运行模式
// 0 手动，1 自动，2 维修

IF AutoButton = TRUE THEN
    DB1.DBB20 := 1;
ELSIF ManualButton = TRUE THEN
    DB1.DBB20 := 0;
ELSIF ServiceButton = TRUE THEN
    DB1.DBB20 := 2;
END_IF;
```

> [!WARNING] 数据类型注意  
> `DBB` 是字节级访问，适合 BYTE。  
> 如果变量是 INT、REAL、DINT，不要随便用 DBB 拆开写，容易造成数据错乱。

> [!IMPORTANT] 工控口诀  
> **DB 里的 8 位数据，看 `DBB`。**

---

# 08｜DBW 数据块字地址

> [!NOTE] 卡片定位  
> `DBW` 表示数据块中的字地址。  
> 一个 Word 等于 16 位，通常对应 `WORD` 或 `INT`。

> [!IMPORTANT] 底层原理  
> `DBW` 从指定字节开始，连续占用 2 个字节。  
> 例如 `DB1.DBW0` 占用 DB1 的 Byte 0 和 Byte 1。

| 地址 | 含义 |
|---|---|
| `DB1.DBW0` | DB1 从字节 0 开始的 16 位数据 |
| `DB1.DBW2` | DB1 从字节 2 开始的 16 位数据 |
| `DB1.DBW4` | DB1 从字节 4 开始的 16 位数据 |

> [!TIP] 使用场景  
> INT 数值、WORD 状态字、模拟量原始值、短整数参数。

```scl
// 场景：HMI 把目标产量写入 DB1.DBW0
// 当前产量达到目标后，停止设备

TargetCount := DB1.DBW0;

IF ProductCount >= TargetCount THEN
    LineRun := FALSE;
    BatchFinish := TRUE;
ELSE
    BatchFinish := FALSE;
END_IF;
```

```scl
// 场景：读取模拟量原始值
// DB1.DBW10 保存压力传感器原始值 0~27648

AI_Raw := DB1.DBW10;
Pressure_MPa := INT_TO_REAL(AI_Raw) * 1.0 / 27648.0;

IF Pressure_MPa < 0.45 THEN
    LowPressureAlarm := TRUE;
ELSE
    LowPressureAlarm := FALSE;
END_IF;
```

> [!WARNING] 地址对齐注意  
> `DBW0` 占用 Byte0 和 Byte1。  
> 下一个 Word 通常从 `DBW2` 开始，不要和前一个数据重叠。

> [!IMPORTANT] 工控口诀  
> **DB 里的 16 位数据，看 `DBW`。**

---

# 09｜DBD 数据块双字地址

> [!NOTE] 卡片定位  
> `DBD` 表示数据块中的双字地址。  
> 一个 Double Word 等于 32 位，通常对应 `DWORD`、`DINT`、`REAL`。

> [!IMPORTANT] 底层原理  
> `DBD` 从指定字节开始，连续占用 4 个字节。  
> 例如 `DB1.DBD0` 占用 Byte0 到 Byte3。

| 地址 | 常见类型 | 说明 |
|---|---|---|
| `DB1.DBD0` | `DINT` | 32 位整数 |
| `DB1.DBD4` | `REAL` | 32 位浮点数 |
| `DB1.DBD8` | `DWORD` | 32 位位组合 |

> [!TIP] 使用场景  
> REAL 工程量、DINT 计数值、编码器位置、累计产量、浮点参数。

```scl
// 场景：从 DB1.DBD0 读取设定切割长度
// Length_mm：当前长度
// CutLength_mm：设定长度

CutLength_mm := DB1.DBD0;

IF Length_mm >= CutLength_mm THEN
    ConveyorRun := FALSE;
    CutterStart := TRUE;
ELSE
    ConveyorRun := TRUE;
    CutterStart := FALSE;
END_IF;
```

```scl
// 场景：把编码器累计脉冲保存到 DB1.DBD20
// EncoderPulse：DINT 编码器脉冲

DB1.DBD20 := EncoderPulse;

Length_mm := DINT_TO_REAL(EncoderPulse) * 0.5;
```

> [!WARNING] 类型匹配注意  
> `DBD` 可以表示 DINT，也可以表示 REAL。  
> 关键要看变量实际数据类型。  
> 同一个地址不要一会儿当 DINT，一会儿当 REAL 使用。

> [!IMPORTANT] 工控口诀  
> **DB 里的 32 位数据，看 `DBD`。**

---



> [!NOTE] 卡片定位  
> `LD` 表示局部数据双字地址。  
> 它是当前程序块局部数据区中的 32 位数据。

> [!IMPORTANT] 底层原理  
> `LD` 占用 4 个局部字节。  
> 常对应当前块 TEMP 区里的 REAL、DINT、DWORD 临时数据。

| 地址 | 常见类型 |
|---|---|
| `%LD0` | `DINT` / `REAL` / `DWORD` |
| `%LD4` | `DINT` / `REAL` / `DWORD` |
| `%LD8` | `DINT` / `REAL` / `DWORD` |

> [!TIP] 使用场景  
> 当前块内部临时 REAL 计算、位置误差、速度误差、工程量换算。

```scl
// 场景：当前块内部临时计算位置误差
// 工程中更推荐使用 TEMP 变量

%LD0 := ActualPosition - TargetPosition;

IF ABS(%LD0) <= 0.2 THEN
    AxisInPosition := TRUE;
ELSE
    AxisInPosition := FALSE;
END_IF;
```

推荐写法：

```scl
// 使用 TEMP 变量 PositionError

PositionError := ActualPosition - TargetPosition;

IF ABS(PositionError) <= 0.2 THEN
    AxisInPosition := TRUE;
ELSE
    AxisInPosition := FALSE;
END_IF;
```

> [!WARNING] 类型注意  
> `LD` 是 32 位区域，可能表示 REAL，也可能表示 DINT。  
> 必须保持类型一致，避免同一地址混用。

> [!IMPORTANT] 工控口诀  
> **局部 32 位数据是 `LD`，SCL 优先用 TEMP 名称。**

---

# 10｜符号地址

> [!NOTE] 卡片定位  
> 符号地址就是用变量名访问地址。  
> 例如用 `StartButton` 代替 `%I0.0`，用 `MotorRun` 代替 `%Q0.0`。

> [!IMPORTANT] 底层原理  
> 符号变量会在变量表、DB 或块接口中绑定实际地址或存储位置。  
> 程序使用变量名，编译器负责对应到底层地址。

| 裸地址 | 符号地址 |
|---|---|
| `%I0.0` | `StartButton` |
| `%I0.1` | `StopButton` |
| `%Q0.0` | `MotorRun` |
| `%M10.0` | `AutoRunning` |
| `DB1.DBX0.0` | `"DB_HMI".StartCmd` |

> [!TIP] 使用场景  
> 新项目、标准程序、长期维护项目、多人协作项目。

```scl
// 裸地址写法

IF %I0.0 = TRUE AND %I0.1 = FALSE THEN
    %Q0.0 := TRUE;
ELSE
    %Q0.0 := FALSE;
END_IF;
```

推荐写法：

```scl
// 符号地址写法

IF StartButton = TRUE AND StopButton = FALSE THEN
    MotorRun := TRUE;
ELSE
    MotorRun := FALSE;
END_IF;
```

```scl
// 场景：使用 DB 符号地址保存 HMI 参数

IF "DB_HMI".StartCmd = TRUE
   AND "DB_Status".FaultCode = 0 THEN

    "DB_Status".MachineRun := TRUE;

END_IF;
```

> [!WARNING] 工程建议  
> SCL 项目优先使用符号地址。  
> 裸地址只建议用于调试、兼容旧项目、特殊通讯映射。

> [!IMPORTANT] 工控口诀  
> **程序给人看，用符号地址；底层给 PLC 看，才是绝对地址。**

---

# 11｜绝对地址

> [!NOTE] 卡片定位  
> 绝对地址就是直接写出 PLC 的物理或存储地址。  
> 例如 `%I0.0`、`%Q0.0`、`%M10.0`、`DB1.DBX0.0`。

> [!IMPORTANT] 底层原理  
> 绝对地址直接指向 PLC 内部存储区或模块映像区。  
> 优点是直观，缺点是维护困难，地址变动后程序容易出错。

| 地址 | 类型 |
|---|---|
| `%I0.0` | 输入位 |
| `%Q0.0` | 输出位 |
| `%M10.0` | 存储位 |
| `%MW100` | 存储字 |
| `%MD200` | 存储双字 |
| `DB1.DBX0.0` | DB 位 |
| `DB1.DBW2` | DB 字 |
| `DB1.DBD4` | DB 双字 |

> [!TIP] 使用场景  
> 快速调试、旧项目维护、通讯映射、硬件地址测试。

```scl
// 场景：快速测试输入输出
// 按下 I0.0，输出 Q0.0

IF %I0.0 = TRUE THEN
    %Q0.0 := TRUE;
ELSE
    %Q0.0 := FALSE;
END_IF;
```

```scl
// 场景：旧项目中使用 M 地址作为中间继电器

IF %I0.0 = TRUE THEN
    %M10.0 := TRUE;
END_IF;

IF %I0.1 = TRUE THEN
    %M10.0 := FALSE;
END_IF;

%Q0.0 := %M10.0;
```

> [!WARNING] 工程风险  
> 绝对地址可读性差。  
> 地址复用、地址重叠、硬件调整后未同步修改，都是常见故障来源。

> [!IMPORTANT] 工控口诀  
> **绝对地址适合调试，正式程序优先符号化。**

---

# 12｜AT 地址映射

> [!NOTE] 卡片定位  
> `AT` 是 SCL 中常用的地址映射方式。  
> 它可以把一个变量映射到另一个变量的相同存储区域，用于拆位、拆字节、解析通讯数据。

> [!IMPORTANT] 底层原理  
> `AT` 不复制数据。  
> 它让不同变量名共享同一块内存。  
> 一个变量变化，映射变量看到的内容也会变化。

| 用法 | 作用 |
|---|---|
| `AT` 位映射 | 把 WORD 拆成 BOOL 位 |
| `AT` 字节映射 | 把 WORD 拆成 BYTE |
| `AT` 结构映射 | 把通讯数据解析成结构 |
| `AT` 状态字解析 | 解析驱动器状态字 |

> [!TIP] 使用场景  
> 变频器状态字、伺服控制字、通讯报文解析、报警字拆位。

```scl
// 场景：把状态字拆成多个状态位
// StatusWord：驱动器状态字
// StatusBits：映射出的状态位

VAR_TEMP
    StatusWord : WORD;
    StatusBits AT StatusWord : STRUCT
        Ready      : BOOL;
        Running    : BOOL;
        Fault      : BOOL;
        Warning    : BOOL;
        Remote     : BOOL;
        Reserved5  : BOOL;
        Reserved6  : BOOL;
        Reserved7  : BOOL;
        Reserved8  : BOOL;
        Reserved9  : BOOL;
        Reserved10 : BOOL;
        Reserved11 : BOOL;
        Reserved12 : BOOL;
        Reserved13 : BOOL;
        Reserved14 : BOOL;
        Reserved15 : BOOL;
    END_STRUCT;
END_VAR

StatusWord := DriveStatusWord;

IF StatusBits.Fault = TRUE THEN
    DriveFault := TRUE;
ELSE
    DriveFault := FALSE;
END_IF;
```

```scl
// 场景：根据 BOOL 位组合控制字
// ControlWord 最终发送给变频器

VAR_TEMP
    ControlWord : WORD;
    ControlBits AT ControlWord : STRUCT
        Enable     : BOOL;
        Start      : BOOL;
        ResetFault : BOOL;
        Jog        : BOOL;
        Direction  : BOOL;
        Reserved5  : BOOL;
        Reserved6  : BOOL;
        Reserved7  : BOOL;
        Reserved8  : BOOL;
        Reserved9  : BOOL;
        Reserved10 : BOOL;
        Reserved11 : BOOL;
        Reserved12 : BOOL;
        Reserved13 : BOOL;
        Reserved14 : BOOL;
        Reserved15 : BOOL;
    END_STRUCT;
END_VAR

ControlWord := 0;

ControlBits.Enable := TRUE;
ControlBits.Start := MotorStartCmd;
ControlBits.ResetFault := ResetButton;

DriveControlWord := ControlWord;
```

> [!WARNING] 使用注意  
> `AT` 映射对数据类型、字节顺序、位顺序很敏感。  
> 用于通讯解析时，必须对照设备手册确认每一位含义。

> [!IMPORTANT] 工控口诀  
> **拆状态字用 `AT`，先看手册再映射。**

---

# 13｜地址重叠

> [!NOTE] 卡片定位  
> 地址重叠是 PLC 地址使用中的常见错误。  
> 它指多个变量占用了同一片存储区域，导致数据互相覆盖。

> [!IMPORTANT] 底层原理  
> 字节、字、双字是包含关系。  
> 例如 `%MW0` 占用 `%MB0` 和 `%MB1`。  
> `%MD0` 占用 `%MB0`、`%MB1`、`%MB2`、`%MB3`。

| 地址 | 实际占用 |
|---|---|
| `%MB0` | Byte 0 |
| `%MW0` | Byte 0 + Byte 1 |
| `%MD0` | Byte 0 + Byte 1 + Byte 2 + Byte 3 |
| `%MW2` | Byte 2 + Byte 3 |
| `%MD4` | Byte 4 + Byte 5 + Byte 6 + Byte 7 |

> [!TIP] 正确地址规划  
> BOOL 按位分配。  
> BYTE 按 1 字节递增。  
> WORD / INT 按 2 字节递增。  
> DWORD / DINT / REAL 按 4 字节递增。

错误示例：

```scl
// 错误：地址重叠
// %MW0 占用 MB0 和 MB1
// %MB1 又被单独使用，会互相影响

%MW0 := ProductCount;
%MB1 := Mode;
```

正确示例：

```scl
// 正确：避免重叠
// MW0 占用 MB0 和 MB1
// Mode 放到 MB2

%MW0 := ProductCount;
%MB2 := Mode;
```

```scl
// 正确：REAL 使用 MD 地址时，按 4 字节递增

%MD0 := SpeedSet;
%MD4 := PressureSet;
%MD8 := TempSet;
```

> [!WARNING] 常见故障  
> 地址重叠会导致数据莫名变化。  
> 比如写了 `%MB1`，结果 `%MW0` 的数值也变了。

> [!IMPORTANT] 工控口诀  
> **字占 2 字节，双字占 4 字节；地址规划不重叠，程序才稳定。**

---

# 14｜地址选型规则

> [!NOTE] 卡片定位  
> 地址选型规则用于快速判断一个信号应该放在哪个区域。

| 需求 | 推荐地址 |
|---|---|
| 现场按钮 | `I` |
| 现场传感器 | `I` |
| 电机接触器 | `Q` |
| 电磁阀 | `Q` |
| 指示灯 | `Q` |
| 内部辅助位 | `M` |
| 临时计算 | `L` / TEMP |
| HMI 参数 | `DB` |
| 设备状态 | `DB` |
| 报警信息 | `DB` |
| 配方数据 | `DB` |
| FB 静态变量 | `STAT` / 背景 DB |
| 通讯映射 | `DB` 或 `I/Q` 映射区 |

> [!IMPORTANT] 选型原则  
> 现场进来用 `I`。  
> 现场出去用 `Q`。  
> 内部临时状态用 `M` 或 DB。  
> 当前块临时计算用 `L` 或 TEMP。  
> 需要 HMI、通讯、保持、归档的数据放 `DB`。

```scl
// 场景：标准设备启动逻辑地址选型

// I：现场输入
StartButton := %I0.0;
StopButton := %I0.1;
EmergencyStop := %I0.2;

// DB：HMI 参数
AutoMode := "DB_HMI".AutoMode;
TargetCount := "DB_HMI".TargetCount;

// TEMP / L：当前块临时判断
StartPermit := AutoMode = TRUE
               AND EmergencyStop = FALSE
               AND FaultCode = 0;

// Q：现场输出
IF StartPermit = TRUE AND StartButton = TRUE THEN
    MotorRun := TRUE;
END_IF;

IF StopButton = TRUE OR EmergencyStop = TRUE THEN
    MotorRun := FALSE;
END_IF;

%Q0.0 := MotorRun;
```

> [!WARNING] 工程建议  
> 新项目尽量少用裸 `M` 地址堆逻辑。  
> 设备状态、报警、参数更推荐集中放入结构化 DB。

> [!IMPORTANT] 工控口诀  
> **输入 I，输出 Q，中间 M，临时 L，参数状态放 DB。**

---

# 15｜地址速记

> [!NOTE] 卡片定位  
> 本卡片用于快速记忆 SCL 常用地址。

| 地址 | 中文含义 | 常见用途 |
|---|---|---|
| `I` | 输入区 | 按钮、传感器 |
| `Q` | 输出区 | 电机、阀、灯 |
| `M` | 存储区 | 内部辅助位 |
| `L` | 局部区 | 当前块临时数据 |
| `DB` | 数据块 | 参数、状态、HMI |
| `X` | 位 | BOOL |
| `B` | 字节 | BYTE |
| `W` | 字 | WORD / INT |
| `D` | 双字 | DWORD / DINT / REAL |

> [!IMPORTANT] 地址宽度口诀  
> `X` 是位，`B` 是 8 位。  
> `W` 是 16 位，`D` 是 32 位。

```scl
// 位地址
%I0.0
%Q0.0
%M10.0
DB1.DBX0.0

// 字节地址
%IB0
%QB0
%MB0
%LB0
DB1.DBB0

// 字地址
%IW0
%QW0
%MW0
%LW0
DB1.DBW0

// 双字地址
%ID0
%QD0
%MD0
%LD0
DB1.DBD0
```

> [!IMPORTANT] 最终口诀  
> **I 是进，Q 是出，M 是中间，L 是局部，DB 存数据。**  
> **X 位，B 字节，W 双字节，D 四字节。**