import { DBHelper } from './DBHelper';
import { LLMUserConfig } from './entity/LLMUserConfig';

export class LLMUserConfigTBUtil {
  private static instance: LLMUserConfigTBUtil | undefined = undefined;

  private constructor() {
    // private constructor to prevent instantiation
  }

  static getInstance(): LLMUserConfigTBUtil {
    if (LLMUserConfigTBUtil.instance === undefined) {
      LLMUserConfigTBUtil.instance = new LLMUserConfigTBUtil();
    }
    return LLMUserConfigTBUtil.instance;
  }

  /**
   * 获取所有数据
   * @param llmUserConfig
   */
  queryAll(): Promise<LLMUserConfig[]> {
    return DBHelper
      .getDaoSession()
      .getBaseDao<LLMUserConfig, string>(LLMUserConfig)
      .queryBuilder()
      .list()
  }

  /**
   * 插入数据
   * @param id
   */
  insert(llmUserConfig: LLMUserConfig): Promise<number> {
    return DBHelper
      .getDaoSession()
      .getBaseDao<LLMUserConfig, string>(LLMUserConfig)
      .insertOrReplace(llmUserConfig)
  }
}