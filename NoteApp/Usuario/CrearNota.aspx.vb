Imports NoteApp

Public Class CrearNota
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'formulario.Visible = True
        'titulo.Visible = True
        'TituloInput.Visible = True
        'Agregar.Visible = True

        If IsPostBack Then
            Dim myNote As New Nota

            myNote.Note_Titulo = TituloInput.Text
            myNote.Note_Contenido = TextoContenedor.InnerText.ToString
            myNote.Note_FechaAviso = "2020-04-15"
            myNote.Note_FechaRepetir = "2020-05-10"
            myNote.Note_Prioridad = "Comun"
            myNote.Note_CategoriaId = 5
            myNote.Note_UsuarioId = 2
            myNote.Note_Avisar = 0
            myNote.Note_TiempoRepeticion = 0


            Dim myAccess As New AccessBase

            If myAccess.editData(myNote) Then
                prueba.Text = "La nota con titulo: " & TituloInput.Text & " ; y contenido: "
                prueba.Text += "<br/>" + TextoContenedor.InnerText.ToString & " <br/> Se guardó corréctamente."
                prueba.ForeColor = Drawing.Color.Green
            Else
                prueba.Text = "La nota con titulo: " & TituloInput.Text & " no se guardó bien"
                prueba.ForeColor = Drawing.Color.Red

            End If

        End If

    End Sub

End Class