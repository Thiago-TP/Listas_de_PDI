%%  --------------------------------------------------
%   Código fonte para a questão 1.3 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;

As barras brancas na imagem apresentada na Figura 2 tem 7 pixels de
largura e 210 pixels de altura. 
A separacao entre as barras tem 17 pixels de largura. 
Como ficaria a imagem se fossem aplicados:

(a) Filtros de media aritmetica de tamanho 3x3 e 7x7
%     3x3: parte preta largamente inalterada, contornos cinzas borrados nas
%     barras brancas.
%     
%     7x7: mesmo efeito do kernel anterior, mas como a largura do kernel e
%     igual a da barra, o borrado cinza e bem maior, e apenas a linha
%     no centro da barra continua branca (valor 255).
    
% (b) Filtros de media geometrica de tamanho 3x3 e 7x7
%     3x3: parte preta original permanece a mesma, mas barras brancas
%     diminuem. Isso ocorre porque o filtro zera o resultado
%     caso haja ao menos um pixel preto no kernel. Sendo o filtro 3x3, 
%     apenas os pontos brancos no perimetro foram zerados.
%     
%     7x7: resultado analogo ao anterior, mas como o kernel aqui e maior,
%     remove-se um contorno maior de cada barra (espessura de 3 pixels,
%     para ser mais exato). Das barras originais, restam uma linha vertical
%     com 1 pixel de largura e 204 de altura.
    
% (c) Filtros contra-harmonicos com Q=1 e Q=−1, e com tamanho 3x3 e 7x7
%     Contra-harmonico (Q=1) 3x3: de maneira geral, se houver n>0 pixels
%     brancos no kernel contra-harmonico, o resultado sera n*255^2/n*255 = 
%     255. Caso nao exista nenhum pixel branco, o resultado e 0. Essa
%     filtragem corresponde portanto exatamente a uma dilatacao com
%     elemento estruturante 3x3 de 1. Dessa maneira, o resultado da 
%     filtragem sera a ampliacao de cada barra em 1 pixel em cada direcao 
%     (irao de 210x7 para 212x9). 
    
%     Contra-harmonico (Q=1) 7x7: a logica aqui e a mesma do caso 3x3. A
%     diferenca no resultado e que a expansao/dilatacao sera de 3 pixels em
%     cada direcao, uma vez que o kernel/elemento estruturante e maior
%     (barras irao de 210x7 para 216x13).
    
%     Harmonico (Q=-1) 3x3: para Q=-1, o filtro contra-harmonico e
%     equivalente ao harmonico, cujo resultado por subarea e a media
%     harmonica dos pixels naquela regiao. Essa media e equivalente a
%     dividir o produto dos valores de brilho pela soma desses mesmos
%     valores. Logo, se existe ao menos 1 pixel preto o resultado sera 0
%     (no caso especial em que todos os pixels sao nulos o resultado tambem
%     e tomado como 0). Assim, o resultado sera 255 se e so se todos os
%     pixels da subarea sao brancos. Em suma, esta filtragem e exatamente
%     uma erosao com elemento estruturante 3x3 de 1, e o resultado sera a
%     reformatacao das barras brancas de 210x7 para 208x5.
%     
%     Harmonico (Q=-1) 7x7: mesma logica do item anterior, mas uma erosao
%     ligeiramente maior dado o maior tamanho do kernel: as barras irao de
%     210x7 para 204x1.
    
% (d) Filtros de mediana de tamanho 3x3 e 7x7
%     3x3: apenas as quinas de cada barra mudaram, isto e, foram zeradas.
%     Em qualquer ponto da parte escura da imagem original o resultado
%     local da mediana daria resultado nulo, uma vez que pelo menos 6 dos
%     pixels no kernel seriam 0. Pela mesma logica, isso acontece no
%     linterior o limites das barras exceto nas quinas, onde apenas 4 dos 9
%     pixels do kernel seriam brancos, resultando em preto.
%     
%     7x7: efeito similar ao caso 3x3, mas alem das quinas outros vizinhos
%     brancos tambem sao removidos. Sendo o kernel 7x7, os vizinhos 
%     removidos sao aqueles duas posicoes a esquerda/direita, ou abaixo/
%     acima, a depender da quina analisada.


%% Validacao
clc; close all; clear all;

% Imagem de teste
fig = makefig();
figure, imshow(fig, []);
title("Imagem original");

