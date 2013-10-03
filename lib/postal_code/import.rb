require 'csv'
module PostalCode
  module Import

    DEFAULT_POSTAL_CODE_CSV_FILE = File.join(File.dirname(__FILE__), "KEN_ALL.CSV")
    private

    def import_postal_code filepath = DEFAULT_POSTAL_CODE_CSV_FILE
      csv = CSV.read(File.new(filepath), headers: false, encoding: "SJIS")
      postal_codes = []
      csv.each do |row|
        attributes = {}
        PostalCode::Postal::ATTRIBUTES.each_with_index{|name, index|
          attributes.merge!(name => (index == 1 ? row[index].delete(' ') : row[index]))}
        postal_codes << PostalCode::Postal.new(attributes)
      end
      postal_codes
    end

  end
end
