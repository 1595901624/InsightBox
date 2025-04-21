import { rcp } from "@kit.RemoteCommunicationKit";
import { buffer } from "@kit.ArkTS";
import { HttpClient } from "../HttpClient";
import { log } from "../../util/LogUtil";
import { LLMResult } from "../../model/LLMResult";

export class SSEGateway extends HttpClient {
  postStreamRequest(url: string) {
    const destination: rcp.ResponseBodyDestination = {
      kind: 'stream',
      stream: {
        write(dataBuffer: ArrayBuffer): Promise<void | number> {
          const rawString = buffer.from(dataBuffer).toString('utf-8')
          // log.info("rcp", `SSEGateway.request(${url}), rawString(${rawString})`)
          const llmResult = JSON.parse(rawString) as LLMResult
          log.info("rcp", `${llmResult?.choices?.[0]?.message?.content ?? ""}`)
          return Promise.resolve()
        }
      },
    }

    this._request(url, {
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer xxxxxxxxxx"
      },
      method: 'POST',
      destination: destination,
      data: {
        "model": "grok-2-1212",
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful assistant."
          },
          {
            "role": "user",
            "content": "写一篇500字的作文!"
          }
        ]
      }
    })
      .then((response: rcp.Response) => {
        log.info("rcp", `SSEGateway.request(${url}), response(${response})`)
      })
      .catch((error: Error) => {
        log.info("rcp", `SSEGateway.request(${url}), error(${error})`)
      })
  }
}