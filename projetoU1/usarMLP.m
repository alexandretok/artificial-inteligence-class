function saida = usarMLP(entradas)
  entradas = [(-1)*ones(1,1); entradas];
  alfaFuncaoAtivacao = 1;
  % % % % % FIM CONFIGURAÇÕES % % % % %



  pesosEscondida = [
6.9789,0.1840,2.4475,-0.4146;
-1.6021,0.2199,-2.9879,-0.3938;
-0.5784,0.5267,-0.7438,0.3908;
-0.2281,-0.4166,0.1674,-0.4095
];

  pesosSaida = [
0.1502,5.1873,11.4628,0.9926,-0.0001
6.3205,13.5249,-7.4423,4.8587,4.4684
];

  % Calcula o x e y da camada escondida (camada 1)
  xCamadaEscondida = calculaSaida(entradas, pesosEscondida);
  yCamadaEscondida = ativacao(xCamadaEscondida, alfaFuncaoAtivacao);
  entradaCamadaSaida = [(-1)*ones(1,1); yCamadaEscondida]; % Adiciona o bias

  % Calcula o x e y da camada de saida (camada 2)
  xCamadaSaida = calculaSaida(entradaCamadaSaida, pesosSaida);
  yCamadaSaida = ativacao(xCamadaSaida, alfaFuncaoAtivacao);

  saida = yCamadaSaida-0.5;
end