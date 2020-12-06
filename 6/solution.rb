input = File.readlines(File.join(__dir__, 'input'))
            .map(&:chomp)

m = ->(method) { method.to_proc }
map = ->(f) { ->(col) { col.map(&f) } }
reduce_with = ->(f) { ->(col) { col.reduce(&f) } }

answer_groups = input.chunk { |line| line.empty?? nil : true }
                     .map(&m[:last] >> map[m[:chars]])

pt1_counts = answer_groups.map(&reduce_with[:union] >> m[:size])
puts "(pt1) sum of unique answers: #{pt1_counts.sum}"

# Array#intersection was added in ruby 2.7
# use reduce_with[:&] for older versions
pt2_counts = answer_groups.map(&reduce_with[:intersection] >> m[:size])
puts "(pt2) sum of common answers: #{pt2_counts.sum}"
