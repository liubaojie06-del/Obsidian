---
tags:
  - PLC
  - TIA_Portal
  - PtP_Communication
  - 点对点通信
  - 串口通信
  - 发送数据
  - 接收数据
  - 通信端口
  - 西门子
aliases:
  - PtP Communication
  - PtP通信
  - 点对点通信
  - Port_Config
  - Send_Config
  - Receive_Config
  - P3964_Config
  - Send_P2P
  - Receive_P2P
  - Receive_Reset
  - Signal_Get
  - Signal_Set
  - Get_Features
  - Set_Features
---
## 01 `Port_Config` | 组态 PtP 通信端口

> [!info] 核心结论
> **Port_Config** 用于配置 PtP 通信端口参数，是点对点通信前的基础设置。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V4.1</strong><br>
指令版本：<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Port_Config** |
| 功能描述 | **组态 PtP 通信端口** |
| 版本 | **V4.0** |
| 核心作用 | 配置串口/通信端口 |
| 使用重点 | 波特率、校验位、数据位、停止位等需按实际设备手册校核 |

### ② 参考表

| 参数方向 | 说明 |
|---|---|
| 波特率 | 通信速度，双方必须一致 |
| 数据位 | 常见 7 位或 8 位 |
| 校验位 | None / Even / Odd 等 |
| 停止位 | 常见 1 位或 2 位 |
| 端口号 | 需匹配实际通信模块端口 |

### ③ 计算/选型示例

- 已知：PLC 需要通过串口和扫码枪通信
- 公式/规则：先配置端口参数，再收发数据
- 操作：使用 **Port_Config** 设置波特率、校验位等参数
- 结论：端口参数一致后，后续才能稳定通信

> [!tip] 记忆口诀
> **PtP 先配端口，波特校验别搞错。**


## 02 `Send_Config` | 组态 PtP 发送方

> [!info] 核心结论
> **Send_Config** 用于配置 PtP 发送相关参数，为后续 Send_P2P 发送数据做准备。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Send_Config** |
| 功能描述 | **组态 PtP 发送方** |
| 版本 | **V4.0** |
| 核心作用 | 配置发送参数 |
| 使用重点 | 发送缓冲区、报文格式、结束符等需按协议校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 发送 ASCII 报文 | 配置发送格式 |
| 发送设备命令 | 配置命令报文结构 |
| 串口数据输出 | 配置发送方参数 |
| 协议相关设置 | 需按设备通信协议校核 |

### ③ 计算/选型示例

- 已知：PLC 需要向仪表发送读取命令
- 公式/规则：发送前先配置发送参数
- 操作：使用 **Send_Config**
- 结论：发送方配置完成后，可用 Send_P2P 发送数据

> [!tip] 记忆口诀
> **要发数据先配置，Send_Config 打前站。**


## 03 `Receive_Config` | 组态 PtP 接收方

> [!info] 核心结论
> **Receive_Config** 用于配置 PtP 接收相关参数，为 Receive_P2P 接收数据做准备。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Receive_Config** |
| 功能描述 | **组态 PtP 接收方** |
| 版本 | **V4.0** |
| 核心作用 | 配置接收参数 |
| 使用重点 | 接收长度、结束符、超时时间、缓冲区需按协议校核 |

### ② 参考表

| 参数方向 | 说明 |
|---|---|
| 接收长度 | 固定长度或变长报文 |
| 结束符 | 如 CR、LF、CRLF 等 |
| 超时时间 | 防止一直等待 |
| 接收缓冲区 | 保存接收到的数据 |
| 协议格式 | 需与外部设备一致 |

### ③ 计算/选型示例

- 已知：扫码枪发送以回车结尾的字符串
- 公式/规则：接收方需要识别结束符
- 操作：使用 **Receive_Config** 配置接收格式
- 结论：PLC 可正确接收扫码枪数据

> [!tip] 记忆口诀
> **要收数据先配置，长度结束符要一致。**


## 04 `P3964_Config` | 组态协议

> [!info] 核心结论
> **P3964_Config** 用于配置 3964 类通信协议参数，适合使用指定协议握手的数据交换场景。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **P3964_Config** |
| 功能描述 | **组态协议** |
| 版本 | **V4.0** |
| 核心作用 | 配置通信协议参数 |
| 使用重点 | 协议握手、控制字符、超时和重试需按对端设备校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 3964 协议通信 | 配置协议参数 |
| 带握手通信 | 需要确认、重发、校验 |
| 工业设备数据交换 | 常见于专用串口协议 |
| 协议细节 | 需按设备手册确认 |

### ③ 计算/选型示例

