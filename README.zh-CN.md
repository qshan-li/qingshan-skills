[English](./README.md) · **简体中文**

# qingshan-skills

面向 AI 编程助手（下面统称 agent）的一套轻量软件开发方法论。它把四个知名方法论——gstack、Superpowers、GSD、Matt Pocock's skills——的精华提炼成 6 个 skill（即方法论里的 6 个步骤/命令），只追求一件事：**让 agent 干活靠谱——不跑偏、不乱改、做完能拿出证据**。具体落在八条主线上：保留工程控制权、外科手术式改动（只动该动的代码）、按风险分级流程、统一团队用语、紧反馈环、贴合语言生态的类型安全、新鲜上下文（重活交给干净的子会话去做）、先验证再下结论。

qingshan-skills 不会接管完整开发流程，它只是一层"最小的工程护栏"：帮 agent 把目标弄清楚、把范围守住、用证据说话、防止上下文越聊越乱，并把那些影响大的决策（架构、发布、不可逆操作）交还给用户和工程师来定。

## 核心约束

- 用"能保证正确性"的最轻流程，不为流程本身增加负担。
- 把控制权留在用户和工程师手里，不让 agent 偷偷替你做产品、架构、发布或不可逆的决定。
- 优先做"端到端能验证的小切片"（纵向切片），避免按技术层把大计划堆在一起。
- 用统一的团队用语减少误解；确认稳定的术语写进 `CONTEXT.md`——注意它只当术语表（glossary）用，绝不拿来做规格说明（spec）、草稿或决策日志。
- 遇到 Bug、性能、部署、稳定性问题，先把事实和基线搞清楚，再谈怎么修。
- 任何"完成、修复、通过、发布、优化"的结论，都必须有刚跑出来的验证证据撑着。

## 使用方式

qingshan-skills 不是一堆互不相干的命令，而是一条"看情况选最轻流程"的路由规则。每次接到软件工程任务，都先从根目录的 [`SKILL.md`](SKILL.md) 进入，读一遍 [`ETHOS.md`](ETHOS.md) 里的共同约束，再按任务的形状挑最够用的那条流程。

1. 判断任务的形状：是目标不清、需要计划、准备改代码、排查故障、要完成证明，还是做复盘沉淀。
2. 按 Memory Retrieval Gate 按需取记忆：只读和当前任务相关的 `CONTEXT.md`、`LEARNINGS.md`、决策记录或全局记忆片段——按任务类型、风险、技术栈、产物、失败模式或决策边界来匹配，绝不一股脑全读。
3. 选入口 skill：低风险任务直接走能解决问题的最短路径；中高风险任务先把理解、计划、证据或回滚思路补齐。
4. 执行该 skill 的 `Workflow`：每个 skill 都写明了触发条件、风险门槛、硬规则、产出和交接方式。
5. 当原始请求要的是完整结果、边界仍然清晰、所有 Taste 决策都已明确批准、且不存在 User Challenge 或缺失的前置条件时，可以跨常规 handoff 一路做下去；如果只调用了某个阶段，那做完这个阶段就把控制权交回。遇到需要停下、给出下一步选项的交接时，Claude Code 会先弹 `AskUserQuestion`、Codex 会先调 `request_user_input`（都把推荐路线放第一项）再写正文；运行时若不支持原生输入，就用编号或标签选项，省得用户手动敲 skill 命令。
6. 只有"重复性、自动化、新上下文、多 agent、迁移或大规模重复"这类工作才需要 Loop Contract（循环契约）。普通的一次性任务靠目标、验收标准、边界和证据就够了。
7. 任何"完成、修复、通过、发布、优化、待评审"的结论，都必须先过 `/verify` 这一关、拿出新鲜证据；`/verify` 也是清理临时任务状态的唯一入口。

### 路由速查

