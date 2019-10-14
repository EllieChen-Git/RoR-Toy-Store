Rails.application.routes.draw do

#get toys
get "/toys", to: "toys#index", as: "toys"

#create toys
post "/toys", to: "toys#create"

#get: form to create toys
get "/toys/new", to: "toys#new", as: "new_toy"

#edit: form to edit a toy
get "/toys/:id/edit", to: "toys#edit", as: "edit_toy"

#get: show a toy
get "/toys/:id", to: "toys#show", as: "toy"

#update(put/patch): update a toy
put "/toys/:id", to: "toys#update"
patch "/toys/:id", to: "toys#update"

#delete: delete a toy
delete "/toys/:id", to: "toys#destroy"

end
