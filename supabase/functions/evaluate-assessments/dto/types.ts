// DTO for an assessment
export interface AssessmentDTO {
  name: string;
  description: string;
  category: string;
  cutoff_score: number;
  questions: QuestionDTO[];
}

// DTO for a question
export interface QuestionDTO {
  question_id: string;
  text: string;
  options: OptionDTO[];
}

// DTO for an option (answer choice)
export interface OptionDTO {
  option_id: string;
  text: string;
  score: number;
}

export interface AssessmentEvaluationRequestDTO {
  assessment_id: string;
  questions: AssessmentEvaluationQuestionDTO[];
}

export interface AssessmentEvaluationQuestionDTO {
  question_id: string;
  answer_id: string;
}