| 任务信号 | 入口 skill | 典型后续 |
| --- | --- | --- |
| 目标、范围、验收标准、术语或用户决策不清 | [`/clarify`](skills/clarify/SKILL.md) | 低风险到 `/execute`；需要拆解到 `/plan` |
| 想读懂一个项目/目录/模块，要一份结构地图和不确定项清单 | [`/clarify`](skills/clarify/SKILL.md) | 继续 `/clarify`，或下一步明确后进 `/plan`、`/investigate`、`/execute` |
| 目标已清楚，但需要拆任务、排顺序、给决策分级或设计验证方式 | [`/plan`](skills/plan/SKILL.md) | `/execute → /verify` |
| 依赖或工具链升级 | [`/plan`](skills/plan/SKILL.md) | 控制影响范围（blast radius）、兼容性影响和验证路径 |
| 已有明确计划，要改代码、配置、文档、工具或项目结构 | [`/execute`](skills/execute/SKILL.md) | 就地完成，或转 `/verify` |
| Bug、失败测试、性能、部署、安全、稳定性或未知根因 | [`/investigate`](skills/investigate/SKILL.md) | 根因清楚后到 `/plan` 或 `/execute` |
| 想改进测试，但有覆盖缺口（coverage gap）、信号时好时坏（flaky）或失败行为没看懂 | [`/investigate`](skills/investigate/SKILL.md) | 先确认是不是真信号，再到 `/plan` 或 `/execute` |
| 代码评审、PR/diff 评审、实现或规格（spec）评审 | [`/verify`](skills/verify/SKILL.md) | 做范围/质量评审，并报告残余风险 |
| 准备宣布完成、修复、通过、发布、优化或待评审 | [`/verify`](skills/verify/SKILL.md) | 若产生了可复用经验，转 `/reflect` |
| 发布、上线、出包、提 PR、合并、发版（ship/deploy/publish/PR/merge/release） | [`/verify`](skills/verify/SKILL.md) | 发布路径验证就绪、Taste 已批准且无 User Challenge 后，才执行或交接"机械的发布动作" |
| 已验证的工作带来了可复用经验、项目不变量、验证命令或持久决策（durable decision） | [`/reflect`](skills/reflect/SKILL.md) | 更新最小的持久化产物，或明确跳过 |

### 风险分级

| 风险 | 用法 |
| --- | --- |
| 低风险 | 走最短路径，例如 `/clarify → /execute`；只有满足"局部完成出口（Local Completion Exit）"条件时才就地收尾 |
| 中风险 | 先把目标、任务顺序、决策分级和验证策略理清，例如 `/clarify → /plan → /execute → /verify` |
| 高风险 | 先把证据、回滚或失败处理准备好；按需启用新上下文子会话、TDD、对抗性评审和发布检查 |

风险分级用的是"保底下限（floor）"，不是开放式打分：涉及安全、密钥、不可逆数据或真实发布动作的，至少算高风险；跨模块、或用户可见的多方案选择，至少算中风险。在够用的前提下选最轻的等级，但不能低于对应的下限。风险只决定流程该有多重，不会让任何硬规则失效。

### 决策分级

| 决策类型 | 怎么处理 |
| --- | --- |
| Mechanical | 项目惯例已经定了、可逆、不影响用户可见行为/公共契约/数据/架构/发布——静默决定即可 |
| Taste | 可逆、但仍影响用户体验、文档形态、工作流或实现风格——攒一批，一次性请用户批准 |
| User Challenge | 涉及架构、产品行为、公共契约、不可逆数据或发布风险——立刻停下问用户 |

注意：哪怕原始请求要的是完整结果，或者事后单独调用了 `/execute`，都**不等于**批准了那批还挂着的 Taste 决策。要把用户选了什么、何时批准的记下来；只有当某个决策发生实质变化时，才需要重新问一次。

## Skill 功能详解

每个 skill 都围绕"它要防止的那种失败"来组织。TDD 是 `/execute` 里高风险变更的默认做法；代码评审是 `/verify` 的一个检查维度；发布是 `/verify` 通过之后的后续动作。这三样都内嵌在已有 skill 里，不单独拆成 skill。

### `/clarify`

防止 agent 在"只以为自己懂了"的情况下就开工。适用于目标、范围、约束、验收标准、术语、权衡或用户决策边界还说不清的任务。

核心动作：

