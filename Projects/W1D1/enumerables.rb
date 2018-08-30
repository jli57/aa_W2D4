# - Extend a Array class
# - Create method my_each
# - Create a while loop
# - Use a proc
require "byebug"

class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  #select is creating new Array
  #iterate through Array
  #picking those that evaluate true to conditional
  #create new Array
  #my each through
  #put conditional in proc, if true, shovel into result Array
  #return result

  def my_select(&prc)
    result = []
    self.my_each do |el|
      result << el if prc.call(el)
    end
    result
  end
  #
  # def my_reject(&prc)
  #   result = []
  #   self.my_each do |el|
  #     result << el if prc.call(el) == false
  #   end
  #   result
  # end

  #my_reject{ |el| el.even? }

  def my_reject(&prc)
    result = []
    self.my_each {|el| result << el if prc.call(el) == false}
    result
  end


  def my_any(&prc)
    self.my_each{|el| return true if prc.call(el) == true}
    false
  end
  #
  # - Create a result array
  # - my_each loop through the array
  # - if el.is_a? Array, my_flatten(el)
  # - else result array << el
  # - return result array
  #
  def my_flatten
    self.reduce([]) do |accum, el|
      if el.is_a? Array
        accum += el.my_flatten
      else
        accum << el
      end
    end
  end
  #


  # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  # a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  # [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
  #
  # c = [10, 11, 12]
  # d = [13, 14, 15]
  # [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
  # - Create length variable
  # - Create a result array self, Array.new(self.length) { Array.new }
  # - length.times do |i|
  # - *arg.each do |arr|
  # - return result
  #
  def my_zip(*args)
    args.unshift(self)
    length = self.length
    result = Array.new(length) { Array.new }
    length.times do |i|
      args.each do |arr|
        result[i] << arr[i]
      end
    end
    result
  end


  def my_rotate(idx=1) #-15
    final_idx = idx
    abs_idx = idx.abs #15
    idx == abs_idx ? neg = false : neg = true
    if abs_idx > self.length
      final_idx = abs_idx % self.length #3
    end
    if neg
      (final_idx = -1 * final_idx) unless final_idx < 0 #-3
    end

    self[final_idx..-1] + self[0...final_idx]
  end

  def my_join(sep="")
    result = ""
    self.each_with_index do |el, idx|
      result += el
      result += sep unless idx == self.length - 1
    end
    result
  end

  def my_reverse
    result = []
    until self.empty?
      debugger
      popped = self.pop
      result << popped
    end
    result
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

  def bubble_sort!(&prc)
    sorted = false
    until sorted
      sorted = true
      self.each_with_index do |el, idx|
        current_el = el
        next_el = self[idx+1]
        if block_given?
          if prc.call(current_el, next_el) == -1
            self[idx], self[idx + 1] = self[idx + 1], self[idx]
            sorted = false
          end
        else
          self.sort!
        end
      end
    end
    self
  end

end

def factors(num)
  (1..num).to_a.select { |n| num % n == 0 }
end
