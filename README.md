# はじめに
アプリを作成する前にあたり、学習した内容をいかにまとめました。参考にしていただきますと幸いです。

## 学習内容
企業課題にてSwiftを用いたアプリを作成するため、まずはSwiftの基礎を固めるために、Udemyの以下の講座を利用して学習を行いました。(学習期間 5/10 ~ 現在)
  https://www.udemy.com/course/ios14-iphone-ios-boot-camp/ 
 
 また、学習は、以下のリポジトリで行いました。
 https://github.com/kaikai8812/swift-practice
 
 以上の講座を用いて、swiftの基礎的な文法、MVCモデルを用いたアプリの作成、storyboardを用いたアプリの作成、各種APIを用いたJSON解析やXML解析の使用方法を学びました。 <br>
 swift、およびモバイルアプリに関する勉強はここで初めて行いましたが、日々の生活でとても身近に感じるモバイルアプリに関する勉強はとても興味深く、一貫して楽しく学習することができました。

# 作成したアプリ
お気に入りのラーメンをシェアするアプリ

<img width="810" alt="スクリーンショット 2021-05-31 10 23 14" src="https://user-images.githubusercontent.com/75291461/120127478-6f67f200-c1fa-11eb-9ac4-470db89e9938.png">

## 制作期間
  2021/05/25 ~

## 機能一覧
- 投稿機能
  ラーメン画像、店名、値段、感想、レーティング、カテゴリーを選択して投稿することができます。

- 投稿一覧画面
  投稿された投稿物を上部タブを用いてカテゴリー別に閲覧することができます。
  
- 投稿詳細画面
  投稿されたラーメンを、その場でネットで検索することができます。
 
- マイページ機能
   プロフィール画像、名前、自己紹介を登録して、表示します。
 
- フォローフォロワー機能
   他の人のプロフィール画面に行った際に、その人物をフォローすることができます。
  
## 使用ライブラリ
- Firebase
    ---- firebaseの各機能を使用するために導入
- Firebase/Firestore
    ---- 投稿データ、ユーザーデータ、フォローフォロワーデータのデータベースとして使用
- Firebase/Auth
    ---- ユーザー認証のため使用
- Firebase/Storage 
    ---- ラーメン投稿画像、およびプロフィール画像の画像データ保存のため使用
- EMAlertController
    ---- 各種アラート表示のため使用
- SDWebImage 
    ---- URLから画像を取得するために使用
- AMPagerTabs
    ---- 上部タブを用いて、カテゴリー別に投稿を表示するために使用
- YPImagePicker
    ---- フィルター付きカメラを使用するために使用
- Cosmos
    ----  投稿のレーティング機能のため使用
- IQKeyboardManagerSwift
    ---- キーボードの表示時にテキストフィールドが隠れないようにするために使用
- PKHUD
    ---- ローディング画面表示のために使用
- SSSpinnerButton 
    ---- フォローボタンのアニメーションのために使用

## レイアウトに関して

- 画面サイズ別にstoryBoard別でレイアウトを作成することで、以下の画面サイズに対応しました。
  - iPhone12 ProMax
  - iPhone12 Mini
  - iPhone12 
  - iPhone11 ProMax
  - iPhone11 
  - iPhone8 Plus
  - iPhone SE(第２世代)
    
    
## 今後追加予定の機能
- ログイン、ログアウト機能
- 各種SNS(Twitter,FaceBook等)を用いた会員登録
- GoogleMapAPIを用いて、投稿情報に、お店の位置情報を追加する
- ActiveLabelを用いて、投稿にハッシュタグを使用できるようにする
- ハッシュタグ別に投稿が確認できる機能を作成する

# 最後に

ご覧いただきありがとうございました！
最後にですが、これからの学習指針をまとめたので、見ていただけると幸いです。 <br>
よろしくお願いします。


## これからの学習指針

  今後の学習の指針として、以下のような学習を行おうと考えています。
  
  - 作成したラーメンアプリの改善
    学習でインプットした内容を実際に作成したアプリに実装することによって、自分の技術として定着させるため。
    
  - 書籍を用いたswift言語の学習
    Udemyを通じて基本的なアプリの作成方法、流れを学ぶことができましたがswiftそのものの言語仕様や文法についてはまだまだ知識が足りないと考えています。
    よってそのような知識を学ぶために以下の書籍で学んでいきます。
    https://gihyo.jp/book/2020/978-4-297-11213-4
    
  - 英語学習
    swiftの学習を進めていくにつれて、rubyを学習しているときに比べ英語の参考文献が多くあることを感じました。
    また、Appleの公式ドキュメントやカンファレンスも英語のものが多く、Swiftに関する最新の情報を得るためには英語の文章を読める程度の英語力が必要だと感じました。
    したがって、英語の勉強、その中でも現在は単語を主に勉強しています。

