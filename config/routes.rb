Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine, at: '/documentation'
  mount Api::V1 => '/'
  root to: redirect('/api/v1/social_networks')
end
