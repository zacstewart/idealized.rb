module Idealized
  class NonZero < Number
    def initialize(predecessor)
      @predecessor = predecessor
    end

    def zero?
      False
    end

    def predecessor
      @predecessor
    end

    def successor
      NonZero.new(self)
    end

    def +(other)
      NonZero.new(predecessor + other)
    end

    def -(other)
      other.zero?.if_then_else(
        ->{ self },
        ->{ predecessor - other.predecessor }
      )
    end

    def ==(other)
      other.zero?.if_then_else(
        ->{ False },
        ->{ predecessor == other.predecessor },
      )
    end

    def times(&block)
      predecessor.times(&block)
      block.call(predecessor)
    end

    def to_i
      1 + predecessor.to_i
    end
  end
end
