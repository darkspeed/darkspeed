include Faker
Fabricator(:user) do
  name = Fallout.character # Fallout :)
  username      {Internet.user_name name}
  email {Internet.email name}
end
