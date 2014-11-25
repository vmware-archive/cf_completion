help_output = `cf help | sed -n '/^GETTING STARTED:/,/^ENVIRONMENT VARIABLES/p'`

filter_word = ARGV[0]

commands = help_output.
  split("\n").
  map { |line| line.match(/^\s+([^, ]*)/) }.
  reject { |match| match.nil? }.
  map { |match| match[1] }. 
  reject { |match| match[/^#{filter_word}/].nil? }

puts commands.join(" ")
