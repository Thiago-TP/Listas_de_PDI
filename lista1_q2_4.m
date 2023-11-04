%%  --------------------------------------------------
%   Código fonte para a questão 2.4 da lista 1 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 23/10/2023
%   --------------------------------------------------
clc; close all; clear all;


%% 2.4(a),(b)
% a seguir testa-se a função grayscale_halftone
clc; close all; clear all;

    % Criação da imagem de teste
    % -> coluna 1=tudo zero, coluna 2 tudo 1, etc.
    test_image = zeros(256, 1);
    for i=1:255
        test_image = cat(2, test_image, i*ones(256, 1)); 
    end
    clear i; % não há por quê deixar esse índice em memória
    
    test_image_halftoned = grayscale_halftone(test_image);
    figure, imshow(test_image, []);
    figure, imshow(test_image_halftoned, []);


%% 2.4(c)
clc; close all; clear all;
    
    % 2.22 (a) -- Lena
    lena = imread('source_files/Fig0222(a)(face).tif');
    figure, imshow(lena, []);
    exportgraphics(gca,'results/lena_grayscale.png', 'Resolution', 300)
    
    lena_halftoned = grayscale_halftone(lena);
    figure, imshow(lena_halftoned, []);
    exportgraphics(gca,'results/lena_grayscale_halftone.png', 'Resolution', 300)
    
    % 2.22 (b) -- cameraman
    cameraman = imread('source_files/Fig0222(b)(cameraman).tif');
    figure, imshow(cameraman, []);
    exportgraphics(gca,'results/cameraman_grayscale.png', 'Resolution', 300)
    
    cameraman_halftoned = grayscale_halftone(cameraman);
    figure, imshow(cameraman_halftoned, []);
    exportgraphics(gca,'results/cameraman_grayscale_halftone.png', 'Resolution', 300)
    
    % 2.22 (c) -- crowd    
    crowd = imread('source_files/Fig0222(c)(crowd).tif');
    figure, imshow(crowd, []);
    exportgraphics(gca,'results/crowd_grayscale.png', 'Resolution', 300)
    
    crowd_halftoned = grayscale_halftone(crowd);
    figure, imshow(crowd_halftoned, []);
    exportgraphics(gca,'results/crowd_grayscale_halftone.png', 'Resolution', 900)
    
    
function im_halftoned = grayscale_halftone(grayscale)
    grayscale_adjusted = adjust_dimentions(grayscale);
    % explicita lista de 'kernels' do halftoning
    kernel_list = [
        % preto
        [0 0 0
         0 0 0
         0 0 0];
        % cinza1
        [0 255 0
         0 0   0
         0 0   0];
        % cinza2
        [0 255 0
         0 0   0
         0 0   255];
        % cinza3
        [255 255 0
         0   0   0
         0   0   255];
        % cinza4
        [255 255 0
         0   0   0
         255 0   255];
        % cinza5
        [255 255 255
         0   0   0
         255 0   255];
        % cinza6
        [255 255 255
         0   0   255
         255 0   255];
        % cinza7
        [255 255 255
         0   0   255
         255 255 255];
        % cinza8
        [255 255 255
         255 0   255
         255 255 255];
        % branco
        [255 255 255
         255 255 255
         255 255 255];
    ];

    % primeiro é necessário identificar
    % o pixel mais escuro e o mais claro
    darkest = double(min(grayscale_adjusted(:)));
    brightest = double(max(grayscale_adjusted(:)));

    % interpolar 10 valores entre os extremos 
    % fornece os marcadores de halftoning
    halftone_vec = uint8(linspace(darkest, brightest, 10));

    % inicializa matriz do halftone
    [height, width] = size(grayscale_adjusted);
    im_halftoned = uint8(zeros(3*height, 3*width));

    % inicializa índices da matriz resultante
    I=1;
    for i=1:height
        J=1;
        for j=1:width
            pixel=grayscale_adjusted(i, j);
            if pixel <= halftone_vec(1)
                im_halftoned(I:I+2, J:J+2) = kernel_list(1:3, 1:3);

            elseif pixel <= halftone_vec(2)
                im_halftoned(I:I+2, J:J+2) = kernel_list(4:6, 1:3);

            elseif pixel <= halftone_vec(3)
                im_halftoned(I:I+2, J:J+2) = kernel_list(7:9, 1:3);

            elseif pixel <= halftone_vec(4)
                im_halftoned(I:I+2, J:J+2) = kernel_list(10:12, 1:3);

            elseif pixel <= halftone_vec(5)
                im_halftoned(I:I+2, J:J+2) = kernel_list(13:15, 1:3);

            elseif pixel <= halftone_vec(6)
                im_halftoned(I:I+2, J:J+2) = kernel_list(16:18, 1:3);

            elseif pixel <= halftone_vec(7)
                im_halftoned(I:I+2, J:J+2) = kernel_list(19:21, 1:3);

            elseif pixel <= halftone_vec(8)
                im_halftoned(I:I+2, J:J+2) = kernel_list(22:24, 1:3);

            elseif pixel <= halftone_vec(9)
                im_halftoned(I:I+2, J:J+2) = kernel_list(25:27, 1:3);

            elseif pixel <= halftone_vec(10)
                im_halftoned(I:I+2, J:J+2) = kernel_list(28:30, 1:3);
            end
            J = J + 3;
        end
        I = I + 3;
    end
end


function adjusted_im = adjust_dimentions(grayscale)
    max_width_inches = 8.5;
    max_height_inches = 11;
    
    % dpi=300 é bem comum
    dpi=300;
    max_width_pixels = max_width_inches * dpi;
    max_height_pixels = max_height_inches * dpi;
    
    % caso (1) altura e largura ok
    % caso (2) altura e largura grandes demais
    % caso (3) altura grande demais, largura ok
    % caso (4) altura ok, largura grande demais
    [height, width] = size(grayscale);    
    
    % (1)    
    adjusted_im = grayscale;
    
    % (2)
    if height > max_width_pixels && width > max_width_pixels
        adjusted_im = imresize(grayscale, ...
                                   max_width_pixels, ...
                                   max_height_pixels);
    end
    
    % (3)
    if height > max_width_pixels && width <= max_width_pixels
        adjusted_im = imresize(grayscale, ...
                               width, ...
                               max_height_pixels);
    end
    
    % (4)
    if height <= max_width_pixels && width > max_width_pixels
        adjusted_im = imresize(grayscale, ...
                               max_width_pixels, ...
                               height);
    end
end
    
