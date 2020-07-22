Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :controller => 'api', :path => 'api' do

    # = = = equipment list = = = = = = = = = = = = = = = = = = = = = = = =
    get '/equipment_list' => :get_equipment_list
    post '/equipment' => :create_equipment
    put '/equipment/:id' => :update_equipment
    delete '/equipment/:id' => :delete_equipment

    # = = = rental request = = = = = = = = = = = = = = = = = = = = = = = =
    get '/rental_request_list' => :get_rental_request_list
    post '/rental_request' => :create_rental_request
    put '/rental_request/:id' => :update_rental_request
    delete '/rental_request/:id' => :delete_rental_request

    match '/:any' => :no_route, :via => :all
  end

  match '/:any' => 'api#no_route', :via => :all
end
