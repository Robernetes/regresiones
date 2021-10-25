%REGRESION EXPONENCIAL 

format bank
x = [ 0.05 0.4 0.8 1.2 1.6 2 2.4 ]';
y = [550 750 1000 1400 2000 2700 3750 ]';

n = length(x); %CANTIDAD DE ELEMENTOS

x2 = x.^2; %COLUMNA DE X2
lny = log(y);%COLUMNA DE LNY
xlny = x.*lny; %COLUMNA DE XLNY
p = mean(lny); %PROMEDIO DE LNY
lny_p_2 = (lny-p).^2; %COLUMNA DE (LNY-P)^2


suma_x = sum(x); %TOTAL DE LA COLUMNA DE X
suma_y = sum(y); %TOTAL DE LA COLUMNA DE Y
suma_x2 = sum(x2); %TOTAL DE LA COLUMNA DE X2
suma_lny = sum(lny); %TOTAL DE LA COLUMNA DE LNY
suma_xlny = sum(xlny); %TOTAL DE LA COLUMNA DE XLNY
suma_lny_p_2 = sum(lny_p_2); %TOTAL DE LA COLUMNA DE (LNY-P)^2

matriz = [ n suma_x; suma_x suma_x2 ]; %MATRIZ
matriz_inv = inv(matriz); %MATRIZ INVERSA
vector = [ suma_lny suma_xlny]'; %VECTOR
ok = matriz_inv * vector; %REULTADO DE MULTIPLICAR LA MATRIZ INVERSA POR VECTOR

lna = ok(1); %LNA
b = ok(2); %B

lastcol = (lny-(lna+b.*x)).^2; %COLUMNA DE (lny-(ln a+bx))^2
suma_lastcol = sum(lastcol); %TOTAL DE LA COLUMNA DE (lny-(ln a+bx))^2


a_e = exp(lna); %ALFA
beta_b = b ; %BETA

%TABLAS
totales = table(suma_x, suma_y, suma_x2, suma_lny, suma_xlny, suma_lny_p_2, suma_lastcol,...
    'VariableNames',{'x','y','x^2','lny','xlny','(lny-p)^2','(lny-(ln a+bx))^2'},'RowNames',{'Totales'});

T = table(x,y,x2,lny,xlny,lny_p_2,lastcol,...
'VariableNames',{'x','y','x^2','lny','xlny','(lny-p)^2','(lny-(ln a+bx))^2'});

T = [T;totales]; %TABLA FINAL
disp(T)

%GRAFICA
scatter(x,y)
xlabel('x')
ylabel('y')
title('Regresion Exponencial')
hold on
plot(x,y,'b:')

%RESULTADOS
format long

elna = exp(lna); %EXPONENCIAL DE LNA
r2 = (suma_lny_p_2-suma_lastcol)/suma_lny_p_2; %R2

fprintf('y = %fe^%fx\n',elna,b)
fprintf('r² = %f\n',r2);

