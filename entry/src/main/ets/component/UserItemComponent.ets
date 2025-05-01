import { LengthMetrics } from '@kit.ArkUI'
import { ChatMessage } from '../model/ChatMessage'

/**
 * 用户消息组件
 */
@ComponentV2
export struct UserItemComponent {
  @Param @Require message: ChatMessage

  build() {
    RelativeContainer() {
      Text(this.message.content ?? "")
        .id('content')
        .fontSize($r('app.float.font_size_chat_message_medium'))
        .textAlign(TextAlign.Start)
        .constraintSize({
          maxWidth: "90%"
        })
        .alignRules({
          // end: {
          //   anchor: 'user_icon',
          //   align: HorizontalAlign.Start
          // }
          end: {
            anchor: '__container__',
            align: HorizontalAlign.End
          }
        })
        .padding(10)
        .margin({
          end: LengthMetrics.vp(8)
        })// 设置字体颜色和背景颜色
        .fontColor($r('app.color.chat_bubble_text_color'))
        .borderRadius({
          topStart: LengthMetrics.vp(16),
          topEnd: LengthMetrics.vp(16),
          bottomStart: LengthMetrics.vp(16),
          bottomEnd: LengthMetrics.vp(8)
        })
        .borderWidth(1)
        .borderColor($r('app.color.chat_bubble_border_color'))
        .backgroundColor($r('app.color.chat_bubble_user_background'))

      // Image($r('app.media.app_icon'))
      //   .interpolation(ImageInterpolation.Medium)
      //   .width(30)
      //   .height(30)
      //   .id('user_icon')
      //   .alignRules({
      //     end: {
      //       anchor: '__container__',
      //       align: HorizontalAlign.End
      //     }
      //   })
    }
    .width("100%")
    .height('auto')
  }
}