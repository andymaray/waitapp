class Permission < Struct.new(:user)

  def allow?(controller, action)
    return true if controller == 'bodyparts' && action == 'show'
    return true if controller == 'bodyparts' && action == 'create'
    return true if controller == 'presentations' && action == 'show'
    return true if controller == 'survey_questions' && action == 'show'
    return true if controller == 'patient_answers' && action == 'show'
    return true if controller == 'patients' && action == 'update'
    return true if controller == 'sessions'
    return true if controller == 'password_resets'
    return true if controller == 'users' && action == 'index'
    # Uncomment the below line when static pages are ready for access
    # return true if controller == 'static_pages'
    if user
        return true if controller == 'patient_answers' && action == 'create'
        return true if controller == 'users' && action == 'update'
        return true if controller == 'users' && action == 'edit'
        return true if controller == 'users' && action == 'show'
        return true if controller == 'patients'
        return true if controller == 'users' && user.admin?
        return true if controller == 'users' && user.super_user?
        return true if controller == 'bodyparts' && user.super_user?
        return true if controller == 'presentations' && user.super_user?
        return true if controller == 'survey_questions' && user.super_user?
        return true if controller == 'translates' && user.super_user?
        return true if controller == 'practices' && user.super_user?
    end
    false
    # Whitelist all for development
    # true
  end

end