% (a) Filtros de media aritmetica de tamanho 3x3 e 7x7
fig_average_3x3 = imfilter(fig, ones(3)/(3*3));
fig_average_7x7 = imfilter(fig, ones(7)/(7*7));

figure, montage(cat(3, fig_average_3x3, fig_average_7x7));
title("Imagem filtrada por media aritmetica: 3x3 (esquerda) e 7x7 (direita)");


% (b) Filtros de media geometrica de tamanho 3x3 e 7x7
fig_geometric_3x3 = geometric_filter(fig, 3);
fig_geometric_7x7 = geometric_filter(fig, 7);
figure, montage(cat(3, fig_geometric_3x3, fig_geometric_7x7));
title("Imagem filtrada por media geometrica: 3x3 (esquerda) e 7x7 (direita)");


% (c) Filtros contra-harmonicos com Q=1 e Q=−1, e com tamanho 3x3 e 7x7
fig_contraharmonic_3x3 = contraharmonic_filter(fig, 1, 3);
fig_contraharmonic_7x7 = contraharmonic_filter(fig, 1, 7);
figure, montage(cat(3, fig_contraharmonic_3x3, fig_contraharmonic_7x7));
title("Imagem filtrada por contra-harmonico: 3x3 (esquerda) e 7x7 (direita)");

fig_harmonic_3x3 = contraharmonic_filter(fig, -1, 3);
fig_harmonic_7x7 = contraharmonic_filter(fig, -1, 7);

figure, montage(cat(3, fig_harmonic_3x3, fig_harmonic_7x7));
title("Imagem filtrada por harmonico: 3x3 (esquerda) e 7x7 (direita)");


% (d) Filtros de mediana de tamanho 3x3 e 7x7
% https://www.mathworks.com/help/images/ref/medfilt2.html
fig_median_3x3 = medfilt2(fig, [3 3]);
fig_median_7x7 = medfilt2(fig, [7 7]);

figure, montage(cat(3, fig_median_3x3, fig_median_7x7));
title("Imagem filtrada por mediana: 3x3 (esquerda) e 7x7 (direita)");


%% Funcoes
function out = makefig()

    black_bar = zeros(210, 17);
    white_bar = 255 * ones(210, 7);
    
    out = cat(2, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar, white_bar, ...
              black_bar);
          
    [~, width, ~] = size(out);
    horizontal_padding = zeros(17, width);
    out = uint8(cat(1, ...
                    horizontal_padding, ...
                    out, ...
                    horizontal_padding)); 

end

function out = geometric_filter(im, kernel_len)
    
    % Percorrendo a imagem de entrada 
    [im_height, im_width, ~] = size(im);    
    
    pad = (kernel_len - 1)/2; 
    padded_height = im_height + 2*pad;
    padded_width = im_width + 2*pad;
    
    padded_im = zeros(padded_height, padded_width);
    padded_im(pad+1:end-pad, pad+1:end-pad) = im;
    
    out = zeros(padded_height, padded_width);    
    
    for i = 1 : (padded_height - kernel_len) +1
        for j = 1 : (padded_width - kernel_len) +1
            im_sample = padded_im(i:i+kernel_len-1, j:j+kernel_len-1);
            
            % https://www.mathworks.com/help/stats/geomean.html
            out(i +pad, j +pad) = geomean(im_sample, 'all');
            
        end
    end
    
    out = uint8(out(pad+1:end-pad, pad+1:end-pad));
end

function out = contraharmonic_filter(im, Q, kernel_len)
    
    % Percorrendo a imagem de entrada 
    [im_height, im_width, ~] = size(im);    
    
    pad = (kernel_len - 1)/2; 
    padded_height = im_height + 2*pad;
    padded_width = im_width + 2*pad;
    
    padded_im = zeros(padded_height, padded_width);
    padded_im(pad+1:end-pad, pad+1:end-pad) = im;
    
    out = zeros(padded_height, padded_width);    
    
    for i = 1 : (padded_height - kernel_len) +1
        for j = 1 : (padded_width - kernel_len) +1
            im_sample = padded_im(i:i+kernel_len-1, j:j+kernel_len-1);
            
            numerator = sum(im_sample.^(Q+1), 'all');
            denominator = sum(im_sample.^Q, 'all');
            
            out(i +pad, j +pad) = numerator/denominator;
        end
    end
    
    out = uint8(out(pad+1:end-pad, pad+1:end-pad));
end

