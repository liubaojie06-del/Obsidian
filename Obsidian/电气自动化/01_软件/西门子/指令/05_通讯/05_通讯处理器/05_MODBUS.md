---
tags:
  - PLC
  - TIA_Portal
  - MODBUS
  - PtP通信
  - Modbus通信
  - 主站通信
  - 从站通信
  - 串口通信
  - 西门子
aliases:
  - MODBUS
  - MB_COMM_LOAD
  - MB_MASTER
  - MB_SLAVE
  - Modbus 主站
  - Modbus 从站
  - PtP Modbus
---
## 01 `MB_COMM_LOAD` | 在 PtP 模块上为 Modbus 通信组态端口

> [!info] 核心结论
> **MB_COMM_LOAD** 用于在 PtP 通信模块上初始化 Modbus 通信端口，是使用 MB_MASTER / MB_SLAVE 前的基础配置。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V2.2</strong><br>
指令版本：<strong>V2.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **MODBUS** |
| 指令名称 | **MB_COMM_LOAD** |
| 功能描述 | **在 PtP 模块上为 Modbus 通信组态端口** |
| 版本 | **V2.1** |
| 核心作用 | 初始化 Modbus 串口通信参数 |
| 使用重点 | 波特率、校验位、停止位、端口号、通信模式需按实际设备手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
Modbus 通信前先配端口：<strong>波特率、校验位、数据位、停止位、站地址</strong>必须一致。
</div>

### ② 参考表

| 参数 | 说明 |
|---|---|
| 通信端口 | PtP 模块或串口端口 |
| 波特率 | 双方必须一致 |
| 校验位 | None / Even / Odd，需按从站设置 |
| 数据位 | 常见为 **8 位** |
| 停止位 | 常见为 1 位或 2 位 |
| 站地址 | 每个 Modbus 从站地址必须唯一 |

### ③ 计算/选型示例

- 已知：PLC 需要通过 PtP 串口与一台 Modbus 仪表通信
- 公式/规则：使用主站或从站前，必须先组态通信端口
- 操作：先执行 **MB_COMM_LOAD**，设置波特率、校验位、停止位和端口
- 结论：端口配置完成后，才能继续使用 **MB_MASTER** 或 **MB_SLAVE**

> [!tip] 记忆口诀
> **Modbus 先 LOAD 端口，参数一致才通信。**


## 02 `MB_MASTER` | 通过 PtP 端口作为 Modbus 主站通信

> [!info] 核心结论
> **MB_MASTER** 用于让 PLC 通过 PtP 端口作为 Modbus 主站，主动读取或写入从站设备数据。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V2.2</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **MODBUS** |
| 指令名称 | **MB_MASTER** |
| 功能描述 | **通过 PtP 端口作为 Modbus 主站通信** |
| 版本 | **V2.2** |
| 通信角色 | **Modbus Master 主站** |
| 核心作用 | 主动访问从站寄存器或线圈 |
| 使用重点 | 从站地址、功能码、寄存器地址、数据长度需按设备手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">重点规则</strong><br>
主站是<strong>主动方</strong>：PLC 主动发请求，从站负责响应。
</div>

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 读取仪表数据 | 温度、压力、流量、电量等 |
| 写入设定值 | 温控设定、频率设定、控制参数 |
| 读取线圈状态 | 获取开关量状态 |
| 写入线圈命令 | 控制远程继电器或设备动作 |
| 风险提醒 | 地址偏移、大小端、数据类型需校核 |

### ③ 计算/选型示例

- 已知：PLC 要读取温控表当前温度寄存器
- 公式/规则：PLC 主动读取从站数据，应作为 **Modbus 主站**
- 操作：先用 **MB_COMM_LOAD** 组态端口，再用 **MB_MASTER** 设置从站地址、功能码和寄存器地址
- 结论：PLC 可读取温控表返回的温度数据

> [!tip] 记忆口诀
> **我主动问别人，用 MB_MASTER。**


## 03 `MB_SLAVE` | 通过 PtP 端口作为 Modbus 从站通信

> [!info] 核心结论
> **MB_SLAVE** 用于让 PLC 通过 PtP 端口作为 Modbus 从站，等待主站读取或写入 PLC 数据。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V2.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **MODBUS** |
| 指令名称 | **MB_SLAVE** |
| 功能描述 | **通过 PtP 端口作为 Modbus 从站通信** |
| 版本 | **V2.1** |
| 通信角色 | **Modbus Slave 从站** |
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
- 操作：先用 **MB_COMM_LOAD** 配置端口，再用 **MB_SLAVE** 设置从站地址和数据映射区
- 结论：上位机可读取 PLC 开放的寄存器数据

> [!tip] 记忆口诀
> **别人主动问我，用 MB_SLAVE。**


## 04 MODBUS | 选型速记

> [!info] 核心结论
> MODBUS 选型先看角色：**先用 MB_COMM_LOAD 配端口；PLC 主动访问别人用 MB_MASTER；别人访问 PLC 用 MB_SLAVE。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
先 LOAD 配端口，主动访问用 MASTER，被动等待用 SLAVE。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 端口组态 | **MB_COMM_LOAD** |
| 主站通信 | **MB_MASTER** |
| 从站通信 | **MB_SLAVE** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 初始化 Modbus PtP 端口 | **MB_COMM_LOAD** |
| PLC 读取温控表 / 电表 / 仪表 | **MB_MASTER** |
| PLC 写入从站设定值 | **MB_MASTER** |
| 上位机读取 PLC 数据 | **MB_SLAVE** |
| 第三方主站写入 PLC 数据 | **MB_SLAVE** |
| 多从站轮询 | **MB_MASTER**，站地址需唯一 |
| PLC 被外部主站访问 | **MB_SLAVE**，需校核数据映射和权限 |

### ③ 计算/选型示例

- 已知：PLC 要读取 3 台仪表数据，同时上位机也要读取 PLC 状态
- 公式/规则：PLC 主动读仪表 = Master；上位机访问 PLC = PLC 做 Slave
- 操作：先用 **MB_COMM_LOAD** 配置 PtP 通信端口；读取仪表用 **MB_MASTER**；开放数据给上位机用 **MB_SLAVE**
- 结论：同一个项目中 Master 和 Slave 可以同时存在，关键看“谁主动访问谁”

> [!tip] 记忆口诀
> **我问别人是 MASTER，别人问我是 SLAVE；通信之前先 LOAD。**