Rails.application.routes.draw do
  root to: 'public/homes#top'

  get 'admin' => 'admin/homes#top'

  # UserとAdminのログインページ


  devise_for :admins, only: [:session], controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, only: [:session, :registration], controllers: {
    registrations: "publics/registrations",
    sessions: "publics/sessions"
  }

  namespace :admin do
    resources :blogs, only:[:index, :new, :create, :edit, :update, :destroy]
  end

  scope module: :public do
    resources :questions, only:[:index, :new, :create ,:show, :update, :destroy] do
      resource :question_favorites, only: [:create, :destroy]
      collection do
        get 'unsolved'
        get 'solved'
        # get 'my_question'
        get 'search'
      end
      member do
        # ベストアンサーを選ぶ画面
        get 'best_select' => 'questions#best_select'
        resources :answers, only:[:new, :create] do
          # post 'check'
        end
      end
    end

    resources :blogs, only:[:show] do
      resources :blog_comments, only: [:create]
      resource :blog_favorites, only: [:create, :destroy]
    end

    resource :contacts, only: [:new, :create] do
      post 'confirm'
      post 'back'
      get 'thank'
    end

    resources :users, only: [:show, :edit, :update] do
      get 'favorite_blogs'
      get 'favorite_questions'
      get 'questions'
    end
  end
end
