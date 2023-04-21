package com.tlife.translator

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform