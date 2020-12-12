# テーブル設計

## users テーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | NOT NULL    |
| email                | string  | NOT NULL    |
| password             | string  | NOT NULL    |
| last_name            | string  | NOT NULL    |
| first_name           | string  | NOT NULL    |
| first_name_hiragana  | string  | NOT NULL    |
| last_name_hiragana   | string  | NOT NULL    |
| first_name_katakana  | string  | NOT NULL    |
| last_name_katakana   | string  | NOT NULL    |
| birthday             | date    | NOT NULL    |
| tel                  | integer | NOT NULL    |

### Association

- has_many :items
- has_many :buyer

## items テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| title              | string     | NOT NULL    |
| explanation        | string     | NOT NULL    |
| category           | string     | NOT NULL    |
| product_condition  | string     | NOT NULL    |
| delivery_fee       | string     | NOT NULL    |
| shipping_area      | string     | NOT NULL    |
| day_to_ship        | string     | NOT NULL    |
| price              | references |             |
| user               | references |             |




### Association

- belongs_to :user
- has_one :buyer

## buyers テーブル

| Column      | Type       | Options    |
| ----------- | ---------- | -----------|
| user        | references |            |
| item        | references |            |

### Association

- belongs_to :user
- belongs_to :item
- has_one :buyer


## shipping_address テーブル

| Column      | Type       | Options    |
| ----------- | ---------- | -----------|
| postal_code | string     |  NOT NULL  |
| prefectural | references |            |
| city        | string     |  NOT NULL  |
| street      | string     |  NOT NULL  |
| buyer       | references |            |

### Association

- belongs_to :buyer