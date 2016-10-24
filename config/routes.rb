Rails.application.routes.draw do
  root :to => "split#show"
  post '/split', to: 'split#split_value'
  get '/list', to: 'split#list'
  get '/view', to: 'split#view'
end
