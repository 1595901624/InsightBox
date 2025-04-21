// {
//   "id": "chatcmpl-123",
// "object": "chat.completion",
// "created": 1677652288,
// "choices": [{
//   "index": 0,
//   "message": {
//     "role": "assistant",
//     "content": "  Hello there, how may I assist you today?",
//   },
//   "finish_reason": "stop"
// }],
//   "usage": {
//   "prompt_tokens": 9,
//   "completion_tokens": 12,
//   "total_tokens": 21
// }
// }
import { LLMChoice } from "./LLMChoice";
import { LLMUsage } from "./LLMUsage";

export interface LLMResult {
  id?: string;
  object?: string;
  created?: number;
  choices?: LLMChoice[];
  usage?: LLMUsage
}