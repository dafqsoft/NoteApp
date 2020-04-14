Public Interface ObjectBBDD

    ReadOnly Property nameTable As String
    ReadOnly Property identificadorTabla As String

    Function getFieldsNotNull() As String

    Function getFieldsNull() As String

    Function getAllFields() As String

    Function returnAllValues() As String

End Interface
