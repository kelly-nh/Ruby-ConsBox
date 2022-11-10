# Kelly Ngoc Hoang - CS 3180 Fall 2022 - Project 4

class Object
    # Non-pair objects should return false 
    # Objects of class Pair should return true
    def pair?
        if self.instance_of? Pair
            return true
        end
        return false
    end

end

class Pair
    attr_accessor :value1, :value2

    def initialize(value1, value2)
        @value1 = value1
        @value2 = value2
    end

    def Pair.null
        return nil
    end

    # Return the first value of the pair
    def car
        return @value1
    end
    
    # Return the rest of the pair
    def cdr
        return @value2
    end

    # Returns true if the pair is a valid list, false if not.
    def list?
        if pair? 
            if car == Pair.null and cdr == Pair.null or cdr.pair?
                return true 
            end
        else
            return false 
        end
        return false
    end

    # Returns true only if the pair is an empty list.
    def null?
        if (cdr.pair?)
            false
        else
            true
        end
    end

    # Return a string representation of the pair
    def to_s
        string = "(" + car.to_s 
        iter = cdr

        # the list continues
        while iter.is_a?(Pair)
            string.concat(" ", iter.car.to_s)
            iter = iter.cdr
        end

        # the end of the list
        if iter == nil 
            return string.concat(")")

        # full pair
        else
            return string.concat(" . ", iter.to_s) + ")"
        end
    end

    # If the pair is a list, count should return the number of items in the top level of the list.
    # If not, it should return false.
    def count
        # no others nested within
        if not cdr.pair?
            return false
        end

        return count_helper(0, self)
    end

    # Helper function for count
    # Increment the sum until gets to the end of the list
    def count_helper(sum, list)
        # end of the list
        if list.cdr == nil
            return sum + 1
        end

        count_helper(sum + 1, list.cdr)
    end

    # If the pair is a list, append should return a new list consisting of other appended to the original list
    # The original list should not be modified! Other can be a list or an atomic data type.
    # If the pair is not a list, append should return false.
    def append(other)
        if not cdr.list?
            return false
        end

        return append_helper(self.clone, other)
    end

    # Helper function for append
    # Getting to the end of the list and then appending new values to the end
    def append_helper(list, other)
        if list.cdr == nil
            list.cdr_setter(self.class.new(other, Pair.null))
            return self
        end
        
        return append_helper(list.cdr, other)
    end

    def cdr_setter(value)
        @value2 = value
    end

end

def cons(value1, value2)
    Pair.new(value1, value2)
end
