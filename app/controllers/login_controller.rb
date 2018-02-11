class LoginController < ApplicationController

  def login
    # Parse request
    data = JSON.parse(request.body.read)
    username = data['username']
    password = data['password']
    email = data['email']

    # Find the user
    user = User.find_by(username: username)
    unless user
      user = User.find_by(email: email)
    end
    unless user
      head :not_found
    end

    # Check password
    if password == user.password
      response.status=(:accepted)
      jdata = {
        'password' => "password",
        'port' => "100"
      }
      render json: jdata
    else
      head :forbidden
    end
  end

  def create_account
    data = JSON.parse(request.body.read)
    username = data['username']
    password = data['password']
    test = User.find_by(username: username)
    if test != nil
      render plain: "Username taken"
      head :conflict
    end
    if test == nil
      User.create(username: username, password: password)
      response.status=(:created)
      render plain: "Success!"
    end
  end

  def delete_user
    data = JSON.parse(request.body.read)
    username = data['username']
    password = data['password']
    email = data['email']

    # Find the user
    user = User.find_by(username: username)
    unless user
      user = User.find_by(email: email)
    end
    unless user
      head :not_found
    end
    if user.password == password
      render plain: "User deleted!"
      user.destroy
    end
    if user.password != password
      render plain: "Incorrect Password!"
      head :forbidden
    end
  end
end
