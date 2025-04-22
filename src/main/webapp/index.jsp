<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoEscambo</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
    <!-- CSS global -->
    <link rel="stylesheet" href="style/globals.css">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container-fluid">
            <!-- Logo -->
            <a class="navbar-brand me-auto" href="index.php">
                <span class="world">World</span><span class="math">Math</span>
            </a>

            <!-- Botão hamburguer (só aparece no mobile) -->
            <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Itens centralizados no desktop -->
                <div class="collapse navbar-collapse justify-content-center">
                    <ul class="navbar-nav">
                        <li class="nav-item"><a class="nav-link" href="#">Início</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Produtos</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Sobre nós</a></li>
                    </ul>
                </div>
            </div>
            <!-- Offcanvas (menu mobile) -->
            <div class="offcanvas offcanvas-end d-lg-none" tabindex="-1" id="offcanvasNavbar">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title">
                        <span class="world">World</span><span class="math">Math</span>
                    </h5>
                    <button type="button" class="btn-close btn-close-dark" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <div class="list-group">
                        <div class="list-group-item disabled">Páginas</div>
                        <a class="list-group-item list-group-item-action" href="#">Início</a>
                        <a class="list-group-item list-group-item-action" href="#">Produtos</a>
                        <a class="list-group-item list-group-item-action" href="#">Sobre nós</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    <div class="container-fluid corpo">
        <h1>Hello World!</h1>
    </div>

</body>
</html>
