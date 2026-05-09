// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "曾祥桉",
  title: "曾祥桉 - CV",
  footer: context { [#emph[曾祥桉 -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Last updated in May 2026] ],
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
  sections-space-between-regular-entries: 0.9em,
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
    month: 5,
    day: 9,
  ),
)


= 曾祥桉

  #headline([AI 项目经理])

#connections(
  [#link("mailto:xianganzeng873@gmail.com", icon: false, if-underline: false, if-color: false)[#connection-with-icon("envelope")[xianganzeng873\@gmail.com]]],
  [#link("https://github.com/bobbyceng", icon: false, if-underline: false, if-color: false)[#connection-with-icon("link")[github.com\/bobbyceng]]],
  [#link("https://github.com/bobbyceng", icon: false, if-underline: false, if-color: false)[#connection-with-icon("github")[bobbyceng]]],
)


== 个人总结

- 具备 AI 产品从需求定义到 MVP 验证的端到端交付经验，有通过 AI 工作流实现业务流程自动化的实践经验（个人 AI 操作系统，持续迭代至 v1.5）。有 AI 产品助理实习与猎头行业经验，理解 B 端业务流程，具备跨角色沟通与推动落地能力。熟悉 Claude Code、Cursor 等主流 AI 工具，能根据业务场景灵活选择与组合。英语可作为工作语言（雅思 6.5）。

== 核心能力

#strong[AI 工作流落地:] 业务流程梳理（SOP）｜AI 自动化设计｜工具选型与组合｜效果跟踪

#strong[AI 能力应用:] Prompt Engineering｜工具调用｜多模态集成｜AI Coding（Claude Code \/ Cursor）

#strong[跨团队协作:] 需求拆解｜跨部门推动｜多角色沟通｜异常兜底

#strong[产品与交付:] PRD｜原型设计｜MVP 验证｜Axure｜Figma

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

#regular-entry(
  [
    #text(size: 1.15em, weight: "bold", stroke: 0.4pt)[可为易达国际货运代理（深圳）有限公司] | 海外客服

    - 面向海外客户承接运输需求，处理提单、报关等业务文件，积累跨语境沟通与复杂流程协同经验

  ],
  [
    #strong[2021.10 - 2022.08]

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

    #summary[项目背景 \     　• 实习期间观察到客户信息分散、人工打标签成本高且准确率不稳定的业务痛点，自主发起 PoC 方案设计。 \ 我的工作 \     　• 梳理标签生成核心场景与优先级，定义 In Scope 与 Out of Scope。 \     　• 设计完整链路：数据接入 → 清洗 → 标签推理 → 回写 CRM。 \     　• 建立标签字典与口径定义，设计\"证据展示机制\"提升标签可解释性。 \     　• 输出 PRD + 流程图 + 交互原型方案。 \ 项目成果 \     　• 将人工标签流程标准化，为后续 AI 标签自动化提供可落地基础方案。]

  ],
  [
  ],
)

== 个人项目

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold", stroke: 0.4pt)[个人 AI 操作系统 | AI 分身工程（Claude Code / v1.5）]

    #summary[项目背景 \     　• 求职与多项目并行中面临信息碎片化、决策反复、跨 session 状态丢失等问题，自主设计并持续迭代一套个人 AI 操作系统，让 AI 成为具备记忆、权限与技能的结构化协作者。 \ 我的工作 \     　• 设计分层 Prompt 架构（Harness Engineering）：主宪法（身份 + 规则）→ 执行协议（权限 + 记忆写回）→ 技能模板（Skills），实现关注点分离与按需加载，降低 token 开销。 \     　• 构建 Skills 体系（5 个专项：拆 JD \/ 项目讲述 \/ 写 cold message \/ 面试复盘 \/ 公司调研），形成求职场景完整闭环。 \     　• 设计双层记忆机制（短期任务版 + 长期画像）与 Sensor 自动校验层，解决\"每次从零开始\"和 AI 越界写回问题。 \     　• 设计红黄绿灯权限体系，确保 AI 执行行为可控、不越界。 \     　• 从 v1.0 迭代至 v1.5，每版针对实际问题做针对性改进（精简主文件、Skills 按需加载、Sensor + Hook 自动校验、结束协议自动写回）。 \ 项目成果 \     　• 持续日常使用，求职准备、项目打磨、面试模拟均通过该系统完成，验证了\"非工程师用 Prompt Engineering 构建可迭代 AI 工作流\"的可行性。]

  ],
  [
  ],
)

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold", stroke: 0.4pt)[Coach Titan | AI 饮食教练 MVP（iOS / Web）]

    #summary[项目背景 \     　• 面向\"不愿精算食物\"的健身人群，基于拳掌法提供低门槛饮食记录与策略建议。 \ 我的工作 \     　• 以零代码背景独立完成端到端交付：产品定义、交互设计、开发部署、iOS 真机验证。 \     　• 设计低摩擦录入闭环：快速输入、预览卡片、下一步建议、历史复盘。 \     　• 集成多模态模型（图像识别 + 文本生成），处理多模型输出一致性与交互衔接。 \     　• 使用 AI Coding 工具完成 MVP 开发，Web 与 iOS 双端可运行。 \ 项目成果 \     　• 完成可演示闭环产品（真实设备运行），验证\"低成本记录路径\"可行性。 \     　• 以零产品经验、零代码背景独立完成端到端主导，证明具备从判断需求到交付产品的完整能力。]

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
