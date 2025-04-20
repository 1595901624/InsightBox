@ComponentV2
export struct ChatInputView {
  build() {
    RelativeContainer() {
      TextInput({
        placeholder: $r('app.string.chat_input_hint'),
      })
        .height(50)
        .borderRadius(0)
        .backgroundColor(Color.Transparent)
        .caretColor($r('app.color.chat_input_caret'))
    }
    .backgroundColor($r('app.color.chat_input_background'))
    .height(80)
    .borderRadius(8)
  }
}