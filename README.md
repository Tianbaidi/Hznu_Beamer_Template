# HZNU Beamer 模板（非官方）

杭州师范大学非官方 Beamer 模板，借鉴了
[华中师范大学 Beamer 模板](https://github.com/K-JW/CCNU_BeamerTemplate)
的设计与代码结构。

## 文件结构

```text
.
├── HZNU_Beamer_Template.tex        # 开箱即用模板
├── hznu.sty                        # 主题样式
├── res/                            # 图片资源
│   ├── hznu_background.png         #   背景水印
│   ├── hznu_logo.png               #   校徽
│   └── hznu_title.png              #   校名横排图
├── demo/                           # 效果展示（自包含，可独立编译）
│   ├── HZNU_BeamerTemplate_demo.tex
│   ├── hznu.sty
│   └── res/
├── tests/
│   └── verify-source.ps1
├── .gitignore
├── .gitattributes
├── LICENSE
└── README.md
```

| 文件 | 用途 |
|------|------|
| `HZNU_Beamer_Template.tex` | 最小可用模板，替换标题/作者/正文后直接编译 |
| `demo/HZNU_BeamerTemplate_demo.tex` | 展示 `hznu.sty` 全部效果：配色、Block、列表、公式、页眉页脚等 |

## 快速开始

### 本地编译

1. 下载整个项目，保持文件结构不变。
2. 打开 `HZNU_Beamer_Template.tex`，替换标题、作者和正文内容。
3. 在项目根目录用 XeLaTeX 编译（两次以生成目录）：

```bash
xelatex HZNU_Beamer_Template.tex
xelatex HZNU_Beamer_Template.tex
```

查看效果展示（demo 目录自包含，可独立编译）：

```bash
cd demo
xelatex HZNU_BeamerTemplate_demo.tex
xelatex HZNU_BeamerTemplate_demo.tex
```

### Overleaf

上传整个项目目录，在 Overleaf 菜单中将编译器设为 **XeLaTeX**。

### 最小配置

```latex
\documentclass[10pt,aspectratio=169]{beamer}

\usepackage{ctex}
\usepackage{metalogo}
\usepackage{hznu}

\usefonttheme[onlymath]{serif}
```

## 源码检查

在 Windows PowerShell 中运行：

```powershell
.\tests\verify-source.ps1
```

该检查确认示例页面与主题关键功能完整，但不能代替 XeLaTeX 编译。

## 免责声明

本模板为**非官方**制作，**不保证**在各类学术活动、会议或答辩中的格式合规性。
使用前请确认主办方或所在学院的具体要求。
