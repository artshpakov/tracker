Rails.application.routes.draw do

  scope controller: :auth do
    get :me
    post :auth
  end

  resources :issues

end
