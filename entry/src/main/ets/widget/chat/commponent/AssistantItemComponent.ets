import { LengthMetrics } from "@kit.ArkUI"

/**
 * 助手消息组件
 */
@ComponentV2
export struct AssistantItemComponent {
  build() {
    RelativeContainer() {
      Image($r('app.media.app_icon'))
        .interpolation(ImageInterpolation.Medium)
        .width(30)
        .height(30)
        .id('user_icon')
        .alignRules({
          start: {
            anchor: '__container__',
            align: HorizontalAlign.Start
          }
        })

      Text("帮我写一段话，按照下面的意思\n1. 你好\n2. 你叫什么名字\n3. 你多大了")
        .id('user_name')
        .fontSize($r('app.float.font_size_chat_message_medium'))
        .textAlign(TextAlign.Start)
        .constraintSize({
          maxWidth: "70%"
        })
        .alignRules({
          start: {
            anchor: 'user_icon',
            align: HorizontalAlign.End
          }
        })
        .padding(8)
        .margin({
          start: LengthMetrics.vp(8)
        })// 设置字体颜色和背景颜色
        .fontColor(Color.White)
        .borderRadius(8)
        .backgroundColor(Color.Orange)
    }
    .padding({
      end: LengthMetrics.vp(16)
    })
    .width("100%")
    .height('auto')
  }
}