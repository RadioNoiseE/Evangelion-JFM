# Evangelion Japanese Font Metric

## 简介  Some Information

`Eva-JFM`是一个为在LuaTeX-ja下使用行间标点、压缩字体等特性设计的JFM文件。其可用于简中、繁中、日文字体，完全利用priority特性（数据来源jlreq），支持直书，同时为繁体字体进行优化（如行末、与直角引号之间等）。七个特性全集中与一个`Lua`文件中，可简单调用。

详细请看[文档](Evangelion-doc.pdf)。

`Eva-JFM` is a JFM file which aims to support 'linegap puncutations', 'scaled font' and more features under LuaTeX-ja. It can be used with Traditional Chinese, Simplified Chinese and Japanese fonts, supporting vertical typesetting, making full-use of the `priority` feature, and added special support for Traditional Chinese font. It's based on jlreq, and insipered by `min10.tfm`. All its seven features are embeded into one file `jfm-eva.lua` to simplify the using.

For more datails please see the [documentation](Evagelion-doc.pdf). The English and Japanese documentation is still in progress.

## 状态 Current Version
`Ver 1.0.0 (c)`

## 历史 Changelog
- 2023.2.18 Ver 1.0.0 (c): fix bug and updated documentation, uploaded to ctan, and added feature`hanging punc`.

- 2023.2.11 Ver 1.0.0 (b): fixed feature `lgp` and added the documentation.

- 2023.2.7 Ver 1.0.0 (a): the first version.

## Copyright
This project is under MIT License.

Author: RadioNoiseE.

Contact: j18516785606@icloud.com.
