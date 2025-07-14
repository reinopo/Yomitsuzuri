# 読綴 -Yomitsuzuri-
著者単位で読書ログを整理できる、読書記録Webアプリです。  
Google Books APIを用いた作品検索、読書状況の管理、著者ごとの作品年表の表示などを実装しています。  
スマートフォンからもご確認いただけます。  

#### テスト用アカウント
メールアドレス： test@example.com  
パスワード： password  
サイトURL： https://www.yomitsuzuri.com

<a href="https://www.yomitsuzuri.com" target="_blank" rel="noopener noreferrer">
  <img src="./docs/kv.png" width="800" alt="キービジュアル">
</a>

## ターゲットユーザー
- 好きな著者の作品をコレクションして制覇したい人
- SNS機能を必要とせず、自分だけのために読書記録をつけたい人

## 主な機能
| 本を検索 | 本を登録 |
|-----------|-----------|
| <img src="./docs/search.gif" width="380"> | <img src="./docs/register.gif" width="380"> |

| 著者をお気に入りに登録 | 著者ページ |
| --- | --- |
| <img src="./docs/favorite.gif" width="380"> | <img src="./docs/author.gif" width="380"> |

| 引用を追加 | 引用を一覧で振り返る |
| --- | --- |
| <img src="./docs/add-citation.gif" width="380"> | <img src="./docs/citation.gif" width="380"> |

## 使用技術
| カテゴリ | 技術 |
| --- | --- |
| フレームワーク | Ruby on Rails 7.1.5.1 |
| バックエンド | Ruby 3.4.3 / Rails |
| フロントエンド | HTML / SCSS / JavaScript |
| DB | PostgreSQL |
| 認証機能 | Devise |
| API | Google Books API |
| インフラ | Heroku + Cloudinary + Cloudflare |
| 開発環境 | Mac + VSCode + Rails + PostgreSQL |

## 機能一覧
#### ユーザー認証 (Devise)
- 新規登録 / ログイン機能

#### 書籍検索・保存 (Google Books API)
- タイトルや著者名で本を検索
- 検索にマッチした本の情報を形成し表示・DBに保存

#### 読書ログ登録・編集
- 本ごとに引用メモ・コメント・既読 / 未読 / 積読を登録
- 個別の作品ページで本の情報を表示、読書ログを編集・削除
- 引用メモを複数登録
- 出版年の情報がない場合は編集可能

#### マイページ
- 登録した本を一覧で表示
- 登録したお気に入り著者を一覧で表示
- 登録した引用メモを一覧で表示

#### 著者をお気に入りに登録
- お気に入りに登録した著者の本を年代順に表示・読了率表示
- 著者をお気に入りから削除

#### プロフィール画像アップロード (Active Storage + Cloudinary)

#### レスポンシブ対応
- PC、タブレット、スマートフォンに対応

## ER図
<img src="./docs/erd.png" width="800" alt="ER図">

## 今後の実装予定
- 著者プロフィール記載（MediaWiki API導入）
- 検索結果における作品数増加
- お気に入り著者を任意の順に並び替え