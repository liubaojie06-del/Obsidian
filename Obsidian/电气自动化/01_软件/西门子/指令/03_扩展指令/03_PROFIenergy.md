---
tags:
  - PLC
  - TIA_Portal
  - PROFIenergy
  - 智能设备
  - 智能从站
  - 节能模式
  - 能源管理
  - 西门子
aliases:
  - PROFIenergy
  - PE_I_DEV
  - PE_Error_RSP
  - PE_Start_RSP
  - PE_End_RSP
  - PE_List_Modes_RSP
  - PE_Get_Mode_RSP
  - PE_PEM_Status_RSP
  - PE_Identify_RSP
  - PE_Measurement_List_RSP
  - PE_Measurement_Values_RSP
---
## 01 `PE_I_DEV` | 控制智能设备中的 PROFIenergy

> [!info] 核心结论
> **PE_I_DEV** 用于在智能设备/智能从站中处理 PROFIenergy 控制功能，是 PROFIenergy 通信控制的核心入口。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
<strong>V1.6</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_I_DEV** |
| 功能描述 | **控制智能设备中的 PROFIenergy** |
| 版本 | **V1.6** |
| 说明 | 截图描述有省略，需按实际软件/厂家手册校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 智能设备节能控制 | 处理 PROFIenergy 命令 |
| 智能从站响应 | 接收并响应上级控制请求 |
| 能源管理 | 配合设备进入/退出节能状态 |
| 参数细节 | 需按设备手册校核 |

### ③ 计算/选型示例

- 已知：上位控制器需要让智能设备进入节能模式
- 公式/规则：PROFIenergy 控制由智能设备侧响应
- 操作：使用 **PE_I_DEV** 处理相关控制命令
- 结论：适合智能设备/智能从站的 PROFIenergy 控制入口

> [!tip] 记忆口诀
> **PE_I_DEV 管设备，节能命令它来接。**


## 02 `PE_Error_RSP` | 生成命令的否定应答

> [!info] 核心结论
> **PE_Error_RSP** 用于在 PROFIenergy 命令无法执行时，生成否定应答。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V1.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_Error_RSP** |
| 功能描述 | **生成命令的否定应答** |
| 版本 | **V1.4** |
| 核心作用 | 返回错误/拒绝响应 |

### ② 参考表

| 场景 | 建议 |
|---|---|
| 命令不支持 | 返回否定应答 |
| 当前状态不允许执行 | 返回否定应答 |
| 参数不合法 | 返回错误信息 |
| 错误码含义 | 需按 PROFIenergy 规范/设备手册校核 |

### ③ 计算/选型示例

- 已知：主站请求设备进入某节能模式，但设备当前不允许
- 公式/规则：命令无法执行时生成错误响应
- 操作：使用 **PE_Error_RSP**
- 结论：主站可收到明确的否定应答

> [!tip] 记忆口诀
> **命令不能办，Error_RSP 来回函。**


## 03 `PE_Start_RSP` | 生成开始暂停时命令应答

> [!info] 核心结论
> **PE_Start_RSP** 用于生成开始暂停/进入节能状态相关命令的应答。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V1.5</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_Start_RSP** |
| 功能描述 | **生成开始暂停时命令应答** |
| 版本 | **V1.5** |
| 说明 | 截图描述有省略，需按实际软件/厂家手册校核 |

### ② 参考表

| 场景 | 说明 |
|---|---|
| 进入暂停状态 | 生成开始暂停应答 |
| 进入节能模式 | 通知控制方命令处理结果 |
| 设备准备节能 | 返回状态信息 |
| 响应内容 | 需按实际参数校核 |

### ③ 计算/选型示例

- 已知：主站发送开始暂停命令
- 公式/规则：从站需要生成对应响应
- 操作：使用 **PE_Start_RSP**
- 结论：适合进入节能/暂停过程的响应处理

> [!tip] 记忆口诀
> **开始暂停要回应，Start_RSP 报状态。**


## 04 `PE_End_RSP` | 生成暂停结束时命令应答

> [!info] 核心结论
> **PE_End_RSP** 用于生成结束暂停/退出节能状态相关命令的应答。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
<strong>V1.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_End_RSP** |
| 功能描述 | **生成暂停结束时命令应答** |
| 版本 | **V1.4** |
| 说明 | 截图描述有省略，需按实际软件/厂家手册校核 |

### ② 参考表

| 场景 | 说明 |
|---|---|
| 退出暂停状态 | 生成结束暂停应答 |
| 退出节能模式 | 通知设备恢复过程 |
| 恢复运行准备 | 返回响应状态 |
| 响应内容 | 需按实际参数校核 |

