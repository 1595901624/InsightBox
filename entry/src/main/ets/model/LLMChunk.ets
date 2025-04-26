// {
//   "id": "a6289a2e-5cee-4a6e-afdd-30e650c10439",
// "object": "chat.completion.chunk",
// "created": 1745653456,
// "model": "grok-2-1212",
// "choices": [
//   {
//     "index": 0,
//   "delta": {
//     "role": "assistant"
//   },
//     "finish_reason": "stop"
//   }
//   ],
//   "system_fingerprint": "fp_3c8052f993"
// }
import { LLMChunkChoice } from './LLMChunkChoice';
import { LLMUsage } from './LLMUsage';

export interface LLMChunk {
  id?: string;
  object?: string;
  model?: string;
  created?: number;
  choices?: LLMChunkChoice[];
  usage?: LLMUsage
}