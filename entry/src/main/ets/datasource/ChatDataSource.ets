import { BasicDataSource } from '../base/BaseDataSource';
import { ChatMessage } from '../model/ChatMessage';
import { ChatMessageType } from '../model/ChatMessageType';
import { ChatRole } from '../model/ChatRole';
import { LLMChoiceMessage } from '../model/LLMChoiceMessage';

export class ChatDataSource extends BasicDataSource<ChatMessage> {
  // addMessage(msg: ChatMessage) {
  //
  // }


  /**
   * 判断是否是最后一条信息
   */
  isLastMessage(index: number): boolean {
    return index === this.getDataList().length - 1
  }

  /**
   * 添加用户消息
   */
  addUserMessage(msg: string) {
    const chatMessage = new ChatMessage()
    chatMessage.id = this.getDataList().length + ""
    chatMessage.name = '用户'
    chatMessage.timestamp = new Date().getTime()
    chatMessage.role = ChatRole.User
    chatMessage.content = msg
    this.insertData(chatMessage)
  }

  /**
   * 添加助手消息
   */
  addAssistantMessage(msg: string, type: ChatMessageType = ChatMessageType.Text) {
    const chatMessage = new ChatMessage()
    chatMessage.id = this.getDataList().length + ""
    chatMessage.name = '助手'
    chatMessage.timestamp = new Date().getTime()
    chatMessage.role = ChatRole.Assistant
    chatMessage.content = msg
    chatMessage.type = type
    this.insertData(chatMessage)
  }

  /**
   * 更新最后一条的Assistant消息
   */
  updateAssistantMessage(msg: string) {
    const chatMessage = this.getDataList()[this.getDataList().length - 1]
    if (chatMessage == undefined || chatMessage.role != ChatRole.Assistant) {
      return
    }
    chatMessage.content = msg
    chatMessage.type = ChatMessageType.Text
    this.replace(this.getDataList().length - 1, chatMessage)
    this.notifyDataReload()
  }

  getContextMessage(): LLMChoiceMessage[] {
    const contextMessage: LLMChoiceMessage[] = []
    for (let i = 0; i < this.getDataList().length; i++) {
      const chatMessage = this.getDataList()[i]
      if (chatMessage.role == ChatRole.User) {
        contextMessage.push({
          role: 'user',
          content: chatMessage.content
        })
      } else if (chatMessage.role == ChatRole.Assistant) {
        contextMessage.push({
          role: 'assistant',
          content: chatMessage.content
        })
      }
    }
    return contextMessage
  }
}