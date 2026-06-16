# qingshan-skills

面向 AI 编程 agent 的轻量软件开发方法论。把 gstack、Superpowers、GSD、Matt Pocock's skills 的精华提炼成 6 个 skill，围绕八条主线展开：**保留工程控制权、外科手术式改动、按风险分级流程、共享领域语言、紧反馈环、TypeScript 纪律、新鲜上下文、先验证再下结论**。

qingshan-skills 不是要接管完整开发流程，而是提供最小的工程保护层：帮助 agent 明确目标、守住范围、建立证据、保持上下文质量，并把高影响决策留给用户和工程师。

## 核心约束

- 用能保护正确性的最轻流程，不为流程本身增加重量。
- 保留用户和工程师控制权，不让 agent 偷走产品、架构、发布或不可逆决策。
- 优先纵向切片和可验证反馈环，避免按层堆大计划。
- 用共享领域语言减少误解；`CONTEXT.md` 只作为 glossary，不作为 spec、草稿或决策日志。
- Bug、性能、部署和稳定性问题先建立事实与基线，再谈修复。
- 完成、修复、发布、优化等结论必须有新鲜验证证据。

## 使用方式

qingshan-skills 不是一组孤立命令，而是一条轻量路由规则。每次软件工程任务先从根目录 [`SKILL.md`](SKILL.md) 进入，读取 [`ETHOS.md`](ETHOS.md) 的共同约束，再按任务形状选择最小可用流程。

1. 判断任务形状：是目标不清、需要计划、准备修改、故障诊断、完成证明，还是复盘沉淀。
2. 选择入口 skill：低风险任务直接进入能解决问题的最短路径；中高风险任务先补足理解、计划、证据或回滚思考。
3. 执行对应 skill 的 `Workflow`：每个 skill 都有触发条件、风险门槛、硬规则、输出和交接方式。
4. 在 skill 之间交接：`/clarify` 产出清晰目标，`/plan` 产出可执行计划，`/execute` 完成改动，`/verify` 证明结论，`/reflect` 只记录可复用学习。
5. 任何“完成、修复、通过、发布、优化、待评审”的结论，都必须先经过 `/verify` 的新鲜证据。

### 路由速查

| 任务信号 | 入口 skill | 典型后续 |
| --- | --- | --- |
| 目标、范围、验收标准、术语或用户决策不清 | [`/clarify`](skills/clarify/SKILL.md) | 低风险到 `/execute`；需要拆解到 `/plan` |
| 目标已清楚，但需要拆任务、排顺序、分级决策或设计验证方式 | [`/plan`](skills/plan/SKILL.md) | `/execute → /verify` |
| 已有明确计划，需要改代码、配置、文档、工具或项目结构 | [`/execute`](skills/execute/SKILL.md) | `/verify` |
| Bug、失败测试、性能、部署、安全、稳定性或未知根因 | [`/investigate`](skills/investigate/SKILL.md) | 根因清楚后到 `/plan` 或 `/execute` |
| 准备声明完成、修复、通过、发布、优化或待评审 | [`/verify`](skills/verify/SKILL.md) | 有可复用经验时到 `/reflect` |
| 已验证的工作产生可复用经验、项目不变量、验证命令或 durable decision | [`/reflect`](skills/reflect/SKILL.md) | 更新最小持久化 artifact，或明确跳过 |

### 风险分级

| 风险 | 用法 |
| --- | --- |
| 低风险 | 用最短路径处理，例如 `/clarify → /execute → /verify`；不写重型计划 |
| 中风险 | 明确目标、任务顺序、决策分级和验证策略，例如 `/clarify → /plan → /execute → /verify` |
| 高风险 | 先建立证据、回滚或失败处理；必要时使用新上下文子代理、TDD、对抗性评审和发布检查 |

风险会因为跨模块、不可逆、用户可见、安全、部署、性能、架构或需求不清而上升。风险只决定流程重量，不取消硬规则。

### 决策分级

| 决策类型 | 处理方式 |
| --- | --- |
| Mechanical | 按项目既有模式直接决定，不打断用户 |
| Taste | 批量给出推荐方案、取舍和可逆性 |
| User Challenge | 停下来让用户明确拍板，例如架构方向、产品行为、不可逆数据或发布风险 |

