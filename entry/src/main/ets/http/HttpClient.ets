import { SessionManager } from "./SessionManager";
import { rcp } from "@kit.RemoteCommunicationKit";
import { HttpOption } from "./HttpOption";

export class HttpClient {
  protected postOrigin(url: rcp.URLOrString, content?: rcp.RequestContent,
    destination?: rcp.ResponseBodyDestination): Promise<rcp.Response> {
    return SessionManager.getInstance().getRcpSession().post(url, content, destination);
  }

  protected getOrigin(url: rcp.URLOrString,
    destination?: rcp.ResponseBodyDestination): Promise<rcp.Response> {
    return SessionManager.getInstance().getRcpSession().get(url, destination);
  }

  // requestOrigin(url: rcp.URLOrString, content?: rcp.RequestContent,
  //   destination?: rcp.ResponseBodyDestination): Promise<rcp.Response> {
  //   return SessionManager.getInstance().getRcpSession().
  // }

  protected _request(url: rcp.URLOrString, option?: HttpOption): Promise<rcp.Response> {
    const session = SessionManager.getInstance().getRcpSession();
    const request = new rcp.Request(url, option?.method ?? "GET", option?.headers, option?.data);
    request.destination = option?.destination;
    return session.fetch(request)
  }
}

