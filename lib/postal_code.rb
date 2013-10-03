require "postal_code/version"
require "singleton"
require "postal_code/import"
require "postal_code/postal"

module PostalCode
  # Your code goes here...
  class JapanPostal
    include Singleton
    include PostalCode::Import

    attr_accessor :postals

    def initialize
      self.postals = import_postal_code
    end

    def detect conditions = {}
      return self.postals if conditions.empty?
      self.postals.select{|p| p.match_conditions?(conditions)}
    end

    def detect_by_code code
      self.postals.select{|p| p.match_post_code?(code)}
    end
    
    def detect_by_address *address
      self.postals.select{|p| p.match_address?(*address)}
    end
    
    def first
      self.postals.first
    end

    def last
      self.postals.last
    end

    def object_at *indexes
      begin
        return self.postals[indexes.first] if indexes.length == 1
        return self.postals[indexes.first, indexes.last] if indexes.length == 2
      rescue TypeError
      end
      return nil
    end

    class << self
      def where conditions = {}
        PostalCode::JapanPostal.instance.detect(conditions)
      end
      
      def find_with_code code
        PostalCode::JapanPostal.instance.detect_by_code code
      end
      
      def find_with_address *address
        PostalCode::JapanPostal.instance.detect_by_address *address
      end
      
      def first
        PostalCode::JapanPostal.instance.first
      end

      def last
        PostalCode::JapanPostal.instance.last
      end
      
      def object_at *indexes
        PostalCode::JapanPostal.instance.object_at *indexes
      end
      
      def all
        PostalCode::JapanPostal.instance.postals
      end
    end

  end
end
