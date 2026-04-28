// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "曾祥桉",
  title: "曾祥桉 - CV",
  footer: context { [#emph[曾祥桉 -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Last updated in Apr 2026] ],
  locale-catalog-language: "en",
  text-direction: ltr,
  page-size: "us-letter",
  page-top-margin: 1.4cm,
  page-bottom-margin: 1.4cm,
  page-left-margin: 1.4cm,
  page-right-margin: 1.4cm,
  page-show-footer: true,
  page-show-top-note: true,
  colors-body: rgb(0, 0, 0),
  colors-name: rgb(0, 79, 144),
  colors-headline: rgb(0, 79, 144),
  colors-connections: rgb(0, 79, 144),
  colors-section-titles: rgb(0, 79, 144),
  colors-links: rgb(0, 79, 144),
  colors-footer: rgb(128, 128, 128),
  colors-top-note: rgb(128, 128, 128),
  typography-line-spacing: 0.4em,
  typography-alignment: "justified",
  typography-date-and-location-column-alignment: right,
  typography-font-family-body: "Source Sans 3",
  typography-font-family-name: "Source Sans 3",
  typography-font-family-headline: "Source Sans 3",
  typography-font-family-connections: "Source Sans 3",
  typography-font-family-section-titles: "Source Sans 3",
  typography-font-size-body: 10pt,
  typography-font-size-name: 30pt,
  typography-font-size-headline: 10pt,
  typography-font-size-connections: 10pt,
  typography-font-size-section-titles: 1.4em,
  typography-small-caps-name: false,
  typography-small-caps-headline: false,
  typography-small-caps-connections: false,
  typography-small-caps-section-titles: false,
  typography-bold-name: true,
  typography-bold-headline: false,
  typography-bold-connections: false,
  typography-bold-section-titles: true,
  links-underline: false,
  links-show-external-link-icon: false,
  header-alignment: center,
  header-photo-width: 3.5cm,
  header-space-below-name: 0.7cm,
  header-space-below-headline: 0.7cm,
  header-space-below-connections: 0.7cm,
  header-connections-hyperlink: true,
  header-connections-show-icons: true,
  header-connections-display-urls-instead-of-usernames: false,
  header-connections-separator: "",
  header-connections-space-between-connections: 0.5cm,
  section-titles-type: "with_partial_line",
  section-titles-line-thickness: 0.5pt,
  section-titles-space-above: 0.5cm,
  section-titles-space-below: 0.3cm,
  sections-allow-page-break: true,
  sections-space-between-text-based-entries: 0.12em,
  sections-space-between-regular-entries: 0.65em,
  entries-date-and-location-width: 4.15cm,
  entries-side-space: 0.2cm,
  entries-space-between-columns: 0.1cm,
  entries-allow-page-break: false,
  entries-short-second-row: true,
  entries-degree-width: 1cm,
  entries-summary-space-left: 0cm,
  entries-summary-space-above: 0cm,
  entries-highlights-bullet:  "•" ,
  entries-highlights-nested-bullet:  "•" ,
  entries-highlights-space-left: 0.15cm,
  entries-highlights-space-above: 0cm,
  entries-highlights-space-between-items: 0cm,
  entries-highlights-space-between-bullet-and-text: 0.5em,
  date: datetime(
    year: 2026,
    month: 4,
    day: 28,
  ),
)


= 曾祥桉

  #headline([AI 产品经理（个性化方向）])

#connections(
  [#link("mailto:xianganzeng873@gmail.com", icon: false, if-underline: false, if-color: false)[#connection-with-icon("envelope")[xianganzeng873\@gmail.com]]],
  [#link("https://github.com/bobbyceng", icon: false, if-underline: false, if-color: false)[#connection-with-icon("link")[github.com\/bobbyceng]]],
  [#link("https://github.com/bobbyceng", icon: false, if-underline: false, if-color: false)[#connection-with-icon("github")[bobbyceng]]],
)


== 个人总结

- 具备 AI 产品从需求定义到 MVP 验证的端到端交付经验，对 AI 个性化与记忆机制方向有产品化实践——自主设计并持续迭代个人 AI 个性化系统（v1.5），涵盖用户画像、长期记忆与个性化偏好管理的完整产品设计。有 AI 产品助理实习经验，了解大模型基本原理与常见应用方式，熟悉 Cursor、Figma 等工具，具备结构化问题拆解与自我驱动能力。英语可作为工作语言（雅思 6.5）。

== 核心能力

#strong[AI 个性化产品设计:] 用户画像｜长期记忆机制｜个性化偏好管理｜产品化落地

#strong[AI 产品设计:] 需求拆解｜场景定义｜PRD｜原型设计｜MVP 验证

#strong[AI 能力应用:] 大模型应用｜Prompt Engineering｜多模态集成｜AI Coding（Claude Code \/ Cursor）

#strong[工具:] Cursor｜Figma｜Axure｜XMind

== 工作与实习经历

#regular-entry(
  [
    #text(size: 1.15em, weight: "bold", stroke: 0.4pt)[闪量互动科技有限公司] | AI 产品经理助理

    - 参与 AI 产品需求梳理与场景定义，完成需求澄清与优先级划分

    - 输出 PRD、流程图及交互原型，明确功能边界与异常处理逻辑

    - 维护需求与风险清单，推动关键节点按计划推进

    - 建立商业化与投放团队痛点清单，识别 AI 提效机会点

  ],
  [
    #strong[2025.05 - 2025.08]

  ],
)

#regular-entry(
  [
    #text(size: 1.15em, weight: "bold", stroke: 0.4pt)[万仕道（北京）管理咨询有限公司深圳分公司] | 猎头顾问

    - 参与岗位需求拆解与人才画像定义，输出候选人评估报告（Shortlist + Brief）

    - 协同 HR 与业务方推进招聘全流程，积累 B 端多角色沟通经验

    - 作为 AI 招聘助手种子用户，持续反馈产品体验问题并提出优化建议

  ],
  [
    #strong[2023.10 - 2024.08]

  ],
)

== 行业活动

#regular-entry(
  [
    #text(size: 1.15em, weight: "bold", stroke: 0.4pt)[AttraX 春潮·Spring AI/硬件黑客松] | 现场运营统筹负责人（志愿者）

    - 统筹3-400人规模活动现场物资调配与志愿者协调，保障多日活动全流程顺利运行

    - 与 Airjelly（AI 桌面助手）团队就个人 AI 工作流实践深度交流，获专业认可；聆听 Anker 内部 AI 工具建设经验，了解企业 AI 赋能项目的落地路径

  ],
  [
    #strong[2026.04]

  ],
)

