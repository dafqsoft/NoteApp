Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient

Public Class AccessBase

    Shared Property myConnectionString As String

    Shared Property myConnection As SqlConnection

    Public Sub New()
        myConnectionString = ConfigurationManager.ConnectionStrings("Conn").ConnectionString

        myConnection = New SqlConnection(myConnectionString)
    End Sub

    'Esto hay que expandirlo para que tenga unas mejores medidas de seguridad ante hackeos
    Shared Function isNotHack(ByRef myWhere As String) As Boolean

        Dim isHack As Boolean = True

        If myWhere.IndexOf("(") Xor myWhere.IndexOf(")") Then
            isHack = False
            If myWhere.IndexOf("1=1") Then
                isHack = False
            Else
                isHack = True
            End If
        End If

        Return isHack
    End Function


    'Recogo la conexión, establezco un enlace, realizo una query, y devuelvo los datos 
    'si tiene un where se le añade, si no -o si es un where trucado- no se añade.
    Shared Function dameData(ByRef myObject As ObjectBBDD, Optional ByVal mySearch As String = "") As DataSet

        Dim myQuery As String = "SELECT " & myObject.getFieldsNotNull _
                                                                         & " , " & myObject.getFieldsNull & " FROM " _
                                                                         & myObject.nameTable
        If isNotHack(mySearch) Then
            If Not IsNothing(mySearch) And mySearch <> "" Then
                myQuery += mySearch
            End If
        End If

        myQuery += " ;"

        Dim myAdapter As New SqlDataAdapter(myQuery, myConnection)

        myConnection.Open()

        Dim myDataSet As DataSet = New DataSet

        myAdapter.Fill(myDataSet, myObject.nameTable)

        Return myDataSet
    End Function

    'Tiene un id opcional, por si va a modificar algo.
    Shared Function editData(ByRef myObject As ObjectBBDD, Optional ByVal id As Integer = 0)

        'If neededTransaction Then
        '    Me.myTransaction = Me.myConnection.BeginTransaction()
        '    withTransaction(Me.myTransaction)
        'End If

        Dim myTransaction As SqlTransaction

        myConnection.Open()

        myTransaction = myConnection.BeginTransaction()

        Dim myTransactionRealizada As Boolean = True

        Try

            Dim myQuery As String

            If id <> 0 Then
                myQuery = "UPDATE " & myObject.nameTable & " SET "
            Else
                myQuery = "INSERT INTO " & myObject.nameTable & "(" & myObject.getAllFields & ") VALUES (" & myObject.returnAllValues & ")"
            End If

            Dim myCommand As SqlClient.SqlCommand = New SqlClient.SqlCommand(myQuery)



            If myCommand.ExecuteNonQuery Then
                myTransaction.Commit()
            End If

        Catch ex As Exception
            myTransaction.Rollback()

            myTransactionRealizada = False
        End Try

        myConnection.Close()

        Return myTransactionRealizada
    End Function


    'Private Function withTransaction(ByVal ongoingTransaction As SqlTransaction)
    '    Try
    '        myCommand = returnCommand()
    '    Catch ex As Exception

    '    End Try

    'End Function

    Private Function borrarData(ByVal nombreTabla As String, ByVal identificador As String, ByVal id As Integer)
        Dim myTransaction As SqlTransaction

        myConnection.Open()

        myTransaction = myConnection.BeginTransaction()

        Dim myTransactionRealizada As Boolean = True

        Try

            Dim myQuery As String = "DELETE FROM " & nombreTabla & " WHERE " & identificador & "= " & id & " ;"

            Dim myCommand As SqlClient.SqlCommand = New SqlClient.SqlCommand(myQuery)

            If myCommand.ExecuteNonQuery Then
                myTransaction.Commit()
            End If

        Catch ex As Exception
            myTransaction.Rollback()

            myTransactionRealizada = False
        End Try

        myConnection.Close()

        Return myTransactionRealizada
    End Function

    'Las transacciones complejas se tratan en la clase del objeto en la que se realicen o una clase aledaña que nombre
    'al susodicho tipo de objeto que va a ser objeto de la transacción
    'Yo solo devuelvo la conexión.
    Public Function devuelveConexion() As SqlConnection
        Return myConnection
    End Function

End Class
