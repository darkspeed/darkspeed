class LoginController < ApplicationController
  def login
    data = JSON.parse(request.body.read)
    username = data['username']
    password = data['password']
    user = User.find_by(username: username)
    if user != nil
      if password == user.password
        response.status=(:accepted)
        jdata = {
          'password' => "password",
          'port' => "100"
        }
        render json: jdata
      end
      if password != user.password
        head :forbidden
      end
    end
    if user == nil
      head :not_found
    end
  end

  def create_account
    data = JSON.parse(request.body.read)
    username = data['username']
    password = data['password']
    test = User.find_by(username: username)
    if test != nil
      head :conflict
    end
    if test == nil
      User.create(username: username, password: password)
      response.status=(:created)
      render plain: "Success!"
    end
  end
end
