#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM_ENTRADAS 2
#define NUM_CONJUNTOS_TREINAMENTO 13
#define MAX_ITERACOES 5000

float gerarAleatorio(){
	return ((rand() % 90) + 10) / 100.0;
}

int ativacao(float x){
	return x < 0 ? 0 : 1;
}

int main(){

	time_t t;
	srand((unsigned) time(&t));

	int i, j, iteracoes;
	float erroDesejavel = 0.001, y, erro[NUM_CONJUNTOS_TREINAMENTO];
	float entrada[NUM_CONJUNTOS_TREINAMENTO][NUM_ENTRADAS + 1] = {
		{-1, 0.0, 0.3}, // 1
		{-1, 0.0, 0.6}, // 2
		{-1, 0.1, 0.8}, // 3
		{-1, 0.2, 0.7}, // 4
		{-1, 0.3, 0.5}, // 5
		{-1, 0.4, 0.2}, // 6
		{-1, 0.4, 0.8}, // 7
		{-1, 0.4, 1.0}, // 8
		{-1, 0.5, 0.6}, // 9
		{-1, 0.5, 0.8}, // 10
		{-1, 0.6, 1.1}, // 11
		{-1, 0.7, 1.0}, // 12
		{-1, 0.7, 0.4} // 13
	};
	int desejado[NUM_CONJUNTOS_TREINAMENTO] = {
		1, // 1
		2, // 2
		2, // 3
		2, // 4
		1, // 5
		1, // 6
		2, // 7
		2, // 8
		1, // 9
		2, // 10
		2, // 11
		2, // 12
		1 // 13
	};
	float pesos[NUM_ENTRADAS + 1] = {gerarAleatorio(), gerarAleatorio(), gerarAleatorio()};

	float passo = 0.3;
	double erroQuad;

	printf("\nTABELA DE TREINAMENTO:\nBIAS\tX1\tX2\tD\n--------------------------\n");
	for(i=0; i < NUM_CONJUNTOS_TREINAMENTO; i++){
		for(j=0; j < NUM_ENTRADAS + 1; j++)
			printf("%.2f\t", entrada[i][j]);
		printf("%i", desejado[i]);
		printf("\n");
	}

	printf("\nPESOS ALEATÓRIOS:\n");
	for(j=0; j < NUM_ENTRADAS + 1; j++)
		printf("%.2f\t", pesos[j]);
	printf("\n\n");

	iteracoes = 0, erroQuad = 1.0;

	while(iteracoes < MAX_ITERACOES && erroQuad > erroDesejavel){
		erroQuad = 0.0;
		for(int linhaTreinamento=0; linhaTreinamento < NUM_CONJUNTOS_TREINAMENTO; linhaTreinamento++){
			y = 0;
			for(j=0; j < NUM_ENTRADAS + 1; j++){
				y += pesos[j] * entrada[linhaTreinamento][j];
			}

			y = ativacao(y) + 1;

			erro[linhaTreinamento] = desejado[linhaTreinamento] - y;

			erroQuad += erro[linhaTreinamento] * erro[linhaTreinamento];

			for(j=0; j < NUM_ENTRADAS + 1; j++){
				pesos[j] = pesos[j] + passo * erro[linhaTreinamento] * entrada[linhaTreinamento][j];
			}
		}

		erroQuad /= NUM_CONJUNTOS_TREINAMENTO;

		printf("Erro Quad: %.2f\n", erroQuad);

		iteracoes++;
	}

	printf("\nNúmero de iterações: %i\n", iteracoes);
	printf("Erro quadrático: %.2f\n", erroQuad);

	float x1, x2;

	printf("\nEscolha valores para X1 e X2 para verificar se a rede foi treinada corretamente.\n");

	while(1){
		printf("\nDigite um valor para X1 (-1 para sair): ");
		scanf("%f", &x1);

		if(x1 == -1.0)
			break;

		printf("\nDigite um valor para X2 (-1 para sair): ");
		scanf("%f", &x2);

		float tmp[NUM_ENTRADAS + 1] = {-1.0, x1, x2};

		y = 0;
		for(j=0; j < NUM_ENTRADAS + 1; j++){
			y += pesos[j] * tmp[j];
		}

		y = ativacao(y) + 1;

		printf("Esse ponto representa a classe %.0f", y);

	}

	return 0;

}

