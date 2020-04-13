<%@ Page Title="Inicio" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="NoteApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Web NoteApp</h1>
        <p class="lead">
            En esta web concebimos las ideas de manera distinta a los demás, como algo vivo que cambia cada día; lo cuall trasladamos en nuestra aplicación en forma de notas,
            unas notas que te serán de lo más fácil de entender y usar. En un futuro contaremos con formas de aviso a usuarios.
        </p>
        <p><a href="#vacio-por-ahora" class="btn btn-primary btn-lg">Aquí podrás aprender más.</a></p>
    </div>

    <div id="carousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carousel" data-slide-to="0" class="active"></li>
            <li data-target="#carousel" data-slide-to="1"></li>
            <li data-target="#carousel" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active" data-interval="10000">
                <img src="/Content/Images/notes-1.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Unas buenas notas</h5>
                    <p>para reducir el tiempo de recuerdo.</p>
                </div>
            </div>
            <div class="item" data-interval="10000">
                <img src="/Content/Images/notes-2.png" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Clasificación adecuada</h5>
                    <p>según el usuario.</p>
                </div>
            </div>
            <div class="item" data-interval="10000">
                <img src="/Content/Images/notes-3.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Simplicidad como apellido</h5>
                    <p>nuestro orgullo es aportarte el lugar perfecto para almacenar tus ideas.</p>
                </div>
            </div>
        </div>
        <a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

</asp:Content>
