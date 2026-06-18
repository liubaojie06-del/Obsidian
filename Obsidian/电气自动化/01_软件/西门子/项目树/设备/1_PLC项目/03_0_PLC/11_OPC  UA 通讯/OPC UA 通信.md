---
tags:
  - PLC
  - TIA_Portal
  - OPC_UA
  - 工业通信
  - 数据采集
  - 上位机通信
aliases:
  - OPC UA 通信
  - OPCUA
  - TIA OPC UA
  - PLC OPC UA
---

# 01｜OPC UA 通信是什么

> [!info] 核心结论
> **OPC UA 通信是 PLC 与上位机、MES、SCADA、数据库、边缘网关之间进行标准化数据交换的工业通信方式。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>图片识别</strong><br>
截图中的 <strong>OPC UA 通信</strong> 是 TIA Portal 中与 OPC UA Server / Client、证书、安全策略、变量访问相关的通信配置入口。
</div>

## ① 分类/公式/规则

| 项目 | 说明 |
|---|---|
| **名称** | OPC UA |
| **全称** | Open Platform Communications Unified Architecture |
| **中文理解** | 开放平台通信统一架构 |
| **主要用途** | 跨厂商、跨平台数据交换 |
| **常见对象** | PLC、SCADA、MES、数据库、边缘网关 |
| **通信特点** | 标准化、安全、可建模、可跨平台 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
OPC UA 就像工业现场的“标准数据接口”，让不同厂家的设备用统一语言交换数据。
</div>

## ② 参考表

| 通信方式 | 典型用途 | 特点 |
|---|---|---|
| **PROFINET** | PLC 与 I/O、驱动器 | 实时控制 |
| **Modbus TCP** | PLC 与仪表、网关 | 简单寄存器通信 |
| **S7 通信** | 西门子 PLC 内部通信 | 西门子体系 |
| **OPC UA** | PLC 与上位系统 | 标准化数据接口 |
| **MQTT** | 边缘/云平台数据上报 | 轻量发布订阅 |

## ③ 计算/选型示例

- **已知：** MES 系统要读取 PLC 的产量、报警、设备状态  
- **公式：** 上位系统标准数据访问 → OPC UA  
- **计算：**
  - PLC 开启 OPC UA Server
  - 暴露产量、报警、状态变量
  - MES 作为 OPC UA Client 读取数据
- **结论：** OPC UA 适合做 PLC 与 MES / SCADA / 数据平台的数据接口。

> [!tip] 记忆口诀
> **实时控制找 PROFINET，标准数据找 OPC UA。**

---

# 02｜OPC UA Server 与 Client

> [!info] 核心结论
> **OPC UA 通信采用 Server / Client 模型：Server 提供数据，Client 读取、写入或订阅数据。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>系统链路</strong><br>
PLC OPC UA Server → 暴露变量节点 → 上位机 OPC UA Client → 读取 / 写入 / 订阅
</div>

## ① 分类/公式/规则

| 角色 | 中文含义 | 作用 |
|---|---|---|
| **OPC UA Server** | 服务器 | 提供变量、对象、方法、事件 |
| **OPC UA Client** | 客户端 | 连接 Server 并访问数据 |
| **Endpoint** | 端点 | Server 对外开放的连接地址 |
| **Node** | 节点 | OPC UA 地址空间中的变量或对象 |
| **Subscription** | 订阅 | Client 持续接收变量变化 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>核心规则</strong><br>
谁提供数据，谁是 Server；谁来访问数据，谁是 Client。
</div>

## ② 参考表

| 场景 | PLC 角色 | 上位机角色 |
|---|---|---|
| **SCADA 读取 PLC 变量** | Server | Client |
| **MES 写入生产配方** | Server | Client |
| **PLC 主动读取第三方 OPC UA 数据** | Client | Server |
| **边缘网关采集 PLC 数据** | Server | Client |
| **多系统共享 PLC 数据** | Server | 多个 Client |

## ③ 计算/选型示例

- **已知：** 上位机要从 PLC 读取设备状态  
- **公式：** 数据在 PLC，访问者是上位机  
- **计算：**
  - PLC：提供状态变量 → Server
  - 上位机：连接 PLC 并读取 → Client
- **结论：** 这种场景 PLC 通常配置为 OPC UA Server。

> [!tip] 记忆口诀
> **数据在哪，Server 就在哪；谁来取数，谁就是 Client。**

---

# 03｜OPC UA 地址空间

> [!info] 核心结论
> **OPC UA 不是简单寄存器表，而是把数据组织成“地址空间”，用对象、变量、节点来描述设备数据。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
Modbus 像寄存器表，OPC UA 像一个有层级结构的数据目录。
</div>

