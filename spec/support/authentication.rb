shared_context 'authentication', type: :controller do

  def signin_user
    User.create name: 'John Doe'
    session[:user_id] = User.last.id
    session[:user_token] = 'TPM123'
  end

end

