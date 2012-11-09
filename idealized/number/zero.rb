module Idealized
  class Zero < Number
    def zero?
      True
    end

    def predecessor
      raise 'Error: Zero.predecessor'
    end

    def successor
      NonZero.new(self)
    end

    def +(other)
      other
    end

    def -(other)
      other.zero?.if_then_else(
        ->{ self },
        ->{ raise 'Error: Zero - NonZero' }
      )
    end

    def ==(other)
      other.zero?
    end

    def times(&block)
      # noop
    end

    def to_i
      0
    end
  end
end
