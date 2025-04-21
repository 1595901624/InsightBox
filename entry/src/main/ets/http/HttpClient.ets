import { SessionManager } from "./SessionManager";
import { rcp } from "@kit.RemoteCommunicationKit";
import { HttpOption } from "./HttpOption";

export class HttpClient {
  postOrigin(url: rcp.URLOrString, content?: rcp.RequestContent,
    destination?: rcp.ResponseBodyDestination): Promise<rcp.Response> {
    return SessionManager.getInstance().getRcpSession().post(url, content, destination);
  }

  getOrigin(url: rcp.URLOrString,
    destination?: rcp.ResponseBodyDestination): Promise<rcp.Response> {
    return SessionManager.getInstance().getRcpSession().get(url, destination);
  }

  // requestOrigin(url: rcp.URLOrString, content?: rcp.RequestContent,
  //   destination?: rcp.ResponseBodyDestination): Promise<rcp.Response> {
  //   return SessionManager.getInstance().getRcpSession().
  // }

  _request(url: rcp.URLOrString, option?: HttpOption): Promise<rcp.Response> {
    const session = SessionManager.getInstance().getRcpSession();
    const request = new rcp.Request(url, option?.method ?? "GET", option?.headers, option?.data);
    request.destination = option?.destination;
    return session.fetch(request)
  }
}

