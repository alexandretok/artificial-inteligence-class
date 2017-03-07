entradas = [-1 -1 -1 -1; 0 1 0 1; 0 0 1 1];
desejado = [-1; -1; -1; 1];
pesos = [0.1 0.1 0.1];

erroQuadratico = 1;

erro = [];

n = 0.1;

total = 0;
limite = 10;

while(erroQuadratico > 0.5 && limite > 0)
  limite = limite - 1;
  total = total + 1;
	iteracao = 1;
	for entrada = entradas
		a = pesos*entrada
		erro(iteracao, 1) = desejado(iteracao, 1) - ativacao(a)
    % atualiza os pesos
    % sprintf('pesos:')
    % disp(pesos)
    % sprintf('entrada:')
    % disp(entrada)
    pesos = pesos + n * transpose(entrada) * erro(iteracao, 1)
		iteracao = iteracao + 1;
	end
	erroQuadratico = sum(power(erro, 2));
  erro = [];
  sprintf('erro quadratico: ')
  disp(erroQuadratico)
end

total

function resultado = ativacao(x)
	if(x<0)
		resultado = -1;
	else
		resultado = 1;
    end
end