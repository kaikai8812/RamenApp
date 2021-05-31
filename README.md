# 作成したアプリ
お気に入りのラーメンをシェアするアプリ

<img width="810" alt="スクリーンショット 2021-05-31 10 23 14" src="https://user-images.githubusercontent.com/75291461/120127478-6f67f200-c1fa-11eb-9ac4-470db89e9938.png">

## 制作期間
  2021/05/25 ~

## 機能一覧
- ラーメン投稿機能
  - ラーメン画像、店名、値段、感想、レーティング、カテゴリーを選択して投稿する。
 
- マイページ機能
  - プロフィール画像、名前、自己紹介を登録して、表示する。
 
- フォローフォロワー機能
  - 他の人のプロフィール画面に行った際に、その人物をフォローすることができる。
  
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

- 画面サイズ別にStoryBoard別でレイアウトを作成することで、以下の画面サイズに対応しました。
  - IPhone12 ProMax
  - IPhone12 Mini
  - IPhone12 
  - IPhone11 ProMax
  - IPhone11 
  - IPhone8 Plus
  - IPhone SE(第２世代)

IPhone12 ProMax / iPhone12 / IPhone12 Mini / IPhone11 / IPhone11 ProMax / IPhone8 Plus / IPhone SE(第２世代)
  
  
    
    
## 今後追加予定の機能
- ログイン、ログアウト機能
- 各種SNS(Twitter,FaceBook等)を用いた会員登録
- GoogleMapAPIを用いて、投稿情報に、お店の位置情報を追加する
- ActiveLabelを用いて、投稿にハッシュタグを使用できるようにする
- ハッシュタグ別に投稿が確認できる機能を作成する