## ① 分类/公式/规则

| 概念 | 说明 |
|---|---|
| **Namespace** | 命名空间，区分不同来源的数据 |
| **NodeId** | 节点唯一标识 |
| **Object** | 对象，例如 Motor、Line、Station |
| **Variable** | 变量，例如 Speed、Status、Alarm |
| **Method** | 方法，可被客户端调用 |
| **Browse** | 浏览地址空间 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点公式</strong><br>
OPC UA 数据点 = Namespace + NodeId + 数据类型 + 访问权限
</div>

## ② 参考表

| PLC 数据 | OPC UA 表达 |
|---|---|
| **电机运行状态** | `Motor1.Running` |
| **电机故障状态** | `Motor1.Fault` |
| **当前产量** | `Production.Count` |
| **温度实际值** | `TempLoop1.PV` |
| **报警代码** | `Alarm.Code` |
| **配方编号** | `Recipe.Number` |

## ③ 计算/选型示例

- **已知：** 要把一台电机的数据暴露给上位机  
- **公式：** 设备对象 = 状态变量 + 命令变量 + 报警变量  
- **计算：**
  - `Motor1.RunCmd`
  - `Motor1.RunFB`
  - `Motor1.Fault`
  - `Motor1.StatusWord`
- **结论：** OPC UA 更适合按设备对象组织数据，而不是散乱暴露地址。

> [!tip] 记忆口诀
> **寄存器看地址，OPC UA 看节点。**

---

# 04｜OPC UA 安全机制

> [!info] 核心结论
> **OPC UA 通信通常需要配置安全策略、证书、用户权限和访问级别，不能只看 IP 能不能通。**

<div class="card red" style="background:#FFF4F3;border-left:6px solid #E74C3C;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>安全提醒</strong><br>
OPC UA 不是“随便连上就读写”，证书、加密、用户权限配置错误都会导致连接失败。
</div>

## ① 分类/公式/规则

| 安全项 | 作用 |
|---|---|
| **Security Policy** | 安全策略，如加密和签名 |
| **Message Security Mode** | 消息安全模式 |
| **Certificate** | 客户端/服务器证书 |
| **Trust List** | 受信任证书列表 |
| **User Authentication** | 用户认证 |
| **Access Rights** | 读写权限 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>连接规则</strong><br>
网络通只是第一步，OPC UA 还要证书可信、策略匹配、权限允许。
</div>

## ② 参考表

| 连接失败原因 | 排查方向 |
|---|---|
| **证书不受信任** | 检查 Trust List |
| **安全策略不匹配** | Client 与 Server 策略一致 |
| **用户名密码错误** | 检查用户认证 |
| **变量不可写** | 检查访问权限 |
| **端口不通** | 检查防火墙和端口 |
| **时间不一致** | 检查设备时间和证书有效期 |

## ③ 计算/选型示例

- **已知：** 上位机能 ping 通 PLC，但 OPC UA 连接失败  
- **公式：** Ping 通 ≠ OPC UA 连接成功  
- **计算：**
  - 网络层正常
  - 但证书可能未信任
  - 或安全策略不匹配
  - 或用户权限不足
- **结论：** OPC UA 连接失败时，要同时查网络、证书、安全策略和权限。

> [!tip] 记忆口诀
> **Ping 通看网络，OPC 通看证书。**

---

# 05｜变量访问与权限

> [!info] 核心结论
> **OPC UA 暴露 PLC 数据时，要明确哪些变量可读、哪些可写、哪些只能内部使用。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>工程理解</strong><br>
上位机读状态通常安全，写命令和配方必须加权限和边界检查。
</div>

## ① 分类/公式/规则

| 权限 | 中文含义 | 典型变量 |
|---|---|---|
| **Read** | 只读 | 运行状态、实际值、报警 |
| **Write** | 可写 | 设定值、配方、启动请求 |
| **Read/Write** | 可读可写 | HMI 参数 |
| **No Access** | 不开放 | 内部逻辑变量 |
| **User-Level Control** | 按用户控制 | 操作员/工程师权限 |

## ② 参考表

| 变量类型 | 建议权限 | 注意 |
|---|---|---|
| **设备运行状态** | 只读 | 给 SCADA / MES 显示 |
| **报警代码** | 只读 | 防止误清除 |
| **生产计数** | 只读或受控写 | 清零需权限 |
| **速度设定** | 可写但限幅 | PLC 侧必须校验 |
| **启动命令** | 谨慎开放 | 防误动作 |
| **安全相关变量** | 不建议开放写 | 按安全规范 |

## ③ 计算/选型示例

