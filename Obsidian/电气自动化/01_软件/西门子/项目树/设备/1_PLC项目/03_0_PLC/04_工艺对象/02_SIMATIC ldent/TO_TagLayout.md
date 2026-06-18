---
tags:
  - PLC
  - TIA_Portal
  - SIMATIC_Ident
  - RFID
  - TO_TagLayout
  - 工艺对象
aliases:
  - TO_TagLayout
  - Tag Layout
  - 标签布局
  - RFID标签布局
  - 载码体存储布局
---

# 01｜TO_TagLayout 是什么

> [!info] 核心结论
> **TO_TagLayout 是 TIA Portal 中用于 SIMATIC Ident / RFID 载码体存储区规划的工艺对象，用来把标签存储区划分成多个可符号访问的 Tag Field。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>图片识别</strong><br>
截图中的 <strong>TO_TagLayout V1.1</strong> 是 SIMATIC Ident 相关的标签布局工艺对象，不是 PID，也不是运动轴。
</div>

## ① 分类/公式/规则

| 项目 | 说明 |
|---|---|
| **名称** | `TO_TagLayout` |
| **版本** | `V1.1` |
| **中文理解** | 标签布局 / 载码体存储布局 |
| **所属方向** | SIMATIC Ident / RFID / 读写器 |
| **核心作用** | 将 RFID 标签存储区划分为多个字段 |
| **典型搭配** | `TO_Ident`、`Read_Tagfield`、`Write_Tagfield` |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
TO_TagLayout 就是给 RFID 标签做“内存分区表”：哪一段存产品号，哪一段存批次，哪一段存工艺参数。
</div>

## ② 参考表

| 对象 | 作用 | 类比 |
|---|---|---|
| **TO_Ident** | 管读写器/Ident 设备 | 读卡器对象 |
| **TO_TagLayout** | 管标签内部数据布局 | 标签内存地图 |
| **Tag Field** | 标签中的一个数据字段 | 一个存储格 |
| **Read_Tagfield** | 读取某个字段 | 读指定格 |
| **Write_Tagfield** | 写入某个字段 | 写指定格 |

## ③ 计算/选型示例

- **已知：** 一个 RFID 标签需要存产品编号、批次号、工艺号
- **公式：** 标签存储区 = 多个 Tag Field
- **计算：**
  - Field 1：产品编号
  - Field 2：批次号
  - Field 3：工艺号
  - PLC 通过字段编号或符号名读写
- **结论：** 多段结构化 RFID 数据适合用 `TO_TagLayout` 管理。

> [!tip] 记忆口诀
> **TO_Ident 管读写器，TO_TagLayout 管标签内存。**

---

# 02｜它和 TO_Ident 的关系

> [!info] 核心结论
> **TO_Ident 负责连接和管理读写器，TO_TagLayout 负责定义 RFID 标签内部数据结构，两者通常配合使用。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>系统链路</strong><br>
PLC → TO_Ident → 读写器 → RFID 标签 → TO_TagLayout 定义标签字段
</div>

## ① 分类/公式/规则

| 对象 | 中文含义 | 核心任务 |
|---|---|---|
| **TO_Ident** | 识别设备工艺对象 | 配置读写器、通信、诊断 |
| **TO_TagLayout** | 标签布局工艺对象 | 定义标签数据字段 |
| **Reader** | RFID 读写器 | 实际读写标签 |
| **Transponder / Tag** | RFID 标签 / 载码体 | 存储数据 |
| **Tag Field** | 标签字段 | 指定地址段数据 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>核心规则</strong><br>
读写器能不能通信，看 TO_Ident；标签数据怎么分区，看 TO_TagLayout。
</div>

## ② 参考表

| 需求 | 使用对象 |
|---|---|
| **配置 RFID 读写器** | `TO_Ident` |
| **诊断读写器状态** | `TO_Ident` |
| **定义标签数据结构** | `TO_TagLayout` |
| **按字段读数据** | `Read_Tagfield + TO_TagLayout` |
| **按字段写数据** | `Write_Tagfield + TO_TagLayout` |

## ③ 计算/选型示例

- **已知：** 读写器已经能识别标签，但 PLC 不想按绝对地址读写
- **公式：** 想符号化访问标签字段 → 使用 `TO_TagLayout`
- **计算：**
  - 原方式：读地址 `0`，长度 `8`
  - 新方式：读字段 `ProductID`
  - 程序可读性更好
- **结论：** TO_TagLayout 适合把 RFID 地址访问变成“字段名访问”。

> [!tip] 记忆口诀
> **设备连接找 Ident，标签字段找 TagLayout。**

---

# 03｜Tag Field 是什么

