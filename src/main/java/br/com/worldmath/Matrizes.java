package br.com.worldmath;

import java.util.HashMap;
import java.util.Map;

public class Matrizes {
    String nome;
    int linha;
    int coluna;
    int[][] valores;

    private static Map<String, Matrizes> matrizMap = new HashMap<>();

    public Matrizes(String nome, int linha, int coluna) {
        this.nome = nome;
        this.linha = linha;
        this.coluna = coluna;
        this.valores = new int[linha][coluna];
        matrizMap.put(nome, this);
    }

    public int getColunas() {
        return this.coluna;
    }

    public int getLinhas() {
        return this.linha;
    }

    public String getNome() {
        return this.nome;
    }

    public void setColuna(int coluna) {
        this.coluna = coluna;
    }

    public void setLinha(int linha) {
        this.linha = linha;
    }

    public void setValores(int[][] valores) {
        this.valores = valores;
    }

    public void setValor(int linha, int coluna, int valor) {
        if (valor >= 0) {
            this.valores[linha][coluna] = valor;
        }
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void exibirMatriz() {
        System.out.println("Matriz: " + nome);
        for (int i = 0; i < this.linha; i++) {
            for (int j = 0; j < this.coluna; j++) {
                System.out.print(valores[i][j] + "\t");
            }
            System.out.println();
        }
    }

    public static void imprimirMatriz(String nome) {
        Matrizes matriz = matrizMap.get(nome);
        if (matriz != null) {
            matriz.exibirMatriz();
        } else {
            System.out.println("Matriz com nome: \"" + nome + "\" não encontrada.");
        }

    }
}
