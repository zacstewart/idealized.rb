slide <<-EOS, :center
  \e[1mThinking Without Primitives\e[0m
  \e[1mDecomposition & Other Functional\e[0m
  \e[1mProgramming Takeaways\e[0m


  Zac Stewart
  @zacstewart

  Big Nerd Ranch
EOS

section "\e[1mWhat all does a boolean do?\e[0m" do
  slide <<-EOS, :block
    1. Handles if-then-else conditions
  EOS

  slide <<-EOS, :block
    2. Boolean algebra (&& and ||)
  EOS

  slide <<-EOS, :block
    3. Negation (!)
  EOS

  slide <<-EOS, :block
    4. Equality comparison (== and !=)
  EOS

  slide <<-EOS, :center
    \e[36mIdealized::Boolean\e[0m
  EOS

  slide <<-EOS, :block
    Why does if_then_else take two Procs for consequent and alternative?

    Simulates \e[1mcall by name\e[0m evaluation strategy (lazy evaluation)

    Ruby uses the \e[1mcall by value\e[0m strategy. Consequently...

      io_buffer.empty?.if_then_else(
        io_buffer.close,
        \e[41mputs io_buffer.get_line\e[0m
      )

    Even if io_buffer.empty? is True, the alternative will be evaluated
    and passed to if_then_else as a value, raising an exception.
  EOS

  slide <<-EOS, :block
    Okay, sure. But...


    1. Can you use these Idealized::Booleans in any meaningful way?

    2. Booleans are really simple. More complex datatypes
       must surely require more than classes and methods, right?
  EOS
end

section "\e[1mNumbers\e[0m" do
  slide <<-EOS, :block
    Let's try creating a numeric datatype that can represent
    natural numbers and basic arithmetic thereof.
  EOS

  slide <<-EOS, :block
    What are the two most basic types of numbers in this class?
  EOS

  slide <<-EOS, :block
    \e[1mZero\e[0m

    Has no predecessor
    Has a successor (namely, 1)
    Addition and subtraction with zero always equals the other number
  EOS

  slide <<-EOS, :block
    \e[1mNon-Zero\e[0m

    Has a successor
    Has a predecessor
  EOS

  slide <<-EOS, :center
    \e[36mIdealized::Number\e[0m
  EOS
end

section "\e[1mDecomposition\e[0m" do
  slide <<-EOS, :block
    Suppose we want to write a small interpreter for arithmetic.
    We'll start out with just numbers and addition.

    We need a top-level class, \e[1mExpression\e[0m, and two subclasses,
    \e[1mNumber\e[0m and \e[1mSum\e[0m, to represent our data.

    We need an evaluator to evaluate those expressions.
  EOS

  slide <<-EOS, :block
    How many methods were required?
    \e[31m5 * 3 classes = 15 total\e[0m

    Thats not too bad, I guess. We are, afterall,
    implementing an interpreter from scratch...
  EOS

  slide <<-EOS, :block
    So, lets add another expression: \e[1mProduct\e[0m

    How many methods are we going to need to write?
  EOS

  slide <<-EOS, :block
    The new class, \e[1mProduct\e[0m is going to require
    all \e[31m5\e[0m of the existing methods, plus another
    classification method \e[1mproduct?\e[0m for a total of \e[31m6\e[0m.

    The three existing classes will need the new \e[1mproduct?\e[0m
    method, coming to a grand total of \e[31m9\e[0m new methods
    to add this expression!
  EOS

  slide <<-EOS, :block
    If we want to add a fourth expression, \e[1mVariable\e[0m, which
    has a \e[1mname\e[0m attribute you will need to define
    \e[1mvariable?\e[0m and \e[1mname\e[0m, on the existing classes,
    \e[31m2 * 4 classes = 8\e[0m methods

    plus \e[31m8\e[0m methods for the new class for a grand total of
    \e[31m16\e[0m new method definitions.
  EOS

  slide <<-EOS, :block
    First 9, then 16. You can see that this is going to become
    unmanageable quickly. In fact, the number of methods you'd
    have to define with each additional Expression type is
    growing \e[1mquadratically\e[0m.

    What can we do about that?
  EOS

  section 'Non-solution: type checking' do
    slide <<-EOS, :block
      We can re-write \e[1mevaluate\e[0m to type check expressions
      instead of defining classification methods on each one.

      def evaluate(expression)
        if expression.is_a?(Number)
          expression.value
        elsif expression.is_a?(Sum)
          evaluate(expression.left_operand) +
            evaluate(expression.right_operand)
        elsif expression.is_a?(Product)
          evaluate(expression.left_operand) *
            evaluate(expression.right_operand)
        elsif expression.is_a?(Variable)
          expression.name
        else
          raise 'Invalid expression'
        end
      end
    EOS

    slide <<-EOS, :block
      Pros:
        Don't have to define classification methods
      Cons:
        Inflexible, potentially dangerous

      Ruby is helping you out a lot here. In a statically typed language,
      you'd have the additional step of type casting in each conditional
      branch of \e[1mevaluate\e[0m.
    EOS
  end

  section 'Solution: OOP Decomposition' do
    slide <<-EOS, :block
      An object-oriented way to decompose this would be to do away with the
      global \e[1mevaluate\e[0m function in favor of defining a method to do
      the job on each expression class.
    EOS

    slide <<-EOS, :code
      class Number
        def evaluate
          @value
        end
      end

      class Sum
        def evaluate
          @left_operand.evaluate + @right_operand.evaluate
        end
      end

      class Product
        def evaluate
          @left_operand.evaluate * @right_operand.evaluate
        end
      end

      class Variable
        def evaluate
          @name
        end
      end
    EOS

    slide <<-EOS, :block
      Much better! But still not ideal.

      If we wanted to \e[1mdisplay\e[0m expressions, we'd have to add
      a new method to each expression class, but that's not so bad.

      What if we want to add a method to \e[1msimplify\e[0m expressions,
      for example:

        a * b + a * c => a * (b + c)

      This is a non-local simplifcation. You cannot encapsulate this
      operation in any one class, so you're back to needing global
      evaluation. We've hit a limitation of object-oriented deconstruction.
    EOS
  end
end
