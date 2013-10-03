module PostalCode
  class Postal
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    ATTRIBUTES = [:jis_code, :former_post_code, :post_code, :province_kana, :city_kana, 
    :town_kana, :province_kanji, :city_kanji, :town_kanji, :plural_code, :unknown, 
    :district_of_a_town, :plural_town, :update, :update_reason]

    attr_accessor :jis_code, :former_post_code, :post_code, :province_kana, :city_kana, 
    :town_kana, :province_kanji, :city_kanji, :town_kanji, :plural_code, :unknown, 
    :district_of_a_town, :plural_town, :update, :update_reason 

    def initialize (attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def match_address? *address
      params_count = address.length
      raise ArgumentError, " wrong number of arguments (#{params_count} for 1..3)" if
        params_count == 0 || params_count >= 4
      if params_count == 1
        return true if 
          match_province?(address[0]) || match_city?(address[0]) || match_town?(address[0])
      elsif params_count == 2
        return true if
          (match_province?(address[0]) && (match_city?(address[1] || match_town?(address[1])))) ||
          (match_city?(address[0]) && match_town?(address[1]))
      elsif params_count == 3
        return true if
          match_province?(address[0]) && match_city?(address[1]) && match_town?(address[2])
      end
      false
    end
    
    def match_post_code? code
      self.post_code == code
    end
    
    def match_conditions? conditions
      conditions.each do |key, value| 
        return false unless self.respond_to?(key) && self.send(key) == value
      end
      true
    end

    def persisted?
      false
    end

    private
    def match_province? province
      match_with? "province", province
    end

    def match_city? city
      match_with? "city", city
    end

    def match_town? town
      match_with? "town", town
    end

    def match_with? address_type, data
      [:kana, :kanji].each do |moji|
        return true if self.send("#{address_type}_#{moji.to_s}").include? data
      end
      false
    end

  end
end
