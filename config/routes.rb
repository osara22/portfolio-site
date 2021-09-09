Rails.application.routes.draw do
  root to: 'public/homes#top'
  
  # UserとAdminのログインページ
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
  devise_for :users, controllers: {
    sessions: "public/sessions",
    passwords: "public/passwords",
    ragistrations: "public/registrations"
  }
end
