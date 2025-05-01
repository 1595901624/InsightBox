import { LengthMetrics } from '@kit.ArkUI'
import { ChatMessage } from '../model/ChatMessage'
import { ChatMessageType } from '../model/ChatMessageType'

/**
 * 助手消息组件
 */
@ComponentV2
export struct AssistantItemComponent {
  @Param @Require message: ChatMessage

  build() {
    RelativeContainer() {
      Text() {
        // loading
        if (this.message.type == ChatMessageType.Loading) {
          ImageSpan($r('app.media.icon_gif_loading'))
            .width(24)
            .height(24)
            .padding({
              end: LengthMetrics.vp(4)
            })
            .baselineOffset(LengthMetrics.vp(-6))
        }
        Span(this.message.content ?? "")
      }
      .id('content')
      .fontSize($r('app.float.font_size_chat_message_medium'))
      .textAlign(TextAlign.Start)
      .constraintSize({
        maxWidth: "90%"
      }) // .alignRules({
      //   start: {
      //     anchor: 'user_icon',
      //     align: HorizontalAlign.End
      //   }
      // })
      .padding(10) // .margin({
      //   start: LengthMetrics.vp(8)
      // })// 设置字体颜色和背景颜色
      .fontColor($r('app.color.chat_bubble_text_color'))

      // .borderRadius(8)
      // .backgroundColor($r('app.color.chat_bubble_assistant_background'))
    }
    .padding({
      end: LengthMetrics.vp(16)
    })
    .width("100%")
    .height('auto')
  }
}