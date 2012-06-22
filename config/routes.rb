# Rails.application.routes.draw do
#   scope(:path => 'refinery', :as => 'refinery_admin', :module => 'refinery/admin') do
#     resources :snippets do
#       collection do
#         post :update_positions
#       end

#       resources :snippets_page_parts do
#         member do
#           get 'add'
#           get 'remove'
#         end
#       end
#     end

#   end
# end

Refinery::Core::Engine.routes.append do

  # Admin routes
  namespace :admin, :path => 'refinery', :as => 'admin' do
    resources :snippets, except: :show do
      collection do
        post :update_positions
      end
    end
    resources :snippets_page_parts do
      member do
        get 'add'
        get 'remove'
      end
    end
  end

end