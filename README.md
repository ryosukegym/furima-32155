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
- has_many :buyers

## items テーブル

| Column                | Type        | Options           |
| --------------------- | ----------- | ----------------- |
| title                 | string      | NOT NULL          |
| explanation           | text        | NOT NULL          |
| category_id           | integer     | NOT NULL          |
| product_condition_id  | integer     | NOT NULL          |
| delivery_fee_id       | integer     | NOT NULL          |
| prefectural_id        | integer     | NOT NULL          |
| day_to_ship_id        | integer     | NOT NULL          |
| price                 | integer     | NOT NULL          |
| user                  | references  | foreign_key: true |




### Association

- belongs_to :user
- has_one :buyer

## buyers テーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| user        | references | foreign_key: true |
| item        | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :shipping_address


## shipping_addresses テーブル

| Column         | Type       | Options               |
| -------------- | ---------- | --------------------- | 
| postal_code    | string     |  NOT NULL             |
| prefectural_id | integer    |  NOT NULL             |
| city           | string     |  NOT NULL             |
| street         | string     |  NOT NULL             |
| buyer          | references |  foreign_key: true    |
| building       | string     |                       |
| tel            | string     |  NOT NULL             |
### Association


- has_one :buyer