- **已知：** MES 要写入目标产量，范围必须 `0~10000`  
- **公式：** 外部写入值必须边界校验  
- **计算：**
  - 若 MES 写入 `12000`
  - 超出允许范围
  - PLC 应拒绝或限幅处理
- **结论：** OPC UA 写入变量不能直接信任，PLC 程序必须做范围保护。

> [!tip] 记忆口诀
> **状态可以读，命令谨慎写；外部写入先校验。**

---

# 06｜OPC UA 典型数据结构

> [!info] 核心结论
> **OPC UA 数据最好按设备、工位、产线、工艺对象组织，方便上位系统浏览和维护。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>结构口诀</strong><br>
产线下面分工位，工位下面分设备，设备下面放变量。
</div>

## ① 分类/公式/规则

| 层级 | 示例 |
|---|---|
| **Line** | `Line1` |
| **Station** | `Station10` |
| **Device** | `Motor1`、`Valve2`、`Axis1` |
| **Variable** | `Running`、`Fault`、`Speed` |
| **Alarm** | `AlarmCode`、`AlarmTextID` |
| **Production** | `Count`、`CycleTime` |

## ② 参考表

| 数据组 | 推荐变量 |
|---|---|
| **设备状态** | Running、Ready、Fault |
| **工艺参数** | Setpoint、Actual、Output |
| **生产数据** | Count、GoodCount、NGCount |
| **报警数据** | AlarmCode、AlarmActive |
| **通信状态** | ClientConnected、Quality |
| **配方数据** | RecipeNo、ProductID |

## ③ 计算/选型示例

- **已知：** 产线有 3 个工位，每个工位有 2 台电机  
- **公式：** 层级结构 = `Line → Station → Motor → Variable`
- **计算：**
  - `Line1.Station1.Motor1.Running`
  - `Line1.Station1.Motor2.Running`
  - `Line1.Station2.Motor1.Running`
- **结论：** 层级清晰的 OPC UA 地址空间更利于上位机长期维护。

> [!tip] 记忆口诀
> **变量别乱丢，按设备建目录。**

---

# 07｜典型使用流程

> [!info] 核心结论
> **OPC UA 通信典型流程：启用 Server → 配置安全 → 暴露变量 → 信任证书 → Client 连接 → 测试读写。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>标准流程</strong><br>
开服务 → 配端点 → 配证书 → 选变量 → 设权限 → 上位机测试
</div>

## ① 分类/公式/规则

| 步骤 | 内容 | 重点 |
|---|---|---|
| **1** | 开启 OPC UA 功能 | CPU 需支持 |
| **2** | 配置 Endpoint | 地址、端口、安全策略 |
| **3** | 配置证书 | 服务器证书、客户端信任 |
| **4** | 选择开放变量 | 变量可见性 |
| **5** | 设置权限 | 只读/可写/用户认证 |
| **6** | Client 测试连接 | 使用 UA Expert 等工具 |
| **7** | 联调上位系统 | SCADA / MES / 网关 |

## ② 参考表

| 检查项 | 正常要求 |
|---|---|
| **PLC IP** | 上位机可访问 |
| **OPC UA 端口** | 未被防火墙阻挡 |
| **Server 状态** | 已启用 |
| **证书** | 双方信任 |
| **安全策略** | Client 和 Server 匹配 |
| **变量权限** | 读写符合需求 |

## ③ 计算/选型示例

- **已知：** 上位机需要读取 PLC 的 50 个状态变量  
- **公式：** 读变量 = `Client 连接 Server → 浏览节点 → 订阅变量`
- **计算：**
  - PLC 开启 OPC UA Server
  - 暴露 50 个变量
  - Client 建立订阅
  - 变量变化时自动更新
- **结论：** 多变量状态采集建议使用订阅机制，而不是高频轮询。

> [!tip] 记忆口诀
> **先连通，再信任；先能读，再开放写。**

---

# 08｜常见故障排查

> [!info] 核心结论
> **OPC UA 故障排查顺序：网络 → 端口 → Server 状态 → 安全策略 → 证书 → 用户权限 → 节点权限。**

<div class="card red" style="background:#FFF4F3;border-left:6px solid #E74C3C;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>排查顺序</strong><br>
IP 通不通 → 端口开不开 → Server 起没起 → 证书信不信 → 权限够不够。
</div>

## ① 分类/公式/规则

| 问题 | 常见原因 |
|---|---|
| **Client 找不到 Server** | IP、端口、防火墙问题 |
| **连接被拒绝** | 安全策略或证书不匹配 |
| **能连接但看不到变量** | 变量未开放或权限不足 |
| **能读不能写** | 节点只读或用户权限不足 |
| **数据质量差** | 变量无效、连接中断、刷新异常 |
| **连接不稳定** | 网络质量、负载、超时参数 |

