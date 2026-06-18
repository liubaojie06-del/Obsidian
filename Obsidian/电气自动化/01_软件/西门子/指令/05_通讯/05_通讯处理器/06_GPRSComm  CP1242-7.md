---
tags:
  - PLC
  - TIA_Portal
  - GPRSComm
  - CP1242-7
  - GSM通信
  - GPRS通信
  - 远程通信
  - 西门子
---
## 01 `TC_CON` | 通过 GSM 网络建立连接

> [!info] 核心结论
> **TC_CON** 用于通过 GSM 网络建立通信连接，是 CP1242-7 远程通信数据收发前的连接入口。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V1.3</strong><br>
指令版本：<strong>V1.2</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **GPRSComm : CP1242-7** |
| 指令名称 | **TC_CON** |
| 功能描述 | **通过 GSM 网络建立连接** |
| 版本 | **V1.2** |
| 核心作用 | 建立 GSM/GPRS 通信连接 |
| 使用重点 | SIM 卡、APN、远程地址、端口、网络信号需按实际项目校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
GSM 通信先看三件事：<strong>信号强不强、SIM 卡通不通、连接参数对不对</strong>。
</div>

### ② 参考表

| 检查项 | 说明 |
|---|---|
| SIM 卡 | 是否开通数据业务 |
| APN | 运营商接入点配置 |
| 信号强度 | 信号弱会导致连接不稳定 |
| 远程地址 | 服务器 IP / 域名需正确 |
| 端口号 | 本地与远程端口需匹配 |
| 防火墙/NAT | 远程通信路径需可达 |

### ③ 计算/选型示例

- 已知：PLC 需要通过 CP1242-7 连接远程服务器
- 公式/规则：远程通信前必须先建立 GSM 网络连接
- 操作：使用 **TC_CON** 建立连接
- 结论：连接建立成功后，才能继续发送或接收数据

> [!tip] 记忆口诀
> **GSM 通信先建连，TC_CON 打前站。**


## 02 `TC_DISCON` | 通过 GSM 网络中止连接

> [!info] 核心结论
> **TC_DISCON** 用于断开或中止已经建立的 GSM 网络连接，适合通信结束、异常恢复或切换连接时使用。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V1.2</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **GPRSComm : CP1242-7** |
| 指令名称 | **TC_DISCON** |
| 功能描述 | **通过 GSM 网络中止连接** |
| 版本 | **V1.2** |
| 核心作用 | 断开 GSM/GPRS 通信连接 |
| 使用重点 | 断开前确认数据已发送完成，避免数据丢失 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 通信任务结束 | 主动断开连接 |
| 连接异常 | 断开后重新连接 |
| 切换服务器 | 先断开旧连接 |
| 节省流量/资源 | 不通信时关闭连接 |
| 维护模式 | 暂停远程通信 |

### ③ 计算/选型示例

- 已知：PLC 与远程服务器完成本次数据上传
- 公式/规则：通信结束后可断开连接释放资源
- 操作：使用 **TC_DISCON**
- 结论：GSM 网络连接被中止

> [!tip] 记忆口诀
> **通信结束要收尾，TC_DISCON 断连接。**


## 03 `TC_SEND` | 通过 GSM 网络发送数据

> [!info] 核心结论
> **TC_SEND** 用于通过 GSM 网络发送数据，适合远程上传状态、报警、日志和生产数据。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V1.2</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **GPRSComm : CP1242-7** |
| 指令名称 | **TC_SEND** |
| 功能描述 | **通过 GSM 网络发送数据** |
| 版本 | **V1.2** |
| 核心作用 | 通过 GSM/GPRS 发送数据 |
| 使用重点 | 发送缓冲区、数据长度、连接状态、网络质量需校核 |

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">重点规则</strong><br>
发送前先确认连接已建立；网络不稳定时，需要做好重发和错误处理。
</div>

### ② 参考表

| 发送内容 | 示例 |
|---|---|
| 设备状态 | 运行、停止、故障 |
| 报警信息 | 故障码、报警时间 |
| 生产数据 | 产量、批次、工艺参数 |
| 诊断信息 | 通信状态、模块状态 |
| 远程日志 | 事件记录、运行记录 |

### ③ 计算/选型示例

- 已知：设备发生报警，需要把报警代码上传到远程平台
- 公式/规则：通过 GSM 网络发送数据用 **TC_SEND**
- 操作：先用 **TC_CON** 建立连接，再用 **TC_SEND** 发送报警数据
- 结论：远程平台可收到 PLC 上传的报警信息

> [!tip] 记忆口诀
> **上传数据用 TC_SEND，连接正常再发送。**