> [!info] 核心结论
> **Tag Field 是 TO_TagLayout 中定义的一个标签数据字段，本质上是 RFID 标签存储区中的一个地址范围。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>一句话理解</strong><br>
Tag Field 就像 DB 里的一个变量，只不过它实际存放在 RFID 标签里面。
</div>

## ① 分类/公式/规则

| 字段属性 | 说明 |
|---|---|
| **Field Name** | 字段名称 |
| **Start Address** | 起始地址 |
| **Length** | 字节长度 |
| **Data Type** | 数据类型 |
| **Field Number** | 字段编号 |
| **Symbolic Access** | 符号化访问 |

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点公式</strong><br>
Tag Field = 起始地址 + 长度 + 数据类型 + 字段名称
</div>

## ② 参考表

| 字段示例 | 数据类型 | 典型长度 |
|---|---|---:|
| **ProductID** | `String` / Byte数组 | 按编码长度 |
| **BatchNo** | `DInt` / Byte数组 | 4 Byte 或更多 |
| **ProcessNo** | `Int` | 2 Byte |
| **StatusWord** | `Word` | 2 Byte |
| **RecipeData** | `Struct` / Byte数组 | 按结构大小 |
| **RawData** | `Array of Byte` | 按标签容量 |

## ③ 计算/选型示例

- **已知：**
  - 产品编号需要 `8 Byte`
  - 批次号需要 `4 Byte`
  - 状态字需要 `2 Byte`
- **公式：** 总长度 = 各字段长度相加
- **计算：**
  - `8 + 4 + 2 = 14 Byte`
- **结论：** 标签至少需要预留 `14 Byte` 可用空间，实际还要考虑扩展和厂家存储规则。

> [!tip] 记忆口诀
> **字段先定名，再定地址；长度算清楚，读写不越界。**

---

# 04｜读写字段指令

> [!info] 核心结论
> **TO_TagLayout 通常配合 `Read_Tagfield` 和 `Write_Tagfield` 使用，实现按字段读取或写入 RFID 标签数据。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>工程理解</strong><br>
不再手工记地址，而是告诉系统：我要读第几个字段，或写哪个字段。
</div>

## ① 分类/公式/规则

| 指令 | 中文含义 | 作用 |
|---|---|---|
| **Read_Tagfield** | 读取标签字段 | 从指定 Tag Field 读数据 |
| **Write_Tagfield** | 写入标签字段 | 向指定 Tag Field 写数据 |
| **TAGFIELD** | 标签字段编号 | 指定读写哪个字段 |
| **TAGLAYOUT** | 标签布局对象 | 传入 `TO_TagLayout` |
| **HW_CONNECT** | Ident 连接对象 | 传入 `TO_Ident` |
| **IDENT_DATA** | 数据缓冲区 | 存放读写数据 |

> [!warning]
> 实际接口名称、数据类型和参数顺序可能随 TIA Portal 版本、库版本变化，必须以当前项目中的块接口为准。

## ② 参考表

| 参数 | 常见作用 | 注意 |
|---|---|---|
| **TAGFIELD** | 选择字段 | 可用编号或生成的索引 |
| **TAGLAYOUT** | 指定布局对象 | 连接 `TO_TagLayout` |
| **HW_CONNECT** | 指定读写器对象 | 连接 `TO_Ident` |
| **IDENT_DATA** | 数据区 | 类型需匹配字段 |
| **LEN_DATA** | 写入长度 | 写字段时常见 |
| **EPCID_UID** | 指定标签 ID | 多标签场景可能用 |
| **LEN_ID** | 标签 ID 长度 | 与 EPC/UID 匹配 |

## ③ 计算/选型示例

- **已知：** 需要读取标签中的 `ProductID` 字段
- **公式：** 字段读写 = `TAGLAYOUT + TAGFIELD + HW_CONNECT + IDENT_DATA`
- **计算：**
  - `TAGLAYOUT` 指向 `TO_TagLayout`
  - `TAGFIELD` 选择 `ProductID`
  - `HW_CONNECT` 指向对应 `TO_Ident`
  - `IDENT_DATA` 连接接收缓冲区
- **结论：** 字段式读写比绝对地址读写更适合复杂 RFID 数据管理。

> [!tip] 记忆口诀
> **读字段用 Read，写字段用 Write；布局给 TAGLAYOUT，设备给 HW_CONNECT。**

---

# 05｜数据类型与缓冲区

> [!info] 核心结论
> **IDENT_DATA 的变量类型要与 Tag Field 的数据类型匹配，通用做法是用 `Array of Byte` 做原始缓冲区。**

