---
tags: [计算机组成原理, PCIe, PCI Express, 高速串行总线, 链路, SerDes, 硬件接口]
type: 知识卡片
date: 2026-05-23
cssclasses: [cards, clean-embeds]
---

# 01 | PCIe 链路：CPU 与高速设备之间的点对点高速通道

> [!abstract] 核心结论
> PCIe 链路不是传统意义上的共享并行总线，而是一种高速串行、点对点、分层协议互连。显卡、NVMe SSD、网卡、采集卡等高速设备，通常通过 PCIe 链路和 CPU / 芯片组通信。

### ① 底层原理：PCIe 不是共享总线，而是点对点链路

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #2C3E50; color: #333; margin-bottom: 10px;">
<strong>PCIe 链路的硬件本质：</strong>
<ul>
  <li><strong>点对点连接：</strong> 一个 PCIe 设备通过专属链路连接到 Root Complex 或 Switch。</li>
  <li><strong>高速串行传输：</strong> 数据不是几十根并行线同时传，而是通过高速差分串行信号传输。</li>
  <li><strong>全双工通信：</strong> 发送方向和接收方向分开，可以同时收发。</li>
  <li><strong>按 Lane 扩展带宽：</strong> x1、x4、x8、x16 表示使用多少条 Lane 并行工作。</li>
  <li><strong>分层协议：</strong> PCIe 把通信分成事务层、数据链路层、物理层。</li>
</ul>
</div>

### ② PCIe 拓扑理解

```text
CPU / Root Complex
        │
        │ PCIe Link
        ▼
   PCIe Endpoint
  显卡 / SSD / 网卡
```

如果中间有 PCIe Switch：

```text
CPU / Root Complex
        │
        ▼
   PCIe Switch
   ┌────┼────┐
   ▼    ▼    ▼
 GPU   SSD  NIC
```

### ③ 一句话理解

```text
PCIe 链路 = 两个 PCIe 设备之间，用多条高速串行 Lane 组成的全双工通信通道。
```

> [!tip] 记忆口诀
> **PCIe 不再大家抢一条总线，而是点对点高速通道；Lane 越多，带宽越大。**

---

# 02 | Lane：PCIe 链路的最小物理通道

> [!abstract] 核心结论
> PCIe 的基本物理通道叫 Lane。每条 Lane 包含一组发送差分线和一组接收差分线，因此一条 Lane 就能实现全双工通信。

### ① 一条 Lane 里面有什么

一条 PCIe Lane 通常包含：

```text
发送差分对 TX+ / TX-
接收差分对 RX+ / RX-
```

示意：

```text
设备 A                         设备 B

TX+  ───────────────────────▶  RX+
TX-  ───────────────────────▶  RX-

RX+  ◀───────────────────────  TX+
RX-  ◀───────────────────────  TX-
```

也就是说：

```text
A 发给 B 用一组差分线。
B 发给 A 用另一组差分线。
两个方向可以同时进行。
```

### ② x1、x4、x8、x16 是什么

```text
PCIe x1  = 1 条 Lane
PCIe x4  = 4 条 Lane
PCIe x8  = 8 条 Lane
PCIe x16 = 16 条 Lane
```

常见用途：

```text
x1：声卡、采集卡、小型网卡
x4：NVMe SSD、扩展卡
x8：高性能网卡、阵列卡
x16：显卡
```

### ③ Lane 聚合

PCIe 可以把多条 Lane 组合成一条更宽的链路：

```text
x4 链路 = 4 条 Lane 同时传输
x16 链路 = 16 条 Lane 同时传输
```

每条 Lane 传输一部分数据，整体带宽叠加。

### ④ Lane 数不一定等于插槽长度

```text
物理插槽可能是 x16 长度。
实际电气连接可能只有 x4 或 x8。
```

所以：

```text
长插槽不一定满速。
要看主板实际布线和 CPU / 芯片组提供的 Lane 数。
```

> [!tip] 记忆口诀
> **一条 Lane 两对线，一对发一对收；x16 就是 16 条 Lane 并行跑。**

---

# 03 | 差分信号：为什么 PCIe 能跑很高速

> [!abstract] 核心结论
> PCIe 使用差分信号传输。数据不是看单根线对地电压，而是看一对线之间的电压差。这样可以提高抗干扰能力，适合高速传输。

### ① 什么是差分信号

普通单端信号：

```text
看一根线相对地是高还是低。
```

差分信号：

```text
看两根线之间谁高谁低。
```

例如：

```text
TX+ 高，TX- 低  → 表示一种状态
TX+ 低，TX- 高  → 表示另一种状态
```

### ② 差分信号的优势

