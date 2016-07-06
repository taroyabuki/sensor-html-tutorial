# iOS端末・Android端末のセンサをウェブアプリで利用する練習

> ハンマーしか持っていなければすべてが釘のように見える（アブラハム・マズロー）

## 準備

1. iOS端末ではSafariを使う。（Windowsからリモートでバッグできたため。）
1. Android端末ではFirefox（要インストール）を使う。（サポートするセンサーが多かったため。）
1. 指示されたURLにアクセスする。（ここでは使わない予定の）Chromeの場合は，httpsでアクセスする。

## 概要

センサーの値が変わると**イベント**が発生する。イベント名にイベントに対応する処理（**イベントハンドラ**）を結びつける。ここでは，センサーの値を表示するだけの簡単なイベントハンドラを作る。

```
<html>
<body>
センサー値：<span id="結果"></span>
<script>
window.addEventListener("イベント名", function (event) {
  上の「結果」のところにセンサー値を埋め込む。
});
</script>
</body>
</html>
```

* [近接センサー（Firefoxのみ）](proximity.html)
* [照度センサー（Firefoxのみ）](light.html)
* [加速度センサー](motion.html)
* [ジャイロセンサー](orientation.html)

位置情報センサーだけは例外で，起動時に読み取って終わりにする。つまり，値の変化に対応しない。

* [位置情報センサー](location.html)

## Tips

### サーバへの通知

センサーの値をサーバに通知する。サー部への通知は，`http://サーバのアドレス/sensor`というURLにアクセスすることで行う。ここではサーバ側のプログラムは作らず，送信されたデータをウェブサーバのログで確認することにする。Apache HTTP Serverなら，次のように確認できる。

```
sudo tail -f /var/log/apache2/access.log
```

照度・加速度・ジャイロセンサーは，センサーの値が変わるたびに送信するとデータが膨大になるため，多くても1秒に1回ということにする。そのためには，通知を行うかどうかを決めるタイマーオブジェクトを作って時間で管理すればよい（詳細はコードを参照）。

* [加速度センサー（サーバ通知）](motion-server.html)

### リモートデバッグ

1. （Android端末）PCに[Google USB Driver](https://developer.android.com/studio/run/win-usb.html)をインストールする。
1. （Android端末）開発者向けオプションを有効にする。
1. （Android端末）USBデバッグを有効にする。
1. （Android端末）Firefoxの設定→高度な設定→「USB経由でリモートでバッグをおこなう」を有効にする。
1. USBケーブルでスマートデバイスとPCを接続する。
1. PC版FirefoxのWebIDEを起動する（ツール→Web開発→WebIDEまたは`Shift-F8`）。
1. （Android端末）WebIDEのUSBデバイスのところに現れる端末をクリックする。
1. （iOS端末）WebIDEの「Safari, Firefox, and other WebViews on iOS」をクリックする。
1. デバイスのブラウザで開いているタブを選べるようになる。

加速度センサー（サーバ通知）では，通信の結果をコンソールに出力するようになっている。PC上でそれを確認できれば成功。

### チャートを描く

センサーの値のような時系列データは，折れ線グラフを描くとわかりやすい。グラフを描く簡単な方法の一つに，[Google Charts](https://developers.google.com/chart/)がある。

* [加速度センサー（チャート）](motion-chart.html)

### サーバの構築

演習時にはサーバをあらかじめ用意するが，自分でサーバを用意したい場合は，gitとVagrantのある環境で，次のようにすればよい。

```
git clone https://github.com/taroyabuki/sensor-html-tutorial.git
cd sensor-html-tutorial
vagrant up
```

## 参考資料

* [スマートフォンはセンサーの塊！ たった数行のHTML5とJSで扱えるセンサーまとめ(デモ・動画あり)](https://ics.media/entry/4095)
* [USB 経由で Android 版 Firefox に接続する](https://developer.mozilla.org/ja/docs/Tools/WebIDE/Troubleshooting#Connecting_to_Firefox_for_Android_over_USB)
