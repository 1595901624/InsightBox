import { LLMChoiceMessage } from './LLMChoiceMessage'

// {
//     "index": 0,
//   "delta": {
//     "role": "assistant"
//   },
//     "finish_reason": "stop"
//   }
export interface LLMChunkChoice {
  index?: number
  delta?: LLMChoiceMessage
  finish_reason?: string
}