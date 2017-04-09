% % % % % CONFIGURAÇÕES % % % % %
entradas = [-1 -1 -1 -1 -1 -1;
	         3  1  3  3 0.5 3;
	         3  3  3  1  1  1;
	         3  3  1  3  3 0.5];

desejado = [1 0.8 1 1 0 1;
			1 1 0.8 0 1 0];
alfaFuncaoAtivacao = 1;
passo = 0.75; % passo escolhido
erroAceitavel = 1e-10;
limiteIteracoes = 12000; % limitar a um numero maximo de iteracoes
alfa = 0.0001;
qtdNeuroniosEntrada = 4;
qtdNeuroniosSaida = 2;
% % % % % FIM CONFIGURAÇÕES % % % % %


erroQuadratico = 999; % vai conter o erro quadratico de cada iteracao
errosLocais = []; % vetor que vai conter os erros para cada entrada
quantidadeAmostrasTreinamento = size(entradas);
quantidadeAmostrasTreinamento = quantidadeAmostrasTreinamento(2);
numeroEntradas = size(entradas);
numeroEntradas = numeroEntradas(1) - 1;
pesosEscondida = rand(qtdNeuroniosEntrada, numeroEntradas + 1);
pesosEscondidaAnterior = zeros(qtdNeuroniosEntrada, numeroEntradas + 1);
pesosSaida = rand(qtdNeuroniosSaida, qtdNeuroniosEntrada + 1);
pesosSaidaAnterior = zeros(qtdNeuroniosSaida, qtdNeuroniosEntrada + 1);
totalIteracoes = 0; % calcular quantas iteracoes foram necessarias

clc % limpa a tela

while(limiteIteracoes > totalIteracoes)
  totalIteracoes = totalIteracoes + 1;
  
  % Calcula o x e y da camada escondida (camada 1)
  xCamadaEscondida = calculaSaida(entradas, pesosEscondida);
  yCamadaEscondida = ativacao(xCamadaEscondida, alfaFuncaoAtivacao);
  entradaCamadaSaida = [(-1)*ones(1,quantidadeAmostrasTreinamento); yCamadaEscondida]; % Adiciona o bias
  
  % Calcula o x e y da camada de saida (camada 2)
  xCamadaSaida = calculaSaida(entradaCamadaSaida, pesosSaida);
  yCamadaSaida = ativacao(xCamadaSaida, alfaFuncaoAtivacao);
  
  % Calcula o erro
  errosLocais = desejado - yCamadaSaida;
  erroQuadratico = mean(mean(errosLocais.^2));
  errosQuadraticos(totalIteracoes) = erroQuadratico;
  
  erroQuadratico;
  if(erroQuadratico < erroAceitavel)
    break;
  end
  
  % Atualizando pesos da camada de saida
  tmp = pesosSaida; % Guarda valor para usar na proxima iteracao (n-1)
  deltaSaida = passo / quantidadeAmostrasTreinamento * (derivadaAtivacao(yCamadaSaida, alfaFuncaoAtivacao) .* errosLocais) * entradaCamadaSaida';
  pesosSaida = pesosSaida + deltaSaida + alfa * pesosSaidaAnterior;
  pesosSaidaAnterior = tmp;
  
  % Atualizando pesos da camada escondida
  tmp = derivadaAtivacao(entradaCamadaSaida, alfaFuncaoAtivacao) .* (pesosSaida' * (derivadaAtivacao(yCamadaSaida, alfaFuncaoAtivacao) .* errosLocais));
  tmp = tmp(2:end,:);
  deltaEntrada = passo / quantidadeAmostrasTreinamento * tmp * entradas';
  tmp = pesosEscondidaAnterior; % Guarda valor para usar na proxima iteracao (n-1)
  pesosEscondida = pesosEscondida + deltaEntrada + alfa * pesosEscondidaAnterior;
  pesosEscondidaAnterior = tmp;
end

  saida = yCamadaSaida
  desejado

  disp(['Iteracoes: ' num2str(totalIteracoes)])
  disp(['Erro quadratico: ' num2str(erroQuadratico)])
  pesosEscondida
  pesosSaida