import { LLMModel } from './LLMModel'

/**
 * LLM 配置
 */
export class LLMConfig {
  /**
   * 品牌名称
   */
  brand: string = "OpenAI"
  /**
   * 模型默认的 api
   */
  url: string = "https://api.openai.com/v1/chat/completions"
  /**
   * 支持的模型列表
   */
  modelList: LLMModel[] = []
  /**
   * 模型的 api key
   */
  apiKey: string = ""
}