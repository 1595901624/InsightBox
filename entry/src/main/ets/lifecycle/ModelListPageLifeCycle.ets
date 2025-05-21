import { HMLifecycle, HMLifecycleContext, IHMLifecycle } from '@hadss/hmrouter';
import { LLMUserConfig } from '../db/entity/LLMUserConfig';
import { LLMUserConfigTBUtil } from '../db/LLMUserConfigTBUtil';
import { log } from '../util/LogUtil';

@HMLifecycle({ lifecycleName: 'modelListPageLifeCycle' })
export class ModelListPageLifeCycle implements IHMLifecycle {
  llmUserConfigList: LLMUserConfig[] = []

  onShown(ctx: HMLifecycleContext): void {
    LLMUserConfigTBUtil.getInstance().queryAll()
      .then((llmUserConfigList) => {
        this.llmUserConfigList = llmUserConfigList;
        // 处理查询结果
        log.info('Query result:', JSON.stringify(llmUserConfigList, null, 2));
      })
      .catch((error: Error) => {
        // 处理错误
        log.error('Error querying data:', error);
      });
  }
}