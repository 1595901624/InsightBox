import { DaoMaster, DaoSession, Database, OpenHelper } from '@ohos/dataorm';
import { GlobalUtil } from '../util/GlobalUtil';
import { LLMUserConfig } from './entity/LLMUserConfig';

export class DBHelper extends OpenHelper {
  private static daoSession: DaoSession | undefined;

  static async init() {
    const helper: DBHelper = new DBHelper(GlobalUtil.getApplicationContext(), "insight_box.db")
    helper.setEntities(LLMUserConfig)
    const db = await helper.getWritableDb()
    DBHelper.daoSession = new DaoMaster(db).newSession()
  }

  getDaoSession(): DaoSession {
    return DBHelper.daoSession!
  }

  onUpgradeDatabase(db: Database, oldVersion: number, newVersion: number): Promise<void> {
    return Promise.resolve();
  }

  onDowngradeDatabase(db: Database, oldVersion: number, newVersion: number): Promise<void> {
    return Promise.resolve();
  }
}