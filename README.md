<div align="center">
  <h1>osiMemories</h1>
  
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
