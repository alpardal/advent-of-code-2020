input = File.readlines(File.join(__dir__, 'input'))
nums = input.map(&method(:Integer))

total = 2020

# pt1

pt1_diffs = {}

val = nums.find do |n|
  pt1_diffs[n].tap do
    pt1_diffs[total - n] = n
  end
end

pt1_vals = [pt1_diffs[val], val]
puts "(pt1) vals: #{pt1_vals.inspect} - product: #{pt1_vals.reduce(:*)}"

# pt 2

pt2_partial_sums = {}

val = nums.find do |n1|
  pt2_partial_sums[n1].tap do
    nums.each { |n2| pt2_partial_sums[total - n1 - n2] = [n1, n2] }
  end
end

pt2_vals = pt2_partial_sums[val] + [val]
puts "(pt2) vals: #{pt2_vals.inspect} - product: #{pt2_vals.reduce(:*)}"
