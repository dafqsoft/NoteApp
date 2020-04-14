<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CrearNota.aspx.vb" Inherits="NoteApp.CrearNota" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <form runat="server" id="formulario" >

        <asp:label runat="server" id="titulo" text="Titulo"></asp:label>
        <asp:TextBox runat="server" ID="TituloInput"></asp:TextBox>
        <asp:Label runat="server" ID="contenido" Text="Contenido"></asp:Label>
        <textarea id="TextoContenedor" runat="server" cols="20" rows="2"></textarea>
        <asp:Button runat="server" ID="Agregar" Text="Guardar Nota" />


    </form>

    <asp:label id="prueba" runat="server"></asp:label>
    
</asp:Content>
