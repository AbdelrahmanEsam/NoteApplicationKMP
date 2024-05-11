package com.example.noteapplication.presentation.notes

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import co.touchlab.skie.configuration.annotations.FlowInterop
import com.example.noteapplication.domain.usecase.DeleteNoteUseCase
import com.example.noteapplication.domain.usecase.GetAllNotesUseCase
import com.example.noteapplication.domain.usecase.InsertNoteUseCase
import com.example.noteapplication.utils.Dispatchers
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.IO
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.qualifier.named


class NotesViewModel(
    private val getAllNotesUseCase: GetAllNotesUseCase,
    private val insertNoteUseCase: InsertNoteUseCase,
    private val deleteNoteUseCase: DeleteNoteUseCase,
) : ViewModel() {


    @FlowInterop.Enabled
    private val _notesState: MutableStateFlow<NotesStates.NotesState> =
        MutableStateFlow(NotesStates.NotesState())
    val notesState = _notesState.asStateFlow()

    @FlowInterop.Enabled
    private val _scrollUp: MutableSharedFlow<Boolean> = MutableSharedFlow()
    val scrollUp = _scrollUp.asSharedFlow()


    fun onEvent(intent: NotesIntents) {
        when (intent) {
            is NotesIntents.DeleteNoteById -> {
                deleteNoteById(intent.id)
            }

            NotesIntents.GetAllNotes -> {
                getAllNotes()
            }


            is NotesIntents.SearchNoteByTitle -> {
                searchNoteByTitle(intent.search)
            }

            NotesIntents.ToggleSearch -> {
                toggleSearch()
            }
        }
    }


    private fun getAllNotes() {
        viewModelScope.launch {
            getAllNotesUseCase.execute().collectLatest { notes ->
                _notesState.update { it.copy(notesList = notes, filteredNotes = notes) }
            }
        }
    }

    private fun searchNoteByTitle(search: String) {
        _notesState.update { it.copy(searchText = search) }
        viewModelScope.launch {
            _notesState.update {
                it.copy(filteredNotes = it.notesList.filter { note ->
                    note.title.lowercase().trim().contains(search) || note.content.lowercase()
                        .trim()
                        .contains(search)
                })
            }
            _scrollUp.emit(true)
        }
    }


    private fun deleteNoteById(id: Long) {
        viewModelScope.launch {
            deleteNoteUseCase.execute(id)
        }
    }


    private fun toggleSearch() {
        _notesState.update { it.copy(isSearchingActive = !it.isSearchingActive) }
        if (!_notesState.value.isSearchingActive) {
            _notesState.update { it.copy(searchText = "") }
        }
    }


    init {
        onEvent(NotesIntents.GetAllNotes)
    }

}