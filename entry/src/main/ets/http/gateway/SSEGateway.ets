import { rcp } from '@kit.RemoteCommunicationKit';
import { buffer } from '@kit.ArkTS';
import { HttpClient } from '../HttpClient';
import { log } from '../../util/LogUtil';
import { LLMResult } from '../../model/LLMResult';
import { SSEListener } from './SSEListener';
import { LLMChunk } from '../../model/LLMChunk';
import { LLMChoiceMessage } from '../../model/LLMChoiceMessage';

export class SSEGateway extends HttpClient {
  private sseListener?: SSEListener

  constructor(sseListener?: SSEListener) {
    super()
    this.sseListener = sseListener
  }

  setListener(listener: SSEListener) {
    this.sseListener = listener
  }

  postStreamRequest(url: string, apikey: string | undefined, modelId: string, contextMessage: LLMChoiceMessage[]) {
    // url = "https://text.pollinations.ai/openai/chat/completions"
    // modelId = "openai-large"

    const onMessage = (msg: LLMResult) => {
      this.sseListener?.onMessage?.(msg)
    }

    const onChunkMessage = (msg: LLMChunk) => {
      this.sseListener?.onChunkMessage?.(msg)
    }

    // const llmChunkList: LLMChunk[] = []
    // let responseMsg = ""
    const destination: rcp.ResponseBodyDestination = {
      kind: 'stream',
      stream: {
        write(dataBuffer: ArrayBuffer): Promise<void | number> {
          const rawString = buffer.from(dataBuffer).toString('utf-8')
          log.info("rcp", `SSEGateway.request(${url}), rawString(${rawString})`)

          // 解析 chunk 数据
          const lines = rawString.split('\n').filter(line => line.trim() !== '')
          for (const line of lines) {
            if (line.startsWith('data:')) {
              const jsonString = line.replace('data:', '').trim()
              try {
                const chunk = JSON.parse(jsonString) as LLMChunk
                onChunkMessage(chunk)

                // 如果 chunk 中包含完整消息，触发 onMessage 回调
                // if (chunk.choices && chunk.choices[0]?.finish_reason) {
                //   const completeMessage: LLMResult = {
                //     id: chunk.id,
                //     object: chunk.object,
                //     created: chunk.created,
                //     model: chunk.model,
                //     choices: chunk.choices.map(choice => ({
                //       text: choice.delta?.content || '',
                //       index: choice.index,
                //       logprobs: choice.logprobs,
                //       finish_reason: choice.finish_reason
                //     }))
                //   }
                //   onMessage(completeMessage)
                // }
              } catch (error) {
                log.error("rcp", `SSEGateway.request(${url}), JSON parse error(${error})`)
              }
            }
          }

          return Promise.resolve()
        }
      },
    }

    this.sseListener?.onStart?.()
    this._request(url, {
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + apikey ?? '',
      },
      method: 'POST',
      destination: destination,
      data: {
        "model": modelId,
        // "messages": [
        //   {
        //     "role": "system",
        //     "content": "You are a helpful assistant."
        //   },
        //   {
        //     "role": "user",
        //     "content": "写一篇500字关于春天的作文!"
        //   }
        // ],
        "messages": contextMessage,
        "stream": true
      }
    })
      .then((response: rcp.Response) => {
        this.sseListener?.onComplete?.()
        log.info("rcp", `SSEGateway.request(${url}), response(${response})`)
      })
      .catch((error: Error) => {
        this.sseListener?.onError?.(error?.message)
        log.info("rcp", `SSEGateway.request(${url}), error(${error?.message})`)
      })
  }
}
