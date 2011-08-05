# -*- ruby -*-

def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts   "Running #{file}"
  system "bundle exec rspec #{file}"
  puts
end

watch("spec/.*/*_spec\.rb") do |match|
  run_spec match[0]
end

watch("lib/icss/(.*/)?(.*)\.rb") do |match|
  run_spec %{spec/#{match[1]}#{match[2]}_spec.rb}
end

# watch("lib/icss/type/(.*)\.rb") do |match|
#   run_spec %{spec/type/record_type_spec.rb} unless (match =~ /record_type$/)
# end
