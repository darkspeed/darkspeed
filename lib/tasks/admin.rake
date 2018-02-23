namespace :admin do
  task create: :environment do
    ARGV.each { |a| task(a.to_sym { ; }) }
    admin = Admin.new(username: ARGV[1].to_s, password: ARGV[2].to_s)
    admin.save
  end

  task delete: :environment do
    ARGV.each { |a| task(a.to_sym { ; }) }
    admin = Admin.find_by_username ARGV[1].to_s
    admin.destroy
  end
end
