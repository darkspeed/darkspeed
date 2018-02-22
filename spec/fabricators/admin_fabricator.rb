include Faker
Fabricator(:admin) do
  username        Internet.user_name DrWho.character
  password_digest Internet.password
end
