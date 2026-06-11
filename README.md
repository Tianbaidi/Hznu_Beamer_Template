# HZNU Beamer 模板（非官方）

本项目是杭州师范大学非官方 Beamer 模板，借鉴了
[华中师范大学 Beamer 模板](https://github.com/K-JW/CCNU_BeamerTemplate)
的设计与代码结构。


## 文件结构

```text
.
├── HZNU_BeamerTemplate.tex  # 示例文档
├── hznu.sty                 # 主题样式
└── res/                     # 背景、校名和校徽图片
```

## 使用方法

1. 下载项目，并保持 `hznu.sty` 与 `res/` 的相对位置不变。
2. 修改 `HZNU_BeamerTemplate.tex` 中的标题、作者和正文。
3. 使用 XeLaTeX 编译。

在 Overleaf 中，请上传整个项目目录，并将编译器设置为 XeLaTeX。

新建文档时，最小配置如下：

```latex
\documentclass[10pt,aspectratio=169,mathserif]{beamer}

\usepackage{ctex}
\usepackage{hznu}
```

## 源码检查

在 Windows PowerShell 中运行：

```powershell
.\tests\verify-source.ps1
```

该检查会确认示例页面和主题关键功能仍然完整，但不能代替 XeLaTeX 编译。

## 免责声明

本模板为**非官方**制作，**不保证**在各类学术活动、会议或答辩中的格式合规性。
使用前请确认主办方或所在学院的具体要求。
