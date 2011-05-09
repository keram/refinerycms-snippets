Refinery::Application.routes.draw do
  resources :snippets, :only => [:index, :show] 

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :snippets, :except => :show do
      collection do
        post :update_positions
      end
    end
    
    resources :snippets_pages
  end
  
end
