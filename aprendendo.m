entradas = [-1 -1 -1 -1; 0 1 0 1; 0 0 1 1];
desejado = [-1 -1 -1 1];
pesos = [0.1 0.1 0.1];

erroQuadratico = 1;


while(erroQuadratico > 0.5)
	iteracao = 1;
	for entrada = entradas
		a = pesos*entrada;
		a = a(:,1)
		desejado(iteracao,:)
		erro(iteracao) = desejado(:, iteracao) - a
		iteracao = iteracao + 1;
	end
	erroQuadratico = 0.1;
end

function resultado = ativacao(x)
	if(x<0)
		resultado = -1;
	else
		resultado = 1;
    end
end