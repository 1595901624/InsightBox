import { LLMModelType } from './LLMModelType'

export class LLMModel {
  /**
   * 模型id
   */
  id: string = "gpt-3.5-turbo"
  /**
   * 模型名称
   */
  name?: string = "GPT-3.5"
  /**
   * 模型分组名称
   */
  groupName?: string = ""
  /**
   * 模型类型
   */
  type?: LLMModelType = LLMModelType.Text
  /**
   * 描述
   */
  description?: string = ""
}