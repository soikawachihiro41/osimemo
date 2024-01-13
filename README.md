<div align="center">
  <h1>osiMemories</h1>
  <img width="749" alt="placeholder" src="https://github.com/soikawachihiro41/osimemo/blob/main/app/assets/images/3.webp">
</div>

## サービスURL
https://www.osimemories.com/
## サービス概要
 仕事で疲れた時や落ち込んだ時に好きな人の写真を見てモチベーションを持ち直した経験ありませんか？
しかし、ついついお気に入りの写真もファルダに埋もれて撮ったことすら忘れてしまう。こんな経験、誰にでもあるはず
そんな悩み解決するため、サイトに写真を管理、定期的に撮った写真をLINEでランダムに届けてくれるサービスです。

## 想定されるユーザー層
推しと生活を共にしたい人

## サービスコンセプト
・ユーザーが抱えている課題感と提供するサービスでどのように解決するのか
　現代の生活はストレスフルで、癒しを求めている人が多いです。推しメモリーズはユーザーが好きな「推し」との思い出の写真をランダムに通知し、毎日の生活に小さな癒しと驚きを提供します。

・なぜそのサービスを作ろうと思ったのか
　私たちが日常生活で経験する幸せの一部は、推しとの思い出によってもたらされます。しかし、忙しい日常生活の中で、これらの思い出はしばしば忘れられがちです。それを思い出させ、日々の生活に癒しを提供することがこのサービスの目指すところです。

・どのようなサービスにしていきたいか
　UIを考え、推しとの思い出を最大限に楽しむことができるようなサービスにしていきたいと思っています。そのために、ユーザーが写真を簡単にアップロードし、自分だけの「推しメモリーズ」コレクションを作成することができるようにしたいと考えています。

・どこが売りになるか、差別化ポイントになるか
　ランダム通知機能により、予期せぬタイミングで推しの写真が届くサプライズ感、ユーザーが自身の推しとの思い出を自由に管理・共有できる自由度

## 使い方
| 準備：QRコードから友だち追加します。 | 1. トーク画面からアプリを開きます。 | 2. リッチメニューの使い方ボタンを押すとアプリの使い方が表示されます。 |
| ---- | ---- | ---- |
| <img src="https://raw.githubusercontent.com/soikawachihiro41/osimemo/main/app/assets/images/QR.webp" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/453c5080-79f7-4ce3-a116-d62ca09a4ecd" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/43f711de-e87e-4968-b9df-16e1bf9af0f3" width="500x500"> |

| 3.アプリ上から飯テロをします | 4.送り相手に画像付きの飯テロが届きます。 | Xシェアボタンを押すと飯画像付きのポストができます。　|
| ---- | ---- | ---- |
| <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/b273aea0-e67e-484e-b88a-72948cd52605" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/9fdf4655-219d-4d47-a13d-82371228f4a8" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/65b979c4-7867-46b1-aa59-c05d88a771d4" width="500x500"> |

# 主な機能

- ログイン（LINEログイン機能）
- 推し（新規作成、編集、詳細、削除、一覧表示）
- 写真（新規作成、編集、詳細、削除、一覧表示）
- 推し別アルバム機能（新規作成、編集、詳細、削除、一覧表示）
- タグ付け機能
- ライン連携
- ランダム通知
- Flex Message作成
- リッチメニューからのSHUFFLE MEMORIES機能
- リッチメニューからのFind a photo機能（撮影日検索）
- ソーシャルシェア機能（twitterシェア機能）
- OGPの追加
- みんなで作る推しアルバム
- 利用規約、プライバシーポリシー
- googleアナリティクス
- Googleフォント追加
- LINE Front-end Framework
- Heroku Scheduler
- Stimulus Autocomplete（Rails7）を使用して検索機能追加します。
- 推しの誕生日通知
- 独自ドメイン
- cloudinary（フェイスフォーカス機能、画像保存先）</br>

## 画面遷移図
Figma： https://www.figma.com/file/qRFv8pmmfvhrD6HxZXW2RB/%E6%8E%A8%E3%81%97%E3%83%A1%E3%83%A2%E3%83%AA%E3%83%BC%E3%82%BA%EF%BC%88%E4%BB%AE%EF%BC%89?type=design&node-id=13%3A1033&mode=design&t=I7Rw2a3wdbh54QNf-1

## ER図
[![Image from Gyazo](https://i.gyazo.com/72436008ce73d9cebe5430877e7f962c.png)](https://gyazo.com/72436008ce73d9cebe5430877e7f962c)

## 技術選定
- Rails7
- postgresql
- JavaScript
- TailWind CSS
- daisyUI
- heroku
- LINE Messaging API
- LINE Login
- cloudinary
