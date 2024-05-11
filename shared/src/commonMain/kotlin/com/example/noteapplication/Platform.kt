package com.example.noteapplication

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform