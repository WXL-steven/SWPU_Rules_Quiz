# 西南石油大学校纪校规题库

这是一个用于检索西南石油大学(南充)校纪校规题库(2023)的开源应用程序，支持单选题和多选题的搜索。基于Flutter框架开发，实现跨平台部署。

## 主要功能

1. **日间/夜间模式**：标题栏右上角的按钮可切换日间和夜间模式。
2. **页面导航**：标题栏下方的切换器可在"单选题"和"多选题"页面间导航。
3. **题目显示**：各页面上的题目和答案分开展示。
4. **搜索框**：底部固定搜索框，支持关键字搜索，右侧有清除按钮。

### 搜索规则

- 仅在题目中搜索，不搜索选项。
- 使用空格分割关键字。
- 关键字匹配不受顺序影响。

例如，搜索："手续 出国"。"9.学生自费出国留学，须办理（ ）手续。"会出现在结果中，因为包含"手续"和"出国"两个关键字。

- 无匹配结果时，显示"无结果"。
- 搜索词为空时，显示全部结果。

## 在线访问

应用已部署在Firebase Hosting上，访问链接：

[https://swputest.web.app](https://swputest.web.app/#/)

## 许可证

本项目采用[GNU General Public License v3.0](LICENSE)许可证。