module UserHelper
  def find_patients_answers(patient)
    @patient_answers = PatientAnswer.where(patient_id: patient.id)
  end
end