- 先读相关代码、文档和已有上下文，别问代码自己就能回答的问题。
- 先选模式：`goal-clarify`（目标澄清）还是 `orientation`（项目导览）；导览模式下不得凭空编造实现层面的验收标准。
- 把目标、非目标、约束和验收标准弄清楚，并给每条验收标准标上来源——是用户说的、仓库里查到的、还是 agent 自己拟的；凡是 agent 自拟、又影响用户可见成功标准的，必须先确认再往下走。
- 读项目或模块时，产出一份"教学图式（teaching-graph）"风格的导览：限定范围、依据、节点与连线、层次、领域流程、推荐阅读顺序、不确定项和下一步走向。
- 对陌生或风险敏感的工作，跑一遍"不确定项梳理（Uncertainty Pass）"，把证据（evidence）、待查事实（open fact）、待定决策（open decision）、盲区假设（blind-spot hypothesis）和残余不确定（residual uncertainty）分开看。注意：陌生本身只触发这道梳理，不会自动把风险等级抬高。
- 对领域词汇做一次"共享术语（shared language）"检查；用户确认稳定的术语，写进或更新到 `CONTEXT.md`。
- 对中高风险任务给出方案取舍和推荐；但高影响的决策必须留给用户。
- Taste 决策攒给 `/plan` 统一批；如果是低风险、要直接进 `/execute`，那就由 `/clarify` 先把这一批 Taste 一次性批掉。

产出：任务类型、风险等级、目标与非目标、验收标准、按需给出的项目/模块导览、术语澄清（含 `CONTEXT.md` 是否更新）、待定决策，以及一段可交给 `/plan` 或 `/execute` 的"轻量目标"。

### `/plan`

防止"范围悄悄变大"和"偷偷替用户做了高影响决策"。适用于目标已经清楚、但还需要拆解、排序、给决策分级、设计验证方式或想清楚怎么回滚的任务。

核心动作：

- 列清楚：会动到哪些文件、模块或边界，以及哪些必须保护、不能碰。
- 如果是直接从根路由进 `/plan`，先把轻量目标、验收标准、保护边界和验证路径建起来；缺这些输入，就退回 `/clarify`。
- 把决策分成三类：Mechanical、Taste、User Challenge。
- 给 Taste 和 User Challenge 决策各写一份"决策说明（Decision Brief）"，写清推荐方案、备选方案、取舍、可逆性和覆盖差异。
- Taste 决策在进 `/execute` 前统一批一次；一旦发现 User Challenge，立刻停下。
- 优先拆成"能独立验证的纵向小切片"，别按技术层横向堆计划。
- 已经批准、又过了三道门槛的"持久决策（durable decision）"，写进项目既有的 ADR（架构决策记录）/决策产物里；项目没有惯例的话，写到根目录 `DECISIONS.md`。
- 对部署、数据、安全、架构这类高风险变更，补上回滚或失败处理。

产出：排好序的任务、影响范围、受保护范围、决策分级、持久决策产物（或为何暂缓）、验证策略、必要的回滚说明，以及一份能直接交给 `/execute` 的计划。

### `/execute`

防止执行时偏离计划、过度工程化、或上下文越聊越腐化。适用于去实现已经明确的代码、配置、文档、工具或项目结构变更。

核心动作：

- 重新确认一遍：轻量目标或计划、约束、受保护文件、验证要求和"决策已被批准"的证据。
- 把轻量目标当作合法的"命名记忆（named-memory）"容器；只应用计划、任务交接、轻量目标或上下文清单里点过名的记忆，别临时拉别的进来。
- 只要还有 Taste 决策挂着没批、或发生了变化，就拒绝动手改；单独调用 `/execute` 不等于批准。
- 跑一遍 Context Gate，判断当前上下文够不够用；风险高时，把窄任务交给干净的新上下文去做。
- 做最小的修改，只碰当前任务真正需要的文件。
- 高风险代码变更按 TDD 的纵向切片来做：一个行为 → 一个先失败的测试 → 一个最小实现。
- 不顺手重构、不引入"投机性抽象（speculative abstraction，即为将来可能用到而提前写的代码）"、不吞错误、不忽略 Promise。

