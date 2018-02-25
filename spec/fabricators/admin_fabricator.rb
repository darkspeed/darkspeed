include Faker
Fabricator(:admin) do
  name = Fallout.unique.character
  username        Internet.user_name name
  password_digest Internet.password
end
