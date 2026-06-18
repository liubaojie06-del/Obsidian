---
tags:
  - PLC
  - TIA_Portal
  - Energy_Suite
  - Energy_Suite扩展
  - 能效评估
  - 能源管理
  - 设备能效
  - 西门子
aliases:
  - Energy Suite 扩展
  - Energy Suite Extension
  - EnS_EEm_Calc
  - EnS_EEm_Report
  - 设备的能效评估
  - 能效评估计算
  - 能效评估报表
---
## 01 `EnS_EEm_Calc` | 统一采集和评估设备能效

> [!info] 核心结论
> **EnS_EEm_Calc** 用于对设备能效数据进行统一采集、计算和评估，是设备能效分析的核心计算类指令。

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">版本</strong><br>
分类版本：<strong>V3.3</strong><br>
指令版本：<strong>V3.3</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **Energy Suite 扩展 / 设备的能效评估** |
| 指令名称 | **EnS_EEm_Calc** |
| 功能描述 | **统一采集和评估设备能效数据** |
| 版本 | **V3.3** |
| 核心作用 | 能效数据采集、计算、评估 |
| 使用重点 | 能耗数据、产量数据、运行状态、统计周期需按实际项目校核 |

<div style="background:#F7F9FC;border-left:6px solid #FF6B35;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#FF6B35;">重点公式</strong><br>
单位能耗 = 总能耗 ÷ 产量
</div>

### ② 参考表

| 评估对象 | 说明 |
|---|---|
| 能耗数据 | 电能、气、水、蒸汽等能源消耗 |
| 产量数据 | 产品数量、批次数、加工量 |
| 运行状态 | 运行、待机、停机、故障 |
| 统计周期 | 班次、日、周、月或批次 |
| 能效结果 | 单位能耗、能效等级、趋势变化 |
| 参数细节 | 需按实际 Energy Suite 配置/厂家手册校核 |

### ③ 计算/选型示例

- 已知：设备一班消耗电能 `120 kWh`，产量 `600 件`
- 公式：`单位能耗 = 总能耗 ÷ 产量`
- 计算：`120 ÷ 600 = 0.2 kWh/件`
- 结论：该班次设备单位能耗为 **0.2 kWh/件**，可用 **EnS_EEm_Calc** 做能效评估

> [!tip] 记忆口诀
> **算能效看两件：用了多少能，产了多少货。**


## 02 `EnS_EEm_Report` | 将设备的能效评估导出

> [!info] 核心结论
> **EnS_EEm_Report** 用于将设备能效评估结果生成或导出报表，适合能耗分析、节能管理和生产追溯。

<div style="background:#F7F9FC;border-left:6px solid #27AE60;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#27AE60;">版本</strong><br>
指令版本：<strong>V3.0</strong>
</div>

### ① 分类/公式/规则

| 项目 | 内容 |
|---|---|
| 所属分类 | **Energy Suite 扩展 / 设备的能效评估** |
| 指令名称 | **EnS_EEm_Report** |
| 功能描述 | **将设备的能效评估导出** |
| 版本 | **V3.0** |
| 核心作用 | 生成/导出设备能效评估报表 |
| 说明 | 截图描述有省略，完整导出格式和参数需按实际软件/厂家手册校核 |

<div style="background:#F7F9FC;border-left:6px solid #9B59B6;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#9B59B6;">重点规则</strong><br>
计算结果要落地，报表要能看出：<strong>能耗多少、效率如何、哪里异常、是否改善</strong>。
</div>

### ② 参考表

| 报表内容 | 说明 |
|---|---|
| 能耗汇总 | 某周期内总能耗 |
| 单位能耗 | 每件产品、每批次或每工序能耗 |
| 运行状态统计 | 运行、待机、停机时间 |
| 能效趋势 | 不同周期的能耗变化 |
| 异常记录 | 能耗过高、效率下降等 |
| 导出要求 | 文件路径、格式、权限需按项目校核 |

### ③ 计算/选型示例

- 已知：设备已完成一周能效统计，需要生成能效分析文件
- 公式/规则：能效结果导出用 **EnS_EEm_Report**
- 操作：选择统计周期、报表对象和导出路径
- 结论：系统生成设备能效评估报表，便于管理人员分析节能效果

> [!tip] 记忆口诀
> **Calc 负责算能效，Report 负责出报表。**


## 03 Energy Suite 扩展 | 选型速记

> [!info] 核心结论
> Energy Suite 扩展的核心是：**先用 EnS_EEm_Calc 采集计算能效，再用 EnS_EEm_Report 导出评估结果。**

<div style="background:#F7F9FC;border-left:6px solid #173B63;padding:12px;border-radius:12px;margin:10px 0;">
<strong style="color:#173B63;">总口诀</strong><br>
能效先计算，结果再报表；Calc 算数据，Report 出结论。
</div>

### ① 分类/公式/规则

| 类型 | 常用指令 |
|---|---|
| 能效采集与计算 | **EnS_EEm_Calc** |
| 能效评估报表 | **EnS_EEm_Report** |

### ② 参考表

| 需求 | 推荐指令 |
|---|---|
| 采集设备能耗数据 | **EnS_EEm_Calc** |
| 计算单位能耗 | **EnS_EEm_Calc** |
| 评估设备能效 | **EnS_EEm_Calc** |
| 导出能效评估结果 | **EnS_EEm_Report** |
| 生成能耗分析报表 | **EnS_EEm_Report** |
| 做节能改善追踪 | **Calc + Report** |

### ③ 计算/选型示例

- 已知：工厂想统计某设备每班次单位能耗，并形成报表
- 公式：`单位能耗 = 总能耗 ÷ 产量`
- 操作：用 **EnS_EEm_Calc** 采集并计算能效；用 **EnS_EEm_Report** 导出评估结果
- 结论：这是典型的设备能效评估与报表输出流程

> [!tip] 记忆口诀
> **采集计算用 Calc，分析输出用 Report；能效管理先有数，再有表。**