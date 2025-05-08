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
    <form id="matrizForm" method="POST" class="mb-5">
        <div class="row g-3">
            <div class="col-md-4">
                <label for="matrizName" class="form-label">Nome da Matriz</label>
                <input type="text" class="form-control" id="matrizName" name="matrizName" required>
            </div>
            <div class="col-md-4">
                <label for="matrizRows" class="form-label">Número de Linhas</label>
                <input type="number" class="form-control" id="matrizRows" name="matrizRows" min="1" required>
            </div>
            <div class="col-md-4">
                <label for="matrizCols" class="form-label">Número de Colunas</label>
                <input type="number" class="form-control" id="matrizCols" name="matrizCols" min="1" required>
            </div>
        </div>
        <div class="mt-4">
            <button type="submit" class="btn btn-primary">Inserir Matriz</button>
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
    document.getElementById("matrizForm").addEventListener("submit", function (e) {
        e.preventDefault(); // Impede o comportamento padrão do formulário (redirecionamento)

        // Captura os valores dos inputs
        const name = document.getElementById("matrizName").value.trim();
        const rows = document.getElementById("matrizRows").value.trim();
        const cols = document.getElementById("matrizCols").value.trim();

        const integerRegex = /^[1-9]\d*$/; // Aceita apenas inteiros positivos

        // Validações
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

        // Envia os dados para o backend usando fetch
        fetch("${pageContext.request.contextPath}/matrizes", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                matrizName: name,
                matrizRows: parseInt(rows),
                matrizCols: parseInt(cols)
            })
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Erro ao enviar os dados.");
                }
                return response.json();
            })
            .then(data => {
                console.log("Matrizes recebidas:", data);
                alert(`Matriz ${name} com ${rows} linhas e ${cols} colunas cadastrada!`);

                // Atualiza a lista de matrizes no front
                const container = document.getElementById("matricesList");
                container.innerHTML = ""; // Limpa a lista atual
                data.forEach(matriz => {
                    const div = document.createElement("div");
                    div.classList.add("col-md-4");
                    div.innerHTML = `
                    <div class="card p-3">
                        <h5>${data->nome}</h5>
                        <p>${data->linhas} x ${data->colunas}</p>
                    </div>
                `;
                    container.appendChild(div);
                });

                // Limpa os campos do formulário
                document.getElementById("matrizName").value = "";
                document.getElementById("matrizRows").value = "";
                document.getElementById("matrizCols").value = "";
            })
            .catch(err => {
                console.error("Erro ao carregar matrizes:", err);
                alert(`Ocorreu um erro ao inserir a matriz`);
            });
    });

    // Evita digitação de caracteres inválidos nos inputs de linhas e colunas
    ["matrizRows", "matrizCols"].forEach(id => {
        document.getElementById(id).addEventListener("input", function (e) {
            this.value = this.value.replace(/[^0-9]/g, ""); // Remove tudo que não for dígito
        });
    });

    // Função para carregar as matrizes ao carregar a página
    function carregarMatrizesDoServidor() {
        fetch("${pageContext.request.contextPath}/matrizes", {
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            }
        })
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
                        <p>${matriz.linha || matriz.linhas} x ${matriz.coluna || matriz.colunas}</p>
                    </div>
                `;
                    container.appendChild(div);
                });
            })
            .catch(err => console.error("Erro ao carregar matrizes:", err));
    }

    // Chama a função ao carregar a página
    carregarMatrizesDoServidor();
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
