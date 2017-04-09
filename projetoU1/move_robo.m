function finalRad = controle(serPort)

    while (true)
        sDireita = ReadSonarMultiple(serPort, 1);  % Direita
        sFrente = ReadSonarMultiple(serPort, 2);   % Frente
        sEsquerda = ReadSonarMultiple(serPort, 3); % Esquerda

        if(isempty(sDireita))
            sDireita = 0.1;
        end
        if(isempty(sFrente))
            sFrente = 0.1;
        end
        if(isempty(sEsquerda))
            sEsquerda = 0.1;
        end
        
        

        entrada = [sDireita; sFrente; sEsquerda];

        saida = usarMLP(entrada);

        SetDriveWheelsCreate(serPort,saida(1,1),saida(2,1));
        
        pause(abs(rand(1) - 0.5));
    end

end