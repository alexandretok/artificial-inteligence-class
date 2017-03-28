entradas = [-1 1 1; -1 0 0; -1 1 0; -1 0 1];
desejado = [-1 0; -1 0; 1 0; 1 0];

erroQuadratico = 999; % vai conter o erro quadratico de cada iteracao

errosLocais = []; % vetor que vai conter os erros para cada entrada

passo = 0.1; % passo escolhido

alfa = 2;

quantidadeAmostrasTreinamento = 1;

numeroEntradas = 2;

if(size(entradas)(2) != numeroEntradas + 1)
  disp(['O numero de entradas esta errado!']);
  return;
end

qtdNeuroniosEntrada = 2;
qtdNeuroniosSaida = 2;

pesosEscondida = [0.1 0.1 0.1; 0.1 0.1 0.1]; % rand(qtdNeuroniosEntrada, numeroEntradas + 1);
pesosSaida = [0.1 0.1 0.1; 0.1 0.1 0.1]; % rand(qtdNeuroniosSaida, qtdNeuroniosEntrada + 1);

totalIteracoes = 0; % calcular quantas iteracoes foram necessarias
limiteIteracoes = 1; % limitar a um numero maximo de iteracoes



clc % limpa a tela

while(erroQuadratico > 0.5 && limiteIteracoes > totalIteracoes)
  totalIteracoes++;
  
  for iteracao = 1:quantidadeAmostrasTreinamento
    entradaCamadaEscondida = entradas(iteracao,:); % Pega a entrada atual
    
    % Calcula o x e y da camada escondida (camada 1)
    xCamadaEscondida = calculaSaida(entradaCamadaEscondida, pesosEscondida);
    yCamadaEscondida = ativacao(xCamadaEscondida, alfa)
    
    entradaCamadaSaida = [-1 yCamadaEscondida]; % Adiciona o bias
    
    y = ativacao(calculaSaida(entradaCamadaSaida, pesosSaida), alfa);
    errosLocais(iteracao, :) = (realpow((desejado(iteracao, 1)-y(1,1)),2) + realpow((desejado(iteracao, 2)-y(1,2)),2))/2;
    pesosEscondida = pesosEscondida + passo * derivadaAtivacao(y, alfa) * transpose(y) * errosLocais(iteracao, :)
  end
  
  errosLocais
  
  % erroQuadratico = 0;
  
  % disp(['teste: ' num2str(totalIteracoes) ';']);
end

% funcao sigmoide (funcao de ativacao)
function resultado = ativacao(x, alfa)
  if size(x) == [1 1]
    resultado = 1 / (1 + exp(-alfa * x));
  else
    for i = 1:size(x)(2)
      resultado(i) = 1 / (1 + exp(-alfa * x(1,i)));
    end
  end
end

function resultado = derivadaAtivacao(x, alfa)
  if size(x) == [1 1]
    resultado = alfa * ativacao(x, alfa) * (1 - ativacao(x, alfa));
  else
    for i = 1:size(x)(2)
      resultado = alfa * ativacao(x(1,i), alfa) * (1 - ativacao(x(1,i), alfa));
    end
  end
end

function resultado = calculaSaida(entrada, pesos)
  resultado = entrada * transpose(pesos);
end