import { LLMChunk } from '../../model/LLMChunk';
import { LLMResult } from '../../model/LLMResult';

/**
 * 聊天SSE监听器
 */
export interface SSEListener {
  /**
   * 请求开始
   */
  onStart?: () => void;

  /**
   * 请求流式返回完整结果
   */
  onMessage?: (message: LLMResult) => void;

  /**
   * 流式返回中间结果
   * @param message
   */
  onChunkMessage?: (message: LLMChunk) => void;

  /**
   * 请求完成(成功)
   */
  onComplete?: () => void;

  /**
   * 请求被终止
   */
  onStop?: () => void;

  /**
   * 请求失败
   */
  onError?: (error: string) => void;
}