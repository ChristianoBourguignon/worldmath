# Projeto de Operações com Matrizes

## Descrição
Este projeto realiza operações matemáticas com matrizes, permitindo que o usuário insira dados através de uma interface web desenvolvida em JSP. As informações fornecidas são enviadas para classes Java, que processam as operações e retornam os resultados.

## Funcionalidades
- Entrada de matrizes via interface JSP.
- Processamento de operações com matrizes (ex.: soma, multiplicação, transposição, etc.).
- Exibição dos resultados na interface web.

## Tecnologias Utilizadas
- **JSP**: Para a construção da interface web e captura de inputs do usuário.
- **Java**: Para a lógica de processamento das operações com matrizes.
- **Servlets**: Para comunicação entre a interface JSP e as classes Java.

## Desenvolvedores
- **Christiano**
- **Gabriel**

## Como Executar
1. Clone o repositório:
   ```bash
   git clone <URL_DO_REPOSITORIO>
   ```
2. Configure um servidor web compatível com JSP (ex.: Apache Tomcat).
3. Compile as classes Java e implante o projeto no servidor.
4. Acesse a aplicação pelo navegador através do endereço fornecido pelo servidor (ex.: `http://localhost:8080/`).
5. Insira os dados das matrizes na interface JSP e execute as operações desejadas.

## Estrutura do Projeto
- `src/`: Contém as classes Java responsáveis pelo processamento das operações com matrizes.
- `web/`: Contém os arquivos JSP para a interface web.
- `WEB-INF/`: Configurações do servidor, como `web.xml`.

## Contribuições
Contribuições são bem-vindas! Para contribuir:
1. Faça um fork do projeto.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`).
3. Commit suas alterações (`git commit -m 'Adiciona nova funcionalidade'`).
4. Envie para o repositório remoto (`git push origin feature/nova-funcionalidade`).
5. Abra um Pull Request.

## Licença
Este projeto está licenciado sob a [MIT License](LICENSE).