### ③ 计算/选型示例

- 已知：主站要求设备退出节能状态
- 公式/规则：设备需要对结束暂停命令进行应答
- 操作：使用 **PE_End_RSP**
- 结论：适合节能结束/恢复运行的响应处理

> [!tip] 记忆口诀
> **暂停结束要回话，End_RSP 告诉它。**


## 05 `PE_List_Modes_RSP` | 生成所查询的节能模式列表

> [!info] 核心结论
> **PE_List_Modes_RSP** 用于生成设备支持的节能模式列表应答。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V1.5</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_List_Modes_RSP** |
| 功能描述 | **生成所查询的节能模式列表** |
| 版本 | **V1.5** |
| 说明 | 截图描述有省略，需按实际软件/厂家手册校核 |

### ② 参考表

| 查询内容 | 应答含义 |
|---|---|
| 支持哪些节能模式 | 返回模式列表 |
| 模式数量 | 返回可用模式信息 |
| 模式编号 | 供主站后续选择 |
| 模式细节 | 需按设备手册校核 |

### ③ 计算/选型示例

- 已知：主站查询设备支持哪些节能模式
- 公式/规则：列表类查询需返回模式清单
- 操作：使用 **PE_List_Modes_RSP**
- 结论：适合节能模式能力上报

> [!tip] 记忆口诀
> **查模式清单，List_Modes_RSP 来列单。**


## 06 `PE_Get_Mode_RSP` | 生成所查询的模式应答

> [!info] 核心结论
> **PE_Get_Mode_RSP** 用于生成指定节能模式的查询应答，返回该模式相关信息。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V2.3</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_Get_Mode_RSP** |
| 功能描述 | **生成所查询的模式应答** |
| 版本 | **V2.3** |
| 说明 | 截图描述有省略，需按实际软件/厂家手册校核 |

### ② 参考表

| 查询对象 | 应答内容 |
|---|---|
| 指定模式编号 | 返回模式信息 |
| 模式参数 | 返回节能模式相关参数 |
| 模式状态 | 可用于主站判断可用性 |
| 参数细节 | 需按实际手册校核 |

### ③ 计算/选型示例

- 已知：主站查询模式 2 的详细信息
- 公式/规则：指定模式查询需要生成对应应答
- 操作：使用 **PE_Get_Mode_RSP**
- 结论：适合返回某个节能模式的详细信息

> [!tip] 记忆口诀
> **查单个模式，Get_Mode_RSP 回细节。**


## 07 `PE_PEM_Status_RSP` | 生成 PEM 状态应答

> [!info] 核心结论
> **PE_PEM_Status_RSP** 用于生成 PROFIenergy 管理状态相关应答，便于主站了解当前能源管理状态。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V1.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_PEM_Status_RSP** |
| 功能描述 | **生成 PEM 状态应答** |
| 版本 | **V1.4** |
| 说明 | 截图描述有省略，需按实际软件/厂家手册校核 |

### ② 参考表

| 状态信息 | 用途 |
|---|---|
| 当前能源状态 | 告知是否处于节能/运行 |
| 命令处理状态 | 告知是否正在切换 |
| 异常状态 | 辅助诊断 |
| 状态编码 | 需按手册校核 |

### ③ 计算/选型示例

- 已知：主站需要确认设备是否已经进入节能状态
- 公式/规则：状态查询需要返回 PEM 状态
- 操作：使用 **PE_PEM_Status_RSP**
- 结论：适合上报当前 PROFIenergy 管理状态

> [!tip] 记忆口诀
> **PEM 状态要说明，Status_RSP 报当前。**


## 08 `PE_Identify_RSP` | 生成所支持的 PROFIenergy 信息

> [!info] 核心结论
> **PE_Identify_RSP** 用于生成设备支持的 PROFIenergy 能力识别信息。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
<strong>V1.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_Identify_RSP** |
| 功能描述 | **生成所支持的 PROFIenergy 信息** |
| 版本 | **V1.4** |
| 说明 | 截图描述有省略，需按实际软件/厂家手册校核 |

### ② 参考表

| 信息类型 | 用途 |
|---|---|
| 支持能力 | 告诉主站设备支持什么 |
| 设备识别 | 辅助能源管理识别 |
| PROFIenergy 能力 | 用于后续命令选择 |
| 参数细节 | 需按实际手册校核 |

### ③ 计算/选型示例

- 已知：主站首次识别设备 PROFIenergy 能力
- 公式/规则：设备需要返回支持信息
- 操作：使用 **PE_Identify_RSP**
- 结论：适合设备能力识别应答

