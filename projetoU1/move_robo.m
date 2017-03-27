function finalRad = controle(serPort)
    while (true)
        x1 = ReadSonarMultiple(serPort, 1); % Direita
        x2 = ReadSonarMultiple(serPort, 2); % Frente
        x3 = ReadSonarMultiple(serPort, 3); % Esquerda
        x4 = ReadSonarMultiple(serPort, 4); % Trás

        if(x2 < 1)
            x = 'vira porra'
            SetFwdVelAngVelCreate(serPort,0,2.5);
        else
            SetFwdVelAngVelCreate(serPort,0.5,0);
        end
        
        pause(1)
    end
end