== 项目经历

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold", stroke: 0.4pt)[CRM 智能客户标签系统（自主 PoC 方案设计，To B）]

    #summary[项目背景 \     　• 实习期间观察到客户数据分散、缺乏结构化用户画像导致销售跟进效率低的业务痛点，自主发起 PoC 方案设计。 \ 我的工作 \     　• 梳理客户标签体系核心维度（意向等级 \/ 需求类型 \/ 决策进度等），建立标签字典与口径定义，构建结构化用户画像基础。 \     　• 设计完整数据链路：数据接入 → 清洗 → LLM 标签推理 → 回写 CRM，通过\"证据展示机制\"提升标签可解释性与可信度。 \     　• 输出 PRD + 流程图 + 交互原型方案。 \ 项目成果 \     　• 将依赖人工经验的非结构化数据转化为可自动化的结构化用户画像，为后续个性化运营提供数据基础。]

  ],
  [
  ],
)

== 个人项目

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold", stroke: 0.4pt)[个人 AI 个性化系统 | AI 分身工程（Claude Code / v1.5）]

    #summary[项目背景 \     　• 针对\"AI 无法跨会话保持上下文、无法持续学习用户偏好\"的核心痛点，自主设计并迭代一套 AI 个性化系统，实现用户画像驱动的差异化响应与记忆持续更新。 \ 我的工作 \     　• 设计双层记忆机制（长期用户画像 + 短期任务版），解决跨会话状态丢失问题，让系统持续积累并应用用户的个性化偏好与行为特征。 \     　• 设计 Sensor 自动校验层，对 AI 写回的记忆数据进行一致性校验与质量管控，保障个性化数据的准确性。 \     　• 构建基于用户画像的 Skills 体系（5 个专项技能），根据用户当前场景按需激活，实现上下文感知的个性化响应。 \     　• 设计红黄绿灯权限体系，明确数据读写边界，兼顾个性化能力与隐私合规控制。 \     　• 从 v1.0 迭代至 v1.5，每版针对实际问题做针对性改进（记忆结构精简、技能按需加载、自动写回协议）。 \ 项目成果 \     　• 持续日常使用验证：基于用户画像的 AI 个性化机制在真实场景可持续运行，形成\"非技术背景 PM 设计 AI 个性化产品\"的完整实践样本。]

  ],
  [
  ],
)

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold", stroke: 0.4pt)[Coach Titan | AI 饮食教练 MVP（iOS / Web）]

    #summary[项目背景 \     　• 面向\"不愿精算食物\"的健身人群，基于拳掌法 + 用户 Profile 提供个性化低门槛饮食记录与策略建议。 \ 我的工作 \     　• 设计基于用户 Profile（目标 \/ 体重 \/ 训练频率 \/ 体型数据）的个性化营养建议生成机制，根据用户状态动态调整拳掌法推荐参数。 \     　• 集成多模态模型（图像识别 + 文本生成），通过拍照输入提供个性化饮食分析与反馈。 \     　• 设计低摩擦录入闭环：快速输入 → AI 估算 → 个性化建议 → 历史复盘，降低用户记录成本。 \     　• 以零代码背景独立完成端到端交付：产品定义、交互设计、开发部署、iOS 真机验证。 \ 项目成果 \     　• 完成可演示闭环产品（真实设备运行），验证\"基于用户画像的轻量个性化建议\"路径可行性。 \     　• 以零产品经验、零代码背景独立完成端到端主导，证明具备从需求判断到产品交付的完整能力。]

  ],
  [
  ],
)

== 教育背景

#education-entry(
  [
    #strong[香港岭南大学], 人工智能与未来

    #summary[毕业论文：AI 在 HR 场景的应用与治理（招聘自动化与绩效管理中的算法偏见与人机协作）]

  ],
  [
    香港

    2024.09 - 2025.08

  ],
  degree-column: [
    #strong[硕士]
  ],
)

#education-entry(
  [
    #strong[深圳技术大学], 商务英语

  ],
  [
    深圳

    2022.09 - 2024.06

  ],
  degree-column: [
    #strong[本科]
  ],
)

== 荣誉证书

- 雅思 6.5

- 英语专业四级
