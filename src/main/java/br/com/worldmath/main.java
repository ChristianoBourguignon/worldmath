package br.com.worldmath;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;


@WebServlet(urlPatterns = {"/matrizes"})
public class main extends HttpServlet {

    private static List<Matrizes> matrizes = new ArrayList<>();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        enviarDados(request, response);
    }
    public void enviarDados(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lê o corpo da requisição (JSON enviado)
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        // Converte JSON para objeto Java
        Gson gson = new Gson();
        System.out.println(sb);

        // Acessa os dados transformando de Json para Objects
        JsonObject jsonObject = JsonParser.parseString(sb.toString()).getAsJsonObject();
        String nome = jsonObject.get("matrizName").getAsString();
        int linhas = jsonObject.get("matrizRows").getAsInt();
        int colunas = jsonObject.get("matrizCols").getAsInt();



        // Adiciona à lista
        matrizes.add(new Matrizes(nome, linhas, colunas));

        // Tratamento da resposta
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Teste de recebimento
        Matrizes.imprimirMatriz(nome);
        System.out.println(nome);
        System.out.println(linhas);
        System.out.println(colunas);
        System.out.println("enviando matriz");

        // Envia a lista como JSON de volta
        PrintWriter pw = response.getWriter();
        pw.write(gson.toJson(matrizes));
        pw.flush();
        pw.close();
    }
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        response.setContentType("application/json");
//        PrintWriter out = response.getWriter();
//        out.write(new Gson().toJson(matrizes)); // use GSON para converter lista em JSON
//    }

}
