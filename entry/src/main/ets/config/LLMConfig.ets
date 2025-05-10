/**
 * LLM 配置
 */

export namespace LLMConfig {

  interface Base {
    /**
     * 配置的标题
     */
    title?: string;

    /**
     * 配置的描述
     */
    description?: string;

    /**
     * 默认值
     */
    default?: string;
  }

  /**
   * LLM 配置
   */
  export interface Config {
    /**
     * id
     */
    id: number;

    /**
     * LLM 的品牌名称
     */
    brand?: string;

    /**
     * LLM 是否启用，默认启用
     */
    enabled?: boolean;

    /**
     * 基础配置
     */
    properties?: Properties;

    /**
     * 高级配置
     */
    advanced?: AdvancedProperties;
  }

  /**
   * LLM 基础配置项
   */
  export interface Properties {
    /**
     * api key 配置
     */
    apikey?: APIKey;

    /**
     * base url 配置
     */
    baseUrl?: BaseUrl;

    /**
     * 模型配置
     */
    model?: Model[];
  }

  /**
   * LLM 高级配置项
   */
  export interface AdvancedProperties {}

  /*
  "apikey": {
      "title": "%apikey.title%",
      "description": "%apikey.description%",
      "default": "",
      "url": "https://platform.openai.com/api-keys"
    },
 */
  export interface APIKey extends Base {
    /**
     * 获取api key 的链接
     */
    url?: string;
  }

  /*
    "baseUrl": {
      "title": "%baseUrl.title%",
      "description": "%baseUrl.description%",
      "default": "https://api.openai.com/v1"
    },
   */
  export interface BaseUrl extends Base {}

  /**
   * 模型配置
   */
  export interface Model extends Base {
    /**
     * 模型列表
     */
    list?: ModelItem[];
  }

  /**
   * 模型配置项
   */
  export interface ModelItem extends Base {
    /**
     * 模型id
     */
    id: string;

    /**
     * 模型分组名称
     */
    group?: string;

    /**
     * 模型类型
     */
    type?: ModelType;
  }

  /**
   * 模型类型
   */
  export enum ModelType {
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
}