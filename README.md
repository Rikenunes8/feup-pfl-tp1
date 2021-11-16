# PFL_TP1_GX_NN

## Configuração e/ou Instalção

README que deverá ainda incluir os passos necessário para configurar e/ou instalar as componentes necessárias (em Windows e Linux).

### Windows

> Aqui

### Linux 

> Aqui

---

## Explicação de funções

### Fib.hs

### BigNumber.hs

- `zip0`: Os elementos de duas listas são emparelhados, formando pares, e quando uma delas termina a outra continua a ser emparelhada com o *Int* 0 até não ter mais elementos.
- `cleanLeft0s`: Dada uma lista de *Int*, são eliminados da mesma os primeiros elementos que forem o *Int* 0. É assegurado que fica pelo menos um elemento na lista devido à concatenação do *last l*, ou seja, o último elemento da lista permanece idependentemente do seu valor.
- `bnList`: Converte um BigNumber para uma lista de inteiros, ignorando assim o sinal do número.
- `stringToN`: Percorre a lista de *Char* e cria uma lista de *Int* aplicando a função *digitToInt* do módulo *Data.Char*.
- `scanner`: Inicializa o *BigNumber* tirando partido da lista de *Int* gerada pela função *stringToN* referida anteriormente e limpando os dígitos não significantes pela aplicação da função *cleanLeft0s*. Tem em conta o primeiro caracter da *String* de forma a inicializar o *BigNumber* como positivo (*Positive*) ou negativo (*Negative*).
- `nToString`:
- `output`:
- `sumDigits`:
- `somaBN`:
- `subDigits`:
- `subBN`:
- `mulDigit`:
- `mulParcelas`:
- `mulNs`:
- `mulBN`: Aplica as propriedades da multiplicação no que toca aos sinais, fazendo corresponder o sinal correto à multiplicação obtida que foi gerada independentemente dos sinais dos argumetos.
- `sucBN`: Produz uma lista infinita de *BigNumber*, cujo primeiro elemento é o argumento *i* e os seguintes são o resultado de, recursivamente, somar 1 unidade ao elemento anterior na lista.
- `divBN`: Começa por produzir uma lista de pares *(q, dq)* em que *dq* corresponde a múltiplos do divisor e *q* correesponde ao multiplicador que dá origem a *dq* (ou seja, *divisor \* q = dq*). Desta lista infinita de pares ordenada, vai se buscar só os elementos cujo *dq* é menor que o *dividendo* da divisão. Daí retira-se o *q* e o *dq* do último elemento da lista que correspondem, respetivamente, ao *quociente* e ao valor pelo qual a subtração do *dividendo* por ele resulta no *resto*.
- `safeDivBN`:

O ficheiro README.pdf deverá conter:
- a descrição de vários casos de teste para todas as funções;
- uma explicação sucinta do funcionamento de cada função;
- as estratégias utilizadas na implementação das funções da alínea 2;
MÁRIO FLORIDO, DANIEL CASTRO SILVA, JOÃO FERNANDES, GONÇALO LEÃO 8/11/2021 | PÁG. 2 / 3
- a resposta à alínea 4.
