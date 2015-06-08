@practice = Practice.create(name: "Podmedics Surgery")

User.create(name: "Steve", email: "steve@podmedics.com", password: "podmedics", password_confirmation: 'podmedics', admin: true, clinician: true, super_user: true, practice: @practice)
User.create(name: "Edward", email: "ed@example.com", password: "podmedics", password_confirmation: 'podmedics', clinician: true, practice: @practice)
User.create(name: "Reception", email: "info@example.com", password: "podmedics", password_confirmation: 'podmedics', admin: true, practice: @practice)
User.create(name: "Maureen", email: "memeagi@gmail.com", password: "podmedics", password_confirmation: 'podmedics', admin: true, super_user: true, clinician: true, practice: @practice)

@english = Language.create(name: "english")
@spanish = Language.create(name: "spanish")
@turkish = Language.create(name: "turkish")

SurveyQuestion.create(question: "What do you think is happening to you / going on?", mandatory: true, language: @english)
SurveyQuestion.create(question: "What are you most worried about?", mandatory: true, language: @english)
SurveyQuestion.create(question: "What were you hoping to gain from this appointment?", mandatory: true, language: @english)
