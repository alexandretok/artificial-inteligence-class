entradas = [-1 -1 -1 -1; 0 1 0 1; 0 0 1 1];
desejado = [-1; -1; -1; 1];
pesos = [0.1 0.1 0.1];

erroQuadratico = 999; % vai conter o erro quadratico de cada iteracao

erro = []; % vetor que vai conter os erros para cada entrada

n = 0.01; % passo escolhido

totalDeIteracoes = 0; % calcular quantas iteracoes foram necessarias
limiteIteracoes = 10; % limitar a um numero maximo de iteracoes

% funcao degrau (funcao de ativacao)
function resultado = ativacao(x)
	if(x<0)
		resultado = -1;
	else
		resultado = 1;
    end
end

while(erroQuadratico > 0.5 && limiteIteracoes > 0)

  limiteIteracoes = limiteIteracoes - 1;
  totalDeIteracoes = totalDeIteracoes + 1;
	indexEntrada = 1;

	for entrada = entradas
		a = pesos * entrada; % calcula a saida
		erro(indexEntrada, 1) = desejado(indexEntrada, 1) - ativacao(a); % calculo do erro
    pesos = pesos + n * transpose(entrada) * erro(indexEntrada, 1); % atualiza os pesos
		indexEntrada = indexEntrada + 1;
	end
	erroQuadratico = sum(power(erro, 2)) / (indexEntrada - 1); % calcula o erro quadratico
  erro = [];
  erroQuadratico
end

pesos
totalDeIteracoes

