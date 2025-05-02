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
    // 读取配置文件 src/main/resources/rawfile/llm_config/llm_configuration.json
    // getContext(this).resourceManager.getRawFileContentSync("llm_config/llm_configuration.json")
    let configString = fileUtil.getRawFileString("llm_config/llm_configuration.json")
    // 获取语言
    // 参考这个文件: https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-intl
    const languageFileName = i18n.System.getSystemLanguage() + "-" + i18n.System.getSystemRegion();
    // 读取配置文件
    let languageFilePath = `llm_config/i18n/${languageFileName}.json`;
    let languageConfigString = fileUtil.getRawFileString(languageFilePath);

    // 默认语言文件
    if (stringUtil.isNullOrEmpty(languageConfigString)) {
      log.error(`getRawFileString error: ${languageFilePath}`);
      // 如果没有找到语言文件，则使用默认简体中文语言文件
      languageFilePath = `llm_config/i18n/zh-Hans-CN.json`;
      languageConfigString = fileUtil.getRawFileString(languageFilePath);
    }

    const languageConfig = JSON.parse(languageConfigString) as Record<string, string>;
    Object.entries(languageConfig).forEach((languageItem: string[]) => {
      const key = languageItem[0];
      const value = languageItem[1];
      configString = configString.replaceAll(`%${key}%`, value);
    });
    const config = JSON.parse(configString) as LLMConfig.Config;
    log.info(JSON.stringify(config, null, 2));
  }
}