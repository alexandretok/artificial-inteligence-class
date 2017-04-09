function resultado = ativacao(x, alfaFuncaoAtivacao)
  resultado = 1 ./ (1 + exp(-alfaFuncaoAtivacao * x));
end