- 已知：外部设备要求使用 3964 协议通信
- 公式/规则：协议参数必须匹配
- 操作：使用 **P3964_Config**
- 结论：双方协议一致后，才能进行可靠数据交换

> [!tip] 记忆口诀
> **普通收发看 P2P，3964 协议先配置。**


## 05 `Send_P2P` | 发送数据

> [!info] 核心结论
> **Send_P2P** 用于通过 PtP 通信发送数据，是点对点通信中的核心发送指令。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Send_P2P** |
| 功能描述 | **发送数据** |
| 版本 | **V4.0** |
| 核心作用 | 通过 PtP 端口发送报文 |
| 使用重点 | 发送数据区、长度、触发条件需按项目校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 发送读取命令 | PLC 向仪表请求数据 |
| 发送控制命令 | 向设备下发启动、停止、复位 |
| 发送字符串 | 如 ASCII 文本、条码请求 |
| 发送二进制数据 | 需注意字节顺序和校验 |

### ③ 计算/选型示例

- 已知：PLC 要向仪表发送命令 `"READ"`
- 公式/规则：发送数据用 **Send_P2P**
- 操作：把 `"READ"` 放入发送缓冲区并触发发送
- 结论：命令通过 PtP 端口发送给仪表

> [!tip] 记忆口诀
> **发数据用 Send_P2P，报文准备再发送。**


## 06 `Receive_P2P` | 接收数据

> [!info] 核心结论
> **Receive_P2P** 用于通过 PtP 通信接收数据，是点对点通信中的核心接收指令。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
<strong>V4.1</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Receive_P2P** |
| 功能描述 | **接收数据** |
| 版本 | **V4.1** |
| 核心作用 | 从 PtP 端口接收报文 |
| 使用重点 | 接收缓冲区、完成标志、错误状态需按实际程序校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 接收仪表返回值 | 如重量、温度、压力 |
| 接收扫码枪数据 | 获取条码字符串 |
| 接收设备状态 | 读取对端返回状态 |
| 接收应答报文 | 判断命令是否执行成功 |

### ③ 计算/选型示例

- 已知：PLC 发送读取命令后，仪表返回 `"25.6"`
- 公式/规则：接收返回数据用 **Receive_P2P**
- 操作：配置接收缓冲区并等待接收完成
- 结论：PLC 获得仪表返回数据，可继续解析为数值

> [!tip] 记忆口诀
> **收数据用 Receive_P2P，先收完整再解析。**


## 07 `Receive_Reset` | 删除接收缓冲区

> [!info] 核心结论
> **Receive_Reset** 用于清除接收缓冲区，适合通信异常、报文残留或重新接收前清空缓存。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Receive_Reset** |
| 功能描述 | **删除接收缓冲区** |
| 版本 | **V4.0** |
| 核心作用 | 清空接收缓存 |
| 使用重点 | 清空前确认有效数据已处理，避免误删 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 报文接收错误 | 清空异常数据 |
| 接收超时后重试 | 清理残留缓存 |
| 切换通信对象 | 清除上一对象数据 |
| 重新同步协议 | 先清空再重新接收 |

### ③ 计算/选型示例

- 已知：接收缓冲区中残留了上一条不完整报文
- 公式/规则：重新接收前先清空缓冲区
- 操作：使用 **Receive_Reset**
- 结论：接收区被清除，避免旧数据干扰新报文

> [!tip] 记忆口诀
> **接收乱了先清空，Receive_Reset 再重来。**


## 08 `Signal_Get` | 读取状态

> [!info] 核心结论
> **Signal_Get** 用于读取 PtP 通信相关状态或伴随信号，便于判断端口、握手或设备状态。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Signal_Get** |
| 功能描述 | **读取状态** |
| 版本 | **V4.0** |
| 核心作用 | 读取通信状态/伴随信号 |
| 使用重点 | 状态位含义需按实际模块和协议校核 |

### ② 参考表

| 可读取内容 | 说明 |
|---|---|
| 通信状态 | 判断端口是否正常 |
| 伴随信号 | 如握手、控制线状态 |
| 错误状态 | 判断异常条件 |
| 设备状态 | 需结合实际硬件校核 |

### ③ 计算/选型示例

- 已知：通信没有响应，需要判断端口状态
- 公式/规则：读取状态用 **Signal_Get**
- 操作：读取相关状态位并判断是否异常
- 结论：可辅助诊断 PtP 通信问题

> [!tip] 记忆口诀
> **状态不明先读取，Signal_Get 查端口。**


## 09 `Signal_Set` | 设置伴随信号

