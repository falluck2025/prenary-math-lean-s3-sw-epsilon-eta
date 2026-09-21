import Mathlib

/-!
Day25-02 · S3-SW · 桥映射与保结构（弱版）

把"数学侧残差与物理侧残差之间存在一个**保结构**的对应"写成可验证命题 ——
**只规定这个对应必须保持哪些性质，不假定它的具体表达式**（弱版口径，老陈 2026-09-19 定）。

理由（老陈原文）：等式 ε = η·κ 是此前的猜测；直接采用会限制后续对
"ε 与 η 究竟如何关联"的寻找。故本步只写"共享结构"。

域：ℂ。与 Day25-01 的同界同开衔接。
-/

namespace PrenaryBridge

/-- 桥映射（弱版）：一个把数学侧残差映为物理侧残差的对应 Φ，
    只要求它保持"非零"与"模小于同一个界"这两条结构性质。 -/
def IsBridgeMap (δ₀ : ℂ) (Φ : ℂ → ℂ) : Prop :=
  ∀ ε : ℂ, ε ≠ 0 → ‖ε‖ < ‖δ₀‖ → (Φ ε ≠ 0 ∧ ‖Φ ε‖ < ‖δ₀‖)

/-- 定理 1（保非零）：桥映射把非零残差映为非零残差。 -/
theorem bridgeMap_preserves_nonzero {δ₀ : ℂ} {Φ : ℂ → ℂ} (h : IsBridgeMap δ₀ Φ)
    {ε : ℂ} (hε : ε ≠ 0) (hb : ‖ε‖ < ‖δ₀‖) : Φ ε ≠ 0 :=
  (h ε hε hb).1

/-- 定理 2（同界）：桥映射下，物理侧残差仍受同一个界 ‖δ₀‖ 约束。 -/
theorem bridgeMap_same_bound {δ₀ : ℂ} {Φ : ℂ → ℂ} (h : IsBridgeMap δ₀ Φ)
    {ε : ℂ} (hε : ε ≠ 0) (hb : ‖ε‖ < ‖δ₀‖) : ‖Φ ε‖ < ‖δ₀‖ :=
  (h ε hε hb).2

/-- 定理 3（复合保结构）：两个桥映射的复合仍是桥映射。 -/
theorem bridgeMap_comp {δ₀ : ℂ} {Φ Ψ : ℂ → ℂ}
    (hΦ : IsBridgeMap δ₀ Φ) (hΨ : IsBridgeMap δ₀ Ψ) :
    IsBridgeMap δ₀ (Ψ ∘ Φ) := by
  intro ε hε hb
  obtain ⟨h1, h2⟩ := hΦ ε hε hb
  exact hΨ (Φ ε) h1 h2

/-- 定理 4（退化面：恒等对应）：若两侧同一（对应取恒等），则它也是一个桥映射 ——
    这是"两侧重合"的退化情形。 -/
theorem identity_is_bridgeMap (δ₀ : ℂ) : IsBridgeMap δ₀ id := by
  intro ε hε hb
  exact ⟨hε, hb⟩

end PrenaryBridge
