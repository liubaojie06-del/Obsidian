---
tags:
  - PLC
  - TIA_Portal
  - OPC_UA
  - OPC_UA服务器
  - 方法调用
  - 服务器方法
  - 通信
  - 西门子
aliases:
  - OPC UA
  - OPC UA Server
  - OPC_UA_ServerMethodPre
  - OPC_UA_ServerMethodPost
  - 服务器方法调用
  - OPC UA 服务器方法
---

## 01 `OPC_UA_ServerMethodPre` | 服务器方法调用的准备工作

> [!info] 核心结论
> **OPC_UA_ServerMethodPre** 用于在 OPC UA 服务器方法被调用前执行准备逻辑，适合做参数检查、权限判断和执行条件确认。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
OPC UA 服务器版本：<strong>V1.0</strong><br>
指令版本：<strong>V1.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **OPC UA / OPC UA 服务器** |
| 指令名称 | **OPC_UA_ServerMethodPre** |
| 功能描述 | **服务器方法调用的准备工作** |
| 版本 | **V1.0** |
| 核心作用 | 方法执行前的预处理 |
| 使用重点 | 参数合法性、调用权限、设备状态需按实际项目校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点规则</strong><br>
方法真正执行前，先确认：<strong>谁调用、参数对不对、设备能不能执行</strong>。
</div>

### ② 参考表

| 检查内容 | 说明 |
|---|---|
| 参数检查 | 判断输入参数是否在允许范围 |
| 权限判断 | 判断调用方是否允许执行 |
| 状态判断 | 判断设备是否处于可执行状态 |
| 错误处理 | 不满足条件时返回错误或拒绝执行 |
| 安全提醒 | 涉及设备动作时需加联锁和保护条件 |

### ③ 计算/选型示例

- 已知：OPC UA 客户端调用“启动设备”方法
- 公式/规则：启动前必须检查设备无故障、急停未触发、参数合法
- 操作：使用 **OPC_UA_ServerMethodPre** 做调用前检查
- 结论：条件满足才允许进入后续方法处理

> [!tip] 记忆口诀
> **Pre 是先检查，参数权限状态都要查。**


## 02 `OPC_UA_ServerMethodPost` | 服务器方法调用的后期处理

> [!info] 核心结论
> **OPC_UA_ServerMethodPost** 用于在 OPC UA 服务器方法调用后执行后处理逻辑，适合做结果返回、状态更新和日志记录。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
指令版本：<strong>V1.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **OPC UA / OPC UA 服务器** |
| 指令名称 | **OPC_UA_ServerMethodPost** |
| 功能描述 | **服务器方法调用的后期处理** |
| 版本 | **V1.0** |
| 核心作用 | 方法执行后的结果处理 |
| 使用重点 | 执行结果、返回状态、日志记录需按实际项目校核 |

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">重点规则</strong><br>
方法执行后要交代清楚：<strong>执行成功没有、结果是什么、是否需要记录</strong>。
</div>

### ② 参考表

| 后处理内容 | 说明 |
|---|---|
| 返回结果 | 把执行结果反馈给 OPC UA 客户端 |
| 状态更新 | 更新方法执行状态或设备状态 |
| 日志记录 | 记录调用时间、调用方、执行结果 |
| 错误反馈 | 执行失败时返回错误状态 |
| 追溯信息 | 便于后期诊断和审计 |

### ③ 计算/选型示例

- 已知：OPC UA 客户端调用“切换配方”方法
- 公式/规则：方法执行后需要返回是否切换成功
- 操作：使用 **OPC_UA_ServerMethodPost** 更新结果并返回状态
- 结论：客户端可知道方法调用是否成功，PLC 也可保存调用日志

> [!tip] 记忆口诀
> **Post 是后收尾，结果状态日志都归位。**


## 03 OPC UA | 选型速记

> [!info] 核心结论
> OPC UA 服务器方法处理的核心是：**调用前用 Pre 做检查，调用后用 Post 做收尾。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
方法调用分两步：Pre 先把关，Post 后反馈。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 方法调用前准备 | **OPC_UA_ServerMethodPre** |
| 方法调用后处理 | **OPC_UA_ServerMethodPost** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 检查输入参数 | **OPC_UA_ServerMethodPre** |
| 判断调用权限 | **OPC_UA_ServerMethodPre** |
| 判断设备是否允许动作 | **OPC_UA_ServerMethodPre** |
| 返回执行结果 | **OPC_UA_ServerMethodPost** |
| 更新调用状态 | **OPC_UA_ServerMethodPost** |
| 记录调用日志 | **OPC_UA_ServerMethodPost** |

### ③ 计算/选型示例

- 已知：上位机通过 OPC UA 调用 PLC 方法修改设备参数
- 公式/规则：修改前检查权限和参数范围，修改后返回执行结果
- 操作：前置检查用 **OPC_UA_ServerMethodPre**，后置反馈用 **OPC_UA_ServerMethodPost**
- 结论：这是典型的 OPC UA 服务器方法调用处理流程

> [!tip] 记忆口诀
> **Pre 查能不能做，Post 报做得怎样。**