> [!info] 核心结论
> **Signal_Set** 用于设置 PtP 通信的伴随信号，常用于硬件握手或控制线状态设置。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Signal_Set** |
| 功能描述 | **设置伴随信号** |
| 版本 | **V4.0** |
| 核心作用 | 设置通信相关控制信号 |
| 使用重点 | 硬件接线、握手方式、信号含义需校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 硬件握手 | 设置控制线状态 |
| 通信准备 | 通知对端可以发送/接收 |
| 特殊串口控制 | 需结合模块特性 |
| 安全提醒 | 信号错误可能导致通信失败 |

### ③ 计算/选型示例

- 已知：对端设备需要握手信号允许后才发送数据
- 公式/规则：设置伴随信号用 **Signal_Set**
- 操作：按协议设置对应控制信号
- 结论：对端设备获得允许信号后开始通信

> [!tip] 记忆口诀
> **要给对端发状态，Signal_Set 来设置。**


## 10 `Get_Features` | 获取扩展功能

> [!info] 核心结论
> **Get_Features** 用于读取 PtP 通信接口支持的扩展功能，适合确认模块能力和当前功能状态。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Get_Features** |
| 功能描述 | **获取扩展功能** |
| 版本 | **V4.0** |
| 核心作用 | 读取接口扩展能力 |
| 使用重点 | 支持功能因 CPU/模块型号不同，需按手册校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 查询模块能力 | 判断支持哪些扩展功能 |
| 通信功能诊断 | 查看当前功能状态 |
| 项目兼容性检查 | 不同模块能力不同 |
| 参数细节 | 需按实际设备手册校核 |

### ③ 计算/选型示例

- 已知：程序需要确认当前通信模块是否支持某扩展功能
- 公式/规则：读取扩展功能用 **Get_Features**
- 操作：查询模块功能能力
- 结论：根据结果决定是否启用对应功能

> [!tip] 记忆口诀
> **功能支不支持，Get_Features 先确认。**


## 11 `Set_Features` | 设置扩展功能

> [!info] 核心结论
> **Set_Features** 用于设置 PtP 通信接口的扩展功能，适合启用或调整模块支持的高级通信能力。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V4.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PtP Communication** |
| 指令名称 | **Set_Features** |
| 功能描述 | **设置扩展功能** |
| 版本 | **V4.0** |
| 核心作用 | 配置接口扩展能力 |
| 使用重点 | 设置前建议先用 Get_Features 确认支持情况 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 启用扩展功能 | 打开模块支持的特殊能力 |
| 调整通信特性 | 修改接口功能状态 |
| 配合模块能力 | 需先确认是否支持 |
| 风险提醒 | 设置错误可能导致通信异常 |

### ③ 计算/选型示例

- 已知：当前模块支持某扩展功能，需要在项目中启用
- 公式/规则：先读取支持情况，再设置功能
- 操作：先用 **Get_Features** 查询，再用 **Set_Features** 设置
- 结论：扩展功能被启用或调整

> [!tip] 记忆口诀
> **先 Get 查能力，再 Set 开功能。**


## 12 PtP Communication | 选型速记

> [!info] 核心结论
> PtP 通信的核心是：**端口先配置，收发再执行；异常先清缓存，状态用 Signal 查。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
端口 Port_Config，发送 Send_Config，接收 Receive_Config；发用 Send_P2P，收用 Receive_P2P，乱了 Reset。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 端口组态 | **Port_Config** |
| 发送方组态 | **Send_Config** |
| 接收方组态 | **Receive_Config** |
| 协议组态 | **P3964_Config** |
| 发送数据 | **Send_P2P** |
| 接收数据 | **Receive_P2P** |
| 清接收缓存 | **Receive_Reset** |
| 状态/信号 | **Signal_Get / Signal_Set** |
| 扩展功能 | **Get_Features / Set_Features** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 配置 PtP 端口参数 | **Port_Config** |
| 配置发送规则 | **Send_Config** |
| 配置接收规则 | **Receive_Config** |
| 配置 3964 协议 | **P3964_Config** |
| 发送串口数据 | **Send_P2P** |
| 接收串口数据 | **Receive_P2P** |
| 清空接收缓冲区 | **Receive_Reset** |
| 读取通信状态 | **Signal_Get** |
| 设置伴随信号 | **Signal_Set** |
| 查询扩展能力 | **Get_Features** |
| 设置扩展能力 | **Set_Features** |

### ③ 计算/选型示例

- 已知：PLC 要通过串口读取扫码枪条码
- 公式/规则：先配置端口和接收规则，再接收数据
- 操作：使用 **Port_Config** 配置串口参数，用 **Receive_Config** 设置接收格式，再用 **Receive_P2P** 接收条码
- 结论：这是典型的 PtP 接收通信流程

> [!tip] 记忆口诀
> **先配端口，再定收发；发用 Send，收用 Receive，故障先查状态和缓存。**