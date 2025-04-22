import { LengthMetrics } from "@kit.ArkUI"

/**
 * 用户消息组件
 */
@ComponentV2
export struct UserItemComponent {
  build() {
    RelativeContainer() {
      Text("帮我写一段话，按照下面的意思\n1. 你好\n2. 你叫什么名字\n3. 你多大了")
        .id('user_name')
        .fontSize($r('app.float.font_size_chat_message_medium'))
        .textAlign(TextAlign.Start)
        .constraintSize({
          maxWidth: "70%"
        })
        .alignRules({
          end: {
            anchor: 'user_icon',
            align: HorizontalAlign.Start
          }
        })
        .padding(8)
        .margin({
          end: LengthMetrics.vp(8)
        })// 设置字体颜色和背景颜色
        .fontColor(Color.White)
        .borderRadius(8)
        .backgroundColor(Color.Blue)

      Image($r('app.media.app_icon'))
        .interpolation(ImageInterpolation.Medium)
        .width(30)
        .height(30)
        .id('user_icon')
        .alignRules({
          end: {
            anchor: '__container__',
            align: HorizontalAlign.End
          }
        })
    }
    .width("100%")
    .height('auto')
  }
}