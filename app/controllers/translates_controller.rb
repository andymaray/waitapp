class TranslatesController < ApplicationController

	def new
		@translate = Translate.new
		@survey_question = SurveyQuestion.find(params[:id])
    get_languages
	end

	def create
		@translate = Translate.new(translate_params)
		if @translate.save
      redirect_to survey_questions_path, notice: "Question is successfully translated"
    else
    	@survey_question = SurveyQuestion.find(params[:translate][:survey_question_id])
      get_languages
      render :new, alert: "Please try again"
    end
	end

  private

    def translate_params
      params.require(:translate).permit(:question, :survey_question_id, :language_id)
    end

    def get_languages
      @translates = @survey_question.translates.pluck(:language_id) if @survey_question.translates
      @translates << @survey_question.language_id
      @translates = Language.where('id not in (?)', @translates)
    end
end
