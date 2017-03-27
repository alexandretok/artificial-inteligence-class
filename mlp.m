entradas = [-1 0 0; -1 1 0; -1 0 1; -1 1 1];
desejado = [-1; 1; 1; -1];

erroQuadratico = 999; % vai conter o erro quadratico de cada iteracao

errosLocais = []; % vetor que vai conter os erros para cada entrada

passo = 0.1; % passo escolhido

alfa = 2;

numeroEntradas = 2;

if(size(entradas)(2) != numeroEntradas + 1)
  disp(['O numero de entradas esta errado!']);
end

qtdNeuroniosEntrada = 4;
qtdNeuroniosSaida = 2;

wEscondida = rand(qtdNeuroniosEntrada, numeroEntradas + 1);
wSaida = rand(qtdNeuroniosSaida, qtdNeuroniosEntrada + 1);

totalIteracoes = 0; % calcular quantas iteracoes foram necessarias
limiteIteracoes = 10; % limitar a um numero maximo de iteracoes

% funcao degrau (funcao de ativacao)
function resultado = ativacao(x, alfa)
  for i = 1:size(x)(2)
    resultado(i) = 1 / (1 + exp(-alfa * x(1,i)));
  end
end

function resultado = derivadaAtivacao(x)
  resultado = alfa * ativacao(x) * (1 - ativacao(x));
end

function resultado = calculaX(entrada, pesos)
  resultado = entrada * transpose(pesos);
end

tmp = ativacao(calculaX(entradas(2,:), wEscondida), alfa);
tmp = [-1 tmp];
ativacao(calculaX(tmp, wSaida), alfa)


while(erroQuadratico > 0.5 && limiteIteracoes > totalIteracoes)
  totalIteracoes += 1;
  
  % disp(['teste: ' num2str(totalIteracoes) ';']);
end