产出：改了哪些文件、为什么这么改、验证命令和结果、还没解决的风险，以及一个能交给 `/verify` 去检查的状态。

### `/investigate`

防止"没有事实就靠猜来修"。适用于 bug、失败测试、回归、性能、部署、CI、安全、稳定性或根因不明的问题。

核心动作：

- 先把"症状"和"期望行为"定义清楚。
- 建立最快、可靠、可重复的反馈环；反馈环太弱就先把它强化，再下结论。
- 复现或观察失败，从测试、日志、指标、调用链、配置或代码路径里收集证据。
- 缩小失败的范围，提出 3 到 5 个"可被证伪"的假设，挑最强的逐个验证。
- 按"修复路径出口标准（Fix-Path Exit Criteria）"决定去哪：只有当重评为低风险、输入齐全、且没有顺序风险（sequencing risk）时才进 `/execute`，否则回 `/plan`。
- 性能问题必须有基线；部署问题必须说清环境边界；安全和稳定性问题必须说清威胁或失败模型。

产出：复现或观察的方法、反馈环质量、已收集到的事实、缩小后的失败范围、根因假设（附信心程度）、风险重评、以及下一步进哪个 skill。

### `/verify`

防止把"看起来对了"当成"已经完成"。除了正在跑的 `/execute` 已经证明满足"局部完成出口（Local Completion Exit）"之外，任何宣布完成、修复、通过、发布、优化或待评审之前，都要过这一关。

核心动作：

- 找到能证明结论的命令、检查或产物，跑一遍新鲜的验证。
- 读真实的输出和退出码，不把旧结果、或"实现者说自己搞定了"当成证据。
- 做"范围漂移检测（Scope Drift Detection）"，拿任务、计划和 diff 对照，逐项判定：已交付（Delivered）、缺失（Missing）、多余（Extra）、变了样（Changed）还是无法验证（Unverifiable）。
- 当可观察的行为有变化时，要拿出"行为回归证明（Behavior Regression Proof）"：有稳定的可测试缝隙（seam）就新增/更新区分性测试；否则给出可重复的"改动路径证明（changed-path proof）"，并声明残余风险。
- 中高风险、或走发布路径的任务，用"评审就绪看板（Review Readiness Dashboard）"。
- 对发布、上线、出包、提 PR、合并、发版等请求，先完成"发布路径就绪证明（release-path readiness proof）"；只有当检查清单就绪、Taste 已批准、残余的 User Challenge 风险已被接受、且这个动作本身是"机械的交接或发布"时，才执行或交接。注意把"就绪状态"和"发布动作状态"分开报告。
- 对认证、数据迁移、并发、支付、部署、LLM 信任边界、大型跨模块 diff 这类高风险变更，做一遍"对抗性评审（Adversarial Review）"。

产出：验证命令和结果、验收是否通过、范围漂移检查、必要时的行为回归状态、需要的评审面板、残余风险、按需的发布动作状态，以及"到底能不能真的宣布完成"。

### `/reflect`

防止同样的坑反复踩，也防止知识库被流水账塞满。只有当已验证的工作确实带来了可复用的经验时才用。

核心动作：

- 先判断这次的结果：是可复用经验（reusable lesson）、还是没记下来的持久决策（durable decision）、还是两者都有、或者根本不值得记。
- 用 Memory Promotion Gate 决定记到哪一层：当前任务、项目上下文、项目学习、全局记忆、还是写进 skill 规则。
- 用"使用契约（Consumption Contract）"确认每个要落盘的产物：未来谁会读、什么时候会被触发读取；没有读者和触发条件的经验，不落盘。
- 写进全局记忆（`~/.qingshan-skills/memory/learnings.jsonl`）的，必须至少包含：触发条件（trigger）、经验本身（lesson）、适用范围（scope）、证据（evidence）、日期和来源。
- 没记下来的持久决策，要补记：日期、范围、理由、被否掉的方案、以及什么条件下可以推翻。
- 术语表（glossary）只记稳定的领域术语或已解决的歧义；ADR 只记"难反转、没上下文会让人意外、且来自真实取舍"的决策。
- 选最小够用的持久化产物，避免写会话流水账和一次性的零散观察。

