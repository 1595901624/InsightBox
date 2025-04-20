import { HMRouter } from "@hadss/hmrouter";
import { PageConstant } from "../constant/PageConstant";

@HMRouter({ pageUrl: PageConstant.PAGE_CHAT })
@ComponentV2
export struct ChatPage {
  build() {
    RelativeContainer() {

    }
    .height('100%')
    .width('100%')
  }

  /**
   * 标题栏
   */
  @Builder
  TitleBar() {

  }
}