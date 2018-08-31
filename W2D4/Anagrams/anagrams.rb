def first_anagram?(str, target)
  str_arr = str.split("")
  str_arr.permutation.to_a.include?(target.split(""))
end

def second_anagram?(str, target)
  str_arr = str.split("")
  target_arr = target.split("")

  str_arr.each_with_index do |ch, i|
    target_i = target_arr.find_index(ch)
    return false if target_i.nil?
    target_arr.delete_at(target_i)
  end
  target_arr.empty?
end

def third_anagram?(str, target)
  a = str.split("").sort
  b = target.split("").sort
  a == b
end

def fourth_anagram?(str, target)
  a = Hash.new(0)
  b = Hash.new(0)

  str.each_char do |el|
    a[el] += 1
  end

  target.each_char do |el|
    b[el] += 1
  end

  a == b
end

def fifth_anagram?(str, target)
  a = Hash.new(0)

  str.each_char do |el|
    a[el] += 1
  end

  target.each_char do |el|
    a[el] += 1
  end

  a.values.all? { |el| el.even? }
end
