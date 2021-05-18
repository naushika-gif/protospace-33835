# テーブル設計

## users テーブル

<!--null:false  空のレコードを保存できなくする -->

| Column     | Type    | Options     |
| --------   | ------  | ----------- |
| email      | string  | null: false |
| password   | string  | null: false |
| name       | string  | null: false |
| profile    | text    | null: false |
| occupation | text    | null: false | 
| position   | text    | null: false |

## Association

- has_many :user_comments
- has_many :users, through: user_comments
- has_many :prototypes

## comments テーブル

| Column     | Type       | Options     |
| ------     | ------     | ----------- |
| text       | text       | null: false |
| user       | references |             |    
| prototype  | references |             |

## Association

- has_many :user_comments
- has_many :users, through: user_comments
- has_many :prototypes


## user_commentsテーブル

| Column     | Type       | Options                        |
| ------     | ------     | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| comment    | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :comment


## prototypes テーブル

| Column     | Type       | Options     |
| --------   | ------     | ----------- |
| title      | string     | null: false |
| catch_copy | text       | null: false |
| concept    | text       | null: false |
| image      |            |             |
| user       | references |             |


## Association

- belongs_to :user
- belongs_to :comment
