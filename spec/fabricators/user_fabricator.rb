include Faker
Fabricator(:user) do
  name = Fallout.unique.character # Fallout :)
  username { Internet.user_name name }
  email { Internet.email name }
  pass = Internet.password
  password { pass }
  password_confirmation { pass }
end
