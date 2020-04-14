Imports NoteApp

Public Class Nota
    Implements ObjectBBDD

    Public Property NotaId As Integer
    Public Property Note_Titulo As String
    Public Property Note_Contenido As String
    Public Property Note_FechaAviso As Date
    Public Property Note_FechaRepetir As Date
    Public Property Note_Prioridad As String
    Public Property Note_CategoriaId As Integer
    Public Property Note_UsuarioId As Integer
    Public Property Note_Avisar As Integer
    Public Property Note_TiempoRepeticion As Integer

    Public ReadOnly Property nameTable As String Implements ObjectBBDD.nameTable
        Get
            Return "dbo.Notas"
        End Get
    End Property

    Public ReadOnly Property identificadorTabla As String Implements ObjectBBDD.identificadorTabla
        Get
            Return "NotaId"
        End Get
    End Property

    Public Function getAllFields() As String Implements ObjectBBDD.getAllFields
        Return " Note_Titulo, Note_Contenido, Note_FechaAviso, Note_FechaRepetir, Note_Prioridad, Note_CategoriaId, Note_UsuarioId, Note_Avisar, Note_TiempoRepeticion "
    End Function

    Public Function returnAllValues() As String Implements ObjectBBDD.returnAllValues
        Return "'" & Note_Titulo & "', '" & Note_Contenido & "', '" & Note_FechaAviso & "', '" & Note_FechaRepetir & "', '" _
            & Note_Prioridad & "', " & Note_CategoriaId & ", " & Note_UsuarioId & ", " & Note_Avisar & ", " & Note_TiempoRepeticion
    End Function

    Private Function getFieldsNotNull() As String Implements ObjectBBDD.getFieldsNotNull
        Return " Note_Titulo, Note_FechaAviso,Note_FechaRepetir, Note_CategoriaId, Note_UsuarioId, Note_Avisar "
    End Function

    Private Function getFieldsNull() As String Implements ObjectBBDD.getFieldsNull
        Return " Note_Contenido, Note_Prioridad, Note_TiempoRepeticion "
    End Function

End Class
