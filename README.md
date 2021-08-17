# Astresonanceのデータベース設計

## Userテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| icon_color         | string | null: false               |

### Association

- has_many :musics
- has_many :titles
- has_many :comments
- has_one :profile
- has_one_attached :icon

## Musicテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| category_id         | integer    | null: false                    |
| genre_id            | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :titles
- has_one_attached :music

## Titleテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| color              | string     | null: false                    |
| user               | references | null: false, foreign_key: true |
| music              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :music
- has_many :comments
- 空のタイトル＝視聴履歴？

## Commentテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| text               | text       | null: false                    |
| user               | references | null: false, foreign_key: true |
| title              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :title

## Profileテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| introduce          | text       |                                |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
