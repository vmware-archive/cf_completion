app_list = `cf apps`

filter_word = ARGV[0]

found_heading = false

heading_search = ->(line) do
  if (!found_heading && !line[/^name/].nil?)
    found_heading = true
    false
  else
    found_heading
  end
end

apps = app_list.
  split("\n").
  select(&heading_search).
  map { |line| line.split(" ")[0] }.
  select { |name| name[/^#{filter_word}/] }

puts apps.join(" ")
