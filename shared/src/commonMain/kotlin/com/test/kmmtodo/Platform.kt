package com.test.kmmtodo

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform