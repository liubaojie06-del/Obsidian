---
tags:
  - PLC
  - TIA_Portal
  - MODBUS_RTU
  - Modbus串口通信
  - 主站通信
  - 从站通信
  - 端口组态
  - 西门子
aliases:
  - MODBUS（RTU）
  - MODBUS RTU
  - Modbus RTU
  - Modbus_Comm_Load
  - Modbus_Master
  - Modbus_Slave
  - Modbus 主站
  - Modbus 从站
---
## 01 `Modbus_Comm_Load` | 组态 Modbus 的端口

> [!info] 核心结论
> **Modbus_Comm_Load** 用于初始化和组态 Modbus RTU 通信端口，是 Modbus RTU 通信前的第一步。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V6.0</strong><br>
指令版本：<strong>V5.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **MODBUS（RTU）** |
| 指令名称 | **Modbus_Comm_Load** |
| 功能描述 | **组态 Modbus 的端口** |
| 版本 | **V5.0** |
| 核心作用 | 初始化 Modbus RTU 通信端口 |
| 使用重点 | 波特率、校验位、停止位、端口号、通信模式需按实际设备手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
Modbus RTU 通信失败，先查端口参数：<strong>波特率、校验位、数据位、停止位、站地址</strong>。
</div>

### ② 参考表

| 参数 | 说明 |
|---|---|
| 波特率 | 双方必须一致，如 9600 / 19200 |
| 校验位 | None / Even / Odd，需与从站一致 |
| 数据位 | 常见为 **8 位** |
| 停止位 | 常见为 1 位或 2 位 |
| 通信端口 | 对应实际串口或通信模块端口 |
| 站地址 | 每个从站地址必须唯一 |

### ③ 计算/选型示例

- 已知：PLC 要通过 RS485 与温控表进行 Modbus RTU 通信
- 公式/规则：通信前必须先组态端口参数
- 操作：使用 **Modbus_Comm_Load** 设置波特率、校验位、停止位和端口
- 结论：端口组态完成后，才能使用主站或从站指令通信

> [!tip] 记忆口诀
> **RTU 先配口，波特校验别弄错。**


## 02 `Modbus_Master` | 作为 Modbus 主站通信

> [!info] 核心结论
> **Modbus_Master** 用于让 PLC 作为 Modbus RTU 主站，主动读取或写入从站设备数据。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
指令版本：<strong>V6.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **MODBUS（RTU）** |
| 指令名称 | **Modbus_Master** |
| 功能描述 | **作为 Modbus 主站通信** |
| 版本 | **V6.0** |
| 通信角色 | **Modbus RTU Master 主站** |
| 核心作用 | 主动访问从站寄存器或线圈 |
| 使用重点 | 从站地址、功能码、寄存器地址、数据长度需按设备手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">重点规则</strong><br>
主站是<strong>主动方</strong>：主动发请求，从站只负责响应。
</div>

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 读取仪表数据 | 温度、压力、流量、电量等 |
| 写入设定值 | 写温度设定、频率设定、控制参数 |
| 读取线圈状态 | 获取开关量状态 |
| 写入线圈命令 | 控制远程继电器或设备动作 |
| 风险提醒 | 地址偏移、数据类型、大小端需校核 |

### ③ 计算/选型示例

- 已知：PLC 要读取温控表当前温度寄存器
- 公式/规则：PLC 主动读取从站数据，应作为 **Modbus 主站**
- 操作：先用 **Modbus_Comm_Load** 组态端口，再用 **Modbus_Master** 设置从站地址、功能码和寄存器地址
- 结论：PLC 可读取温控表返回的温度数据

> [!tip] 记忆口诀
> **我主动问别人，用 Modbus_Master。**


## 03 `Modbus_Slave` | 作为 Modbus 从站通信

> [!info] 核心结论
> **Modbus_Slave** 用于让 PLC 作为 Modbus RTU 从站，等待主站读取或写入 PLC 数据。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
指令版本：<strong>V6.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **MODBUS（RTU）** |
| 指令名称 | **Modbus_Slave** |
| 功能描述 | **作为 Modbus 从站通信** |
| 版本 | **V6.0** |
| 通信角色 | **Modbus RTU Slave 从站** |
| 核心作用 | 被主站访问，提供或接收数据 |
| 使用重点 | 从站地址、数据映射区、访问权限需按项目校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
从站是<strong>被动方</strong>：等待主站请求，再返回数据或接收写入。
</div>

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 上位机读取 PLC 数据 | PLC 提供寄存器数据 |
| 第三方主站访问 PLC | PLC 作为 Modbus 从站 |
| 主站写入 PLC 参数 | 接收设定值、控制字 |
| 多设备联网 | 每个从站地址必须唯一 |
| 安全提醒 | 允许外部写入时，必须加权限和联锁 |

### ③ 计算/选型示例

- 已知：上位机作为 Modbus 主站，需要读取 PLC 的运行状态和产量
- 公式/规则：外部设备主动访问 PLC，PLC 应作为 **Modbus 从站**
- 操作：使用 **Modbus_Slave**，配置从站地址和数据映射区
- 结论：上位机可读取 PLC 开放的寄存器数据

> [!tip] 记忆口诀
> **别人主动问我，用 Modbus_Slave。**


## 04 MODBUS（RTU） | 选型速记

> [!info] 核心结论
> MODBUS RTU 选型先看角色：**先用 Modbus_Comm_Load 配端口；PLC 主动访问别人用 Master；别人访问 PLC 用 Slave。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
先 Load 配端口，主动访问用 Master，被动等待用 Slave。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 端口组态 | **Modbus_Comm_Load** |
| 主站通信 | **Modbus_Master** |
| 从站通信 | **Modbus_Slave** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 初始化 Modbus RTU 端口 | **Modbus_Comm_Load** |
| PLC 读取温控表/电表/仪表 | **Modbus_Master** |
| PLC 写入从站设定值 | **Modbus_Master** |
| 上位机读取 PLC 数据 | **Modbus_Slave** |
| 第三方主站写入 PLC 数据 | **Modbus_Slave** |
| 多从站轮询 | **Modbus_Master**，站地址需唯一 |
| PLC 被多个设备访问 | **Modbus_Slave**，需校核通信能力 |

### ③ 计算/选型示例

- 已知：PLC 要读取 3 台仪表数据，同时上位机也要读取 PLC 状态
- 公式/规则：PLC 主动读仪表 = Master；上位机访问 PLC = PLC 做 Slave
- 操作：先用 **Modbus_Comm_Load** 配置端口；读取仪表用 **Modbus_Master**；开放数据给上位机用 **Modbus_Slave**
- 结论：同类项目中主站和从站角色要按“谁主动访问谁”来判断

> [!tip] 记忆口诀
> **我问别人是 Master，别人问我是 Slave；通信之前先 Load。**