产出：可复用经验、未来的触发条件、未来的读者、必要的术语表或持久决策补充、更新过的产物，或者明确说明"这次不需要沉淀"。

## 操作流程

### 默认流程

```text
/clarify -> /plan -> /execute -> /verify -> /reflect
      \                         ^
       -> /investigate -> /plan |
```

`/investigate` 可以在任何阶段切入；诊断清楚后，回到 `/plan` 再 `/execute`。根目录 `SKILL.md` 是每次会话的引导和路由入口，`ETHOS.md` 是所有 skill 共用的约束层。

### 常见路径

按场景挑最轻量的流程，不必每次都走完全程：

| 场景 | 路径 |
| --- | --- |
| 小幅 Mechanical 文档改动 | `/clarify → /execute → done`（走局部完成出口） |
| Bug 修复 | `/investigate → /execute → /verify` |
| 性能调优 | `/investigate → /plan → /execute → /verify` |
| 依赖或工具链升级 | `/plan → /execute → /verify` |
| 代码评审、PR/diff 评审 | `/verify` |
| 发布、提 PR、合并、上线 | `/verify` 发布路径检查就绪后，执行或交接机械动作 |
| 大型跨模块工作 | `/clarify → /plan → /execute`（交给新上下文子会话）`→ /verify → /reflect` |

## 工程支撑模板

仓库在 [`docs/templates/`](docs/templates/) 下提供了一些轻量模板，只在对应流程需要时才用：

- `decision-brief.md`：Taste 或 User Challenge 决策的说明。
- `fresh-context-packet.md`：给"新上下文的工作者/评审者"的窄任务输入包。
- `task-handoff.md`：当 `/clarify` 或 `/investigate` 的结果要扛过上下文压缩、跨 agent、或进入 `/plan`/`/execute` 时，用来交接当前任务。
- `release-checklist.md`：`/verify` 里的发布、PR、部署或交接检查清单——它不是一个新的 `/ship` skill。
- `durable-decision.md`：`/plan` 用来记录已批准的持久决策，或 `/reflect` 用来补记之前漏掉的持久决策。
- `context-glossary.md`：当 `/clarify` 需要给项目建立共享术语时，`CONTEXT.md` 该长什么样。
- `runtime-bootstrap.md`：给"不直接读 Agent Skills 的运行时"用的最小加载包装。

根目录的 [`CONTEXT.md`](CONTEXT.md) 是本仓库自己的术语表，只记稳定的术语和已解决的歧义，不记计划、实现细节或决策日志。项目层面的学习写进 `LEARNINGS.md` 或既有的复盘文档；全局记忆只会按"触发条件匹配"的方式被检索出相关片段，不要求每次任务都全量读一遍。

`prompts/` 下的评审 prompt，只在相关流程需要结构化审查、或新上下文协作时才用；`adversarial-reviewer.md` 支撑 `/verify` 里的高风险对抗性评审。

## 安装

qingshan-skills 不绑定具体运行时，本质就是让 agent 运行时能读到根 skill 和这六个工作流 skill。提供五种安装方式，按需挑一种。

### 方式一：setup 脚本（推荐）

```bash
git clone https://github.com/qshan-li/qingshan-skills.git
cd qingshan-skills
./setup
```

脚本会先校验仓库完整性，再把根 skill 和各个工作流 skill 链接到 Claude Code、Codex 和通用 agent 的目录。加 `--force` 可以替换已有链接，并生成一份带时间戳的备份：

```bash
./setup --force
```

只要遇到冲突目标，安装就会以非零状态中止，不会留下一份装了一半的状态。`--skip-validation` 只跳过"校验仓库"这一步。

### 方式二：Claude Code Plugin Marketplace

```
/plugin marketplace add qshan-li/qingshan-skills
/plugin install qingshan-skills@qingshan-skills
```

### 方式三：sync 脚本

用仓库根目录的同步脚本建立全局链接：

```bash
bash scripts/sync-global-skills.sh
```

