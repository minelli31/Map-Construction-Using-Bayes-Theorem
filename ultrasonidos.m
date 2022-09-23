function [Mapa] = ultrasonidos(posX,posY, angAcum, MapReal, Mapa, grados, ocultarMapa)
    MapReal.M = rot90(MapReal.M,3);
    vec_X = round(posX);   %posicion X del robot
    vec_Y = round(posY);   %posicion X del robot      
    angU = angAcum; 
    epsilon = 10;
    i = -0.261799;   %Aprox -15 grados
    angU = angU + i;
    if(ocultarMapa)
        Mapa=0.5*ones(size(MapReal.M));
    end
	for k=1:grados
        obstaculo = false;
        rayoU = 1; 
        m = 0;
        for k=1:80
            vec_UX(k) = round(cos(angU)*rayoU);
            vec_UY(k) = round(sin(angU)*rayoU);
            X = vec_X+vec_UX(k); 
            Y = vec_Y+vec_UY(k);
            if(MapReal.M(X,Y)== 1 & ~obstaculo)
                prob = 0.5+0.5/3;
                proBayes = (prob*Mapa(X,Y))/((prob*Mapa(X,Y))+(1-prob)*(1-Mapa(X,Y)));
                while(m <= epsilon)
                    vec_UX(k+m) = round(cos(angU)*rayoU);
                    vec_UY(k+m) = round(sin(angU)*rayoU);
                    X = vec_X+vec_UX(k+m); 
                    Y = vec_Y+vec_UY(k+m);
                    Mapa(X,Y)= proBayes;
                    m = m + 1;
                    rayoU = rayoU + 1;
                end
                obstaculo = true;
            elseif(MapReal.M(X,Y)== 0 & ~obstaculo)
                prob = 0.1; 
                proBayes = (prob*Mapa(X,Y))/((prob*Mapa(X,Y))+(1-prob)*(1-Mapa(X,Y)));
                Mapa(X,Y)= proBayes;
            end
            rayoU = rayoU + 1;
        end
        angU = angU + 0.0174533; %Aprox 1 grado
	end   
end