export enum ChatStatus {
  /**
   * 准备状态（初始状态）
   */
  Ready,
  /**
   * 空闲状态（助手和用户都没有输入/输出的状态）
   */
  Idle,
  /**
   * 用户正在文本输入
   */
  UserTextInput,

  /**
   * 用户正在说话
   */
  UserSpeakingInput,

  /**
   * 助手正在说话、输出
   */
  AssistantGenerating,
}