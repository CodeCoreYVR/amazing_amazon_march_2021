Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get('/home', to: 'welcome#home')
  get('/about', to: 'welcome#about')
  get('/contact_us', to: 'welcome#contact_us')
  post('/thank_you', to: 'welcome#thank_you')
end
