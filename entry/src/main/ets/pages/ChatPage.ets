import { HMRouter } from "@hadss/hmrouter";
import { PageConstant } from "../constant/PageConstant";
import { ChatInputView } from "../widget/ChatInputView";
import { SafeAreaLayout } from "../widget/SafeAreaLayout";

@HMRouter({ pageUrl: PageConstant.PAGE_CHAT })
@ComponentV2
export struct ChatPage {
  build() {
    SafeAreaLayout() {
      RelativeContainer() {

        ChatInputView()
          .alignRules({
            bottom: {
              align: VerticalAlign.Bottom,
              anchor: '__container__',
            },
          })
      }
      .width("100%")
      .height("100%")
    }
  }
}