## Skill 功能详解

每个 skill 都围绕「它防止的失败」组织。TDD 是 `/execute` 内高风险变更的默认模式；代码评审是 `/verify` 的一个维度；发布是 `/verify` 通过后的路径。这三者都内嵌进现有 skill，不单独成 skill。

### `/clarify`

防止 agent 在只“以为自己理解”的情况下开工。它用于目标、范围、约束、验收标准、术语、权衡或用户决策边界不清的任务。

核心动作：

- 先读相关代码、文档和已有上下文，避免问代码能回答的问题。
- 明确目标、非目标、约束、验收标准和任务风险。
- 对领域词汇做 shared language 检查；`CONTEXT.md` 只作为 glossary。
- 对中高风险任务给出方案取舍和推荐；高影响决策必须留给用户。

产出：任务类型、风险等级、目标和非目标、验收标准、术语澄清、开放决策，以及可交给 `/plan` 或 `/execute` 的轻量目标陈述。

### `/plan`

防止范围漂移和静默替用户做高影响决策。它用于目标已清楚，但需要拆解、排序、决策分级、验证策略或回滚思考的任务。

核心动作：

- 列出会触碰和应保护的文件、模块或边界。
- 把决策分为 Mechanical、Taste、User Challenge。
- 对 Taste 和 User Challenge 决策写 Decision Brief，说明推荐方案、替代方案、取舍、可逆性和覆盖差异。
- 优先拆成可独立验证的纵向切片，避免按技术层横向堆计划。
- 对部署、数据、安全、架构等高风险变更补充回滚或失败处理。

产出：有顺序的任务、影响范围、受保护范围、决策分级、验证策略、必要的回滚说明，以及可直接交给 `/execute` 的计划。

### `/execute`

防止执行时偏离计划、过度工程化或上下文腐化。它用于实现已明确的代码、配置、文档、工具或项目结构变更。

核心动作：

- 重新确认计划、约束、受保护文件和验证要求。
- 运行 Context Gate，判断当前上下文是否足够；风险高时用窄任务交给新上下文。
- 做最小修改，只触碰当前任务需要的文件。
- 高风险代码变更按 TDD 纵向切片执行：一个行为、一个失败测试、一个最小实现。
- 不顺手重构、不引入 speculative abstraction、不吞错误、不忽略 Promise。

产出：变更文件、为什么这样改、验证命令和结果、未解决风险，以及交给 `/verify` 的可检查状态。

### `/investigate`

防止在没有事实的情况下猜修。它用于 bug、失败测试、回归、性能、部署、CI、安全、稳定性或未知根因问题。

核心动作：

- 先定义症状和期望行为。
- 建立最快、可靠、可重复的反馈环；弱反馈环先强化再下结论。
- 复现或观察失败，收集测试、日志、指标、trace、配置或代码路径证据。
- 缩小失败面，形成 3 到 5 个可证伪假设，并逐一验证最强假设。
- 性能问题必须有 baseline；部署问题必须说明环境边界；安全和稳定性问题必须说明威胁或失败模型。

产出：复现或观察方法、反馈环质量、已收集事实、缩小后的失败面、根因假设和信心、最小修复路径。

### `/verify`

防止把“看起来对”当成“已经完成”。它用于任何完成、修复、通过、发布、优化或待评审声明之前。

核心动作：

- 找到能证明结论的命令、检查或 artifact，并运行新鲜验证。
- 读取输出和退出码，不把旧结果或实现者报告当证据。
- 做 Scope Drift Detection，对照任务、计划和 diff 判断 Delivered、Missing、Extra、Changed 或 Unverifiable。
- 中高风险或发布路径使用 Review Readiness Dashboard。
- 对认证、数据迁移、并发、支付、部署、LLM 信任边界、大型跨模块 diff 等高风险变更做 Adversarial Review。

产出：验证命令和结果、验收状态、范围漂移检查、必要的评审面板、残余风险，以及是否可以真实声明完成。

### `/reflect`

防止同样的坑反复出现，也防止知识库被流水账污染。它只在已验证工作产生可复用学习时使用。

