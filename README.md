# Listas de PDI
Minhas respostas às questões das listas de PDI (Processamento Digital de Imagens).\
Aulas ministradas pelo Prof. Dr. Edson Mintsu.\
Identificação do aluno: Thiago Tomás de Paula, 190038641.\
Universidade de Brasília, Brasília, 3 de novembro de 2023.

## Lista 1
Ao todo, a lista 1 é composta por 8 qestões, divididas em duas partes:
a primeira teórica e a segunda prática.
As respostas das questões teóricas, assim como as análises dos resultados práticos são dados a seguir.
De forma complementar, os arquivos .m neste repositório contém a metodologia adotada para chegar aos resultados.

### Parte 1: Teoria
**Questão 1.1:**
_Durante a luz do dia ao entrarmos em um teatro escuro, demora um
intervalo de tempo considerável até conseguirmos ver suficientemente bem para encontrar
um lugar vazio. Qual dos processos visuais explicados no Capítulo 2_
(Gonzalez, Rafael C. e Woods, Richard E., Digital Image Processing, 3º ed, 2008, Addison Wesley)
_está em ação nessa situação?_

Ao contrário da maioria dos animais, a visão humana é voltada para a detecção do gradiente de brilho,
em particular quando o brilho, ou claridade, é relativamente forte.
É graças às contrações e dilatações da íris que o olho humano consegue 
melhor processar uma grande ou pequena recepção de brilho, respectivamente.
Assim, ao entrar num quarto escuro, o tempo necessário para melhorar a visão 
corresponde justamente à dilatação da íris, que ocorre gradualmente. 

---
**Questão 1.2:**
_A subtração de imagens é frequentemente utilizada em aplicações industriais para detectar componentes em falta na montagem de produtos. 
A abordagem consiste em armazenar uma imagem “golden” que corresponde a uma montagem correta;
esta imagem é depois subtraída das imagens recebidas do mesmo produto. Idealmente,
a diferença seria zero se os produtos estivessem montados corretamente. As imagens de
diferença para produtos com componentes em falta seriam diferentes de zero na área em
que diferem da imagem “golden”. Quais condições devem ser cumpridas na prática para
o método funcionar? Em quais situações ele pode falhar?_

Essa comparação é delicada uma vez que, para o bom funcionamento, as figuras devem retratar objetos nas mesmas posições.
Estando nas mesmas posições, os fundos devem ser similares, e o ruído deve ser ser mínimo.
Se essas condições são observadas, o método deve funcionar. Se não, deve falhar.

---
**Questão 1.3:**
_Mostrar que é possível calcular transformadas 2-D com núcleos separáveis
e simétricos_:
1. _Computando as transformadas 1-D ao longo das linhas (colunas) individuais da
entrada, e_
2. _Computar transformadas 1-D ao longo das colunas (linhas) do resultado do passo 1._

Imagina-se a princípio inteegral dupla tal que as linhas são consideradas primeiro, e depois as colunas.
Visto que a integral converge, e sendo o núcleo simétrico, pode-se trocar a ordem de integração.
Agora, a integral interior é a das colunas.
Sendo o núcleo ainda separável, o fator dependente da linha pode ser multiplicado por fora da integral das colunas.
Executando a integração nas colunas, o resultado depende apenas das linhas. 
Finalmente, a integral desse resultado (a transformada das colunas) nas linhas dará a transformada 2D completa.

---
**Questão 1.4:**
1. _Qual efeito o histograma de uma imagem apresentaria (em geral) com escolha de
zero para os bit planes de ordem inferior?_ 

Como os bit planes inferiores tem pouca contribuição no valor da cor (relativa a seu canal),
a zeragem iria reduzir ligeiramente os valores de cor/brilho,
deixando os claros mais próximos dos escuros.
No histograma, isso corresponde a uma concentração da metade direita para esquerda do gráfico, onde os valores dos pixels são menores.

2. _Qual seria o efeito no histograma se, em vez disso, colocássemos como zero os bit
planes de ordem superior?_ 

Ao contrário da situação anterior, a modificação aqui não será sutil: a imagem em geral ficará bem mais escura.
No histograma, ocorrerá um pico denso nos valores de cor/brilho próximos do preto. 

3. _Explique por que razão a técnica de equalização de histograma discreto não produz,
em geral, um histograma plano._ 

De maneira geral, a altura do histograma plano ideal não é inteira, enquanto que os níveis de brilho reais são.

### Parte 2: Prática.
**Questão 2.1:**\
(a, b): em branco.

(c): cabe rodar a primeira seção em `lista1_q2_1.m`.\
A imagem carregada se torna matriz bidimensional de single.
Ao mudar para escala de cinza, 
embora os contornos e volumes principais da imagem se preservem,
na escala de cinza perde-se muita informação nos detalhes coloridos.
Em particular, aponta-se os vitrais. Com isso dito, a figura do atrium 
não parece ter perdido tanta informação quanto o memorial, pelo menos
falando subjetivamente.

(d): cabe rodar a segunda seção em `lista1_q2_1.m`.\
Imagem com gammas diferentes simplesmente saturam demais uma cor.
Não fica bom. Por outro lado, 0<gamma<1 e igual para todos clareia
a imagem, exibindo detalhes, em particular para o memorial (vide telhados).

(e): cabe rodar a terceira seção em `lista1_q2_1.m`.
Para sigma fixo, aumentar n aumenta vertiginosamente o contraste;
para n fixo, aumentar sigma diminui vagarosamente o contraste (escurece)

---
**Questão 2.2:**\
(a): cabe rodar a primeira seção do código `lista1_q2_2.m`.

(b): cabe rodar a segunda seção do código `lista1_q2_2.m`.

(c): cabe rodar a segunda seção do código `lista1_q2_2.m`.\
É fácil ver que as restaurações feitas pelo método bilinear são melhores que as do vizimho mais próximo,
evitando artefatos em troca de algum borramento da imagem.

(d, e): cabe rodar a quarta seção do código `lista1_q2_2.m`.
Aqui ficam bem aparentes, nas bordas e contornos das imagens, a presença dos artefatos "dentes de serra" da réplica.
O bilinear consegue atenuar esse efeito, mas com o custo de introduzir uma leve translação da imagem em relação à réplica.

---
**Questão 2.3:** \
Aqui cabe rodar o código `lista1_q2_3.m`.
A comparação foi feita para k em {1, 2, 3} e a média móvel cujo kernel é 7x7 e homogêneo.
Em suma, quanto maior k, mais se sobrepõe o ruído, uma vez que
o salt and pepper ficam nos extremos da distribuição.
Por outro lado, k pequeno torna a filtragem menos suave,
introduzindo artefatos na image original em troca de atenuação de ruído.
Subjetivamente, a meu ver o resultado com filtro de métida móvel foi o melhor.

---
**Questão 2.4:**\
(a, b): cabe rodar a devida seção em `lista1_q2_4.m`.\
(c): sim, uma vez houve distorção de amostragem e falsos contornos na lena e cameran, mas com menor intensidade em crowd.

---
**Questão 2.5:**\
Não está claro o que a clusterização contribuiria no halftoning. 
O código em `lista1_q2_5.m` simplesmente
realiza o halftoning em cada canal RGB separadamente e junta os resultados numa matriz.
As funções são a mesmas da questão 2.4.
