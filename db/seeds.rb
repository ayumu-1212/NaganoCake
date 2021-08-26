# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Admin.create!(
    email: "a@a",
    password: "aaaaaa"
)

100.times do |n|
    gimei = Gimei.new
    address = Gimei.address
    email = Faker::Internet.email
    tel = Faker::Number.number(digits: 11).to_s
    postal_code = Faker::Number.number(digits: 7).to_s
    EndUser.create(
        last_name: gimei.last.kanji,
        first_name: gimei.first.kanji,
        last_name_kana: gimei.last.katakana,
        first_name_kana: gimei.first.katakana,
        address: address.kanji,
        email: email,
        phone_number: tel,
        postal_code: postal_code,
        password: "password"
    )
end

Genre.create(name: "ケーキ")
Genre.create(name: "プリン")
Genre.create(name: "焼き菓子")
Genre.create(name: "キャンディ")
Genre.create(name: "ゼリー")
Genre.create(name: "和菓子")

sweets = [
    [
    "ショートケーキ",
    "シフォンケーキ",
    "モンブラン",
    "ロールケーキ",
    "フルーツケーキ",
    "ブッシュ・ド・ノエル",
    "スフレ",
    "キルシュトルテ"
    ],[
    "革命プディング",
    "夢プリン",
    "プレミアム・プリン",
    "プレミアム・プディング",
    "とっても濃厚。旦那もやみつきプリン！",
    "至極のプリン"
    ],[
    "クッキー",
    "マドレーヌ",
    "クラフティ",
    "マカロン",
    "ビスコッティ",
    "スコーン",
    "パウンドケーキ",
    "ガレット・ブルトンヌ"
    ],[
    "キャラメル",
    "カルボーン",
    "小梅",
    "鳥のミルク",
    "生ラムネ",
    "ミルキー",
    "ライオネスコーヒーキャンディー"
    ], [
    "信州りんごゼリー",
    "信州ももゼリー",
    "信州洋梨ゼリー",
    "信州ぶどうゼリー"
    ],[
    "人形焼き",
    "花びら餅",
    "豆大福",
    "水ようかん",
    "みたらし団子",
    "もなか",
    "柚餅子",
    "ようかん",
    "わらび餅"
    ]
]

sweets.each_with_index do |names, i|
    names.each do |name|
        Item.create(
            genre_id: i+1,
            name: name,
            description: name + "はおいしいよ！",
            sales_status: 1,
            price: (3 + rand(10))*100
        )
    end
end