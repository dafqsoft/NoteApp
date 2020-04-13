Public Class CrearNota
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        formulario.Visible = True
        titulo.Visible = True
        TituloInput.Visible = True
        Agregar.Visible = True

        If IsPostBack Then
            prueba.Text = TituloInput.Text
        End If

    End Sub

End Class