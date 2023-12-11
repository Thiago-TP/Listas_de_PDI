%%  --------------------------------------------------
%   Código fonte para a questão 2.3 da lista 1 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 23/10/2023
%   --------------------------------------------------
clc; close all; clear all;


%% 2.3 -- https://www.mathworks.com/help/images/ref/imnoise.html
% 'lena1.tif' é cinza, 'lena3.tif' tem cor
clc; close all; clear all;

    % Imagem original
    lena_grayscale = imread('source_files/lena1.tif'); 
    
    % 10% de ruído salt and pepper
    lena_grayscale_noise = imnoise(lena_grayscale, 'salt & pepper', 0.1);
    
    % Filtragem sigma espacial para diferentes valores de k
        L=7; % filtro é 7x7

        k=1.0; % 68.3 porcento  
        lena_filtered_k1 = imsigmafilter(lena_grayscale_noise, k, L);

        k=2.0; % 95.5 porcento  
        lena_filtered_k2 = imsigmafilter(lena_grayscale_noise, k, L);
        
        k=3.0; % 99.7 porcento  
        lena_filtered_k3 = imsigmafilter(lena_grayscale_noise, k, L);
        
    % Filtragem com média móvel (moving average, ma)
    kernel_ma = ones(7)/49; % matriz 7x7 de 1/49
    lena_filtered_ma = imfilter(lena_grayscale, kernel_ma);
    
    % Comparação de resultados
    figure, montage([lena_grayscale_noise, ...
                     lena_filtered_ma, ...
                     lena_filtered_k1, ...
                     lena_filtered_k2, ...
                     lena_filtered_k3]);
    exportgraphics(gca,'results/results_2-3.png', 'Resolution', 300)

function filtered_image = imsigmafilter(matrix_2d, k, L)
    [height, width] = size(matrix_2d);
    filtered_image = uint8(zeros(height, width));
    half_L = (L-1)/2;
    offset = half_L + 1; % matlab começa contagem em 1
    % (i, j) = centro do filtro
    for i=offset:height-offset
        for j=offset:width-offset
            sample_LxL = matrix_2d(i-half_L:i+half_L, j-half_L:j+half_L);
            filtered_image(i, j) = filter_sample(sample_LxL, k);
        end
    end    
end

function filtered_value = filter_sample(sample_matrix, k)
    aux_vector = double(sample_matrix(:)); % vetor é mais fácil de lidar
    average = mean(aux_vector); % https://www.mathworks.com/help/matlab/ref/mean.html
    sigma = std(aux_vector);    % https://www.mathworks.com/help/matlab/ref/std.html
    
    [height, width] = size(sample_matrix);
    sum=0;
    counter=0;
    for i=1:height
        for j=1:width
            gray = double(sample_matrix(i, j));
            if average - k*sigma < gray && gray < average + k*sigma
                sum = sum + gray;
                counter = counter + 1;
            end
        end
    end
    
    if counter == 0
       filtered_value = uint8(0);
    else
        filtered_value = uint8(sum/counter);
    end
end

