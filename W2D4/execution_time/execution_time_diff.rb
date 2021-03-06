require 'byebug'
# compare one element to every other element
#-----PHASE 1 WAY
# def my_min(array)
#
#   smallest = array.first
#   array.each_with_index do |el, i|
#
#     array.each_with_index do |el2, j|
#       next if i == j
#       if el < el2 && el < smallest
#         smallest = el
#       end
#
#     end
#   end
#   smallest
#
# end

#--------PHASE 2 WAY
def my_min(array)

  smallest = array.first
  array.each_with_index do |el, i|
    smallest = el if el < smallest
  end
  smallest

end

#---Phase 1
# def largest_contiguous_subsum(array)
#   result = []
#   array.each_with_index do |el1,i|
#     array.each_with_index do |el2,j|
#       next if i > j
#       result << array[i..j]
#     end
#   end
#   largest_sum = result.first.reduce(:+)
#
#   result.each do |sub_arr|
#     temp_sum = sub_arr.reduce(:+)
#     largest_sum = temp_sum if temp_sum > largest_sum
#   end
#   largest_sum
# end

#Phase 2
def largest_contiguous_subsum(array)
  previous_sum = 0
  current_sum = 0
  array.each_with_index do |el, i|

      current_sum = previous_sum + el
      if previous_sum < 0
        if el < previous_sum
          current_sum = previous_sum
        else
          current_sum = el
        end
      end

        previous_sum =  current_sum
  end

  current_sum
end