<div class="card orange" style="background:#FFF7F3;border-left:6px solid #FF6B35;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>重点规则</strong><br>
字段类型不匹配，可能导致编译错误、读写失败或数据解析错误。
</div>

## ① 分类/公式/规则

| 数据形式 | 适合场景 |
|---|---|
| **Array of Byte** | 通用原始报文 |
| **Word / DWord** | 状态字、编号 |
| **Int / DInt** | 数值编号 |
| **Real** | 工艺参数 |
| **String** | 产品码、批次码 |
| **Struct / UDT** | 结构化标签数据 |

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>工程建议</strong><br>
复杂项目可以用 UDT 统一定义标签结构；调试阶段可先用 Byte 数组验证读写。
</div>

## ② 参考表

| 数据内容 | 推荐类型 | 注意 |
|---|---|---|
| **产品编号** | `String` / Byte数组 | 编码格式统一 |
| **工单号** | `String` | 长度固定 |
| **状态位** | `Word` | 位定义清楚 |
| **数量** | `DInt` | 字节序校核 |
| **工艺参数** | `Real` | 浮点格式校核 |
| **原始数据** | `Array of Byte` | 最通用 |

## ③ 计算/选型示例

- **已知：** RFID 标签要存 12 位 ASCII 产品码
- **公式：** ASCII 字符数 = 字节数
- **计算：**
  - 12 个字符
  - 每个字符 1 Byte
  - 至少需要 `12 Byte`
- **结论：** ProductID 字段长度至少设置为 `12 Byte`，如需结束符或扩展需预留更多空间。

> [!tip] 记忆口诀
> **不确定用 Byte，确定结构再用 UDT。**

---

# 06｜标签内存规划

> [!info] 核心结论
> **TO_TagLayout 的关键不是“能不能读写”，而是提前规划好标签内存地址、长度、类型和扩展空间。**

<div class="card green" style="background:#F1FBF5;border-left:6px solid #27AE60;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>规划口诀</strong><br>
先规划字段，再写程序；先留扩展，再上产线。
</div>

## ① 分类/公式/规则

| 规划项 | 说明 |
|---|---|
| **字段顺序** | 哪些数据先存 |
| **字段长度** | 每个字段占多少 Byte |
| **起始地址** | 每个字段从哪里开始 |
| **数据类型** | 字符、整数、浮点、结构 |
| **扩展空间** | 后期新增字段 |
| **版本字段** | 标记标签格式版本 |

## ② 参考表

| 字段 | 起始地址示例 | 长度示例 | 用途 |
|---|---:|---:|---|
| **LayoutVersion** | `0` | `2 Byte` | 布局版本 |
| **ProductID** | `2` | `12 Byte` | 产品编号 |
| **BatchNo** | `14` | `8 Byte` | 批次号 |
| **ProcessNo** | `22` | `2 Byte` | 工艺编号 |
| **StatusWord** | `24` | `2 Byte` | 状态标志 |
| **Reserve** | `26` | 按需 | 预留区 |

> [!warning]
> 上表只是示例布局，实际地址和长度必须按标签容量、数据类型、项目规范和厂家手册校核。

## ③ 计算/选型示例

- **已知：**
  - ProductID：`12 Byte`
  - BatchNo：`8 Byte`
  - ProcessNo：`2 Byte`
  - StatusWord：`2 Byte`
  - Reserve：`8 Byte`
- **公式：** 总长度 = 所有字段长度相加
- **计算：**
  - `12 + 8 + 2 + 2 + 8 = 32 Byte`
- **结论：** 标签可用用户区至少需要 `32 Byte`，并建议再预留扩展空间。

> [!tip] 记忆口诀
> **字段不重叠，长度不越界，版本要保留。**

---

# 07｜适合与不适合场景

> [!info] 核心结论
> **TO_TagLayout 适合 RFID 标签数据结构清晰、字段较多、需要长期维护的项目；简单读写少量字节时可以直接用 Byte 缓冲区。**

<div class="card purple" style="background:#F8F1FF;border-left:6px solid #9B59B6;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>选型判断</strong><br>
字段多、地址复杂、多人维护，用 TO_TagLayout；数据少、一次性测试，用普通读写也可以。
</div>

## ① 分类/公式/规则

| 场景 | 是否适合 |
|---|---|
| **产品追溯标签** | 适合 |
| **工装托盘 RFID** | 适合 |
| **多字段工艺参数** | 适合 |
| **MES 生产数据写入** | 适合 |
| **只读 4 个字节测试** | 不一定需要 |
| **没有 RFID/Ident 设备** | 不适合 |

## ② 参考表

