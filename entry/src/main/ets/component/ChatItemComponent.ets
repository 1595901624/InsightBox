import { ChatMessage } from '../model/ChatMessage'
import { ChatRole } from '../model/ChatRole'
import { AssistantItemComponent } from './AssistantItemComponent'
import { SystemItemComponent } from './SystemItemComponent'
import { UserItemComponent } from './UserItemComponent'

@ComponentV2
export struct ChatItemComponent {
  @Param message: ChatMessage = new ChatMessage()

  build() {
    if (this.message.role === ChatRole.System) {
      SystemItemComponent()
    } else if (this.message.role === ChatRole.Assistant) {
      AssistantItemComponent()
    } else if (this.message.role === ChatRole.User) {
      UserItemComponent({
        message: this.message
      })
    }
  }
}