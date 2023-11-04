%%  --------------------------------------------------
%   Código fonte para a questão 2.2 da lista 1 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 23/10/2023
%   --------------------------------------------------
clc; close all; clear all;


%% 2.2(a) -- replicação: teste da função de ampliação por n > 0 inteiro
clc; close all; clear all;

    % figura teste: Lena grayscale
    fig = imread('source_files/lena1.tif');

    n=3;
    amp_fig = nearest_neighbor_amplify(fig, n);
    figure, imshow(fig, []);
    figure, imshow(amp_fig, []);
    
    % É fácil observar os "dentes de serra" caraterísticos do vizinho mais
    % próximo, efeito que aumenta conforme n cresce.
    

%% 2.2(b) -- replicação: teste da função de redução por potências de 2
clc; close all; clear all;

    % figura teste: Lena grayscale
    fig = imread('source_files/lena1.tif');

    % Divisões
    fig_div02 = reduce(fig, 2);
    fig_div04 = reduce(fig, 4);    
    fig_div08 = reduce(fig, 8);    
    fig_div16 = reduce(fig, 16);  
    
    % Restaura divisões
    fig_div02_mul02 = nearest_neighbor_amplify(fig_div02, 2);
    fig_div04_mul04 = nearest_neighbor_amplify(fig_div04, 4);
    fig_div08_mul08 = nearest_neighbor_amplify(fig_div08, 8);
    fig_div16_mul16 = nearest_neighbor_amplify(fig_div16, 16);
    
    % Resultados das restaurações
    figure, montage([fig, ...
                     fig_div02_mul02, ...
                     fig_div04_mul04, ...
                     fig_div08_mul08, ...
                     fig_div16_mul16, ...    
    ]);
    exportgraphics(gca,'results/restaurations_neighbor.png', 'Resolution', 300)
    

%% 2.2(c)
clc; close all; clear all;
    % figura teste: Lena grayscale
    fig = imread('source_files/lena1.tif');

    n=3;
    amp_fig = bilinear_amplify(fig, n);
    figure, imshow(fig, []);
    figure, imshow(amp_fig, []);
    
    % Divisões
    fig_div02 = reduce(fig, 2);
    fig_div04 = reduce(fig, 4);    
    fig_div08 = reduce(fig, 8);    
    fig_div16 = reduce(fig, 16);   
    
    % Restaura divisões
    fig_div02_mul02 = bilinear_amplify(fig_div02, 2);
    fig_div04_mul04 = bilinear_amplify(fig_div04, 4);
    fig_div08_mul08 = bilinear_amplify(fig_div08, 8);
    fig_div16_mul16 = bilinear_amplify(fig_div16, 16);
    
    % Resultados das restaurações
    figure, montage([fig, ...
                     fig_div02_mul02, ...
                     fig_div04_mul04, ...
                     fig_div08_mul08, ...
                     fig_div16_mul16,]);    
    exportgraphics(gca,'results/restaurations_bilinear.png', 'Resolution', 300)


%% 2.2(d),(e)
clc; close all; clear all;
    lena = imread('source_files/lena1.tif');
    
    % Rotações réplica
    lena_nn15 = nearest_neighbor_rotate(lena, 15);
    lena_nn30 = nearest_neighbor_rotate(lena, 30);
    lena_nn60 = nearest_neighbor_rotate(lena, 60);
    lena_nn90 = nearest_neighbor_rotate(lena, 90);

    % Resultados das rotações réplica
    aux = cat(4, lena, lena_nn15, lena_nn30, lena_nn60, lena_nn90);
    figure, montage(aux, 'Size', [1 5]);
    exportgraphics(gca,'results/rotations_neighbor.png', 'Resolution', 300)
    
    % Rotações bilineares
    lena_b15 = bilinear_rotate(lena, 15);
    lena_b30 = bilinear_rotate(lena, 30);
    lena_b60 = bilinear_rotate(lena, 60);
    lena_b90 = bilinear_rotate(lena, 90);
  
    % Resultados das rotações bilineares      
    aux = cat(4, lena, lena_b15, lena_b30, lena_b60, lena_b90);
    figure, montage(aux, 'Size', [1 5]);
    exportgraphics(gca,'results/rotations_bilinear.png', 'Resolution', 300)
                   

%% funções
function amplified_im = nearest_neighbor_amplify(grayscale, n)
    if n <= 1
        amplified_im = grayscale;
        return
    end
    
    % Inicializa resultado com zeros
    [height, width] = size(grayscale);
    amplified_im = uint8(zeros(n*height, n*width));
    
    % Preenche metade das linhas e colunas com a imagem original    
    amplified_im(1:n:end, 1:n:end) = grayscale(1:end, 1:end);
    for i=2:n
        amplified_im(i:n:end, 1:n:end) = amplified_im(1:n:end-(i-1), 1:n:end);    
    end
    for j=2:n
        amplified_im(:, j:n:end) = amplified_im(:, 1:n:end-(j-1));    
    end 
