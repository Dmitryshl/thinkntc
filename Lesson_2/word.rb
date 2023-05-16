alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
hash = {}

alphabet.each.with_index(1) do |letter, index|
  if vowels.include?(letter)
    hash[letter] = index
  end
end

puts hash