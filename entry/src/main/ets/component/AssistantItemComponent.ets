import { LengthMetrics } from '@kit.ArkUI'
import { ChatMessage } from '../model/ChatMessage'

/**
 * 助手消息组件
 */
@ComponentV2
export struct AssistantItemComponent {
  @Param @Require message: ChatMessage

  build() {
    RelativeContainer() {
      // Image($r('app.media.app_icon'))
      //   .interpolation(ImageInterpolation.Medium)
      //   .width(30)
      //   .height(30)
      //   .id('user_icon')
      //   .alignRules({
      //     start: {
      //       anchor: '__container__',
      //       align: HorizontalAlign.Start
      //     }
      //   })

      Text(this.message.content ?? "")
        .id('content')
        .fontSize($r('app.float.font_size_chat_message_medium'))
        .textAlign(TextAlign.Start)
        .constraintSize({
          maxWidth: "90%"
        })
        .alignRules({
          start: {
            anchor: 'user_icon',
            align: HorizontalAlign.End
          }
        })
        .padding(10)
        .margin({
          start: LengthMetrics.vp(8)
        })// 设置字体颜色和背景颜色
        .fontColor($r('app.color.chat_bubble_text_color'))
        .borderRadius(8)
        .backgroundColor($r('app.color.chat_bubble_assistant_background'))
    }
    .padding({
      end: LengthMetrics.vp(16)
    })
    .width("100%")
    .height('auto')
  }
}