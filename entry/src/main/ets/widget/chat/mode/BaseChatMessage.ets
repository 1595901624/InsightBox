import { ChatRole } from "../../../model/ChatRole";

/**
 * 聊天信息
 */
export interface BaseChatMessage {
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
}