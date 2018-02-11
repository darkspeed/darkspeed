class LoginController < ApplicationController

  def login
    # Parse request
    data = JSON.parse(request.body.read)
    login = data['login']
    password = data['password']

    # Find the user
    user = User.find_by(username: login)
    unless user
      user = User.find_by(email: login)
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
    email = data['email']
    test = User.find_by(username: username)
    if test != nil
      render plain: "Username taken"
      head :conflict
    end
    if test == nil
      User.create(username: username, password: password, email: email)
      response.status=(:created)
      render plain: "Success!"
    end
  end

  def delete_user
    # Parse request
    data = JSON.parse(request.body.read)
    login = data['login']
    password = data['password']

    # Find the user
    user = User.find_by(username: login)
    unless user
      user = User.find_by(email: login)
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

  def reset_password
    data = JSON.parse(request.body.read)
    email = data['email']
    user = User.find_by(email: email)
    UserMailer.reset(email).deliver_now
  end
end
