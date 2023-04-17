package com.test.kmmtodo

import com.test.Database
import com.test.TODOItem

class AppDataBase(driverFactory: DriverFactory) {
    private val driver = driverFactory.createDriver()
    private val database = Database(driver)
    private val queries = database.toDoItemQueries

    suspend fun insertItem(title: String) {
        queries.insert(null, title, false)
    }

    suspend fun deleteItem(id: Long) {
        queries.deleteById(id)
    }

    suspend fun updateCheck(checked: Boolean, id: Long) {
        queries.updateFinish(checked, id)
    }

    suspend fun getAllItems(): List<TODOItem> {
        return queries.selectAll().executeAsList()
    }
}