```text
抗干扰能力强。
电磁辐射更低。
适合高速串行传输。
对共模噪声不敏感。
信号完整性更好。
```

### ③ 共模干扰为什么能抵消

如果外界干扰同时加到两根线上：

```text
TX+ 被干扰 +0.1V
TX- 也被干扰 +0.1V
```

因为接收端看的是两者差值：

```text
(TX+ + 0.1V) - (TX- + 0.1V)
```

干扰部分会相互抵消。

### ④ PCIe 对布线要求很高

PCIe 高速差分线需要注意：

```text
差分对等长。
阻抗控制。
减少过孔。
控制走线间距。
避免强干扰源。
注意参考平面连续。
```

如果布线不好：

```text
眼图变差。
误码率升高。
链路降速。
甚至训练失败。
```

> [!tip] 记忆口诀
> **PCIe 看的是两根线的差值，不是单根线的绝对电压；差分抗干扰，高速更稳定。**

---

# 04 | SerDes：并行数据如何变成高速串行数据

> [!abstract] 核心结论
> PCIe 芯片内部通常先产生并行数据，再由 SerDes 转换成高速串行比特流发送出去。接收端再把高速串行比特流恢复成并行数据。

### ① SerDes 是什么

```text
SerDes = Serializer / Deserializer
串行器 / 解串器
```

作用：

```text
发送端：
把内部并行数据转换成高速串行数据。

接收端：
把高速串行数据恢复成内部并行数据。
```

### ② 发送过程

```text
内部并行数据
      ↓
编码 / 加扰
      ↓
Serializer 串行化
      ↓
高速差分信号输出
      ↓
PCIe Lane
```

### ③ 接收过程

```text
PCIe Lane 输入
      ↓
高速差分信号接收
      ↓
时钟数据恢复 CDR
      ↓
Deserializer 解串
      ↓
解码 / 解扰
      ↓
内部并行数据
```

### ④ 为什么需要 SerDes

CPU / 控制器内部更适合并行处理数据：

```text
例如一次处理 32 bit、64 bit、128 bit。
```

但芯片外部高速引脚数量有限：

```text
不可能给每一位都拉一根并行线。
```

所以：

```text
内部并行，外部高速串行。
```

### ⑤ CDR 时钟恢复

PCIe 高速串行传输中，接收端需要从数据流中恢复时钟。

```text
CDR = Clock Data Recovery
```

作用：

```text
从接收到的比特流中恢复采样节拍。
保证接收端在正确时刻采样数据。
```

> [!tip] 记忆口诀
> **芯片里面并行算，出芯片前串行传；SerDes 负责并串转换，CDR 负责找准采样节拍。**

---

# 05 | PCIe 分层结构：事务层、数据链路层、物理层

> [!abstract] 核心结论
> PCIe 不是简单电线传数据，而是一套分层协议。事务层决定“要读写什么”，数据链路层保证“包可靠送达”，物理层负责“比特真正传输”。

### ① PCIe 三层结构

```text
软件 / 驱动
    ↓
事务层 Transaction Layer
    ↓
数据链路层 Data Link Layer
    ↓
物理层 Physical Layer
    ↓
PCIe Lane
```

### ② 事务层

事务层负责生成和解析 TLP。

```text
TLP = Transaction Layer Packet
事务层包
```

常见事务：

```text
Memory Read
Memory Write
Configuration Read
Configuration Write
Message
Completion
```

事务层关心：

```text
访问哪个地址。
读还是写。
数据长度多少。
请求者是谁。
响应发给谁。
```

### ③ 数据链路层

数据链路层负责可靠传输。

它会处理：

```text
序列号。
ACK / NAK。
CRC 校验。
错误检测。
重传机制。
流控信用。
```

### ④ 物理层

物理层负责把数据真正送上 Lane。

它处理：

```text
编码。
加扰。
串并转换。
链路训练。
Lane 对齐。
均衡。
电气信号。
```

### ⑤ 分层的好处

```text
事务层不用关心电压怎么变化。
物理层不用理解操作系统要读哪个文件。
数据链路层专心保证包不丢、不乱。
```

> [!tip] 记忆口诀
> **事务层管读写含义，链路层管可靠传输，物理层管电气比特。**

---

# 06 | TLP 与 DLLP：PCIe 链路上真正传的包

> [!abstract] 核心结论
> PCIe 链路上传输的不是简单“地址线 + 数据线”，而是各种数据包。最重要的是 TLP 和 DLLP：TLP 携带读写事务，DLLP 负责链路控制和可靠性。

### ① TLP 是什么

```text
TLP = Transaction Layer Packet
事务层包
```

