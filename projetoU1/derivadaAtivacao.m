function resultado = derivadaAtivacao(x, alfaFuncaoAtivacao)
  resultado = alfaFuncaoAtivacao * x .* (1 - x);
end