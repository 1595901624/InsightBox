import { rcp } from "@kit.RemoteCommunicationKit";

export class SessionManager {
  private static instance: SessionManager;
  private session: rcp.Session | null = null;

  private constructor() {
    // Initialize session data
    this.initSession();
  }

  private initSession() {
    const sessionConfig: rcp.SessionConfiguration = {
      requestConfiguration: {
        transfer: {
          autoRedirect: true,
          timeout: {
            connectMs: 5000,
            transferMs: 10000
          }
        },
        tracing: {
          verbose: true
        }
      },
      sessionListener: {
        onCanceled: () => console.info("Session was cancelled"),
        onClosed: () => console.info("Session was closed")
      }
    };
    this.session = rcp.createSession(sessionConfig);
  }

  public static getInstance(): SessionManager {
    if (!SessionManager.instance) {
      SessionManager.instance = new SessionManager();
    }
    return SessionManager.instance;
  }

  getRcpSession(): rcp.Session {
    if (this.session === null) {
      this.initSession();
    }
    return this.session!;
  }

  close() {
    if (this.session) {
      this.session.close();
      this.session = null;
    }
  }
}