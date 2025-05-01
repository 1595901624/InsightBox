export enum ChatMessageType {
  /**
   * 文本消息
   */
  Text = 'text',
  /**
   * 图片消息
   */
  Image = 'image',
  /**
   * 视频消息
   */
  Video = 'video',
  /**
   * 音频消息
   */
  Audio = 'audio',
  /**
   * 文件消息
   */
  File = 'file',

  /**
   * 加载中
   */
  Loading = 'loading',

  /**
   * 思考中
   */
  Thinking = 'thinking',
}