%%  --------------------------------------------------
%   Código fonte para a questão 1.5 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 26/11/2023
%   --------------------------------------------------
clc; close all; clear all;


% (a) 
% Quantos niveis de cinza existem no sistema de cores RGB, 
% tendo em conta que uma imagem tem 8 bits?
    Uma imagem de 8 bits pode ter no máximo 2^8 = 256 niveis de cinza,
    indo do preto (0x00) ao branco (0xFF).
   
    
% (b)
% Em uma imagem RGB, os componentes R, G e B tem um perfil horizontal de
% intensidades, como apresentado no diagrama da Figura 3.

% Qual e a cor da coluna do meio desta imagem? 
%     Assume-se que a imagem tenha largura N, de forma que os perfis se
%     refiram a N colunas, indexadas de 0 a N-1, da esquerda para a direita.
%     Ademais, entende-se que a cor de dois pixeis numa mesma coluna são idênticas.
%     Sob essas hipóteses, a coluna do meio, de índice N/2, terá RGB igual
%     a [0.5, 1, 0.5] * 255 = [127, 255, 127], que corresponde a um verde
%     claro pálido.
    
% Qual e a cor dos limites da imagem?
%     Ainda sob as mesmas hipóteses da resposta anterior, entende-se como
%     "limites da imagem" as colunas de indice 0 e N-1. Nesse caso, tem-se
%     que a cor no índice 0 é [1, 0, 0] * 255 = [255, 0, 0], vermelho puro.
%     Por outro lado, a cor no índice N-1 é [0, 0, 1] * 255 = [0, 0, 255],
%     azul puro. 
% ---

% O código a seguir gera figura NxN com perfil de cor igual ao da figura 3,
% validando as respostas dadas.
    % definição do tamanho
    N     = 256;                        % valor facilita as contas
    
    % definição dos perfis
    red   = N-1:-1:0;                   % reta decrescente
    green = cat(2, 0:2:N-1, N-2:-2:0);  % reta crescente/decrescente
    blue  = 0:N-1;                      % reta crescente
    
    % imagem com perfil dado
    im = uint8(cat(3, ...
                   ones(N) .* red, ...
                   ones(N) .* green, ...
                   ones(N) .* blue));    
    figure, imshow(im, []);
    exportgraphics(gca, 'Lista2_resultados/q1.5_perfil.png', 'Resolution', 300);
    
    