它承载真正的读写请求和响应。

常见 TLP：

```text
Memory Read Request
Memory Write Request
Completion
Configuration Read
Configuration Write
Message
```

### ② TLP 里面通常有什么

```text
包头 Header
地址 Address
请求者 ID Requester ID
标签 Tag
字节使能 Byte Enable
数据 Payload
属性 Attribute
校验 ECRC
```

示意：

```text
┌────────┬────────┬────────┬────────┐
│ Header │ Address│ Payload│  ECRC  │
└────────┴────────┴────────┴────────┘
```

### ③ DLLP 是什么

```text
DLLP = Data Link Layer Packet
数据链路层包
```

它不主要承载普通读写数据，而是用于链路管理。

常见 DLLP：

```text
ACK
NAK
Flow Control Update
Power Management
Vendor-specific
```

### ④ TLP 和 DLLP 的关系

```text
TLP：
上层读写事务的数据包。

DLLP：
链路层控制包，用于确认、重传、流控。
```

可以理解为：

```text
TLP 是货物。
DLLP 是物流回执和交通控制。
```

### ⑤ 为什么 PCIe 要用包

因为 PCIe 是串行分组交换结构：

```text
没有传统并行地址线和数据线。
所有信息都要封装进包。
包里带地址、类型、长度、数据和校验。
```

> [!tip] 记忆口诀
> **TLP 装读写事务，DLLP 管确认流控；一个像货物，一个像回执。**

---

# 07 | LTSSM：PCIe 链路如何从上电到可用

> [!abstract] 核心结论
> PCIe 链路上电后不能立刻传业务数据，必须经过链路训练。LTSSM 负责控制链路从检测、训练、协商速度和宽度，到最终进入正常工作状态。

### ① LTSSM 是什么

```text
LTSSM = Link Training and Status State Machine
链路训练与状态状态机
```

它负责：

```text
检测对端是否存在。
协商链路宽度。
协商链路速率。
完成 Lane 对齐。
完成均衡训练。
进入正常传输状态。
```

### ② 常见状态

```text
Detect
Polling
Configuration
L0
Recovery
L1
L2
Disabled
Hot Reset
```

最重要的是：

```text
L0 = 链路正常工作状态。
```

### ③ 链路训练大致过程

```text
1. Detect：
   检测是否有设备连接。

2. Polling：
   双方发送训练序列，确认物理连接。

3. Configuration：
   协商 Lane 数、速率、编号、极性等。

4. L0：
   链路进入正常工作，可以传输 TLP / DLLP。

5. Recovery：
   链路错误、降速、重新均衡时进入恢复状态。
```

### ④ 为什么需要训练

PCIe 是高速串行链路。

不同主板、插槽、设备、走线长度不同，会影响信号质量。

所以需要训练：

```text
确认链路可用。
找到支持的最高速率。
确定实际 Lane 宽度。
调整均衡参数。
保证误码率可接受。
```

### ⑤ 常见现象

```text
显卡插在 x16 插槽，但只跑 x8：
可能是 Lane 协商结果只有 x8。

设备支持 Gen4，但只跑 Gen3：
可能是信号质量、主板、CPU 或设备协商限制。

链路反复掉线：
可能是信号完整性、供电、固件或兼容性问题。
```

> [!tip] 记忆口诀
> **PCIe 上电先训练，协商速度和宽度；进了 L0，才算真正开跑。**

---

# 08 | PCIe 带宽：速率、编码和 Lane 数共同决定

> [!abstract] 核心结论
> PCIe 带宽由单 Lane 速率、编码效率和 Lane 数共同决定。x16 不等于固定带宽，还要看是 Gen3、Gen4、Gen5 还是更高代际。

### ① 带宽计算思路

```text
有效带宽 ≈ 单 Lane 速率 × 编码效率 × Lane 数
```

还要注意：

```text
bit 要换算成 Byte。
8 bit = 1 Byte。
```

### ② 常见代际速率

```text
PCIe Gen1：2.5 GT/s
PCIe Gen2：5.0 GT/s
PCIe Gen3：8.0 GT/s
PCIe Gen4：16.0 GT/s
PCIe Gen5：32.0 GT/s
PCIe Gen6：64.0 GT/s
```

### ③ 编码效率

早期：

```text
Gen1 / Gen2 使用 8b/10b 编码。
每 10 bit 里只有 8 bit 是有效数据。
效率 = 80%
```

Gen3 到 Gen5：

```text
使用 128b/130b 编码。
效率约为 98.46%
```

Gen6：

```text
使用 PAM4 + FLIT + FEC 等机制。
有效带宽计算方式更复杂。
```

