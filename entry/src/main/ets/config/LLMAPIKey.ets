/*
  "apikey": {
      "title": "%apikey.title%",
      "description": "%apikey.description%",
      "default": "",
      "url": "https://platform.openai.com/api-keys"
    },
 */

export interface LLMAPIKey {
  /**
   * 默认的 api key
   */
  default: string;

  /**
   * api key 的描述
   */
  description?: string;

  /**
   * api key 的标题
   */
  title?: string;

  /**
   * 获取api key 的链接
   */
  url?: string;
}