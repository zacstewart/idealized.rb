module Idealized
  class True < Boolean
    def self.if_then_else(consequent, alternative)
      consequent.call
    end

    def self.and(other)
      other
    end

    def self.or(other)
      self
    end

    def self.!
      False
    end

    def self.==(other)
      other
    end

    def self.!=(other)
      !other
    end
  end
end
