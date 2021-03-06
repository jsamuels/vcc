ActionController::Routing::Routes.draw do |map|
  map.root :controller => "login", :action => "login"
  map.connect "login/:action", :controller => 'login', :action => /[A-z_]+/
  
  map.connect "members/:action", :controller => 'members', :action => /[A-z_]+/
  map.resources :members
  map.connect "pageviews/:action", :controller => 'pageviews', :action => /user_pageviews|pageview_date_filter|pageview_user_agent/
  map.resources :pageviews
  map.connect "proofs/:action", :controller => 'proofs', :action => /[A-z_]+/
  map.resources :proofs
  map.connect "devices/:action", :controller => 'devices', :action => /[A-z_]+/
  map.resources :devices
  map.resources :member_preferences

  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
