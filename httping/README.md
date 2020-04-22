## HTTP の応答時間を調べてグラフ化するツール

詳しくは次のページを参照：
https://ha-na-chan.github.io/tech-matome/tools/index.html

web サーバの HTTP の応答時間を記録し、グラフ化します。

サーバへの ping だとサーバーは生きているのは分かりやすいけど、web サーバだし HTTP の健全性も見たいよなあ……と思って作りました。

`httping` 、文字通り `http + ping` みたいなものを利用しています。

![sample](1day_www.XXXXXX.com.png)

## つかいかた

### インストール

`httping` と、データの格納＆グラフ化に RRDtool を使いますのでインストールします。
これらについての説明は、用意した別のページを参照してください。

```
sudo apt install httping
sudo apt install rrdtool
```

次に、`httping.sh` と `initial.sh` を、任意の同じディレクトリにおいてください。
`httping.sh` の 10行目にファイルの保存先を書き込むところがあるので、これを任意の場所に変更します。

```DIR="/home/USER/Documents"```

### httping とグラフ化

`httping.sh` を下記のように実行します。

```$ sh httping.sh <web サーバのアドレス>```

たぶんこれで必要なファイルと、グラフ化（3つ分）はできていると思います。その後に、cron などに適宜登録しておけば、グラフが描かれていきます。

最初のうちは、データが少なすぎるのでグラフは描画されません。詳しくは説明ページを参照してください。


