%%  --------------------------------------------------
%   Código fonte para a questão 2.4 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;


% (b) 
% Baixe a imagem da Figura 4 (Figura 1.10 (4) do livro texto). 
% Usando o algoritmo desenvolvido em (a), processe a imagem de forma a que 
% o rio no centro da imagem apareca amarelo, enquanto o resto da imagem 
% mantem os niveis originais da escala de cinzas. E aceitavel ter um pequeno 
% numero de pixels amarelos isolados na imagem de saıda.
    rio_grayscale = imread('Lista2_imagens/fig_lista4_2.bmp');
    figure, imshow(rio_grayscale, []);
    
    brilho_baixo = 0:40; % intervalo obtido por tentativa e erro
    cor_baixo = 255 * [1, 1, 0]; % amarelo
    
    brilho_alto = 250:255;
    cor_alto  = 255 * [1, 0, 0]; % vermelho
    
    % Como e pedido apenas uma cor no enunciado, o brilho/cor alto nao
    % serao usados, apenas os baixos (visto que o rio e escuro na foto)
    rio_amarelo = pseudocor(rio_grayscale, ...
                            brilho_baixo, ...
                            cor_baixo, ...
                            brilho_baixo, ...
                            cor_baixo);
                        
    figure, imshow(rio_amarelo, []);
    exportgraphics(gca, 'Lista2_resultados/q2.4_pseudocor_rio.png', 'Resolution', 300)
    
    
% (a)
% Implemente um algoritmo de processamento de cor que gere cores falsas (pseudocores). 
% Nesse sistema, deve-se especificar dois intervalos de nıveis de cinza na imagem de entrada. 
% O algoritmo deve gerar uma imagem colorida (RGB) com pixels com uma cor 
% especifica para cada intervalo de niveis de cinza da imagem de entrada.
% Os pixels restantes da imagem de entrada (fora dos dois intervalos) 
% devem manter os nıveis de cinza originais.
function im = pseudocor(grayscale, range1, color1, range2, color2)
    % grayscale: matriz 2D de uint8
    % ranges:    vetor de uint8
    % colors:    tripla RGB, e.g. (37, 255, 0) 
    % im:        matriz 3D de uint8
    
    % Inicializa resultado
    im = cat(3, grayscale, grayscale, grayscale);
    
    % Colore os pontos nos intervalos
    [height, width, ~] = size(grayscale);
    for i=1:height
        for j=1:width
            if ismember(grayscale(i, j), range1)
                im(i, j, :) = color1;
            elseif ismember(grayscale(i, j), range2)
                im(i, j, :) = color2;
            end
        end
    end
end
