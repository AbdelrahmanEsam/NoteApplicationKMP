package com.example.noteapplication.di

import com.example.noteapplication.data.local.DatabaseDriverFactory
import com.example.noteapplication.utils.Dispatchers
import org.koin.core.qualifier.named
import org.koin.dsl.module

actual fun platformModule() = module {
    single {
        DatabaseDriverFactory()
    }

    single(named(Dispatchers.IO)) {
        kotlinx.coroutines.Dispatchers.Default
    }

}





actual interface CommonParcelable