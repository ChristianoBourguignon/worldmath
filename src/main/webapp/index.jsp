<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cadastro de Matrizes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-5">
    <h1 class="mb-4">Cadastro de Matrizes</h1>

    <!-- Formulário -->
    <form id="matrixForm" action="#" th:action="@{/matrizes}" th:object="${main}" class="mb-5">
        <div class="row g-3">
            <div class="col-md-4">
                <label for="matrixName" class="form-label">Nome da Matriz</label>
                <input type="text" class="form-control" id="matrixName" name="matrizName" required>
            </div>
            <div class="col-md-4">
                <label for="matrixRows" class="form-label">Número de Linhas</label>
                <input type="number" class="form-control" id="matrixRows" name="matrizRows" min="1" required>
            </div>
            <div class="col-md-4">
                <label for="matrixCols" class="form-label">Número de Colunas</label>
                <input type="number" class="form-control" id="matrixCols" name="matrizCols" min="1" required>
            </div>
        </div>
        <div class="mt-4">
            <button type="submit" class="btn btn-primary">Cadastrar Matriz</button>
        </div>
    </form>

    <!-- Área para exibir as matrizes -->
    <div id="matricesDisplay">
        <h2 class="mb-3">Matrizes Cadastradas</h2>
        <div id="matricesList" class="row gy-3">
            <!-- Matrizes serão inseridas aqui futuramente -->
        </div>
    </div>
</div>
<script>
    document.getElementById("matrixForm").addEventListener("submit", function (e) {
        e.preventDefault();

        let name = document.getElementById("matrixName").value.trim();
        let rows = document.getElementById("matrixRows").value.trim();
        let cols = document.getElementById("matrixCols").value.trim();

        const integerRegex = /^[1-9]\d*$/; // Aceita apenas inteiros positivos

        if (!name) {
            alert("Por favor, insira o nome da matriz.");
            return;
        }

        if (!integerRegex.test(rows)) {
            alert("Número de linhas deve ser um número inteiro positivo, sem pontos ou símbolos.");
            return;
        }

        if (!integerRegex.test(cols)) {
            alert("Número de colunas deve ser um número inteiro positivo, sem pontos ou símbolos.");
            return;
        }

        // Exemplo de confirmação (você pode substituir por outra lógica)
        console.log(name);
        console.log(rows);
        console.log(cols);
        alert(`Matriz: ${name} com ${rows} linhas e ${cols} colunas cadastrada!`);

        // Aqui você pode adicionar a lógica para criar a matriz e exibi-la
    });

    // Evita digitação de caracteres inválidos nos inputs de linhas e colunas
    ["matrixRows", "matrixCols"].forEach(id => {
        document.getElementById(id).addEventListener("input", function (e) {
            this.value = this.value.replace(/[^0-9]/g, ''); // Remove tudo que não for dígito
        });
    });

    function carregarMatrizesDoServidor() {
        fetch('/matrizes')
            .then(response => response.json())
            .then(data => {
                const container = document.getElementById("matricesList");
                container.innerHTML = "";
                data.forEach(matriz => {
                    const div = document.createElement("div");
                    div.classList.add("col-md-4");
                    div.innerHTML = `
                    <div class="card p-3">
                        <h5>${matriz.nome}</h5>
                        <p>${matriz.linhas} x ${matriz.colunas}</p>
                    </div>
                `;
                    container.appendChild(div);
                });
            });
    }

    // Chame após criação da matriz:
    carregarMatrizesDoServidor();

</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