脚本会把 `qingshan-skills`、`clarify`、`plan`、`execute`、`investigate`、`verify`、`reflect` 链接到 Claude Code、Codex 和通用 agent 的全局 skill 目录。加 `--force` 可以替换已有链接：

```bash
bash scripts/sync-global-skills.sh --force
```

### 方式四：Cursor

在磁盘上保留一份完整的 qingshan-skills 仓库，然后给每个用到它的项目装一条 Cursor 项目规则：

```bash
bash scripts/install-cursor-project-rule.sh /path/to/consumer-project
# 可选但推荐
export QINGSHAN_SKILLS_ROOT=/absolute/path/to/qingshan-skills
```

这条规则会按 `QINGSHAN_SKILLS_ROOT`、内置路径（baked path）或 `~/.qingshan-skills/repo` 的顺序解析出 skills 根目录，再读取权威的根路由、ETHOS 和选中的工作流 skill。注意：别把使用方的项目根目录当成 skills 仓库。

### 方式五：手动安装

把仓库克隆到本地后，按运行时的要求手动链接或复制 skill 文件：

```bash
git clone https://github.com/qshan-li/qingshan-skills.git
cd qingshan-skills

# Claude Code
ln -s "$(pwd)" ~/.claude/skills/qingshan-skills
for s in clarify plan execute investigate verify reflect; do
  ln -s "$(pwd)/skills/$s" ~/.claude/skills/$s
done

# Codex
ln -s "$(pwd)" "${CODEX_HOME:-$HOME/.codex}/skills/qingshan-skills"
for s in clarify plan execute investigate verify reflect; do
  ln -s "$(pwd)/skills/$s" "${CODEX_HOME:-$HOME/.codex}/skills/$s"
done

# 通用 agent
ln -s "$(pwd)" ~/.agents/skills/qingshan-skills
for s in clarify plan execute investigate verify reflect; do
  ln -s "$(pwd)/skills/$s" ~/.agents/skills/$s
done
```

其他运行时和详细选项见 [`docs/installation.md`](docs/installation.md)。

核心的 `SKILL.md` 只保留跨运行时通用的 `name` 和 `description` 这两个字段（frontmatter）。Claude Code、Codex、Cursor 等工具的专属字段、插件清单、hooks、规则包装或 UI 元数据，都属于"运行时适配层"，不该写进核心 skill。边界见 [`docs/runtime-adapters.md`](docs/runtime-adapters.md)。

## 验证

```bash
bash scripts/validate-skills.sh
```

预期输出：

```text
OK qingshan-skills validation passed
```

校验内容包含：必需文件、skill 的 YAML frontmatter、必需章节、模板、prompt 护栏、插件清单、VERSION 一致性、Cursor 规则，以及带"必需信号（Required signals）"的压测场景。

压测场景的契约覆盖，用的是对话记录产物（transcript artifact）：

```bash
bash scripts/validate-behavior-tests.sh
```

每个压测场景至少要有一条 `PASS`（通过）的对话记录。`FAIL`（失败）和 `BLOCKED`（被阻断）的记录可以作为历史证据保留，但不计入场景覆盖。

手工整理的对话记录是"可审查的契约样例（fixture）"，不等于真实运行时（hosted runtime）的黑盒行为证明。

测试分层和 ACP 边界见 [`docs/testing.md`](docs/testing.md)。ACP 属于未来的"运行时适配器集成测试"，不是核心 skill 语义测试的第一层。运行时行为以根 [`SKILL.md`](SKILL.md) 和六个工作流 skill 为准；[`docs/superpowers/specs/`](docs/superpowers/specs/) 只保留设计理念和理由，不是第二套可执行规则。

想检查真实宿主的加载情况，有一个可选的"运行时冒烟检查（runtime smoke）"；它不会被核心验证自动调用：

```bash
QINGSHAN_RUNTIME_SMOKE=1 bash scripts/validate-runtime-smoke.sh
```

另外可以单独检查选定的"权威正文（canonical body）"行为：

```bash
QINGSHAN_RUNTIME_BEHAVIOR=1 bash scripts/validate-runtime-behavior.sh
```
