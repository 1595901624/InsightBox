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
      .getBaseDao<LLMUserConfig, number>(LLMUserConfig)
      .queryBuilder()
      .list()
  }

  /**
   * 插入或者更新数据
   * @param id
   */
  insertOrReplace(llmUserConfig: LLMUserConfig): Promise<number> {
    return DBHelper
      .getDaoSession()
      .getBaseDao<LLMUserConfig, number>(LLMUserConfig)
      .insertOrReplace(llmUserConfig)
  }

  /**
   * 删除数据
   * @param id
   */
  delete(id: number): Promise<void> {
    return DBHelper
      .getDaoSession()
      .getBaseDao<LLMUserConfig, number>(LLMUserConfig)
      .deleteByKeyAsync(id)
  }
}