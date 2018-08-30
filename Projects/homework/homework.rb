#Sluggish
array = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
def self.bubble_sort!(array)
   len = array.length - 1
   sorted = false

   until sorted
     sorted = true
     (0...len).each do |idx|
       if array[idx] > array[idx + 1]
         array[idx], array[idx + 1] = array[idx + 1], array[idx]
         sorted = false
       end
     end
   end

   array
 end

#Dominant
def self.merge_sort (array, &prc)
  return array if array.length <= 1

  mid_idx = array.length / 2
  merge(
    merge_sort(array.take(mid_idx), &prc),
    merge_sort(array.drop(mid_idx), &prc),
    &prc
  )
end


def self.merge(left, right, &prc)
  merged_array = []
  prc = Proc.new { |num1, num2| num1 <=> num2 } unless block_given?
  until left.empty? || right.empty?
    case prc.call(left.first, right.first)
    when -1
      merged_array << left.shift
    when 0
      merged_array << left.shift
    when 1
      merged_array << right.shift
    end
  end

  merged_array + left + right
end



#Clever
def dominant(array)
  length = 0
  array.each do |el|
    if el.length > length
      length = el
    end
  end
  length
end


#Dancing
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]


#Slow Dance
def slow_dance(direction, array)
  array.each do |el|
    return arr.index(el) if el == direction
  end

end

#Constant Dance
def constant_dance(direction, array)
  hash = {"up" => 1 , "right-up" => 2, "right" => 3, "right-down" => 4, "down" => 5, "left-down" => 6, "left" => 7,  "left-up" => 8}
  hash[direction]
end