## ② 参考表

| 现象 | 排查方向 | 解决建议 |
|---|---|---|
| **Ping 不通** | 网络层 | 查 IP、网线、网关 |
| **Ping 通但连不上 OPC UA** | 端口/证书/策略 | 查 Endpoint |
| **证书错误** | Trust List | 导入并信任证书 |
| **BadUserAccessDenied** | 用户权限 | 检查账号权限 |
| **BadNodeIdUnknown** | 节点路径错误 | 重新浏览节点 |
| **写入失败** | 变量只读或类型错 | 查访问权限和数据类型 |

## ③ 计算/选型示例

- **已知：** Client 报 `BadNodeIdUnknown`  
- **公式：** NodeId 无效 = 节点不存在或路径不对  
- **计算：**
  - 变量可能未开放到 OPC UA
  - NodeId 可能写错
  - PLC 项目下载后节点可能变化
- **结论：** 应重新浏览 OPC UA 地址空间，确认真实 NodeId。

> [!tip] 记忆口诀
> **连不上查证书，读不到查节点，写不了查权限。**

---

# 09｜设计注意事项

> [!info] 核心结论
> **OPC UA 适合数据交换，不适合替代实时 I/O 控制；设计时要控制变量数量、刷新周期、权限和安全策略。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>工程边界</strong><br>
OPC UA 适合信息层数据，不适合高速实时闭环控制。
</div>

## ① 分类/公式/规则

| 注意项 | 说明 |
|---|---|
| **实时性** | 不用于高速实时控制 |
| **变量数量** | 不要无脑开放全部变量 |
| **刷新周期** | 根据数据变化速度设置 |
| **写入权限** | 命令类变量要谨慎 |
| **证书管理** | 证书过期会影响连接 |
| **CPU 负载** | Client 多、订阅多会增加负担 |
| **数据建模** | 结构越清晰，维护越方便 |

## ② 参考表

| 数据类型 | 推荐刷新方式 |
|---|---|
| **设备状态** | 订阅 |
| **报警状态** | 订阅或事件 |
| **产量统计** | 周期读取 |
| **温度压力** | 适中周期 |
| **高速轴位置** | 不建议高频 OPC UA 采集 |
| **配方参数** | 按需读取/写入 |

## ③ 计算/选型示例

- **已知：** 上位机想每 `10ms` 读取 500 个变量  
- **公式：** 高频大量变量访问 → 可能造成通信和 CPU 压力  
- **计算：**
  - 500 个变量
  - 10ms 周期
  - 每秒请求量很大
- **结论：** OPC UA 不适合这种高频大规模实时采集，应降低刷新周期或优化数据打包，需按 CPU 性能校核。

> [!tip] 记忆口诀
> **OPC UA 管数据透明，不管高速实时控制。**

---

# 10｜一页速记总卡

> [!info] 核心结论
> **OPC UA 通信的核心价值是：用安全、标准、跨平台的方式，把 PLC 数据开放给上位机、MES、SCADA 和边缘系统。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>总口诀</strong><br>
PLC 做 Server，上位机做 Client；证书要信任，变量要授权，写入要校验。
</div>

## ① 分类/公式/规则

| 主轴 | 关键词 |
|---|---|
| **对象** | OPC UA 通信 |
| **模型** | Server / Client |
| **数据** | Node、Variable、Object |
| **安全** | Certificate、Security Policy、User |
| **访问** | Read、Write、Subscribe |
| **应用** | SCADA、MES、数据库、网关 |
| **风险** | 证书、权限、端口、变量暴露 |

## ② 参考表

| 需求 | 推荐 |
|---|---|
| **上位机读 PLC 数据** | PLC 开 OPC UA Server |
| **MES 写配方** | OPC UA 写入 + PLC 校验 |
| **SCADA 订阅状态** | OPC UA Subscription |
| **高速 I/O 控制** | PROFINET / 实时总线 |
| **简单寄存器通信** | Modbus TCP |
| **西门子 PLC 内部通信** | S7 通信 |

## ③ 计算/选型示例

- **已知：** 工厂需要把 PLC 的产量、报警、设备状态上传到 MES  
- **公式：** 生产数据上报 = `OPC UA Server + 标准节点 + 订阅/读取`
- **计算：**
  - PLC 暴露 `Production.Count`
  - 暴露 `Alarm.Code`
  - 暴露 `Machine.State`
  - MES 通过 OPC UA Client 读取或订阅
- **结论：** OPC UA 是 PLC 与信息化系统对接的常用标准接口。

> [!tip] 记忆口诀
> **OPC UA 三件事：连得上、信得过、读写对。**