# PFL_TP1_GX_NN

## Configuração e/ou Instalção

README que deverá ainda incluir os passos necessário para configurar e/ou instalar as componentes necessárias (em Windows e Linux).

### Windows

> Aqui

### Linux

> Aqui

---

## Explicação de funções

Por cada ficheiro de código-fonte é apresentado, por função, uma explicação sucinta do seu funcionamento e uma descrição de vários casos de teste.

Em específico, para as funções da alínea 2 também são exploradas as estratégias utilizadas na sua implementação.

<br>

### Fib.hs


<br>

### BigNumber.hs

#### `zip0`
**Funcionamento:** Os elementos de duas listas são emparelhados, formando pares, e quando uma delas termina a outra continua a ser emparelhada com o *Int* 0 até não ter mais elementos.

| **Casos de teste:** | |
| -- | -- |
| Emparelhamento de listas vazias | zip0 [] [] = [] |
| Emparelhamento de listas de igual tamanho | zip0 [1,2,3] [3,2,1] = [(1,3),(2,2),(3,1)] |
| Emparelhamento de listas de diferente tamanho | zip0 [1,2] [3] = [(1,3),(2,0)]; zip0 [3] [1,2] = [(3,1),(0,2)] |


#### `cleanLeft0s`
**Funcionamento:** Dada uma lista de *Int*, são eliminados desta os primeiros elementos que forem o *Int* 0. É assegurado que fica pelo menos um elemento na lista devido à concatenação do *last l*, ou seja, o último elemento da lista permanece independentemente do seu valor.

| **Casos de teste:** | |
| -- | -- |
| Lista com apenas 0's | cleanLeft0s [0] = [0]; cleanLeft0s [0,0,0] = 0 |
| Lista sem zeros à esquerda | cleanLeft0s [1] = [1]; cleanLeft0s [1,0,0] = [1,0,0]|
| Lista com zeros à esquerda | cleanLeft0s [0,1] = [1]; cleanLeft0s [0,0,1,0] = [1,0]|


#### `bnList`
**Funcionamento:** Retorna a lista de dígitos de um BigNumber, ignorando o seu sinal.

| **Casos de teste:** | |
| -- | -- |
| BigNumber Positivo | (Positive [1,2,3]) = [1,2,3] |
| BigNumber Negativo | (Negative [1,2,3]) = [1,2,3] |


#### `stringToN`
**Funcionamento:** Percorre a lista de *Char* e cria uma lista de *Int* aplicando a função *digitToInt* do módulo *Data.Char*, transformando assim cada dígito da *String* no seu inteiro respetivo e adicionando este à lista de inteiros.

| **Casos de teste:** | |
| -- | -- |
| String vazia | stringToN "" = [] |
| String constituida apenas por digitos | stringToN "123" = [1,2,3] |


#### `scanner`
**Funcionamento/Estratégia:** Inicializa o *BigNumber* tirando partido da lista de *Int* gerada pela função *stringToN* referida anteriormente e limpando os dígitos não significativos pela aplicação da função *cleanLeft0s*. Tem em conta o primeiro caracter da *String* de forma a distinguir o *BigNumber* como positivo (*Positive*) ou negativo (*Negative*). Na ausência desse caracter de sinal é assumido que o número representado por essa string é positivo.

| **Casos de teste:** | |
| -- | -- |
| String de um número negativo | scanner "-123" = Negative [1,2,3] |
| String de um número positivo com sinal | scanner "+123" = Positive [1,2,3] |
| String de um número positivo sem sinal | scanner "123" = Positive [1,2,3] |
| String de um número positivo com zeros à esquerda | scanner "0123" = [1,2,3] |

*Nota:* assumimos que a string recebida como argumento é válida e não tem mais nada para além do sinal seguido de digitos.

#### `nToString`

**Funcionamento:** Percorre uma lista de *Int* adicionando ao resultado a representação em string de cada um dos elementos pela ordem em que se encontram na lista, sem descartar nenhum. Para obter a string de um *Int* é aplicada a função *show*.

| **Casos de teste:** | |
| -- | -- |
| Lista vazia |  nToString [] = "" |
| Lista composta por digitos | nToString [0,1,2,3] = "0123" |


#### `output`
**Funcionamento/Estratégia:** Converte um BigNumber em string, na qual o primeiro caracter representa o sinal ('+' ou '-') seguida pelos digitos que constituem o número representado pelo BigNumber, descartando possiveis 0's que possam existir à esquerda do valor de um número, com auxilio das funções *nToString* e *cleanLeft0s*.

| **Casos de teste:** | |
| -- | -- |
| BigNumber Negativo | output (Negative [2,3]) = "-23" |
| BigNumber Positivo | output (Positive [2,3]) = "+23" |
| BigNumber Positivo com zeros à esquerda | output (Positive [0,2,0]) = "+20" |


#### `sumDigits`
**Funcionamento:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `somaBN`
**Funcionamento:**

**Estratégia:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `subDigits`
**Funcionamento:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `subBN`
**Funcionamento:**

**Estratégia:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `mulDigit`
**Funcionamento:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `mulParcelas`
**Funcionamento:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `mulNs`
**Funcionamento:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `mulBN`
**Funcionamento:** Aplica as propriedades da multiplicação no que toca aos sinais, fazendo corresponder o sinal correto à multiplicação obtida que foi gerada independentemente dos sinais dos argumetos.