end


% https://programmer.help/blogs/digital-image-processing-1-interpolation-algorithm-of-image-scaling-function.html
function amplified_im = bilinear_amplify(grayscale, n)
    if n == 1
       amplified_im = grayscale;
       return
    end
    
    [height, width] = size(grayscale);
    im = double(grayscale); 
    
    % Vetorização da linhas e colunas afetadas pela bilinearização
    x_n = 1 : n*height - 1;
    y_n = 1 : n*width - 1;
    
    % Vetores da  bilinearização: índices e coeficientes
    x = x_n*(height - 1)/(n*height - 1) + (n-1)*height/(n*height - 1);
    y = y_n*(width - 1)/(n*width - 1)   + (n-1)*width /(n*width - 1);    
    p = floor(y); q = floor(x);
    a = y - p;    b = x - q;
    
    % Preenchimento parcial da imagem de resultado
    amplified_im = zeros(n*height, n*width);
    amplified_im(y_n, x_n) = ...
        (1 - a)' * (1 - b) .* im(p, q)      + ...
        (1 - a)' * (b)     .* im(p, q + 1)  + ...
        (a)'     * (1 - b) .* im(p+1, q)    + ...
        (a)'     * (b)     .* im(p+1, q+1);
    
    % Preenchimento da última coluna e linha, que ainda estão zerados,
    % com a penúltima coluna e linha, respectivamente.
    amplified_im(:, end) = amplified_im(:, end-1); % coluna
    amplified_im(end, :) = amplified_im(end-1, :); % linha
    
    % Converte para byte
    amplified_im = uint8(amplified_im);
end


function reduced_im = reduce(grayscale, n)
    [height, width] = size(grayscale); 
    reduced_im = uint8(zeros(height/n, width/n));
    reduced_im(1:end, 1:end) = grayscale(1:n:end, 1:n:end);
end


% https://stackoverflow.com/questions/56761216/explanation-of-nearest-neighbor-interpolation-algorithm-for-image-rotation
function rotated_im = nearest_neighbor_rotate(im, theta)
    % Kernel da rotação
    T = [cosd(theta) -sind(theta) 
         sind(theta) cosd(theta)];
     
    % Inicialização de variáveis
    [height, width, channels, ~] = size(im); 
    rotated_im = uint8(zeros(height, width, channels));
    offset_vec = [height width]'/2;
     
    for i = 1:height
        for j = 1:width
            vec_from_upperleft = [j i]';
            vec_from_im_center = vec_from_upperleft - offset_vec;
            result_vec         = (T * vec_from_im_center) + offset_vec;

            % (p, q) = posição de (i, j) rotacionado
            p = floor(result_vec(2)); q = floor(result_vec(1));

            % Vizinho mais próximo com crop
            if p>0 && p<=height && q>0 && q<=width           
                rotated_im(i, j, :) = im(p, q, :);
            end
        end
    end
end


% https://stackoverflow.com/questions/62243117/image-rotation-in-matlab-using-bilinear-interpolation
function rotated_im = bilinear_rotate(im, theta)
    % Kernel da rotação
    T = [cosd(theta) -sind(theta) 
         sind(theta) cosd(theta)];
     
    % Inicialização de variáveis
    [height, width, channels, ~] = size(im); 
    rotated_im = uint8(zeros(height, width, channels));
    offset_vec = [height width]'/2;
     
    for i = 1:height
        for j = 1:width
            vec_from_upperleft = [j i]';
            vec_from_im_center = vec_from_upperleft - offset_vec;
            result_vec         = (T * vec_from_im_center) + offset_vec;

            % (p, q) = posição de (i, j) rotacionado
            p = floor(result_vec(2)); q = floor(result_vec(1));
            % (a, b) = parte fracionária de (p, q)
            a = result_vec(2) - p;    b = result_vec(1) - q;

            % Bilinearização com crop
            if p > 0 && p <= height && q > 0 && q <= width
                rotated_im(i, j, :) = rotated_im(i, j, :) + ...
                (1-a) * (1-b) * im(p, q, :);
            end
            if p > 0 && p <= height && q+1 > 0 && q+1 <= width
                rotated_im(i, j, :) = rotated_im(i, j, :) + ...
                (1-a) * b * im(p, q+1, :);
            end
            if p+1 > 0 && p+1 <= height && q > 0 && q <= width
                rotated_im(i, j, :) = rotated_im(i, j, :) + ...
                a * (1-b) * im(p+1, q, :);
            end
            if p+1 > 0 && p+1 <= height && q+1 > 0 && q+1 <= width
                rotated_im(i, j, :) = rotated_im(i, j, :) + ...
                a * b * im(p+1, q+1, :);
            end
        end
    end
end

