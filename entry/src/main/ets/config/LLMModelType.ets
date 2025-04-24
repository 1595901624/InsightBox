/**
 * 模型类型
 */
export enum LLMModelType {
  /**
   * 文本(最基础的模型)
   */
  Text = 1,

  /**
   * 视觉
   */
  Vision = 1 << 1,

  /**
   * 推理
   */
  Thinking = 1 << 2,

  /**
   * 嵌入
   */
  Embedding = 1 << 3,
}