**Estratégia:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `sucBN`
**Funcionamento:** Produz uma lista infinita de *BigNumber*, cujo primeiro elemento é o argumento *i* e os seguintes são o resultado de, recursivamente, somar 1 unidade ao elemento anterior na lista.

| **Casos de teste:** | |
| -- | -- |
| | |



#### `divBN`
**Funcionamento:** Começa por produzir uma lista de pares *(q, dq)* em que *dq* corresponde a múltiplos do divisor e *q* correesponde ao multiplicador que dá origem a *dq* (ou seja, *divisor \* q = dq*). Desta lista infinita de pares ordenada, vai se buscar só os elementos cujo *dq* é menor que o *dividendo* da divisão. Daí retira-se o *q* e o *dq* do último elemento da lista que correspondem, respetivamente, ao *quociente* e ao valor pelo qual a subtração do *dividendo* por ele resulta no *resto*.

**Estratégia:**

| **Casos de teste:** | |
| -- | -- |
| | |



#### `safeDivBN`
**Funcionamento:**

**Estratégia:**

| **Casos de teste:** | |
| -- | -- |
| | |



---

## Resposta à alínea 4

> Comparação das resoluções das alíneas 1 e 3 com tipos (Int -> Int), (Integer -> Integer) e (BigNumber -> BigNumber), explorando a sua aplicação a números grandes e verificando qual o maior número que cada uma aceita como argumento.

### (Int -> Int)

O tipo *Int* é um tipo de precisão fixa. Permite representar inteiros de 64 bits, pelo que o maior número possível de ser representado corresponde a *2^63 - 1 = 9 223 372 036 854 775 807*. Tal informação foi também verificada pelo recurso à função **maxBound**:

![Limites_Int](imgs/bound_int.png)

Testando assim uma versão das alíneas da pergunta 1, mas restringindo o tipo ao pretendido, obtivemos os seguintes resultados:

| Argumento (n)| Resultado Esperado | Resultado Obtido |
| :--: | --: | --: |
| 90 | 2 880 067 194 370 816 120 | 2 880 067 194 370 816 120 |
| 91 | 4 660 046 610 375 530 309 | 4 660 046 610 375 530 309 |
| 92 | 7 540 113 804 746 346 429 | 7 540 113 804 746 346 429 |
| 93 | 12 200 160 415 121 876 738 | -6 246 583 658 587 674 878 |

Concluimos, que o maior número que aceita como argumento é 92, último cujo valor na sequencia é menor ao limite de *INT*.


### (Integer -> Integer)

O tipo *Integer* é um tipo de precisão arbitrária, isto significa que consegue representar qualquer número independentemente do seu tamanho, o desde que haja memória suficiente. O limite de representação é assim tão maior quanto a memória que existe disponível. O que se traduz na inexistência de *overflows*, no entanto, as operações aritméticas tornam-se relativamente lentas. Normalmente, é um tipo de dados usado quando se considera que um *overflow* com *Int* poderá acontecer, compromentendo a eficiência.

![Limites_Integer](imgs/bound_integer.png)

Listagem de algumas chamadas realizadas à função, para teste:
- fibListaInfinita 95
- fibListaInfinita 1000
- fibListaInfinita 930000

Após estes testes, onde os valores na sequencia que correspondem a estes índices são número extramamente grandes, concluímos que podemos não conseguimos apresentar o maior número que aceita como argumento, uma vez que tal está diretamente relacionado com a memória disponível.


### (BigNumber -> BigNumber)

O tipo *BigNumber* é um tipo que representa um número pela lista dos seus digitos. Por isso, não existe um limite de representação tão rigido como explorado nos pontos acima. Apesar de também acabar por estar limitado pela memória disponível, por se tratar de uma lista os seus diferentes elementos, tendo em conta a forma como o *Haskell* a organiza, não necessitam de estar consecutivos em memória, tornando a sua alocação mais eficiente. Por outro lado, podemos também realçar que na definição deste tipo de dados nenhuma operação aritmética inerente ao cálculo da sequência de fibonacci gera *overfow*, já que estas apenas são feitas entre dígitos e/ou inteiros muito pequenos. Para além, de que o *Haskell* é uma linguagem muito eficiente no que diz respeito à manipulação de listas.

Este assim é o tipo ideal a usar quando pretendemos representar números relativamente grandes.

Listagem de algumas chamadas realizadas à função, para teste:
- fibListaInfinitaBN 95
- fibListaInfinitaBN 1000
- fibListaInfinitaBN 93000

Tal como no ponto anterior, não é possível precisar o maior número que consegue receber como argumento.


### Diferentes Abordagens e os Tipos

A complexidade temporal e espacial das 3 formas de implementação da sequência de fibonacci também influencia de igual forma o limite máximo do número a representar,independentemente do tipo de dados a manipular.
1. As funções menos eficientes são as de abordagem recursiva exigentes a nível, tanto de espaço como de tempo.
2. No intermédio, estão as funções de abordagem de programação dinâmica muito exigentes a nivel de espaço o que compromete e influencia o espaço na memória disponível para a representação de cada um dos elementos da lista auxiliar. (fibListaBN 930000 => ocupação de memória de 97% no limite)
3. As funções de abordagem de lista infinita são as mais eficientes, tanto a nível de espaço e tempo, permitindo assim reservar mais espaço para os números a representar, recebidos tanto como argumento como aqueles computacionados.
