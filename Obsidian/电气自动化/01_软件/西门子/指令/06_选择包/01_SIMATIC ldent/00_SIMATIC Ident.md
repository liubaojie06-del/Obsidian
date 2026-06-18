---
tags:
  - PLC
  - TIA_Portal
  - SIMATIC_Ident
  - RFID
  - 光学阅读器
  - 读写器
  - 用户数据
  - 西门子
aliases:
  - SIMATIC Ident
  - Read
  - Read_MV
  - Reset_Reader
  - Set_MV_Program
  - Write
  - 读出用户数据
  - 写入用户数据
---
## 01 `Read` | 读出用户数据

> [!info] 核心结论
> **Read** 用于从 RFID 标签、识别载体或读写器中读出用户数据，是 SIMATIC Ident 最常用的读取指令。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V5.6</strong><br>
指令版本：<strong>V4.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SIMATIC Ident** |
| 指令名称 | **Read** |
| 功能描述 | **读出用户数据** |
| 版本 | **V4.4** |
| 核心作用 | 从识别设备读取用户数据 |
| 使用重点 | 地址、长度、数据缓冲区、读写器状态需按实际设备手册校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| RFID 标签读取 | 读取托盘、工装、产品标签数据 |
| 产品追溯 | 获取产品 ID、批次号、工艺信息 |
| 工位识别 | 判断当前物料或载具身份 |
| 数据采集 | 把标签数据读入 PLC 变量区 |
| 风险提醒 | 读取长度和存储区地址需校核 |

### ③ 计算/选型示例

- 已知：工装 RFID 标签中存有产品编号
- 公式/规则：从识别载体读取数据用 **Read**
- 操作：设置读取地址、读取长度和接收缓冲区
- 结论：PLC 可获得标签中的产品编号，用于后续工艺判断

> [!tip] 记忆口诀
> **读标签用 Read，用户数据拿进来。**


## 02 `Read_MV` | 读出光学阅读器的读取数据

> [!info] 核心结论
> **Read_MV** 用于读取光学阅读器相关数据，适合二维码、条码或视觉读取结果进入 PLC 的场景。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
<strong>V4.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SIMATIC Ident** |
| 指令名称 | **Read_MV** |
| 功能描述 | **读出光学阅读器的读取数据** |
| 版本 | **V4.4** |
| 核心作用 | 读取光学阅读器结果 |
| 说明 | 截图描述有省略，完整参数需按实际软件/厂家手册校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 二维码读取 | 读取产品码、追溯码 |
| 条码读取 | 获取物料号、批次号 |
| 光学识别 | 获取 MV 阅读器识别结果 |
| 结果判断 | 读取成功 / 失败 / 码值内容 |
| 参数细节 | 需按阅读器型号和项目配置校核 |

### ③ 计算/选型示例

- 已知：光学阅读器识别到产品二维码
- 公式/规则：读取光学阅读器结果用 **Read_MV**
- 操作：触发读取并接收识别结果数据
- 结论：PLC 可得到二维码内容，用于追溯或分拣判断

> [!tip] 记忆口诀
> **光学读码找 Read_MV，码值结果读进 PLC。**


## 03 `Reset_Reader` | 复位阅读器

> [!info] 核心结论
> **Reset_Reader** 用于复位读写器或阅读器，适合通信异常、读写错误或设备状态恢复场景。

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">版本</strong><br>
<strong>V4.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SIMATIC Ident** |
| 指令名称 | **Reset_Reader** |
| 功能描述 | **复位阅读器** |
| 版本 | **V4.4** |
| 核心作用 | 复位识别阅读器 |
| 使用重点 | 复位前需确认当前读写任务是否可以中断 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 阅读器异常 | 状态错误或无响应 |
| 读写失败后恢复 | 清除异常状态后重新读写 |
| 更换识别对象 | 重新初始化阅读器状态 |
| 维护调试 | 现场恢复设备通信 |
| 风险提醒 | 复位可能中断当前任务 |

### ③ 计算/选型示例

- 已知：读写器连续读取失败，状态无法恢复
- 公式/规则：阅读器状态异常可尝试复位
- 操作：使用 **Reset_Reader**
- 结论：阅读器复位后，可重新执行读取或写入任务

> [!tip] 记忆口诀
> **读写器卡住别硬读，Reset_Reader 先复位。**


