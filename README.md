[![DOI](https://zenodo.org/badge/DOI/DOI-TBD.svg)](https://doi.org/DOI-TBD)

# 偏元数学 · Day25 · ε↔η 映射（共享结构 · 同界 · 同退化）· Lean 4 形式化验证

## Prenary Mathematics · Day25 · The ε↔η Mapping: Shared Structure · Common Bound · Common Degeneration · Lean 4 Formal Verification

本文工作尚未得到独立实验验证，全部结论均为形式化验证层面的初步结果。

> **DOI**：`DOI-TBD`（**发布后回填本行与顶部徽章**）。本仓库为偏元数学 S3（第三程）横向推进的第一小步，上承 Day24 `prenary-math-lean-s3-complexification`（[10.5281/zenodo.22815027](https://doi.org/10.5281/zenodo.22815027)）与 Day23 `prenary-math-lean-s2-residual-scaling`（[10.5281/zenodo.22813242](https://doi.org/10.5281/zenodo.22813242)）。

## 摘要

本仓库在 S3 的**复数域基底**上，把"数学侧残差 ε 与物理侧超额 η 的对应"立为**可验证的弱结构**——只规定两侧必须共享哪些性质，**不假定映射的具体形式**。

**一、同界同开（Day25-01）**：在 ℂ 上，两侧（ε、η）共用同一个非零界 δ₀，且两侧都非零、模都严格小于 ‖δ₀‖（δ₀ 不可达）。δ₀ = 0 时桥为空，两侧同时退回经典。**"开"在 ℂ 上读作"模严格小于"（开球内）**，与 004 的"上界不可达"一致；ℝ 是"方向为零"处的退化面。

**二、桥映射（Day25-02）**：把"两侧残差之间存在保结构的对应"写成 `IsBridgeMap`——只要求它保持"非零"与"模小于同一个界"两条性质，**不假定表达式**；并给出复合封闭与退化面（恒等对应）。

**口径（2026-09-19 定）**：共享结构 + 同界 + 同退化。**明确不采用等式 ε = η·κ**——那是此前的猜测，若直接写死，会把"ε 与 η 究竟如何关联"这一待探索对象提前锁死。

**不在范围内**：不给映射的具体表达式（尤其**不用 ε = η·κ**）；不触及物理载体（如 θ_bias 的具体形式）；不证 K0；不含统计命题（G4）；**不主张**任何物理量的数值对应。

## Abstract

On the S3 **complex-domain foundation**, this repository makes the correspondence between the mathematical-side residual ε and the physical-side excess η a **verifiable weak structure** — specifying only which properties the two sides must share, and **not assuming the form of the map**.

**I. Common bound & openness (Day25-01)**: over ℂ the two sides (ε, η) share one nonzero bound δ₀, are both nonzero, and both have modulus strictly less than ‖δ₀‖ (δ₀ unreachable). When δ₀ = 0 the bridge is empty (degeneration to classical). **Over ℂ, "open" reads as "modulus strictly less" (inside the open ball)**; ℝ is the degenerate face at zero direction.

**II. Bridge map (Day25-02)**: the "structure-preserving correspondence between the two sides" is written as `IsBridgeMap` — required only to preserve *nonzero* and *modulus below the common bound*, with **no expression assumed**; plus closure under composition and the degenerate face (identity).

**Stance (fixed 2026-09-19)**: shared structure + common bound + common degeneration. **The equation ε = η·κ is deliberately NOT adopted** — it was a prior guess, and committing to it would lock the yet-to-be-found relation between ε and η.

**Out of scope**: no explicit expression of the map (in particular **no ε = η·κ**); no physical carrier (e.g. the form of θ_bias); no proof of K0; no statistical statements (G4); **no** numerical correspondence to physical quantities.

## 关键词

偏元数学；ε↔η映射；共享结构；同界；同退化；桥结构；桥映射；复数域；上界不可达；退化链；Lean 4；形式化验证；陈偏贞；老陈与AI的深夜实验室；PGI蛟龙；华夏思哲偏元注

## 概述

偏元数学是对经典数学的扩展尝试，ε = 0 时退化为经典。

S3 已把动作层升到 ℂ（Day24）。**但"数学侧的 ε 与物理侧的 η 到底怎么对应"，此前只有猜测（ε = η·κ）。** 本仓库把这一步退回"只立共享结构"：

- **两侧的残差域是同一个**（同一个界 δ₀、同为"开"——模严格小于 ‖δ₀‖、两侧都非零）；
- **两侧之间的对应只规定必须保持的性质，不规定形式**。

这样，"ε 与 η 究竟如何关联"留作后续可探索的对象，而不是提前锁死。这一步是 S3 横向推进的**地基**，不宣称任何映射已被找到。

> **后续**：本仓的**数学侧对应**见 Day26 `prenary-math-lean-s3-direction-return`（对象层 `ℂ★` · 二态 · 偏元序）。两者互为支撑，但**发布文案不互相越读**——本仓仍不宣称 ε 与 η 的具体关系已给出。

## 核心定义

```lean
-- 桥结构（复数版）：两侧共用同一个非零界 δ₀，都非零，模都严格小于 ‖δ₀‖
def IsBridge (δ₀ ε η : ℂ) : Prop :=
  δ₀ ≠ 0 ∧ ε ≠ 0 ∧ η ≠ 0 ∧ ‖ε‖ < ‖δ₀‖ ∧ ‖η‖ < ‖δ₀‖

-- 桥映射（弱版）：只要求保持"非零"与"模小于同一个界"，不假定表达式
def IsBridgeMap (δ₀ : ℂ) (Φ : ℂ → ℂ) : Prop :=
  ∀ ε : ℂ, ε ≠ 0 → ‖ε‖ < ‖δ₀‖ → (Φ ε ≠ 0 ∧ ‖Φ ε‖ < ‖δ₀‖)
```

## 定理清单

> **如实说明**：两份文件是同一结构（桥）的两面——Day25-01 是**静态约束**（两侧残差域相同），Day25-02 是**对应关系**（保结构映射）。命题均为**结构性**的（不涉及数值），**不构成**关于 ε 与 η 具体关系的断言。

### Day25-01 · `Day25-01_两侧同界同开闭与退化_LEAN源码_20260919.lean`（4 条）

| 定理 | 命题 |
|:--|:--|
| `both_norm_lt` | 同界同开：`‖ε‖ < ‖δ₀‖ ∧ ‖η‖ < ‖δ₀‖` |
| `both_nonzero` | 两侧都非零：`ε ≠ 0 ∧ η ≠ 0` |
| `bound_nonzero` | 界非零：`δ₀ ≠ 0` |
| `no_bridge_at_zero` | 退化：`δ₀ = 0` 时桥为空 `¬ IsBridge 0 ε η` |

### Day25-02 · `Day25-02_桥映射与保结构_LEAN源码_20260919.lean`（4 条）

| 定理 | 命题 |
|:--|:--|
| `bridgeMap_preserves_nonzero` | 保非零：`Φ ε ≠ 0` |
| `bridgeMap_same_bound` | 同界：`‖Φ ε‖ < ‖δ₀‖` |
| `bridgeMap_comp` | 复合保结构：`IsBridgeMap δ₀ (Ψ ∘ Φ)` |
| `identity_is_bridgeMap` | 退化面：恒等对应也是桥映射 `IsBridgeMap δ₀ id` |

## 验证记录

| 文件 | 内核 | Comparator | Challenge Hash（锁挑战） | 代码 SHA256（锁解答） |
|:--|:--|:--|:--|:--|
| Day25-01 | No goals + All Messages (0) | ✅ Successfully validated | `84f408ac2fa86f98615f1cf5bd83f22382d09fb7b975ff845b5b8565eba1fe91` | 同左 |
| Day25-02 | No goals + All Messages (0) | ✅ Successfully validated | `65ae32b45026f591c14ec4612a7967febdbddbdb82870db5d28af08ee2d0df1d` | 同左 |

- **平台**：L∃∀N Comparator Live (Experimental) · Latest Mathlib with Lean v4.35.0
- **验证时间**：2026-09-19 11:55–11:56
- **双哈希说明**：本组采用**自编 challenge** 模式（Challenge 文本 = 我方提交代码），故 **Challenge Hash 与代码 SHA256 取同一值**；已用本地 `sha256sum` 与 Comparator 显示值**逐字核对一致**。

## 文件说明

```
.
├── Day25-01_两侧同界同开闭与退化_LEAN源码_20260919.lean   # 同界同开 + 退化（4 条）
├── Day25-02_桥映射与保结构_LEAN源码_20260919.lean          # 桥映射 + 保结构（4 条）
├── README.md
├── LICENSE
└── evidence/                                               # 验证截图（内核 / Comparator）
```

## 复现方式

1. 打开 `https://comparator.live.lean-lang.org/`（Latest Mathlib with Lean v4.35.0）。
2. 将对应 `.lean` 文件**整份复制**（Ctrl+A，含 `import Mathlib` 与 `/-!` 抬头），分别贴入 **Challenge** 与 **Candidate Solution** 面板。
3. 运行内核，确认 `All Messages = 0`；再点二次验证，应显示 `Trusting challenge with hash <SHA256>` 且结果为通过。
4. 用 `sha256sum <file>.lean` 计算本地哈希，应与上表 Challenge Hash **逐字一致**。

## 可证伪条件

本仓库的结论**可被如下任一事实推翻**：

1. 若两侧**并不共用**同一个界（即存在 ε 或 η 突破 ‖δ₀‖），则"同界"失效。
2. 若"开"不成立（即 δ₀ 可达，‖ε‖ = ‖δ₀‖ 或 ‖η‖ = ‖δ₀‖ 可实现），则"同开"失效。
3. 若 δ₀ = 0 时仍可构造出非空桥，则退化命题失效。
4. **弱版口径下，本仓不预言 ε 与 η 的具体关系**——因此它**不能被用来支持** ε = η·κ 或任何显式形式；若有人据此宣称"ε 与 η 的关系已被证明"，即为对本仓的越读。

## 作者致谢许可

- 许可：**CC BY-NC-ND 4.0**
- 署名：**陈松（Chen Song）**
- ORCID：**0009-0002-9510-2239**
- 依托个人研究项目"偏元数学"推进；形式化验证平台：Lean 4 / Mathlib（L∃∀N Comparator Live）。

## 作者备注

- 本仓库是**形式化验证层面的初步结果**，未经独立实验验证；结论以"Lean 内核编译通过 + Comparator 独立二次验证通过 + 双哈希一致"为准。
- **DOI**：`DOI-TBD`（发布后回填）。
- **口径备忘**：本步采用"共享结构 + 同界 + 同退化"弱版；`ε = η·κ` 为历史猜测，**本仓刻意不采用**，以免提前锁死 ε 与 η 的关联形式。
- 抬头的源码文件中**不写 DOI / 版本**等会随发布变动的字段——以保证"二次验证哈希 = 落盘 SHA256"。

---

**老陈与AI的深夜实验室 发布 请笑纳**
