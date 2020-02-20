> # オタク！ラジオを聞き逃すな！ってことで作るradio録音
> ## 録音対応プラットフォーム
> - Radiko
> - 超A&G+
> - 音泉
> - 響  
>
> ゆるゆるさんのREADMEより引用

# 対象者  
- 声優さんのラジオ番組を自動で録音したい！
- Windows10 64bit Homeだよ？
- Dockerってなに？
- Linuxってなに？
- Pythonってなに？

こんな感じのお方でも、[ゆるゆる](https://twitter.com/taittide)さんの作成された素晴らしいプログラム「[Rec-adio](https://github.com/sun-yryr/Rec-adio)」を利用できるようになります。

# 前提条件
- Windows 10 64bit Home (Proは後述)
- Docker Toolbox を導入する努力  
  
Dockerという仮想化技術を使って、Windows上にLinux(Ubuntu 18.04 LTS)のコンテナ(環境)を構成します。
Proの場合はハードルが低いのですが、Homeの場合一手間かかります…

# 全体の流れ
1. Docker Toolboxの導入
2. 共有フォルダの設定(Proの場合は必要なし)
3. GitHubから構成用ファイルのダウンロードと展開
4. LINE Notifyの登録(録音結果をLINEで通知したい人だけ)
5. 設定ファイルの書き換え
6. バッチファイルの実行
7. あとは待つだけ…

# Dockerの導入
まずはこちらのサイトを参考に、Dockerを導入しましょう。
> windows 10 home で docker を導入するメモ  
> https://qiita.com/idani/items/fb7681d79eeb48c05144  

肝心のダウンロード用リンクがわかりにくいので、ここに書いておきますね。
> Docker Toolbox  
> https://github.com/docker/toolbox/releases  

`DockerToolbox-19.03.1.exe`をダウンロードしてください。  
※2020/02/20 時点

インストールが終わって、無事に`Docker Quickstart Terminal`が起動したら、`exit`と入力してウィンドウを閉じましょう。

# 共有フォルダの設定
Dockerコンテナで保存したデータは、仮想化環境に保存されてしまうので、Windows(ホスト)にデータが保存されるように、共有フォルダの設定が必要になります。  
※Proの場合は必要ありません。
1. `Oracle VM VirtualBox マネージャー`を起動
2. `設定ボタン`をクリック
3. `共有フォルダー`を選択
4. 画面右のフォルダの`＋`をクリック
5. フォルダーのパスに`C:\`を選択
6. フォルダー名は`C_DRIVE`になるはず
7. `自動マウント`にチェック
8. `永続化する`にチェック
9. `OK`を選択
10. 設定画面を`OK`で閉じる
11. ツールバーの`仮想マシン(M)`から`リセット(R)`を実行  
※警告画面が出るかもしれませんが、無視しても構いません
12. `Oracle VM VirtualBox マネージャー`は`最小化`しておく
13. `Docker Quickstart Terminal`を実行してクジラのAAが出てきたらOK、`exit`で閉じておきましょう

# 構成用ファイルのダウンロードと展開

1. ダウンロード
2. 解凍
3. C:ドライブ直下に展開  

> Windows10 HomeでRec-adioのDockerコンテナを作りますよ？  
> https://github.com/ryohei-ochi/Docker-Rec-adio  

こちらから、右の方にある緑のボタン`Clone or download`の`Download ZIP`で、ZIPファイルをダウンロードして、解凍します。  
以下のように、すべてのファイルとフォルダを展開します。

```
C:\Docker\Rec-adio\conf
C:\Docker\Rec-adio\savefile
C:\Docker\Rec-adio\docker-compose.yml
C:\Docker\Rec-adio\01_start_build.bat
C:\Docker\Rec-adio\02_stop.bat
～以下省略～
```

# LINE Notifyの登録
録音結果をLINEで受け取りたい方は、こちらのサイトを参考に`アクセストークン`を取得して、メモしておいてください。

> [超簡単]LINE notify を使ってみる  
> https://qiita.com/iitenkida7/items/576a8226ba6584864d95  

1. `トークン名`は任意です、`録音鯖`とでもしておきましょう
2. トークルームは自分だけが受け取れれば良いので`1:1でLINE Notifyから通知を受け取る`を選択すれば良いと思います
3. このサイトの`トークン`をメモするところまででOKです

# 設定ファイルの書き換え
`C:\Docker\Rec-adio\conf`にある`config.json`を編集します。  
前項でLINE notifyのアクセストークンをメモした方は`line_token`の`アクセストークン`にトークンをコピペしましょう。  
`keywords`には、録音したい出演者やタイトルなどを入力します。  
何行追加しても問題ないですが、**最後の行に`,`がつかないように気をつけてください。**  
ちなみにデフォルトでの動作確認用として、超！A&Gの毎日21時台の番組出演者を設定してあります。

```json:config.json
{
    "all": {
        "savedir": "",
        "dbx_token": "",
        "line_token": "アクセストークン",
        "keywords": [
            "夏川椎菜",
            "大西沙織"
        ]
    },
    "mysql": {
        "hostname": "mysql-server",
        "port": "3306",
        "username": "radio",
        "password": "password",
        "database": "radio_db"
    }
}
```
# バッチファイルの実行
準備は整いました、いよいよです。  
`C:\Docker\Rec-adio\01_start_build.bat`をダブルクリックで実行してください。  
環境にもよりますが、しばらく時間がかかりますので、アニメでも消化しておきましょう。  

こんな画面になれば、無事にDockerコンテナ(仮想化環境)の完成です。

```
～省略～
Successfully tagged rec-adio_os:latest
Starting mysql-server ... done
Starting phpmyadmin   ... done
Starting ubuntu1804   ... done
Attaching to phpmyadmin, mysql-server, ubuntu1804
～省略～
ubuntu1804    | SAVEROOT : /src/Rec-adio/savefile
ubuntu1804    | (夏川椎菜|大西沙織)
ubuntu1804    | (夏川椎菜|大西沙織)
ubuntu1804    | (夏川椎菜|大西沙織)
ubuntu1804    | (夏川椎菜|大西沙織)
```


# 録音されたファイルの保存先
`C:\Docker\Rec-adio\savefile`以下に保存されますので、あとは煮るなり焼くなり好きに使いましょう。

# サーバの停止
`C:\Docker\Rec-adio\02_stop.bat`をダブルクリックで実行してください。

# 設定変更の手順
1. サーバの停止
2. `config.json`を編集
3. `C:\Docker\Rec-adio\01_start_build.bat`の実行

# 自動起動は難しい
Homeの場合、Windowsを再起動した際に、Dockerコンテナを自動的に起動させるのは難しいです。
1. `Docker Quickstart Terminal`の実行と`exit`
2. `C:\Docker\Rec-adio\01_start_build.bat`の実行  

この2つの手順を踏む必要があります。

# Dockerの完全初期化
謎の不具合や、コンテナをアンインストールしたい場合などは、以下のコマンドを`PowerShell`で実行してください。
```
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

docker network prune -f
docker rmi -f $(docker images --filter dangling=true -qa)
docker volume rm $(docker volume ls --filter dangling=true -q)
docker rmi -f $(docker images -qa)
```

# Proの場合
- Docker for Windowsをインストール  
- `C:\Docker\Rec-adio\01_start_build.bat`の実行中に、共有許可を求める通知が出るので`Share　it`で許可する  
- コンテナの自動起動もできるはず？