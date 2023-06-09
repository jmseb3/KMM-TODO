package com.test.kmmtodo

import app.cash.sqldelight.coroutines.asFlow
import app.cash.sqldelight.coroutines.mapToList
import com.test.Database
import com.test.TODOItem
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.withContext

class AppDataBase(driverFactory: DriverFactory) {
    private val driver = driverFactory.createDriver()
    private val database = Database(driver)
    private val queries = database.toDoItemQueries

    fun insertItem(title: String) {
        queries.insert(null, title, false)
    }

    fun deleteItem(id: Long) {
        queries.deleteById(id)
    }

    fun updateCheck(checked: Boolean, id: Long) {
        queries.updateFinish(checked, id)
    }

    fun getAllItemFlow() : Flow<List<TODOItem>> = queries.selectAll().asFlow().mapToList(Dispatchers.Main)

}