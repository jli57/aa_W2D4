def bad_two_sum?(arr, target)

  arr.each_with_index do |el, i|
    arr.each_with_index do |el2, j|
      next if i >= j
      return true if el + el2 == target
    end
  end
  false

end

# n^2: looping through array within array

def okay_two_sum?(arr, target)

end 
