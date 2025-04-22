import { LengthMetrics } from '@ohos.arkui.node'
import { ChatStatus } from '../model/ChatStatus'

/**
 * 聊天输入组件
 */
@ComponentV2
export struct ChatInputView {
  /**
   * 聊天的状态
   */
  @Param chatStatus: ChatStatus = ChatStatus.Ready
  /**
   * 点击发送按钮的回调
   */
  @Event onSendClick?: (msg: string) => void
  /**
   * 点击停止按钮的回调
   */
  @Event onStopClick?: () => void
  @Local private inputText: string = ''

  build() {
    RelativeContainer() {
      TextInput({
        text: $$this.inputText,
        placeholder: $r('app.string.chat_input_hint'),
      })
        .height(50)
        .maxLines(1)
        .borderRadius(0)
        .backgroundColor(Color.Transparent)
        .caretColor($r('app.color.chat_input_caret'))

      this.EndButtonBuilder()
    }
    .backgroundColor($r('app.color.chat_input_background'))
    .height(80)
    .borderRadius(8)
  }

  @Builder
  EndButtonBuilder() {
    if (this.chatStatus === ChatStatus.AssistantGenerating) {
      Image($r('app.media.icon_svg_stop'))
        .height(30)
        .width(30)
        .padding(3)
        .borderRadius(20)
        .margin({
          end: LengthMetrics.vp(8),
          bottom: LengthMetrics.vp(8)
        })
        .fillColor(Color.Black)
        .alignRules({
          end: {
            anchor: '__container__',
            align: HorizontalAlign.End
          },
          bottom: {
            anchor: '__container__',
            align: VerticalAlign.Bottom
          }
        })
        .onClick(() => {
          this.onStopClick?.()
        })
    } else {
      Image($r('app.media.icon_svg_up'))
        .height(30)
        .width(30)
        .padding(6)
        .borderRadius(20)
        .margin({
          end: LengthMetrics.vp(8),
          bottom: LengthMetrics.vp(8)
        })
        .fillColor(Color.White)
        .backgroundColor(Color.Black)
        .alignRules({
          end: {
            anchor: '__container__',
            align: HorizontalAlign.End
          },
          bottom: {
            anchor: '__container__',
            align: VerticalAlign.Bottom
          }
        })
        .onClick(() => {
          this.onSendClick?.(this.inputText)
        })
    }
  }
}