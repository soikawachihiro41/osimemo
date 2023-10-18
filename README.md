# [推しメモリーズ]

## サービス概要
 推しメモリーズは、あなたが愛する「推し」（お気に入りのキャラクター、ペット、恋人、子供など）との思い出の写真をLINE通知でランダムに届けてくれるサービスです。
   毎日の生活に癒しを提供し、自分でも忘れていた思い出の写真を再発見ができます。

## 想定されるユーザー層
推しと生活を共にしたい人

## サービスコンセプト
・ユーザーが抱えている課題感と提供するサービスでどのように解決するのか
　現代の生活はストレスフルで、癒しを求めている人が多いです。推しメモリーズはユーザーが好きな「推し」との思い出の写真をランダムに通知し、毎日の生活に小さな癒しと驚きを提供します。

・なぜそのサービスを作ろうと思ったのか
　私たちが日常生活で経験する幸せの一部は、推しとの思い出によってもたらされます。しかし、忙しい日常生活の中で、これらの思い出はしばしば忘れられがちです。それを思い出させ、日々の生活に癒しを提供することがこのサービスの目指すところです。

・どのようなサービスにしていきたいか
　私たちはユーザーが推しとの思い出を最大限に楽しむことができるようなサービスにしていきたいと思っています。そのために、ユーザーが写真を簡単にアップロードし、自分だけの「推しメモリーズ」コレクションを作成することができるようにしたいと考えています。

・どこが売りになるか、差別化ポイントになるか
　ランダム通知機能により、予期せぬタイミングで推しの写真が届くサプライズ感、ユーザーが自身の推しとの思い出を自由に管理・共有できる自由度

## 実装を予定している機能
### MVP
* ログイン（LINEログイン機能）
* 写真アップロード
* 写真一覧
* ライン連携
* ランダム通知

### その後の機能
* 推し別アルバム機能
* ソーシャルシェア機能
* 推し誕生日通知機能

## 画面遷移図
Figma： https://www.figma.com/file/qRFv8pmmfvhrD6HxZXW2RB/%E6%8E%A8%E3%81%97%E3%83%A1%E3%83%A2%E3%83%AA%E3%83%BC%E3%82%BA%EF%BC%88%E4%BB%AE%EF%BC%89?type=design&node-id=13%3A1033&mode=design&t=I7Rw2a3wdbh54QNf-1

### READMEに記載した機能
- [ ] 写真投稿機能
- [ ] 写真検索機能
- [ ] アルバム閲覧機能
- [ ] アルバム編集機能
- [ ] アルバム削除機能
- [ ] 誕生日登録機能
- [ ] 誕生日登録編集機能
- [ ] 誕生日削除機能


### 未ログインでも閲覧or利用できるページ
以下の項目はちゃんと未ログインでも閲覧or利用できる画面遷移になっているか？
- [ ] トップページ
- [ ] みんなの推しアルバム

### メールアドレス・パスワード変更確認項目
直に変更できるものではなく、一旦メールなどを介して専用のページで変更する画面遷移になっているか？
[ ] LINEログイン機能を使用を行うため作成していません。

### 想定URL
[こちら](https://xd.adobe.com/view/53d16b6b-bcdf-479b-4e6a-a67539af96c5-25e0/grid/)と同様にURLを記載している場合は違和感がないものになっているか？（必須ではありません）
- [ ] 特に違和感を感じなかった

## ER図
[![Image from Gyazo](https://i.gyazo.com/1ffbc74fcc9fb7e6c894824c233e40f1.png)](https://gyazo.com/1ffbc74fcc9fb7e6c894824c233e40f1)

## 技術選定
- Rails7
- postgresql
- JavaScript
- TailWind CSS
- daisyUI
- heroku
- LINE Messaging API
- LINE Login