### ④ Gen4 x16 大致带宽

```text
Gen4 单 Lane 速率 = 16 GT/s
128b/130b 后有效约 15.754 Gb/s
换算成字节约 1.969 GB/s

x16：
1.969 GB/s × 16 ≈ 31.5 GB/s
```

注意：

```text
这是单方向理论有效带宽。
PCIe 是全双工，双向可以同时传输。
```

### ⑤ 常见理论单方向带宽速查

```text
Gen3 x4  ≈ 3.94 GB/s
Gen3 x16 ≈ 15.75 GB/s

Gen4 x4  ≈ 7.88 GB/s
Gen4 x16 ≈ 31.5 GB/s

Gen5 x4  ≈ 15.75 GB/s
Gen5 x16 ≈ 63.0 GB/s
```

实际应用中还要扣除：

```text
TLP 头部开销。
协议开销。
流控开销。
设备内部瓶颈。
软件栈开销。
访问模式影响。
```

> [!tip] 记忆口诀
> **PCIe 带宽看三件：代际速率、编码效率、Lane 数量；x16 很宽，但还要看 Gen 几。**

---

# 09 | 可靠传输：ACK、NAK、CRC 与重传

> [!abstract] 核心结论
> PCIe 链路层不是盲目发送数据。它会给包编号、做 CRC 校验，并通过 ACK / NAK 机制确认是否需要重传，从而提高链路可靠性。

### ① 为什么需要可靠传输

高速串行链路可能受到：

```text
噪声。
抖动。
信号衰减。
串扰。
连接器损耗。
走线反射。
```

这些都可能导致：

```text
比特错误。
包校验失败。
数据损坏。
```

### ② LCRC 校验

```text
LCRC = Link CRC
链路层循环冗余校验
```

作用：

```text
接收端检查 TLP 在链路上传输过程中是否出错。
```

如果校验通过：

```text
发送 ACK。
```

如果校验失败：

```text
发送 NAK。
请求重传。
```

### ③ ACK / NAK

```text
ACK：
确认收到正确的数据包。

NAK：
表示收到错误或丢失，需要重传。
```

### ④ 重传缓冲

发送端不会发完就忘。

它会保留最近发送但还没确认的 TLP：

```text
等待 ACK 后删除。
收到 NAK 后重传。
超时也可能触发恢复。
```

### ⑤ 这和普通内存总线不同

传统简单并行总线中：

```text
一次读写周期结束就结束。
```

PCIe 中：

```text
链路层会维护可靠传输状态。
像网络一样有确认、校验、重传。
```

> [!tip] 记忆口诀
> **PCIe 像高速网络，发包要校验；ACK 表示收好，NAK 表示重来。**

---

# 10 | PCIe 链路总结

> [!abstract] 核心结论
> PCIe 链路的底层核心是“高速差分 Lane + SerDes + 分层协议 + 包交换 + 链路训练 + 可靠传输”。它不是简单并行总线，而是芯片和设备之间的高速串行网络。

### ① 核心总结

<div style="background-color: #F7F9FC; padding: 15px; border-radius: 8px; border-left: 5px solid #27AE60; color: #333; margin-bottom: 10px;">
<strong>PCIe 链路底层总结：</strong>
<ul>
  <li><strong>本质：</strong> 点对点高速串行链路。</li>
  <li><strong>Lane：</strong> PCIe 最小物理通道，包含发送差分对和接收差分对。</li>
  <li><strong>x1 / x4 / x8 / x16：</strong> 表示 Lane 数量。</li>
  <li><strong>差分信号：</strong> 用两根线的电压差表示信息，抗干扰更强。</li>
  <li><strong>SerDes：</strong> 内部并行数据和外部高速串行信号之间转换。</li>
  <li><strong>事务层：</strong> 生成 TLP，表达读写请求和响应。</li>
  <li><strong>数据链路层：</strong> ACK / NAK、CRC、重传、流控。</li>
  <li><strong>物理层：</strong> 编码、加扰、链路训练、均衡、电气传输。</li>
  <li><strong>LTSSM：</strong> 控制链路训练和状态切换。</li>
  <li><strong>带宽：</strong> 由 PCIe 代际、编码效率和 Lane 数共同决定。</li>
</ul>
</div>

### ② 最底层一句话

```text
PCIe 链路 = 多条高速差分串行 Lane 组成的点对点全双工包交换通道。
```

### ③ 最终记忆口诀

> [!tip] 记忆口诀
> **PCIe 不拉一排地址数据线，而是高速串行发包；Lane 是车道，SerDes 是并串转换，TLP 是货物，DLLP 是回执，LTSSM 先训练，L0 才开跑。**