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

**Casos de teste:**
- Emparelhamento de listas vazias: 
- Emparelhamento de listas de igual tamanho:
- Emparelhamento de listas de diferente tamanho:  


#### `cleanLeft0s`
**Funcionamento:** Dada uma lista de *Int*, são eliminados da mesma os primeiros elementos que forem o *Int* 0. É assegurado que fica pelo menos um elemento na lista devido à concatenação do *last l*, ou seja, o último elemento da lista permanece idependentemente do seu valor.

**Casos de teste:**
-


#### `bnList`
**Funcionamento:** Converte um BigNumber para uma lista de inteiros, ignorando assim o sinal do número.

**Casos de teste:**
-


#### `stringToN`
**Funcionamento:** Percorre a lista de *Char* e cria uma lista de *Int* aplicando a função *digitToInt* do módulo *Data.Char*.

**Casos de teste:**
-


#### `scanner`
**Funcionamento:** Inicializa o *BigNumber* tirando partido da lista de *Int* gerada pela função *stringToN* referida anteriormente e limpando os dígitos não significantes pela aplicação da função *cleanLeft0s*. Tem em conta o primeiro caracter da *String* de forma a inicializar o *BigNumber* como positivo (*Positive*) ou negativo (*Negative*).

**Estratégia:**

**Casos de teste:**
-


#### `nToString`
**Funcionamento:**

**Casos de teste:**
-


#### `output`
**Funcionamento:**

**Estratégia:**

**Casos de teste:**
-


#### `sumDigits`
**Funcionamento:**

**Casos de teste:**
-


#### `somaBN`
**Funcionamento:**

**Estratégia:**

**Casos de teste:**
-


#### `subDigits`
**Funcionamento:**

**Casos de teste:**
-


#### `subBN`
**Funcionamento:**

**Estratégia:**

**Casos de teste:**
-


#### `mulDigit`
**Funcionamento:**

**Casos de teste:**
-


#### `mulParcelas`
**Funcionamento:**

**Casos de teste:**
-


#### `mulNs`
**Funcionamento:**

**Casos de teste:**
-


#### `mulBN`
**Funcionamento:** Aplica as propriedades da multiplicação no que toca aos sinais, fazendo corresponder o sinal correto à multiplicação obtida que foi gerada independentemente dos sinais dos argumetos.

**Estratégia:**

**Casos de teste:**
-


#### `sucBN`
**Funcionamento:** Produz uma lista infinita de *BigNumber*, cujo primeiro elemento é o argumento *i* e os seguintes são o resultado de, recursivamente, somar 1 unidade ao elemento anterior na lista.

**Casos de teste:**
-


#### `divBN`
**Funcionamento:** Começa por produzir uma lista de pares *(q, dq)* em que *dq* corresponde a múltiplos do divisor e *q* correesponde ao multiplicador que dá origem a *dq* (ou seja, *divisor \* q = dq*). Desta lista infinita de pares ordenada, vai se buscar só os elementos cujo *dq* é menor que o *dividendo* da divisão. Daí retira-se o *q* e o *dq* do último elemento da lista que correspondem, respetivamente, ao *quociente* e ao valor pelo qual a subtração do *dividendo* por ele resulta no *resto*.

**Estratégia:**

**Casos de teste:**
-


#### `safeDivBN`
**Funcionamento:**

**Estratégia:**

**Casos de teste:**
-


---

## Resposta à alínea 4



O ficheiro README.pdf deverá conter:
- a descrição de vários casos de teste para todas as funções;
- uma explicação sucinta do funcionamento de cada função;
- as estratégias utilizadas na implementação das funções da alínea 2;
- a resposta à alínea 4.
