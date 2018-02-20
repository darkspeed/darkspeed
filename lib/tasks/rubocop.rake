task default: :cop

task :cop do
  puts '=' * 20
  system 'rubocop'
end
