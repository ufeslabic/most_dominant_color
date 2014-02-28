most_dominant_color
===================

MatLab script to determine the dominant color in an image

Resumo
====
O principal objetivo do código é encontrar a cor dominante em uma imagem. Dado um conjunto de imagens, o código varre imagem por imagem em busca da cor dominante e salva os resultados em RGB em um arquivo. O código foi escrito em Matlab. Este documento apresenta as principais informações do código.

Funcionalidade do código
====
O código tem a função de encontrar a cor dominante em RGB em uma imagem. Os resultados são salvos em um arquivo nativo para o Matlab.

Descrição do código
======
O código foi desenvolvido para Matlab e ele é constituído de três funções:

most_dominant_color  É a classe principal do código. Ele carrega a lista de imagens contidas no diretório apontado pelo Matlab. As extensões incluídas são: tiff, tif, bmp, jpg, jpeg e png. Ele salva os valores de cor dominante para cada imagem num arquivo MDC.mat (arquivo que pode ser lido pelo Matlab com o comando load MDC). Por segurança, é salvo um arquivo de redundância. Esta função chama a função dominant que realiza a busca da cor dominante.

dominant(figs)  Esta função tem como parâmetro de entrada o nome de uma imagem (figs). A imagem é lida e reduzida para um quarto do tamanho. Este procedimento foi adotado para tornar o processamento mais rápido. A imagem é decomposta nas camadas R, G, B. Existe um tratamento para imagens em nível de cinza. Cada canal é reduzido de 8 bits para 6 bits para diminuir a diversidade de cores. É calculada a distância Euclidiana entre as cores. A cor mais frequente e mais próxima das outras é selecionada. Em seguida são identificadas as cores mais próximas a cor selecionada cuja distância seja menor do que um limiar preestabelecido (3). É realizada uma média ponderada entre essas cores para obter a cor dominante. Essa função retorna a cor dominante da imagem.

color_retrieval(Index,resolut)  Esta função realiza uma recuperação das cores que foram “comprimidas” num passo interno dentro da função dominant. O parâmetro Index é a cor comprimida e resolut é o número de bits que cada canal foi reduzido. A saída dessa função é a cor nos canais R, G e B.

Compilação e Execução
====
O código não é compilado. Para executá-lo é necessário ter o Matlab. Dois caminhos podem ser seguidos para executá-lo:

A forma geral:
Copiar o arquivo do código para a pasta work dentro do diretório do Matlab;
Abrir o Matlab e direcionar o diretório do Matlab para o local onde estão as imagens;
Executar o comando: most_dominant_color.

A forma específica:
Copiar o arquivo do código para a pasta onde estão as imagens;
Abrir o Matlab e direcionar o diretório do Matlab para o local onde estão as imagens;

Executar o comando: most_dominant_color.

A primeira opção é a melhor, pois é aplicável para qualquer pasta com imagens, enquanto na segunda opção é necessário copiar o arquivo para cada pasta de imagens.

Parâmetros de Entrada
=====
Não existe parâmetro de entrada para o algoritmo, mas é necessário direcionar o diretório do Matlab para o diretório das imagens. Para executar é usado o comando most_dominant_color.

Formato de Entrada
====
As entradas são imagens. Os formatos de imagens aceitos são: tiff, tif, bmp, jpg, jpeg e png. Outros formatos de imagens podem ser incluídos dentro da função most_dominant_color.
Formato de Saída

A saída do programa é através de um arquivo chamado MDC.mat. Para abrir este arquivo deve ser usado o Matlab e o comando load MDC no diretório onde se encontra esse arquivo. As principais informações neste arquivo são o nome das imagens e a cor dominante de cada uma delas. A cor dominante é dado em R, G e B e em valor decimal.
Limitações do Código
====
O código foi feito para funcionar para imagens em RGB e possui um tratamento para imagens em nível de cinza. Não é garantido funcionar em imagens salvas em outro espaço de cor.

O código foi feito para funcionar para imagens nos formatos: tiff, tif, bmp, jpg, jpeg e png. Imagens em outros formatos são ignoradas. No entanto, outros formatos podem ser adicionados na função most_dominant_color, desde que não sejam limitadas pela capacidade do Matlab de abrir arquivos. O código foi feito na versão 7 do Matlab. Sem garantia de funcionamento em versões anteriores.

Contato
====
Dúvidas sobre o código podem ser tiradas com Patrick Marques Ciarelli através do e-mail de contato patrick_cstm@hotmail.com.
