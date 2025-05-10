import i18n from '@ohos.i18n';
import { fileUtil } from '../util/FileUtil';
import { log } from '../util/LogUtil';
import { stringUtil } from '../util/StringUtil';
import { LLMConfig } from './LLMConfig';

/**
 * 配置文件工具类
 */
export class LLMConfigUtil {
  private static instance: LLMConfigUtil | null = null;
  private configList: LLMConfig.Config[] = [];

  private constructor() {

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

  /**
   * 获取配置文件
   */
  public init() {
    try {
      // 读取配置文件 src/main/resources/rawfile/llm_config/llm_configuration.json
      // getContext(this).resourceManager.getRawFileContentSync("llm_config/llm_configuration.json")
      let configString = fileUtil.getRawFileString("llm_config/llm_configuration.json")
      // 获取语言
      // 参考这个文件: https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-intl
      const languageFileName = i18n.System.getSystemLanguage();
      log.info(`getSystemLanguage: ${i18n.System.getSystemLanguage()}`);
      // 读取配置文件
      let languageFilePath = `llm_config/i18n/${languageFileName}.json`;
      let languageConfigString = fileUtil.getRawFileString(languageFilePath);

      // 默认语言文件
      if (stringUtil.isNullOrEmpty(languageConfigString)) {
        log.error(`getRawFileString error: ${languageFilePath}`);
        // 如果没有找到语言文件，则使用默认简体中文语言文件
        languageFilePath = `llm_config/i18n/zh-Hans.json`;
        languageConfigString = fileUtil.getRawFileString(languageFilePath);
      }

      const languageConfig = JSON.parse(languageConfigString) as Record<string, string>;
      Object.entries(languageConfig).forEach((languageItem: string[]) => {
        const key = languageItem[0];
        const value = languageItem[1];
        configString = configString.replaceAll(`%${key}%`, value);
      });
      this.configList = JSON.parse(configString) as LLMConfig.Config[];
      log.info(JSON.stringify(this.configList, null, 2));
    } catch (error) {
      log.error(`LLMConfigUtil.init error: ${error?.message} ${error?.stack}`);
      this.configList = [];
    }
  }

  /**
   * 获取配置列表
   */
  getConfigList() {
    if (this.configList === null) {
      this.init();
    }
    return this.configList;
  }

  /**
   * 获取配置
   */
  getConfigById(id: number): Nullable<LLMConfig.Config> {
    const configList = this.getConfigList();
    const config = configList.find((config) => {
      return config.id == id;
    });
    return config;
  }

  /**
   * 获取启用的配置列表
   */
  getEnabledConfigList(): LLMConfig.Config[] {
    const configList = this.getConfigList();
    const enabledModelList = configList.filter((config) => {
      return config.enabled == undefined || config.enabled == true;
    });
    return enabledModelList ?? [];
  }
}