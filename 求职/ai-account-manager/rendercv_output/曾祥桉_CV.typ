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
  page-top-margin: 0.7in,
  page-bottom-margin: 0.7in,
  page-left-margin: 0.7in,
  page-right-margin: 0.7in,
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
  typography-line-spacing: 0.3em,
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
  sections-space-between-regular-entries: 0.75em,
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
    day: 16,
  ),
)


= 曾祥桉

  #headline([AI SaaS Account Manager])

#connections(
  [#link("mailto:xianganzeng873@gmail.com", icon: false, if-underline: false, if-color: false)[#connection-with-icon("envelope")[xianganzeng873\@gmail.com]]],
  [#link("https://github.com/bobbyceng", icon: false, if-underline: false, if-color: false)[#connection-with-icon("link")[github.com\/bobbyceng]]],
  [#link("https://github.com/bobbyceng", icon: false, if-underline: false, if-color: false)[#connection-with-icon("github")[bobbyceng]]],
)


== 个人总结

- 香港岭南大学 AI 硕士，具备 AI 产品应用理解与客户沟通双重能力。有猎头顾问经验，擅长需求拆解与多角色沟通协同；有海外客服经验，熟悉跨境业务流程与英文工作环境。对 AI 技术在商业场景的落地有实际项目经验，能快速理解 AI SaaS 产品逻辑并转化为客户可理解的方案。英语可作为工作语言（雅思 6.5）。

== 核心能力

#strong[客户沟通:] 需求澄清｜多角色协同｜客户问题收集与反馈闭环｜跨语境沟通

#strong[AI 应用理解:] Prompt Engineering｜AI 产品方案设计｜MVP 验证｜AI 工具实操

#strong[数据意识:] 关注转化率与用户行为指标｜具备基础归因分析思维

#strong[工具:] Axure｜Figma｜XMind｜AI Coding 工具（Claude Code \/ Cursor）

#strong[语言:] 英语（雅思 6.5，可作为工作语言）｜粤语｜普通话

== 工作与实习经历

#regular-entry(
  [
    #strong[闪量互动科技有限公司], AI 产品经理助理

    - 参与 AI 产品需求梳理与场景定义，完成需求澄清与优先级划分

    - 收集业务侧反馈，识别 AI 提效机会点，推动产品功能优化

    - 维护需求与风险清单，协调关键节点推进

  ],
  [
    #strong[2025.05 - 2025.08]

  ],
)

#regular-entry(
  [
    #strong[万仕道（北京）管理咨询有限公司深圳分公司], 猎头顾问

    - 面向企业客户进行岗位需求拆解与人才画像定义，积累 B 端客户需求沟通经验

    - 输出候选人评估报告，协同 HR 与业务方推进全流程，管理多方预期

    - 作为 AI 招聘助手种子用户，持续反馈产品体验问题并推动优化

  ],
  [
    #strong[2023.10 - 2024.08]

  ],
)

#regular-entry(
  [
    #strong[可为易达国际货运代理（深圳）有限公司], 海外客服

    - 面向欧美客户承接跨境运输需求，全英文沟通确认关键信息与异常处理

    - 跟进提单、报关等跨境业务全流程，积累客户服务与问题闭环经验

  ],
  [
    #strong[2021.10 - 2022.08]

  ],
)

== 项目经历

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold")[个人 AI 操作系统 | AI 分身工程（Claude Code / v1.5）]

    #summary[项目背景 \     　• 求职与多项目并行中面临信息碎片化、决策反复问题，自主设计并持续迭代一套个人 AI 操作系统，将 AI 从\"问答工具\"变为持续协作的结构化助手。 \ 我的工作 \     　• 设计分层架构：主宪法 → 执行协议 → 技能模板（Skills），实现按需加载，降低每次对话的 token 成本。 \     　• 构建 Skills 体系（5 个专项：拆 JD \/ 项目讲述 \/ 写 cold message \/ 面试复盘 \/ 公司调研），形成求职场景完整闭环。 \     　• 搭建双层记忆机制（短期任务 + 长期画像）与 Sensor 自动校验层，确保信息不丢失、AI 输出不越界。 \     　• 建立红黄绿灯权限体系与版本迭代评测流程（v1.0 → v1.5），通过固定题库验证每次升级效果。 \ 项目价值 \     　• 日常使用该系统完成求职、项目打磨等工作，体现对 AI 产品能力边界的真实理解与实操经验——能向客户解释\"AI 能做什么、怎么用、边界在哪\"。]

  ],
  [
  ],
)

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold")[CRM 智能客户标签系统（自主 PoC 方案设计，To B）]

    #summary[项目背景 \     　• 实习期间观察到客户信息分散、人工打标签成本高的业务痛点，自主发起方案设计。 \ 我的工作 \     　• 梳理标签使用场景与优先级，设计端到端链路：数据接入 → 清洗 → 标签推理 → 回写 CRM。 \     　• 建立标签字典与口径定义，设计证据展示机制提升可解释性。 \ 项目价值 \     　• 为 AI 标签自动化提供可落地基础方案，降低业务侧校验成本。]

  ],
  [
  ],
)

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold")[Coach Titan | AI 饮食教练 MVP（iOS / Web）]

    #summary[项目背景 \     　• 面向健身人群，基于拳掌法提供低门槛饮食记录与策略建议。 \ 我的工作 \     　• 独立完成从产品定义到 iOS 真机验证的端到端交付。 \     　• 集成多模态 AI 模型（图像识别 + 文本生成），完成可运行 MVP。 \ 项目价值 \     　• 验证\"低成本记录路径\"可行性，体现独立理解和交付 AI 产品的能力。]

  ],
  [
  ],
)

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold")[语音下单助手（出行 AI Copilot，Concept Design）]

    #summary[项目背景 \     　• 为熟悉 AI 对话式交互设计，以出行下单场景为对象完成完整方案设计。 \ 我的工作 \     　• 拆解下单全链路，设计语音对话流程与多轮补全逻辑。 \     　• 构建异常处理机制（超时、识别失败、兜底策略），输出 PRD 与交互原型。 \ 项目价值 \     　• 沉淀对 AI 对话产品的用户流程设计与异常兜底能力。]

  ],
  [
  ],
)

#regular-entry(
  [
    #text(size: 1.3em, weight: "bold")[飞书 AI 晨报 | 低成本新闻聚合助手（Python / Feishu / RSS）]

    #summary[项目背景 \     　• 针对多源信息获取低效问题，构建轻量化 AI 晨报系统。 \ 我的工作 \     　• 设计多源信息聚合 + 飞书推送流程，\"两级触发\"机制平衡响应与资源。 \     　• 在零成本约束下完成 MVP 闭环搭建。 \ 项目价值 \     　• 交付可运行方案，体现用 AI 工具解决实际效率问题的能力。]

  ],
  [
  ],
)

== 教育背景

#education-entry(
  [
    #strong[香港岭南大学], 人工智能与未来

    #summary[毕业论文：AI 在 HR 场景的应用与治理（标签体系与排序逻辑）]

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
