import Foundation
import SQLite3

struct Account {
    let id: Int64
    let userId: Int64
    let type: String
    let balance: Double
}

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?

    private init() {
        openDB()
        createTables()
        seedIfNeeded()
    }

    private func openDB() {
        let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = (docs as NSString).appendingPathComponent("db.sqlite3")
        guard sqlite3_open(path, &db) == SQLITE_OK else {
            fatalError("Cannot open DB at \(path)")
        }
    }

    private func createTables() {
        let sql1 = """
          CREATE TABLE IF NOT EXISTS users (
            user_id INTEGER PRIMARY KEY,
            username TEXT UNIQUE,
            password TEXT
          );
        """
        let sql2 = """
          CREATE TABLE IF NOT EXISTS accounts (
            account_id   INTEGER PRIMARY KEY,
            user_id      INTEGER,
            account_type TEXT,
            balance      REAL,
            FOREIGN KEY(user_id) REFERENCES users(user_id)
          );
        """
        exec(sql: sql1)
        exec(sql: sql2)
    }

    private func exec(sql: String) {
        var err: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, sql, nil, nil, &err) != SQLITE_OK {
            let msg = String(cString: err!)
            fatalError("SQLite error: \(msg)")
        }
    }

    private func countUsers() -> Int {
        var stmt: OpaquePointer?
        sqlite3_prepare_v2(db, "SELECT COUNT(*) FROM users;", -1, &stmt, nil)
        sqlite3_step(stmt)
        let c = Int(sqlite3_column_int(stmt, 0))
        sqlite3_finalize(stmt)
        return c
    }

    private func seedIfNeeded() {
        guard countUsers() == 0 else { return }
        let users = [
          (1, "alice",   "password1"),
          (2, "bob",     "password2"),
          (3, "charlie", "password3"),
          (4, "diana",   "password4"),
          (5, "edward",  "password5")
        ]
        for (id,u,p) in users {
            let insU = "INSERT INTO users(user_id,username,password) VALUES(?,?,?);"
            var s1: OpaquePointer?
            sqlite3_prepare_v2(db, insU, -1, &s1, nil)
            sqlite3_bind_int64(s1, 1, Int64(id))
            sqlite3_bind_text(s1, 2, u, -1, nil)
            sqlite3_bind_text(s1, 3, p, -1, nil)
            sqlite3_step(s1); sqlite3_finalize(s1)

            insertAccount(id*10+1, Int64(id), "checking", Double(id*100))
            insertAccount(id*10+2, Int64(id), "savings",  Double(id*1000))
        }
    }

    private func insertAccount(_ accId: Int, _ uid: Int64, _ type: String, _ bal: Double) {
        let insA = "INSERT INTO accounts(account_id,user_id,account_type,balance) VALUES(?,?,?,?);"
        var s2: OpaquePointer?
        sqlite3_prepare_v2(db, insA, -1, &s2, nil)
        sqlite3_bind_int64(s2, 1, Int64(accId))
        sqlite3_bind_int64(s2, 2, uid)
        sqlite3_bind_text(s2, 3, type, -1, nil)
        sqlite3_bind_double(s2, 4, bal)
        sqlite3_step(s2); sqlite3_finalize(s2)
    }

    // MARK: – Public

    func validateUser(username: String, password: String) -> Int64? {
        let sql = "SELECT user_id FROM users WHERE username=? AND password=? LIMIT 1;"
        var stmt: OpaquePointer?
        sqlite3_prepare_v2(db, sql, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, username, -1, nil)
        sqlite3_bind_text(stmt, 2, password, -1, nil)
        var uid: Int64?
        if sqlite3_step(stmt) == SQLITE_ROW {
            uid = sqlite3_column_int64(stmt, 0)
        }
        sqlite3_finalize(stmt)
        return uid
    }

    func getAccounts(for userId: Int64) -> [Account] {
        let sql = "SELECT account_id,user_id,account_type,balance FROM accounts WHERE user_id=?;"
        var stmt: OpaquePointer?
        sqlite3_prepare_v2(db, sql, -1, &stmt, nil)
        sqlite3_bind_int64(stmt, 1, userId)
        var out = [Account]()
        while sqlite3_step(stmt) == SQLITE_ROW {
            let a = Account(
              id:      sqlite3_column_int64(stmt, 0),
              userId:  sqlite3_column_int64(stmt, 1),
              type:    String(cString: sqlite3_column_text(stmt, 2)),
              balance: sqlite3_column_double(stmt, 3)
            )
            out.append(a)
        }
        sqlite3_finalize(stmt)
        return out
    }

    func getAccount(_ accountId: Int64) -> Account? {
        let sql = "SELECT account_id,user_id,account_type,balance FROM accounts WHERE account_id=?;"
        var stmt: OpaquePointer?
        sqlite3_prepare_v2(db, sql, -1, &stmt, nil)
        sqlite3_bind_int64(stmt, 1, accountId)
        var a: Account?
        if sqlite3_step(stmt) == SQLITE_ROW {
            a = Account(
              id:      sqlite3_column_int64(stmt, 0),
              userId:  sqlite3_column_int64(stmt, 1),
              type:    String(cString: sqlite3_column_text(stmt, 2)),
              balance: sqlite3_column_double(stmt, 3)
            )
        }
        sqlite3_finalize(stmt)
        return a
    }
    
    func getUsername(for userId: Int64) -> String? {
           let sql = "SELECT username FROM users WHERE user_id = ? LIMIT 1;"
           var stmt: OpaquePointer?
           sqlite3_prepare_v2(db, sql, -1, &stmt, nil)
           sqlite3_bind_int64(stmt, 1, userId)
           var result: String?
           if sqlite3_step(stmt) == SQLITE_ROW {
               result = String(cString: sqlite3_column_text(stmt, 0))
           }
           sqlite3_finalize(stmt)
           return result
       }
}


