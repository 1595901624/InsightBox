import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

export class GlobalUtil {
  // private static appContext;

  private static uiAbilityContext: common.UIAbilityContext

  private static windowStage: window.WindowStage

  private static applicationContext: common.ApplicationContext;

  static init(uiAbilityContext: common.UIAbilityContext, windowStage: window.WindowStage) {
    GlobalUtil.uiAbilityContext = uiAbilityContext;
    GlobalUtil.windowStage = windowStage;
    GlobalUtil.applicationContext = uiAbilityContext.getApplicationContext();
  }

  static getUIAbilityContext(): Context {
    return GlobalUtil.uiAbilityContext;
  }

  static getWindowStage(): window.WindowStage {
    return GlobalUtil.windowStage;
  }

  static getApplicationContext(): common.ApplicationContext {
    return GlobalUtil.applicationContext;
  }
}