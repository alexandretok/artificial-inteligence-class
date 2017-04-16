#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define NUM_ENTRADAS 2
#define NUM_FUNCOES 3
#define NUM_CONJUNTOS_TREINAMENTO 27
#define MAX_ITERACOES 5000

float gerarAleatorio(){
	return ((rand() % 90) + 10) / 100.0;
}

float sigmoide(float x[NUM_ENTRADAS + 1], float centro[NUM_ENTRADAS]){
	float distancia = sqrt(pow(x[1] - centro[0], 2) + pow(x[2] - centro[1], 2));
	float sigmoide = exp(-distancia/0.5);
	return sigmoide;
}

int main(){

	time_t t;
	srand((unsigned) time(&t));

	int i, j, iteracoes, linhaTreinamento;
	float erroDesejavel = 0.001, y, erro[NUM_CONJUNTOS_TREINAMENTO];
	float phi[NUM_CONJUNTOS_TREINAMENTO][NUM_FUNCOES + 1];
	float centros[NUM_FUNCOES][NUM_ENTRADAS] = {
		{gerarAleatorio(), gerarAleatorio()},
		{gerarAleatorio(), gerarAleatorio()},
		{gerarAleatorio(), gerarAleatorio()}
	};
	float entrada[NUM_CONJUNTOS_TREINAMENTO][NUM_ENTRADAS + 1] = {
		{-1, 0.0, 0.45}, // 1
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
		{-1, 0.7, 0.4}, // 12
		{-1, 0.7, 1.0}, // 13
		{-1, 0.8, 1.0}, // 14
		{-1, 0.9, 0.8}, // 15
		{-1, 1.0, 0.9}, // 16
		{-1, 0.0, 1.6}, // 17
		{-1, 0.2, 1.5}, // 18
		{-1, 0.3, 1.8}, // 19
		{-1, 0.4, 1.4}, // 20
		{-1, 0.5, 1.3}, // 21
		{-1, 0.5, 1.9}, // 22
		{-1, 0.6, 1.6}, // 23
		{-1, 0.7, 1.2}, // 24
		{-1, 0.9, 1.1}, // 25
		{-1, 0.9, 1.6}, // 26
		{-1, 1.0, 1.1} // 27
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
		1, // 12
		2, // 13
		2, // 14
		1, // 15
		1, // 16
		3, // 17
		3, // 18
		3, // 19
		3, // 20
		3, // 21
		3, // 22
		3, // 23
		3, // 24
		3, // 25
		3, // 26
		3 // 27
	};
	float pesos[NUM_FUNCOES + 1] = {gerarAleatorio(), gerarAleatorio(), gerarAleatorio(), gerarAleatorio()};

	float passo = 0.1;
	double erroQuad;

	printf("\nTabela de treinamento:\n Bias\t X1\t X2\tD\n--------------------------\n");
	for(i=0; i < NUM_CONJUNTOS_TREINAMENTO; i++){
		for(j=0; j < NUM_ENTRADAS + 1; j++)
			printf("%.2f\t", entrada[i][j]);
		printf("%i", desejado[i]);
		printf("\n");
	}

	printf("\nCentros das funções:\n");
	for(j=0; j < NUM_FUNCOES; j++){
		for(i=0; i < NUM_ENTRADAS; i++)
		printf("%.2f\t", centros[j][i]);
		printf("\n");
	}

	printf("\nPesos iniciais:\n");
	for(j=0; j < NUM_FUNCOES + 1; j++)
		printf("%.2f\t", pesos[j]);
	printf("\n\n");

	iteracoes = 0, erroQuad = 1.0;

	while(iteracoes < MAX_ITERACOES && erroQuad > erroDesejavel){
		erroQuad = 0.0;
		for(linhaTreinamento=0; linhaTreinamento < NUM_CONJUNTOS_TREINAMENTO; linhaTreinamento++){
			phi[linhaTreinamento][0] = entrada[linhaTreinamento][0]; // BIAS
			// printf("phi0: %f\t", phi[linhaTreinamento][0]);
			for(j=1; j < NUM_FUNCOES + 1; j++){
				phi[linhaTreinamento][j] = sigmoide(entrada[linhaTreinamento], centros[j - 1]);
				// printf("phi%i: %f\t", j, phi[linhaTreinamento][j]);
			}
			// printf("\n");

			y = 0;
			for(j=0; j < NUM_FUNCOES + 1; j++){
				y += pesos[j] * phi[linhaTreinamento][j];
			}
			// printf("y%i: %f\t", linhaTreinamento, y);

			erro[linhaTreinamento] = desejado[linhaTreinamento] - y;
			// printf("erro: %f\n", erro[linhaTreinamento]);

			erroQuad += erro[linhaTreinamento] * erro[linhaTreinamento];

			for(j=0; j < NUM_FUNCOES + 1; j++){
				pesos[j] = pesos[j] + passo * erro[linhaTreinamento] * phi[linhaTreinamento][j];
				// printf("peso(%i): %f\t", j, pesos[j]);
			}
			// printf("\n\n");
		}

		erroQuad /= NUM_CONJUNTOS_TREINAMENTO;

		// printf("MSE: %.2f\n", erroQuad);

		iteracoes++;
	}

	printf("Pesos encontrados:\n");
	for(j=0; j < NUM_FUNCOES + 1; j++){
		printf("W[%i] = %.2f\n", j, pesos[j]);
	}
	printf("\n");

	printf("\nNúmero de iterações: %i\n", iteracoes);
	printf("MSE Final: %.2f\n", erroQuad);

	float x1, x2;

	return 0;

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

		printf("Esse ponto representa a classe %.0f\n\n", y);
	}

	return 0;
}
