import { rcp } from "@kit.RemoteCommunicationKit"

export interface HttpOption {
  /**
   * 请求头
   */
  headers?: { [key: string]: string }
  /**
   * 请求方法
   */
  method?: 'GET' | 'POST' | 'HEAD' | 'PUT' | 'DELETE' | 'PATCH' | 'OPTIONS'
  /**
   * 请求参数
   */
  params?: { [key: string]: any }
  /**
   * `data` 是作为请求体被发送的数据
   * 仅适用 'PUT', 'POST', 'DELETE 和 'PATCH' 请求方法
   */
  data?: { [key: string]: any }
  /**
   * `responseType` 是服务器响应的数据类型
   */
  destination?: rcp.ResponseBodyDestination
}