## 04 `TC_RECV` | 通过 GSM 网络接收数据

> [!info] 核心结论
> **TC_RECV** 用于通过 GSM 网络接收远程数据，适合接收服务器命令、参数下发和远程控制信息。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V1.2</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **GPRSComm : CP1242-7** |
| 指令名称 | **TC_RECV** |
| 功能描述 | **通过 GSM 网络接收数据** |
| 版本 | **V1.2** |
| 核心作用 | 通过 GSM/GPRS 接收数据 |
| 使用重点 | 接收缓冲区、数据长度、命令校验、安全权限需校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">安全提醒</strong><br>
远程接收控制命令时，必须校验来源、权限和命令合法性，不能直接执行未知命令。
</div>

### ② 参考表

| 接收内容 | 示例 |
|---|---|
| 远程命令 | 启动、停止、复位 |
| 参数下发 | 设定值、阈值、配方号 |
| 时间同步 | 远程校时信息 |
| 配置更新 | 通信参数或运行参数 |
| 维护指令 | 远程诊断、状态查询 |

### ③ 计算/选型示例

- 已知：远程平台需要下发新的压力上限参数
- 公式/规则：通过 GSM 网络接收数据用 **TC_RECV**
- 操作：PLC 建立连接后，使用 **TC_RECV** 接收数据，并校验参数范围
- 结论：参数合法后再写入 PLC 控制逻辑

> [!tip] 记忆口诀
> **接收远程数据用 TC_RECV，先校验再执行。**


## 05 `TC_CONFIG` | 将组态数据传输到 CP1242-7

> [!info] 核心结论
> **TC_CONFIG** 用于把组态数据传输到 CP1242-7 通信模块，适合运行中配置或更新通信参数。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
<strong>V1.2</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **GPRSComm : CP1242-7** |
| 指令名称 | **TC_CONFIG** |
| 功能描述 | **将组态数据传输到 CP1242-7** |
| 版本 | **V1.2** |
| 核心作用 | 下发/更新 CP1242-7 组态数据 |
| 使用重点 | 组态结构、通信参数、模块状态需按实际手册校核 |

### ② 参考表

| 组态方向 | 说明 |
|---|---|
| 网络参数 | APN、拨号或接入参数 |
| 连接参数 | 远程地址、端口、连接类型 |
| 通信模块参数 | CP1242-7 相关配置 |
| 安全参数 | 访问权限、认证配置 |
| 校核要求 | 以模块手册和项目规范为准 |

### ③ 计算/选型示例

- 已知：现场更换运营商 SIM 卡后，需要更新通信接入参数
- 公式/规则：组态数据需要传输到通信模块
- 操作：使用 **TC_CONFIG** 将新组态传输到 CP1242-7
- 结论：模块按新参数进行 GSM/GPRS 通信

> [!tip] 记忆口诀
> **参数要下发，TC_CONFIG 配模块。**


## 06 GPRSComm : CP1242-7 | 选型速记

> [!info] 核心结论
> CP1242-7 通信的核心是：**建连接用 TC_CON，断连接用 TC_DISCON，发数据用 TC_SEND，收数据用 TC_RECV，配参数用 TC_CONFIG。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
CON 建连，DISCON 断连；SEND 发数据，RECV 收数据；CONFIG 配模块。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 建立 GSM 连接 | **TC_CON** |
| 中止 GSM 连接 | **TC_DISCON** |
| 发送数据 | **TC_SEND** |
| 接收数据 | **TC_RECV** |
| 传输组态数据 | **TC_CONFIG** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 通过 GSM 网络建立连接 | **TC_CON** |
| 断开远程通信连接 | **TC_DISCON** |
| 上传报警/状态/日志 | **TC_SEND** |
| 接收远程命令/参数 | **TC_RECV** |
| 更新 CP1242-7 组态 | **TC_CONFIG** |
| 通信异常恢复 | 常用 **TC_DISCON + TC_CON** |
| 远程双向通信 | 常用 **TC_SEND + TC_RECV** |

### ③ 计算/选型示例

- 已知：远程泵站需要通过 GSM 网络上传运行状态，并接收平台下发的启停命令
- 公式/规则：先建连接，再收发数据，必要时断开重连
- 操作：用 **TC_CON** 建立连接；用 **TC_SEND** 上传状态；用 **TC_RECV** 接收命令；异常时用 **TC_DISCON** 断开后重连
- 结论：这是典型的 CP1242-7 远程 GSM/GPRS 通信流程

> [!tip] 记忆口诀
> **远程通信五件套：配置、连接、发送、接收、断开。**