Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "application#show"
  get '/split', to: 'application#split_value'
end
