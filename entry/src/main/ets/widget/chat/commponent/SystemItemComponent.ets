/**
 * 系统消息组件
 */
@ComponentV2
export struct SystemItemComponent {
  build() {
    Text("欢迎来到聊天室")
      .width("100%")
      .padding(8)
      .textAlign(TextAlign.Center)
      .fontColor(Color.Grey)
  }
}