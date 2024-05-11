package com.example.noteapplication.presentation.notes


sealed interface NotesIntents{
    data object GetAllNotes : NotesIntents

    data class DeleteNoteById(val id : Long) : NotesIntents
    data class SearchNoteByTitle(val search : String) : NotesIntents
    data object ToggleSearch : NotesIntents

}