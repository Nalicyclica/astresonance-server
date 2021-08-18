# Astresonanceのデータベース設計

## Userテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| icon_color         | string | null: false               |
| introduce          | text   | default: "よろしくお願いします" |

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
| text               | string     | null: false                    |
| user               | references | null: false, foreign_key: true |
| title              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :title

## Categoryの種類
    { id: 0, name: 'other' },
    { id: 1, name: 'melody' },
    { id: 2, name: 'song' }

## Genreの種類
  { id: 0, name: 'other' },
    { id: 1, name: 'Pops' },
    { id: 2, name: 'Rocks' },
    { id: 3, name: 'Jazzes' },
    { id: 4, name: 'Classics' },
    { id: 5, name: 'African world musics' },
    { id: 6, name: 'Asian world musics' },
    { id: 7, name: 'Europian world musics' },
    { id: 8, name: 'Latin American world musics' },
    { id: 9, name: 'Middle Eatern world musics' }