> [!tip] 记忆口诀
> **先识别再控制，Identify_RSP 亮身份。**


## 09 `PE_Measurement_List_RSP` | 生成所支持的测量值列表

> [!info] 核心结论
> **PE_Measurement_List_RSP** 用于生成设备支持的测量值列表，便于主站知道可读取哪些能源数据。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V1.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_Measurement_List_RSP** |
| 功能描述 | **生成所支持的测量值列表** |
| 版本 | **V1.4** |
| 说明 | 截图中名称/描述有省略，需按实际软件校核 |

### ② 参考表

| 测量值类型 | 说明 |
|---|---|
| 功率 | 设备当前功率信息 |
| 能耗 | 累计或周期能耗 |
| 状态量 | 与能源相关的状态 |
| 支持列表 | 以设备实际支持为准 |

### ③ 计算/选型示例

- 已知：主站想知道设备能提供哪些能源测量数据
- 公式/规则：测量能力查询返回列表
- 操作：使用 **PE_Measurement_List_RSP**
- 结论：适合上报可支持的测量值清单

> [!tip] 记忆口诀
> **能测什么先列单，Measurement_List_RSP 来上报。**


## 10 `PE_Measurement_Values_RSP` | 生成所查询的测量值应答

> [!info] 核心结论
> **PE_Measurement_Values_RSP** 用于生成主站查询的测量值应答，返回实际能源测量数据。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V1.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **PROFIenergy / 智能设备 / 智能从站** |
| 指令名称 | **PE_Measurement_Values_RSP** |
| 功能描述 | **生成所查询的测量值应答** |
| 版本 | **V1.4** |
| 说明 | 截图中名称/描述有省略，需按实际软件校核 |

### ② 参考表

| 查询对象 | 应答内容 |
|---|---|
| 当前功率 | 返回功率测量值 |
| 当前能耗 | 返回能耗数据 |
| 指定测量项 | 返回对应测量值 |
| 单位/精度 | 需按设备手册校核 |

### ③ 计算/选型示例

- 已知：主站查询设备当前功率
- 公式/规则：测量值查询需要返回实际数值
- 操作：使用 **PE_Measurement_Values_RSP**
- 结论：适合能源数据读取应答

> [!tip] 记忆口诀
> **查数值就回值，Measurement_Values_RSP 给数据。**


## 11 PROFIenergy | 选型速记

> [!info] 核心结论
> PROFIenergy 指令的核心是：**设备控制用 PE_I_DEV，错误用 Error_RSP，启停节能用 Start/End_RSP，模式查询用 List/Get，测量数据用 Measurement。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
控制设备 PE_I_DEV，失败应答 Error；开始暂停 Start，结束暂停 End；查模式用 Mode，查能耗看 Measurement。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 设备控制 | **PE_I_DEV** |
| 否定应答 | **PE_Error_RSP** |
| 开始/结束暂停 | **PE_Start_RSP / PE_End_RSP** |
| 模式列表 | **PE_List_Modes_RSP** |
| 单个模式查询 | **PE_Get_Mode_RSP** |
| PEM 状态 | **PE_PEM_Status_RSP** |
| 能力识别 | **PE_Identify_RSP** |
| 测量值列表 | **PE_Measurement_List_RSP** |
| 测量值读取 | **PE_Measurement_Values_RSP** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 控制智能设备 PROFIenergy | **PE_I_DEV** |
| 命令不支持/执行失败 | **PE_Error_RSP** |
| 响应开始暂停命令 | **PE_Start_RSP** |
| 响应结束暂停命令 | **PE_End_RSP** |
| 查询支持的节能模式 | **PE_List_Modes_RSP** |
| 查询指定模式信息 | **PE_Get_Mode_RSP** |
| 查询 PEM 状态 | **PE_PEM_Status_RSP** |
| 识别设备 PROFIenergy 能力 | **PE_Identify_RSP** |
| 查询支持的测量值 | **PE_Measurement_List_RSP** |
| 查询实际测量值 | **PE_Measurement_Values_RSP** |

### ③ 计算/选型示例

- 已知：主站要查询设备支持哪些节能模式，并选择其中一个模式进入暂停
- 公式/规则：先查能力，再选择模式，再执行启停控制
- 操作：先用 **PE_List_Modes_RSP** 返回模式列表，再用 **PE_Start_RSP** 响应开始暂停
- 结论：这是典型的 PROFIenergy 节能模式控制流程

> [!tip] 记忆口诀
> **先识别，查模式；再启停，查测量；错了就回 Error。**