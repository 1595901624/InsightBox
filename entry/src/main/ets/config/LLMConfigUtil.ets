/**
 * 配置文件工具类
 */
export class LLMConfigUtil {
  private static instance: LLMConfigUtil | null = null;

  private constructor() {
    // 读取配置文件
    // 获取语言
  }

  /**
   * 获取单例
   */
  public static getInstance(): LLMConfigUtil {
    if (LLMConfigUtil.instance === null) {
      LLMConfigUtil.instance = new LLMConfigUtil();
    }
    return LLMConfigUtil.instance;
  }
}