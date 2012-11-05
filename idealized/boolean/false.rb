module Idealized
  class False < Boolean
    def self.if_then_else(consequent, alternative)
      alternative.call
    end

    def self.and(other)
      self
    end

    def self.or(other)
      other
    end

    def self.!
      True
    end

    def self.==(other)
      !other
    end

    def self.!=(other)
      other
    end
  end
end
