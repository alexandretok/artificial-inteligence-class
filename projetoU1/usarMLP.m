function saida = usarMLP(entradas)
  entradas = [(-1)*ones(1,1); entradas];
  alfaFuncaoAtivacao = 1;
  % % % % % FIM CONFIGURAÇÕES % % % % %



  pesosEscondida = [
12.1763    0.1679    4.4008   -0.2669;
-6.9905   -1.8578   -8.7471    1.8711;
4.2831    0.0199    3.7135   -0.0207
];

  pesosSaida = [
-4.0919    5.9630   -3.6484   -3.5309;
3.5136    8.1471    3.0944    2.5786
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