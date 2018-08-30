require "byebug"

def range(x, y)
  return [] if x >= y

  [x] + range(x + 1, y)
end

def iter_range(x, y)
  result = []

  until x == y
    result << x
    x += 1
  end

  result
end

def exp(b, power)
  return 1 if power == 0
  b * exp(b, power - 1)
end

def exp2(b, power)
  return 1 if power == 0

  if power.even?
    exp(b, power/2) ** 2
  else
    b * (exp2(b,(power - 1)/2) ** 2)
  end

end

def deep_dup(nested)
  result = []
  nested.each do |el|
    unless el.is_a?(Array)
      result <<  el
    else
      result << deep_dup(el)
    end
  end
  result
end

def fib(n)
  return [0, 1] if n == 2
  arr = fib(n-1)
  arr << arr[-1] + arr[-2]
end

def fib_iter(n)
  arr = [0, 1]
  until arr.length == n
    arr << arr[-1] + arr[-2]
  end
  arr
end

# def bsearch(arr, target)
#   return [0] if find_side(arr, target).zero?
#   moves = bsearch
#   subs = find_subs(arr, target)
#
# end
#
# def find_subs(arr, target)
#   if arr.length.even?
#     even_subs(arr, target)
#   else
#     odd_subs(arr, target)
#   end
# end
#
# def even_subs(arr, target)
#   left = arr[0...arr.length/2]
#   right = arr[((arr.length/2))..-1]
#   subs = [left, nil, right]
#   # find_side(subs, target)
# end
#
# def odd_subs(arr, target)
#   left = arr[0..(arr.length/2)-1]
#   right = arr[((arr.length/2)+1)..-1]
#   mid = arr[arr.length/2]
#   subs =[left, mid, right]
#   # find_side(subs, target)
# end
#
# def find_side(subs, target)
#   if subs[0].last >= target
#     return -1
#   elsif subs[1] == target
#     return 0
#   else
#     return 1
#   end
# end

def bsearch(arr, target)
  return nil if arr.empty?
  mid_idx = arr.length/2
  return mid_idx if arr[mid_idx] == target
  return bsearch(arr[0...mid_idx], target) if target < arr[mid_idx]
  search_res = bsearch(arr[mid_idx+1..-1], target)
  search_res.nil? ? nil : search_res + mid_idx + 1
  # if bsearch(arr[mid_idx+1..-1], target).nil?
  #   nil
  # else
  #   bsearch(arr[mid_idx+1..-1], target) + mid_idx + 1
  # end
end

def merge_sort(array)
  return array if array.length <= 1
  midpoint = array.length / 2
  left = array.take(midpoint)
  right = array.drop(midpoint)
  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)
  merge(sorted_left, sorted_right)
end

def merge(a1, a2)
  result = []
  until a1.length == 0 && a2.length == 0
    if a1.length == 0
      result << a2.shift
    elsif a2.length == 0
      result << a1.shift
    elsif a1[0] < a2[0]
      result << a1.shift
    else
      result << a2.shift
    end
  end
  result
end
