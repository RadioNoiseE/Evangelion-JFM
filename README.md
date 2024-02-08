# Evangelion Japanese Font Metric

## 简介・簡単な紹介・Some Information

`Eva-JFM`是一个为在LuaTeX-ja下使用行间标点、压缩字体等特性设计的JFM文件。其可用于简中、繁中、日文字体，充分利用priority特性（数据来源jlreq），支持直书，同时为繁体字体进行优化（如行末、与直角引号之间等）。

详细请看[简体中文文档](Eva-JFM_doc-sc.pdf)。

本项目已上传至[CTAN](https://www.ctan.org/pkg/evangelion-jfm)。

このメトリックは、縦書きと横書きの両方のテキストに対して、従来の中国語、簡体字中国語、および日本語のフォント とともに使用できます。これは、LuaTeX-jaで提供される優先機能を最大限に活用するフォントメトリックを提供し、標準に基づき、一部の高度な（すなわち、めったに使用されない）機能をサポートすることを目的としています。

より多くの情報は[ドキュメント](Eva-JFM_doc-jp.pdf)を見てください。

それは[CTAN](https://www.ctan.org/pkg/evangelion-jfm)にアップロードされました。

`Eva-JFM` is a JFM file which aims to support 'linegap puncutations', 'scaled font' and more features under LuaTeX-ja. It can be used with Traditional Chinese, Simplified Chinese and Japanese fonts, supporting vertical typesetting, making full-use of the `priority` feature, and added special support for Traditional Chinese font. It's based on jlreq, and insipered by `min10.tfm`. All its nine features are embeded into one single file `jfm-eva.lua` to simplify the using.

For more datails please see the [English documentation](Eva-JFM_doc-en.pdf). 

This package is also available on [CTAN](https://www.ctan.org/pkg/evangelion-jfm).

## 支持特性・サポート機能・Supported Features

- 行间标点 行間句読点 Linegap Punctuations

- 标点悬挂 ぶら下げ Hanging Punctuations

- 简体中文 簡体字中國語 Simplified Chinese

- 繁体中文 繁体字中国語 Traditional Chinese

- 日本语 日本語 Japanese

- 直书 縱組 Vertical Typesetting

- 半宽西文 半角歐文 Half-width Alphabets

- 全宽西文 全角歐文 Full-width Alphabets

- 忽略标准 非標準 Non-standard

- 原始 調整なし Plain

- 原始比例宽度 プロポーショナル（調整なし） Proportional (with no aki adjust for punct)

- 比例宽度 プロポーショナル Proportional

## 状态・現在のバージョン・Current Version

`Ver 1.0.5 (c)`

## 历史・変更ログ・Changelog

- 2024.2.8 Ver 1.0.5 (c): fix the variable scope for `extd_ratio`, this should fix the nil error.

- 2023.8.25 Ver 1.0.5 (b): add feature `prop` and `propw` for japanese typesetting.

- 2023.8.23 Ver 1.0.5 (a): add character `U+2E3A` and `U+2E3B` to be compatible with Source Han Fonts' ligatures.

- 2023.8.3 Ver 1.0.4 (f): ''optimized'' the behaviour of TC punct at line end.

- 2023.5.19 Ver 1.0.4 (e): update japanese documentation and README.

- 2023.5.17 Ver 1.0.4 (c): sync the documentation (en&sc) for the new feature.

- 2023.5.16 Ver 1.0.4 (b): trobble with error handling is fixed (i hope).

- 2023.5.14 Ver 1.0.4 (a): add feature `plain` for verbatim environments.

- 2023.5.5 Ver 1.0.3 (d): revised code and documentation.

- 2023.4.26 Ver 1.0.3 (c): jp doc (fin).

- 2023.4.25 Ver 1.0.3 (b): jp doc (mid).

- 2023.4.24 Ver 1.0.3 (a): the Japanese documentation (ini).

- 2023.4.15 Ver 1.0.2 (h): revised English doc and add reference.

- 2023.4.2 Ver 1.0.2 (g): typeset English document and revised both.

- 2023.3.19 Ver 1.0.2 (f): fix `extd_ratio` and add `end_adjust` for midp.

- 2023.3.18 Ver 1.0.2 (e): line-end adjust key fixed.

- 2023.3.15 Ver 1.0.2 (d): revised documentation.

- 2023.3.13 Ver 1.0.2 (c): entire documentation translated to English.

- 2023.3.12 Ver 1.0.2 (b): the English documentation (section 3).

- 2023.3.12 Ver 1.0.2 (a): the English documentation (section 1 & 2).

- 2023.3.6 Ver 1.0.1 (f): adjust kanjiskip after `lgp`.

- 2023.3.3 Ver 1.0.1 (e): fix `extd_ratio`.

- 2023.2.27 Ver 1.0.1 (d): fix `parbdd` and `boxbdd`.

- 2023.2.26 Ver 1.0.1 (c): users can now customize ratio for `extd` feature.

- 2023.2.26 Ver 1.0.1 (b): docstrip, updated documentation.

- 2023.2.25 Ver 1.0.1 (a): add feature `hwid` and `fwid`.

- 2023.2.24 Ver 1.0.0 (d): more `priority`, revised document.

- 2023.2.18 Ver 1.0.0 (c): fix bug and updated documentation, uploaded to ctan, and added feature `hanging punc`.

- 2023.2.11 Ver 1.0.0 (b): fixed feature `lgp` and added documentation.

- 2023.2.7 Ver 1.0.0 (a): initial version.

## Copyright

This project is under MIT License. (Ref [`license`](LICENSE))

Author: RadioNoiseE, 黄京.

Email Addr: `j18516785606@icloud.com`.
