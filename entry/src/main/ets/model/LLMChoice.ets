import { LLMChoiceMessage } from "./LLMChoiceMessage"

export interface LLMChoice {
  index?: number
  message?: LLMChoiceMessage
  finish_reason? : string
}