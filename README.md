# テーブル設計

## users テーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | NOT NULL    |
| email                | string  | unique:true |
| encrypted_password   | string  | NOT NULL    |
| last_name            | string  | NOT NULL    |
| first_name           | string  | NOT NULL    |
| first_name_katakana  | string  | NOT NULL    |
| last_name_katakana   | string  | NOT NULL    |
| birthday             | date    | NOT NULL    |

### Association

- has_many :items
- has_many :buyer

## items テーブル

| Column                | Type       | Options           |
| --------------------- | ---------- | ----------------- |
| title                 | string     | NOT NULL          |
| explanation           | string     | NOT NULL          |
| category_id           | string     | NOT NULL          |
| product_condition_id  | string     | NOT NULL          |
| delivery_fee_id       | string     | NOT NULL          |
| prefectural_id        | string     | NOT NULL          |
| day_to_ship_id        | string     | NOT NULL          |
| price                 | integer    |                   |
| user                  | references | foreign_key: true |




### Association

- belongs_to :user
- has_one :buyer

## buyers テーブル

| Column      | Type       | Options---------- |
| ----------- | ---------- | ----------------- |
| user        | references | foreign_key: true |
| item        | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :buyer


## shipping_address テーブル

| Column      | Type       | Options               |
| ----------- | ---------- | --------------------- | 
| postal_code | string     |  NOT NULL             |
| prefectural | references |  NOT NULL             |
| city        | string     |  NOT NULL             |
| street      | string     |  NOT NULL             |
| buyer       | references |                       |
| building    | string     |  NOT NULL             |
| tel         | integer    | : false, unique: true |
### Association

- belongs_to :buyer