Rails.application.routes.draw do
  root :to => "split#show"
  post '/split', to: 'split#split_value'
end
