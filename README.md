# Name

SSSM ssBigClock Version002

## Overview

Windows用スクリーンセーバー(多分7以降なら動くのでは？Win10で開発)
画面いっぱいの大きなデジタル時計
マルチモニタ対応
フォント指定
表示色指定
背景色指定

## Requirement

Windows7以降?
開発と動作確認はWindows10
Delphi XE10.3で開発

## Setup

ssbigclock.scr を C:\Windows\System32 へコピー

## Screen shots
![Desktop](https://raw.githubusercontent.com/mikekoma/ssBigClock/master/readme/desktop.png)

![Settings](https://raw.githubusercontent.com/mikekoma/ssBigClock/master/readme/setting.png)

![Dialog](https://raw.githubusercontent.com/mikekoma/ssBigClock/master/readme/dialog.png)


## Licence

MIT License

Copyright (c) 2020 Suns & Moon Laboratory

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## History

2020-04-03 Ver002
 - フォントダイアログ、開いたときに設定値反映していなかったのを修正
 - FontColorの初期値を$404040から$202020に変更
 - 描画を1秒おきに統一(Main,Subで違っていた)
 - FormMainとFormSubのソースを1本にまとめた(可読性は落ちた)


2020-04-02 Ver001

## 参考資料
これ以上はないのじゃないかという解説記事。これ消えたらどうしようレベル。
これを参考にスレッドやめてマルチモニタ対応した感じです。これ調べてたらすごく時間かかったはず。

Delphi で作るスクリーンセーバー制作講座
http://www009.upp.so-net.ne.jp/rando/how2ss/index.html

## Author

Suns & Moon Laboratory
https://www.s-m-l.org
twitter @mikekoma
