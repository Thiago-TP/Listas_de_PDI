%%  --------------------------------------------------
%   Código fonte para a questão 2.1 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;

% Desenvolva um algoritmo em Matlab/Octave que realize o watermarking
% a partir de uma imagem que sera marcada (f) e uma marca da agua (ω).
% Para tanto, utilize a expressao:
% fω = (1 − α)· f + α · ω
% onde fω e a imagem watermarked e α e uma constante que controla a 
% visibilidade relativa da marca da agua na imagem. 
% Realize os testes com as imagens que preferir.


%% Teste com primeiro par de imagens (f1 e w1)
clc; close all; clear all;

    f1 = imread('Lista2_resultados/q2.1_f1.jpg');
    w1 = imread('Lista2_resultados/q2.1_w1.jpg');

    alpha = 0.2;
    fw1 = (1 - alpha)*f1 + alpha*w1;
    
    figure, imshow(fw1, []);
    exportgraphics(gca, 'Lista2_resultados/q2.1_fw1.png', 'Resolution', 300)


%% Teste com segundo par de imagens (f2 e w2)
clc; close all; clear all;

    f2 = imread('Lista2_resultados/q2.1_f2.jpg');
    w2 = imread('Lista2_resultados/q2.1_w2.jpg');
    
    alpha = 0.1;
    fw2 = (1 - alpha)*f2 + alpha*w2;
    
    figure, imshow(fw2, []);
    exportgraphics(gca, 'Lista2_resultados/q2.1_fw2.png', 'Resolution', 300)
    
