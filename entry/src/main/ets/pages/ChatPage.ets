import { HMRouter } from "@hadss/hmrouter";
import { PageConstant } from "../constant/PageConstant";
import { log } from "../util/LogUtil";
import { SafeAreaLayout } from "../widget/SafeAreaLayout";

@HMRouter({ pageUrl: PageConstant.PAGE_CHAT })
@ComponentV2
export struct ChatPage {
  build() {
    SafeAreaLayout() {
      RelativeContainer() {

      }
      .height('100%')
      .width('100%')
    }
  }

  aboutToAppear(): void {
    log.info('ChatPage', 'aboutToAppear', 0, true, {
      name: 'ChatPage',
      age: 18,
      isStudent: true,
    } as ESObject);
  }

  /**
   * 标题栏
   */
  @Builder
  TitleBar() {

  }
}