| 需求 | 推荐方式 |
|---|---|
| **读写器配置** | `TO_Ident` |
| **标签字段管理** | `TO_TagLayout` |
| **按字段读取** | `Read_Tagfield` |
| **按字段写入** | `Write_Tagfield` |
| **简单原始读写** | Byte数组 + 基础 Ident 指令 |
| **复杂追溯数据** | TagLayout + UDT |

## ③ 计算/选型示例

- **已知：** 一个托盘 RFID 要存产品号、工位号、工艺状态、检测结果、时间戳
- **公式：** 多字段结构化数据 → 使用 TagLayout
- **计算：**
  - 数据字段多
  - 地址管理复杂
  - 后期需要维护和扩展
- **结论：** 该场景适合用 `TO_TagLayout` 统一规划标签内存。

> [!tip] 记忆口诀
> **字段越多，越要布局；地址越乱，越要 TagLayout。**

---

# 08｜常见故障排查

> [!info] 核心结论
> **TO_TagLayout 相关问题通常集中在字段编号、数据类型、长度、标签容量、读写器连接和标签 ID 匹配。**

<div class="card red" style="background:#FFF4F3;border-left:6px solid #E74C3C;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>排查顺序</strong><br>
读写器在线 → 标签存在 → 字段编号正确 → 长度正确 → 类型匹配 → 地址不越界。
</div>

## ① 分类/公式/规则

| 问题 | 常见原因 |
|---|---|
| **读字段失败** | TAGFIELD 选错 |
| **写字段失败** | LEN_DATA 或类型不匹配 |
| **数据乱码** | 字节序/编码格式错误 |
| **读到旧数据** | 写入未成功或读错标签 |
| **找不到标签** | 读写器距离、天线、标签 ID 问题 |
| **地址越界** | 字段长度超出标签容量 |

## ② 参考表

| 现象 | 排查方向 | 解决建议 |
|---|---|---|
| **Error=1** | 查 Status | 对照帮助文档 |
| **读不到数据** | Reader / Tag / TAGFIELD | 先确认标签在线 |
| **数据长度不对** | Field Length | 校核字段长度 |
| **写入后读不一致** | 数据类型/字节序 | 用 Byte 数组验证 |
| **多标签读错** | EPCID_UID / LEN_ID | 指定目标标签 |
| **字段重叠** | 地址规划错误 | 重做布局表 |

## ③ 计算/选型示例

- **已知：** 字段长度设置为 `8 Byte`，但写入缓冲区为 `12 Byte`
- **公式：** 写入长度 ≤ 字段长度
- **计算：**
  - 字段容量：`8 Byte`
  - 待写数据：`12 Byte`
  - 超出 `4 Byte`
- **结论：** 会导致写入失败或数据被截断，需增大字段长度或缩短写入数据。

> [!tip] 记忆口诀
> **读写失败先查长度，数据乱码先查类型。**

---

# 09｜一页速记总卡

> [!info] 核心结论
> **TO_TagLayout 的核心价值是把 RFID 标签存储区结构化，让 PLC 可以按“字段”而不是按“裸地址”读写标签数据。**

<div class="card blue" style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px 14px;border-radius:12px;margin:10px 0;">
<strong>总口诀</strong><br>
Ident 管设备，TagLayout 管标签；字段定地址，类型定数据，长度别越界。
</div>

## ① 分类/公式/规则

| 主轴 | 关键词 |
|---|---|
| **对象** | `TO_TagLayout V1.1` |
| **用途** | RFID 标签内存布局 |
| **字段** | Tag Field |
| **读写** | `Read_Tagfield` / `Write_Tagfield` |
| **连接** | `TO_Ident` |
| **数据区** | `IDENT_DATA` |
| **重点** | 地址、长度、类型、字段编号 |

## ② 参考表

| 需求 | 推荐 |
|---|---|
| **配置读写器** | `TO_Ident` |
| **规划标签字段** | `TO_TagLayout` |
| **读产品号** | `Read_Tagfield` |
| **写批次号** | `Write_Tagfield` |
| **通用原始数据** | `Array of Byte` |
| **结构化标签数据** | `Struct / UDT` |

## ③ 计算/选型示例

- **已知：** 一个 RFID 标签要存产品追溯数据
- **公式：** 追溯标签 = `标签布局 + 字段读写 + 读写器连接`
- **计算：**
  - 用 `TO_Ident` 配读写器
  - 用 `TO_TagLayout` 定义字段
  - 用 `Read_Tagfield` 读取字段
  - 用 `Write_Tagfield` 写入字段
- **结论：** TO_TagLayout 适合用于规范化、可维护的 RFID 数据管理。

> [!tip] 记忆口诀
> **先建标签布局，再读写字段；先定数据结构，再写 PLC 程序。**