## 04 `Set_MV_Program` | 更改光学阅读器程序

> [!info] 核心结论
> **Set_MV_Program** 用于切换或更改光学阅读器的程序，适合不同产品、不同码制或不同识别任务切换。

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">版本</strong><br>
<strong>V4.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SIMATIC Ident** |
| 指令名称 | **Set_MV_Program** |
| 功能描述 | **更改光学阅读器程序** |
| 版本 | **V4.4** |
| 核心作用 | 切换光学阅读器程序 |
| 说明 | 截图描述有省略，完整含义需按实际阅读器手册校核 |

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 产品换型 | 切换不同产品的读码程序 |
| 码制变化 | 一维码 / 二维码 / 特殊码切换 |
| 工位任务切换 | 不同工位使用不同识别逻辑 |
| 识别参数切换 | 曝光、区域、模板等按实际设备校核 |
| 风险提醒 | 切换程序后需确认当前程序号正确 |

### ③ 计算/选型示例

- 已知：产线从产品 A 切换到产品 B，二维码位置和规则不同
- 公式/规则：不同识别任务需要切换阅读器程序
- 操作：使用 **Set_MV_Program** 切换到产品 B 对应程序
- 结论：光学阅读器按新程序执行识别任务

> [!tip] 记忆口诀
> **产品换型先换程序，Set_MV_Program 管读码方案。**


## 05 `Write` | 写入用户数据

> [!info] 核心结论
> **Write** 用于向 RFID 标签、识别载体或读写器相关存储区写入用户数据，常用于生产追溯和工艺信息写入。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
<strong>V4.4</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **SIMATIC Ident** |
| 指令名称 | **Write** |
| 功能描述 | **写入用户数据** |
| 版本 | **V4.4** |
| 核心作用 | 向识别载体写入用户数据 |
| 使用重点 | 写入地址、写入长度、数据格式、写保护需按实际标签和设备手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点提醒</strong><br>
写入标签前必须确认地址和长度，避免覆盖已有关键追溯数据。
</div>

### ② 参考表

| 使用场景 | 说明 |
|---|---|
| 写入产品编号 | 将产品 ID 写入 RFID 标签 |
| 写入工艺状态 | 记录当前工序完成状态 |
| 写入批次信息 | 写入批号、配方号、生产线号 |
| 写入检测结果 | 保存合格/不合格等信息 |
| 风险提醒 | 写入前需确认标签可写、区域正确 |

### ③ 计算/选型示例

- 已知：产品完成检测后，需要把检测结果写入 RFID 标签
- 公式/规则：向识别载体写入数据用 **Write**
- 操作：设置写入地址、数据长度和写入内容
- 结论：检测结果被写入标签，后续工位可读取追溯

> [!tip] 记忆口诀
> **写标签用 Write，地址长度先核对。**


## 06 SIMATIC Ident | 选型速记

> [!info] 核心结论
> SIMATIC Ident 的核心是：**读用户数据用 Read，写用户数据用 Write；光学读码用 Read_MV，换程序用 Set_MV_Program，异常恢复用 Reset_Reader。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
读写标签用 Read/Write，光学读码用 Read_MV；程序切换 Set_MV，异常复位 Reset。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 读取用户数据 | **Read** |
| 写入用户数据 | **Write** |
| 读取光学阅读器数据 | **Read_MV** |
| 复位阅读器 | **Reset_Reader** |
| 更改光学阅读器程序 | **Set_MV_Program** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 读取 RFID 标签数据 | **Read** |
| 写入 RFID 标签数据 | **Write** |
| 读取二维码 / 条码结果 | **Read_MV** |
| 阅读器异常后恢复 | **Reset_Reader** |
| 产品换型切换读码程序 | **Set_MV_Program** |
| 做产品追溯 | 常用 **Read + Write** |
| 做光学识别 | 常用 **Read_MV + Set_MV_Program** |

### ③ 计算/选型示例

- 已知：产品进站时读取 RFID 编号，出站时写入检测结果
- 公式/规则：进站读取用 **Read**，出站写入用 **Write**
- 操作：进站读取产品 ID；检测完成后，将结果写入标签指定区域
- 结论：这是典型的 SIMATIC Ident 追溯读写流程

> [!tip] 记忆口诀
> **进站 Read 识身份，出站 Write 写结果；光学码值 Read_MV，异常 Reset 再来过。**