OnlineExam::Application.routes.draw do
  resources :instructions

  devise_for :users, :controllers => { :sessions => 'sessions'}
  # devise_scope :user do
  #   root to: "sessions#new"
  # end

  resources :users

  resources :students do
    collection do
      get "new_upload"
      post "upload"
      get "students_to_promote"
      post "promote_or_demote_all"
      post "promote_or_demote"
    end

    member do
      get "results"
    end
  end

  resources :faculties
  resources :courses do
    member do
      get "heirarchy"
    end
  end

  resources :exams do
    collection do
      get "course_exams_json"
    end

    resources :descriptive_questions do
      collection do
        get 'xls_template_descriptive'
        get 'upload_new'
        post 'upload'
      end
    end
    resources :multiple_choice_questions do
      collection do
        get 'upload_new'
        post 'upload'
        get 'xls_template'
      end
    end

    resources :audio_video_question_masters

    member do
      get "schedules"
    end
  end

  resources :reports do
    collection do
      get "print"
      get "drill_result"
      get "grouped_results"
      get "results"
    end
  end

  resources :results do
    member do
      get "result_in_detail"
      put "update_result_details"
    end
    collection do
      get "exam_results"
      get "mail"
    end
  end

  resources :schedules do
    member do
      get "exam"
      get "review_exam"
      get "submit_exam"
      get "exam_entrance"
      post "validate_exam_entrance"
      post "next_question" 
      get "next_question" 
      get "increment_a_v_listen_count"
    end
  end

  get "search/index" => "search#index"
  get "staticpages/course_management" => "staticpages#course_management"
  get "staticpages/exam_management" => "staticpages#exam_management"
  get "staticpages/student_management" => "staticpages#student_management"
  get "staticpages/online_exam" => "staticpages#online_exam"
  get "staticpages/faculty_management" => "staticpages#faculty_management"
  get "staticpages/reporting" => "staticpages#reporting"

  get 'auto_search/autocomplete_user_user_id'
  get 'auto_search/autocomplete_user_user_info'
  get 'auto_search/autocomplete_student_roll_number'
  get 'auto_search/autocomplete_faculty_name'
  get 'auto_search/autocomplete_course_name'
  get 'auto_search/autocomplete_exam_subject'
  get 'auto_search/autocomplete_exam_exam_name'
  get 'auto_search/autocomplete_student'

  root to: "home#index"

end
