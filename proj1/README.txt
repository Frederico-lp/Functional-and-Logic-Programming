MUDAR PARA PDF

fibRec:
Implementação recursiva pouco eficiente em que para cada termo que não 0 ou 1 é feita uma chamada
recursiva para calcular esse termo. O mesmo termo pode e em principio será calculado varias vezes
Exemplo de teste: fibRec 50

fibLista:
Implementação com lista semelhante ao que acontece em programação dinamica noutros tipos de lingugens.
Cada termo so é calculado uma vez e este fica "guardado" na lista para ser usado no calculo dos tempos seguintes.
Só sao calculados os termos necessarios para o calculo da sequencia de fibonacci.
Exemplo de teste: fibRec 500

fibListaInfinita:
Implementação com lista infinita em que se toma partido do lazy evaluation de Haskell.
Uma lista infinita é gerada que soma (zipWith) os elementos da lista com a cauda dos elementos
da mesma lista criando assim uma lista com os resultados das somas.
Exemplo de teste: fibRec 1000

scanner:
String é passada para Int e de seguida sao feitas sucessivas divisões das quais é guardado o
modulo para guardar no BigNumber. A função tem varias guardas para garantir que também é possivel
ler números negativos.
Exemplo de teste: scanner "1000"
Exemplo de teste: scanner "-1000"

output:
Nesta função é simplesmente feita uma chamada da funçao "show" para todos os elementos do BigNumber
atraves da funçao concatMap
Exemplos de teste:  scanner [-1,0,0,0]
                    scanner [1,9,8,7]

somaBN:
Nesta função é feita uma soma sucessiva dos algarismos menos significativos e se existir overflow
este é passado para o algarismo seguinte. Foi necessário criar varias guardas para os casos de overflow
para não ficarem escritos 0s no BigNumber(ex: somaBN [1,5] [1,0] seria [0,2,5] sem as guardas).
Estas somas sucessivas são conseguidas a partir de chamadas recursivas para aceder aos varios elementos
do BigNumber.
Exemplo de teste:   somaBN [5] [2,7]
                    somaBN [5] [27]
                    somaBN [9,9] [5,5]

subBN:
A função de subtração é algo semelhante à de adição da parte de ser uma subtração sucessiva, ainda
que as operaçoes realizadas entre os algarismos sejam diferentes.

simpleMul:
A função simpleMul recebe dois números inteiros e faz uma multiplicação simples. É chamada na função mulBN com o propósito de
multiplicar dois números presentes em duas listas distintas, cada uma representativa de um BigNumber.

Os casos de teste usados para a função foram os seguintes:
    - simpleMul 2 3, em que o output é 6.
    - simpleMul 12 35, em que o output é 420.
    - simpleMul 342 555, em que o output é 189810.

mulBN:
A função mulBN #explicar a função#

- Os casos teste usados para a função foram os seguintes:
    -
    -
    -

divBN:

fibRecBN:
Semelhante a fibRec com a diferença que a operação de soma entre termos é feita com somaBN devido
aos termos serem BigNumbers.

fibListaBN:
Semelhante a fibLista com a diferença que a operação de soma entre termos é feita com somaBN devido
aos termos serem BigNumbers.

fibListaInfinitaBN:
Semelhante a fibListaInfinita com a diferença que a operação de soma entre termos é feita com somaBN devido
aos termos serem BigNumbers.


O desenvolvimento das funções da alínea 2 (dois) tiveram por base estratégias de #explicar estratégias de desenvolvimento# 



4)?????????????????
Int: [-9223372036854775808, 9223372036854775807]

Integer: ?

BigNumber: O limite de algarismos é o limite maximo de tamanho de listas em Haskell.






