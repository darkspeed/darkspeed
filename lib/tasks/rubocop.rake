task default: :rubocop

task :rubocop do
  puts '=' * 20
  system 'rubocop'
end
