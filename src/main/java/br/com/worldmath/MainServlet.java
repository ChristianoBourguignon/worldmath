package br.com.worldmath;

import com.google.gson.Gson;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet(urlPatterns = {"/matrizes"})
public class MainServlet extends HttpServlet {

    private static List<Matrizes> matrizes = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String nome = req.getParameter("matrixName");
            String rowsStr = req.getParameter("matrixRows");
            String colsStr = req.getParameter("matrixCols");
            String matrixValuesStr = req.getParameter("matrixValues");

            System.out.println("POST /matrizes - Recebido: nome=" + nome + ", rows=" + rowsStr + ", cols=" + colsStr + ", values=" + matrixValuesStr);

            if (nome == null || rowsStr == null || colsStr == null || matrixValuesStr == null) {
                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Parâmetros ausentes\"}");
                return;
            }

            int linhas = Integer.parseInt(rowsStr);
            int colunas = Integer.parseInt(colsStr);

            // Parsear os valores da matriz
            int[][] valores = new int[linhas][colunas];
            String[] lines = matrixValuesStr.trim().split("\n");
            if (lines.length != linhas) {
                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Número de linhas nos valores não corresponde\"}");
                return;
            }

            for (int i = 0; i < linhas; i++) {
                String[] values = lines[i].trim().split("\\s+");
                if (values.length != colunas) {
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"status\":\"error\", \"message\":\"Número de colunas na linha " + (i+1) + " não corresponde\"}");
                    return;
                }
                for (int j = 0; j < colunas; j++) {
                    try {
                        valores[i][j] = Integer.parseInt(values[j].trim());
                    } catch (NumberFormatException e) {
                        resp.setContentType("application/json");
                        resp.getWriter().write("{\"status\":\"error\", \"message\":\"Valor inválido na posição [" + i + "," + j + "]: " + values[j] + "\"}");
                        return;
                    }
                }
            }

            Matrizes matriz = new Matrizes(nome, linhas, colunas);
            matriz.setValores(valores);
            matrizes.add(matriz);

            System.out.println("Matrizes armazenadas: " + matrizes.size());

            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"ok\"}");
        } catch (NumberFormatException e) {
            System.out.println("Erro: Linhas ou colunas inválidas - " + e.getMessage());
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Linhas ou colunas inválidas\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Erro interno no servidor: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("GET /matrizes - Retornando " + matrizes.size() + " matrizes");
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.write(new Gson().toJson(matrizes));
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String method = req.getMethod();
        System.out.println("Método recebido: " + method + " para /matrizes");
        if ("GET".equalsIgnoreCase(method)) {
            doGet(req, resp);
        } else if ("POST".equalsIgnoreCase(method)) {
            doPost(req, resp);
        } else {
            resp.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
            resp.setHeader("Allow", "GET, POST");
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Método não permitido: " + method + "\"}");
        }
    }
}