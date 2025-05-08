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
            <div class="mb-3">
                <label for="matrixValues" class="form-label">Valores da Matriz</label>
                <textarea class="form-control" id="matrixValues" name="matrixValues" rows="5" placeholder="Digite os valores da matriz, cada linha separada por quebra de linha, e os valores separados por espaço. Exemplo:&#10;1 2 3&#10;4 5 6&#10;7 8 9"></textarea>
            </div>
        </div>
        <div class="mt-4">
            <button type="submit" class="btn btn-primary">Cadastrar Matriz</button>
        </div>
    </form>

    <div id="matricesDisplay">
        <h2 class="mb-3">Matrizes Cadastradas</h2>
        <div id="matricesList" class="row gy-3">

        </div>
    </div>
</div>
<script>
    document.getElementById("matrixForm").addEventListener("submit", function (e) {
        e.preventDefault();

        let name = document.getElementById("matrixName").value.trim();
        let rows = document.getElementById("matrixRows").value.trim();
        let cols = document.getElementById("matrixCols").value.trim();
        let values = document.getElementById("matrixValues").value.trim();

        const integerRegex = /^[1-9]\d*$/;

        if (!name) {
            alert("Por favor, insira o nome da matriz.");
            return;
        }

        if (!integerRegex.test(rows)) {
            alert("Número de linhas deve ser um número inteiro positivo.");
            return;
        }

        if (!integerRegex.test(cols)) {
            alert("Número de colunas deve ser um número inteiro positivo.");
            return;
        }

        console.log("Enviando POST para /matrizes com:", { matrixName: name, matrixRows: rows, matrixCols: cols, matrixValues: values });

        fetch('/matrizes', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                matrixName: name,
                matrixRows: rows,
                matrixCols: cols,
                matrixValues: values
            })
        })
            .then(response => {
                console.log("Resposta do POST:", response.status, response.statusText);
                if (!response.ok) {
                    throw new Error('Erro na requisição POST: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log("Dados recebidos do POST:", data);
                if (data.status === 'ok') {
                    alert('Matriz cadastrada com sucesso!');
                    document.getElementById("matrixForm").reset();
                    carregarMatrizesDoServidor();
                } else {
                    alert('Erro ao cadastrar matriz: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Erro no POST:', error);
                alert('Ocorreu um erro ao cadastrar a matriz: ' + error.message);
            });
    });

    ["matrixRows", "matrixCols"].forEach(id => {
        document.getElementById(id).addEventListener("input", function (e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    });

    function carregarMatrizesDoServidor() {
        console.log("Enviando GET para /matrizes");
        fetch('/matrizes')
            .then(response => {
                console.log("Resposta do GET:", response.status, response.statusText);
                if (!response.ok) {
                    throw new Error('Erro na requisição GET: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log('Matrizes recebidas (antes de renderizar):', data);
                const container = document.getElementById("matricesList");
                if (!container) {
                    console.error("Elemento matricesList não encontrado no DOM!");
                    alert("Erro: Elemento de exibição das matrizes não encontrado.");
                    return;
                }
                container.innerHTML = "";
                if (!data || data.length === 0) {
                    container.innerHTML = "<p>Nenhuma matriz cadastrada.</p>";
                    return;
                }
                data.forEach((matriz, index) => {
                    console.log(`Renderizando matriz ${index}:`, matriz);
                    let tableHTML = '<table class="table"><tbody>';
                    try {
                        matriz.valores.forEach(row => {
                            tableHTML += '<tr>';
                            row.forEach(val => {
                                tableHTML += '<td>' + (val !== undefined ? val : 'N/A') + '</td>';
                            });
                            tableHTML += '</tr>';
                            console.log(`Linha adicionada ao tableHTML:`, tableHTML);
                        });
                    } catch (e) {
                        console.error(`Erro ao construir tabela para matriz ${matriz.nome}:`, e);
                        tableHTML = '<p>Erro ao carregar valores da matriz.</p>';
                    }
                    tableHTML += '</tbody></table>';
                    console.log(`tableHTML completo para matriz ${index}:`, tableHTML);

                    const div = document.createElement("div");
                    div.classList.add("col-md-4", "mb-3");
                    div.innerHTML = '<div class="card p-3">' +
                        '<h5>' + matriz.nome + ' (' + matriz.linha + 'x' + matriz.coluna + ')</h5>' +
                        tableHTML +
                        '</div>';
                    console.log(`Div a ser adicionada ao DOM:`, div.outerHTML);
                    container.appendChild(div);
                    console.log(`Conteúdo de matricesList após adicionar div:`, container.innerHTML);
                });
            })
            .catch(error => {
                console.error('Erro ao carregar matrizes:', error);
                alert('Não foi possível carregar as matrizes: ' + error.message);
            });
    }

    carregarMatrizesDoServidor();
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
