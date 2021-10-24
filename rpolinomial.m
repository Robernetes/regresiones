%REGRESION POLINOMIAL
%x = input('Ingresa la lista de los valores de x: ');
%y = input('Ingrese la lista de los valores de y');
x = [ 0 1 2 3 4 5 ];
y = [ 2.1 7.7 13.6 27.2 40.9 61.1 ];
% x = [ 0.05 0.4 0.8 1.2 1.6 2 2.4 ];
% y = [ 550 750 1000 1400 2000 2700 3750 ];
format bank
m = 2;
n = length(x);

x = x';
y = y';


suma_x = sum(x); %TOTAL DE X
suma_y = sum(y); %TOTAL DE Y

promedio_y = mean(y); %PROMEDIO DE Y

x2 = x.^2;  %COLUMNA DE X^2
x3 = x.^3;  %COLUMNA DE X^3
x4 = x.^4;  %COLUMNA DE X^4
suma_x2 = sum(x2); %TOTAL DE X^2
suma_x3 = sum(x3); %TOTAL DE X^3
suma_x4 = sum(x4); %TOTAL DE X^4

xy = x.*y; %COLUMNA DE XY
suma_xy = sum(xy); %TOTAL DE XY

x2_por_y = (x2.*y); %COLUMNA DE X^2Y
suma_x2_por_y = sum(x2_por_y); %TOTAL DE X^2Y


y_ym_2 = (y-promedio_y).^2; %COLUMNA DE (Y-YM)^2
suma_y_ym_2 = sum(y_ym_2); %TOTAL DE (Y-YM)^2



matriz = [ n suma_x suma_x2; suma_x suma_x2 suma_x3; suma_x2 suma_x3 suma_x4 ]; %MATRIZ

matriz_inv = inv(matriz); %MATRIZ INVERZA

vector = [ suma_y suma_xy suma_x2_por_y ]'; %VECTOR

ok = matriz_inv * vector; %VECTOR RESULTANTE DE PRODUCTO DE MATRIZ INVERSA POR VECTOR

a0 = ok(1); %RESULTADO DE A0
a1 = ok(2); %RESULTADO DE A1
a2 = ok(3); %RESULTADO DE A0

y_a0_a1_por_x_a2_x2_2 = (y-a0-a1.*x-a2.*x2).^2; %COLUMNA DE y_a0_a1_por_x_a2_x2_2 
suma_lastCol = sum(y_a0_a1_por_x_a2_x2_2); % SUMA DE y_a0_a1_por_x_a2_x2_2 

%RESULTADOS
coedet = (suma_y_ym_2-suma_lastCol)/suma_y_ym_2; %COEFICIENTE DE DETERMINACION
errorEst = sqrt(suma_lastCol/(n-(m+1))); %ERROR ESTANDAR
ecuacion = [ 'y = ',num2str(a0),'+','(',num2str(a1),')x+','(',num2str(a2),')x^2' ];  %ECUACION

%GRAFICA
scatter(x,y)
xlabel('x')
ylabel('y')
title('Regresion Polinomial')
hold on
plot(x,y,'b:')

%LINK DE REPOSITORIO
site = '<a href = "https://github.com/Robernetes/regresiones">Repositorio Github</a>';

%TABLAS
totales = table(suma_x, suma_y, suma_x2, suma_x3, suma_x4, suma_xy, suma_x2_por_y,suma_y_ym_2,suma_lastCol,...
    'VariableNames',{'x','y','x^2','x^3','x^4','xy','x^2y','(y-ym)^2','(y-a0-a1x-a2x^2)^2'},'RowNames',{'Totales'});
T = table(x,y,x2,x3,x4,xy,x2_por_y,y_ym_2,y_a0_a1_por_x_a2_x2_2,...
'VariableNames',{'x','y','x^2','x^3','x^4','xy','x^2y','(y-ym)^2','(y-a0-a1x-a2x^2)^2'});

T = [T;totales];
disp(T)

%IMPRESION DE DATOS
format long
disp(ecuacion)
fprintf('Coeficiente de determinacions: %f',coedet)
fprintf('\nError estandar: %f\n',errorEst)
disp(site)










