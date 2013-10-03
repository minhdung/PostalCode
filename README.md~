# PostalCode

Useful gem to search japan's zipcode

## Installation

Add this line to your application's Gemfile:

    gem 'postal_code', git: "https://github.com/minhdung/PostalCode.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postal_code

## Usage

Zipcode's data format: (see more details at www.post.japanpost.jp/zipcode/dl/readme.html) 
    
    :jis_code, :former_post_code, :post_code, :province_kana, :city_kana, :town_kana, :province_kanji, :city_kanji,
    :town_kanji, :plural_code, :unkown, :district_of_a_town, :plural_town, :update, :update_reason

Search functions

- where

    > PostalCode::JapanPostal.where(post_code: "2520815", province_kanji: "神奈川")

- find_with_code

    > PostalCode::JapanPostal.find_with_code "2520815"  

- find_with_address

    > PostalCode::JapanPostal.find_with_address "神奈川"

    > PostalCode::JapanPostal.find_with_address "神奈川", "藤沢"

    > PostalCode::JapanPostal.find_with_address "神奈川", "藤沢", "石川"

Other useful functions: first, last, object_at, add

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
