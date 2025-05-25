import { DaoMaster, DaoSession, Database, OpenHelper } from '@ohos/dataorm';
import { GlobalUtil } from '../util/GlobalUtil';
import { log } from '../util/LogUtil';
import { LLMUserConfig } from './entity/LLMUserConfig';

export class DBHelper extends OpenHelper {
  private static daoSession: DaoSession | undefined;

  static async init() {
    try {
      const helper: DBHelper = new DBHelper(GlobalUtil.getUIAbilityContext(), "insight_box.db")
      helper.setEntities(LLMUserConfig)
      const db = await helper.getWritableDb()
      DBHelper.daoSession = new DaoMaster(db).newSession()
    } catch (e) {
      log.error('DBHelper', `init DB error: ${e?.code} ${e?.message} ${e?.stack}`)
    }
  }

  static getDaoSession(): DaoSession {
    if (DBHelper.daoSession === undefined) {
      throw new Error('DBHelper not initialized')
    }
    return DBHelper.daoSession!
  }

  static async getDaoSessionAsync(): Promise<DaoSession> {
    if (DBHelper.daoSession === undefined) {
      await DBHelper.init()
    }
    return Promise.resolve(DBHelper.daoSession!)
  }

  onUpgradeDatabase(db: Database, oldVersion: number, newVersion: number): Promise<void> {
    return Promise.resolve();
  }

  onDowngradeDatabase(db: Database, oldVersion: number, newVersion: number): Promise<void> {
    return Promise.resolve();
  }
}