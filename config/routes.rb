Rails.application.routes.draw do
  root :to => "split#show"
  get '/split', to: 'split#split_value'
end
