import { BasicDataSource } from '../base/BaseDataSource';
import { ChatMessage } from '../model/ChatMessage';
import { ChatRole } from '../model/ChatRole';

export class ChatDataSource extends BasicDataSource<ChatMessage> {
  // addMessage(msg: ChatMessage) {
  //
  // }


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
  addAssistantMessage(msg: string) {
    const chatMessage = new ChatMessage()
    chatMessage.id = this.getDataList().length + ""
    chatMessage.name = '助手'
    chatMessage.timestamp = new Date().getTime()
    chatMessage.role = ChatRole.Assistant
    chatMessage.content = msg
    this.insertData(chatMessage)
  }
}