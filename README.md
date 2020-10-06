# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Table Design

## users table

| Column          | Type   | Options             |
| --------------- | ------ | ------------------- |
| nickname        | string | null: false         |
| email           | string | null: false, unique |
| password        | string | null: false         |
| first_name      | string | null: false         |
| first_name_kana | string | null: false         |
| last_name       | string | null: false         |
| last_name_kana  | string | null: false         |
| birth_date      | date   | null: false         |

### Association

- has_many :items
- has_many :items, through: :transactions
- has_many :cards
- has_many :postals

## items table

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| user_id                | references | null: false, foreign_key: true |
| name                   | string     | null: false                    |
| information_text       | text       | null: false                    |
| category_id            | integer    | null: false                    |
| status_id              | integer    | null: false                    |
| shipping_fee_status_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| scheduled_delivery_id  | integer    | null: false                    |
| sell_price             | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :transaction

## cards table

| Column    | Type       | Options     |
| --------- | ---------- | ----------- |
| user_id   | references | null: false |
| number    | string     | null: false |
| exp_month | string     | null: false |
| exp_year  | string     | null: false |
| cvc       | string     | null: false |

### Association

- belongs_to :user

## postals table

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user_id       | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | integer    | null: false                    |
| addresses     | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to :user

## transactions table

| Column    | Type | Options                              |
| --------- | ---- | ------------------------------------ |
| user_id   | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |
| card_id   | references | null: false, foreign_key: true |
| postal_id | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :item
belongs_to :card
belongs_to :postal