核心动作：

- 判断结果是 reusable lesson、durable decision、两者都有，还是不值得沉淀。
- 用 Memory Promotion Gate 决定记录层级：当前任务、项目上下文、项目学习、全局记忆或 skill 规则。
- durable decision 必须记录日期、范围、理由、被拒绝方案和反转条件。
- glossary 只记录稳定领域术语或已解决歧义；ADR 只记录难反转、无上下文会意外、且来自真实取舍的决策。
- 选择最小持久化 artifact，避免 session journal 和一次性观察。

产出：可复用经验、未来触发条件、必要的 glossary 或 durable decision、更新的 artifact，或明确说明无需沉淀。

## 操作流程

### 默认流程

```text
/clarify -> /plan -> /execute -> /verify -> /reflect
      \                         ^
       -> /investigate -> /plan |
```

`/investigate` 可以在任意阶段切入，诊断清楚后回到 `/plan` 再 `/execute`。用根目录 `SKILL.md` 作为会话引导与路由入口，`ETHOS.md` 作为各 skill 共享的约束层。

### 常见路径

按场景选最轻量的流程，不必每次走完全程：

| 场景 | 路径 |
| --- | --- |
| 小幅文档改动 | `/clarify → /execute → /verify` |
| Bug 修复 | `/investigate → /execute → /verify` |
| 性能调优 | `/investigate → /plan → /execute → /verify` |
| 大型跨模块工作 | `/clarify → /plan → /execute`（交给新上下文子代理）`→ /verify → /reflect` |

## 工程支撑模板

仓库在 [`docs/templates/`](docs/templates/) 下提供轻量模板，只在对应 workflow 需要时使用：

- `decision-brief.md`：Taste 或 User Challenge 决策说明。
- `fresh-context-packet.md`：给新上下文 worker / reviewer 的窄任务输入包。
- `release-checklist.md`：`/verify` 内的发布、PR、部署或交接检查，不是新的 `/ship` skill。
- `durable-decision.md`：`/reflect` 确认需要沉淀的 durable decision。
- `context-glossary.md`：需要建立项目共享术语时的 `CONTEXT.md` 形状。
- `runtime-bootstrap.md`：不直接读取 Agent Skills 的运行时加载根 router 的最小包装。

根目录 [`CONTEXT.md`](CONTEXT.md) 是本仓库自己的 glossary，只记录稳定术语和已解决歧义，不记录计划、实现细节或决策日志。

## 安装

qingshan-skills 与具体运行时无关，本质是让 agent 运行时读到根 skill 和六个 workflow skill。对 Claude Code 与 Codex，用仓库根目录的同步脚本建立全局链接：

```bash
bash scripts/sync-global-skills.sh
```

脚本会把 `qingshan-skills`、`clarify`、`plan`、`execute`、`investigate`、`verify`、`reflect` 链接到 Claude Code 与 Codex 的全局 skill 目录。移动仓库后重新运行即可；若目标位置已存在且冲突，加 `--force` 可先把旧目标移到备份再链接。其他运行时与详细选项见 [`docs/installation.md`](docs/installation.md)。

核心 `SKILL.md` 只保留跨运行时通用的 `name` 与 `description` frontmatter。Claude Code、Codex、Cursor 等工具的专属字段、插件 manifest、hooks、规则包装或 UI 元数据属于运行时适配层，不应写进核心 skill。边界见 [`docs/runtime-adapters.md`](docs/runtime-adapters.md)。

## 验证

```bash
bash scripts/validate-skills.sh
```

预期输出：

```text
OK qingshan-skills validation passed
```

校验内容包括必需文件、skill 的 YAML frontmatter、必需章节、模板、prompt 护栏，以及带 Required signals 的压测场景。

行为回归使用 transcript artifact：

```bash
bash scripts/validate-behavior-tests.sh
```

测试分层和 ACP 边界见 [`docs/testing.md`](docs/testing.md)。ACP 属于未来 runtime adapter 集成测试，不是核心 skill 语义测试的第一层。设计依据见 [`docs/superpowers/specs/`](docs/superpowers/specs/) 下的权威设计文档。
