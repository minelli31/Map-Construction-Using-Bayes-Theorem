%
clear all 
clc
Encoder=load('Encoder.mat');    % Cargamos los enconders
MapReal=load('Mapa.mat');       % Cargamos el Mapa lógico
EI=Encoder.Enc(:,1);            % Encoders rueda izquierda
ED=Encoder.Enc(:,2);            % Encoders rueda derecha
DI=2*pi*5.*EI/100;              % rueda izquierda             
DD=2*pi*5.*ED/100;              % rueda derecha
DT=(DI+DD)/2;                   % centro del eje
ang=(DD-DI)/10;                 % angulo del movimiento
angAcum(1)=0;
angAcum(2)=ang(1,1);
Mapa=0.5*ones(size(MapReal.M));
grados = 360;
Permanecer = true;
ocultarMapa = true;
while(Permanecer)
option = menu('Elija una opción: ','Solamente el Robot','Robot Sensor Estático','Robot y Mapa Sensor Estático 30°','Robot Sensor 360°','Robot y Mapa Sensor 360°','Mapa Completo','Salir');
    switch option
        case 1
            posX=200;
            posY=100;
            Mapa=0.5*ones(size(MapReal.M));
            for i=2:40
                angAcum(i)=ang(i-1)+angAcum(i-1);               % angulo acumulado
                posX(i)=DT(i-1)*cos(angAcum(i-1))+posX(i-1);    % trigonometria X
                posY(i)=DT(i-1)*sin(angAcum(i-1))+posY(i-1);    % trigonometria Y
                figure(1);hold;
                image(300*Mapa);
                ax = gca;
                ax.YDir = 'normal';
                hold on;
                plot(posX,posY,'o-','MarkerFaceColor','red','MarkerEdgeColor','red','MarkerIndices',i)
                pause(.1);
            end
        case 2
            posX=200;
            posY=100;
            Mapa=0.5*ones(size(MapReal.M));
            grados = 30;
            ocultarMapa = true;
            for i=2:40
                angAcum(i)=ang(i-1)+angAcum(i-1);
                posX(i)=DT(i-1)*cos(angAcum(i-1))+posX(i-1);
                posY(i)=DT(i-1)*sin(angAcum(i-1))+posY(i-1);
                Mapa = ultrasonidos(posX(i),posY(i), angAcum(i), MapReal, Mapa, grados, ocultarMapa);
                MapaTemp=rot90(Mapa);
                temp_map = flip(MapaTemp);
                figure(1);
                image(300*temp_map);
                ax = gca;
                ax.YDir = 'normal';
                hold on;
                plot(posX,posY,'o-','MarkerFaceColor','red','MarkerEdgeColor','red','MarkerIndices',i)
                pause(.1);
            end
        case 3
            posX=200;
            posY=100;
            Mapa=0.5*ones(size(MapReal.M));
            grados = 30;
            ocultarMapa = false;
            for i=2:40
                angAcum(i)=ang(i-1)+angAcum(i-1);
                posX(i)=DT(i-1)*cos(angAcum(i-1))+posX(i-1);
                posY(i)=DT(i-1)*sin(angAcum(i-1))+posY(i-1);
                Mapa = ultrasonidos(posX(i),posY(i), angAcum(i), MapReal, Mapa, grados, ocultarMapa);
                MapaTemp=rot90(Mapa);
                temp_map = flip(MapaTemp);
                figure(1);
                image(300*temp_map);
                ax = gca;
                ax.YDir = 'normal';
                hold on;
                plot(posX,posY,'o-','MarkerFaceColor','red','MarkerEdgeColor','red','MarkerIndices',i)
                pause(.1);
            end
        case 4
            posX=200;
            posY=100;
            Mapa=0.5*ones(size(MapReal.M));
            grados = 360;
            ocultarMapa = true;
            for i=2:40
                angAcum(i)=ang(i-1)+angAcum(i-1);
                posX(i)=DT(i-1)*cos(angAcum(i-1))+posX(i-1);
                posY(i)=DT(i-1)*sin(angAcum(i-1))+posY(i-1);
                Mapa = ultrasonidos(posX(i),posY(i), angAcum(i), MapReal, Mapa, grados, ocultarMapa);
                MapaTemp=rot90(Mapa);
                temp_map = flip(MapaTemp);
                figure(1);
                image(300*temp_map);
                ax = gca;
                ax.YDir = 'normal';
                hold on;
                plot(posX,posY,'o-','MarkerFaceColor','red','MarkerEdgeColor','red','MarkerIndices',i)
                pause(.1);
            end
        case 5
            posX=200;
            posY=100;
            Mapa=0.5*ones(size(MapReal.M));
            grados = 360;
            ocultarMapa = false;
            for i=2:40
                angAcum(i)=ang(i-1)+angAcum(i-1);
                posX(i)=DT(i-1)*cos(angAcum(i-1))+posX(i-1);
                posY(i)=DT(i-1)*sin(angAcum(i-1))+posY(i-1);
                Mapa = ultrasonidos(posX(i),posY(i), angAcum(i), MapReal, Mapa, grados, ocultarMapa);
                MapaTemp=rot90(Mapa);
                temp_map = flip(MapaTemp);
                figure(1);
                image(300*temp_map);
                ax = gca;
                ax.YDir = 'normal';
                hold on;
                plot(posX,posY,'o-','MarkerFaceColor','red','MarkerEdgeColor','red','MarkerIndices',i)
                pause(.1);
            end
        case 6
            Mapa=0.5*ones(size(MapReal.M)); 
            temp_map = flip(MapReal.M);
            figure(1);
            image(300*temp_map);
            ax = gca;
            ax.YDir = 'normal';
            hold on;
        case 7 
            Permanecer = false;
            disp('Bye Bye');
        otherwise
            Permanecer = false;
            disp('Bye Bye');
    end
end

