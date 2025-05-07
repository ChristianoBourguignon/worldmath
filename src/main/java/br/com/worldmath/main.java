package br.com.worldmath;
import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet(urlPatterns = {"/matrizes"})
public class main extends HttpServlet {

    private static List<Matrizes> matrizes = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("matrizName");
        int linhas = Integer.parseInt(request.getParameter("matrizRows"));
        int colunas = Integer.parseInt(request.getParameter("matrizCols"));
        //String nome = "Christiano";
        //int coluna = 4;
        //int linha = 3;
        matrizes.add(new Matrizes(nome, linhas, colunas));

        response.setContentType("application/json");
        response.getWriter().write("{\"status\":\"ok\"}");
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.write(new Gson().toJson(matrizes)); // use GSON para converter lista em JSON
    }
}
