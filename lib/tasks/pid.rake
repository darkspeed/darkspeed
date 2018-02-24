namespace :pid do
  task reset: :environment do
    path = Rails.root.join 'app/services/darksocks'
    `rm #{path}/*.pid 2> /dev/null`
  end
end
