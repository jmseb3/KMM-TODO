package com.test.kmmtodo

import app.cash.sqldelight.db.SqlDriver
import app.cash.sqldelight.driver.native.NativeSqliteDriver
import com.test.Database

actual class DriverFactory() {
    actual fun createDriver(): SqlDriver {
        return NativeSqliteDriver(Database.Schema,"todo.db")
    }
}