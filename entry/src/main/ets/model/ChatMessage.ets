import { ChatMessageType } from './ChatMessageType';
import { ChatRole } from './ChatRole';

/**
 * 聊天信息
 */
export class ChatMessage {
  id?: string
  /**
   * 用户名
   */
  name?: string;
  /**
   * 角色
   */
  role?: ChatRole;
  /**
   * 内容
   */
  content?: string;
  /**
   * 时间戳
   */
  timestamp?: number = 0
  /**
   * 消息类型
   */
  type?: ChatMessageType = ChatMessageType.Text

  constructor(name: string = '', role: ChatRole = ChatRole.Unknown, content: string = '') {
    this.name = name;
    this.role = role;
    this.content = content;
  }
}