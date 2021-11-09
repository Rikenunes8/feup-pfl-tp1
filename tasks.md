# TO DO:

- 1
	- Implementar fibLista
	- Validar fibRec e fibListaInfinita
- 2
	- Definição do tipo BigNumber
	- somaBN (somaBN::BigNumber -> BigNumber -> BigNumber)
	- subBN (subBN::BigNumber -> BigNumber -> BigNumber)
	- mulBN (mulBN::BigNumber -> BigNumber -> BigNumber)
	- divBN (divBNd:: BigNumber -> BigNumber -> (BigNumber, BigNumber))
	- [Para facilitar estas operações, assuma que os dígitos podem estar na lista por ordem inversa, chamando inicialmente uma função de reverse. Exemplo: 123 + 49 = 172 é representado por: [3, 2, 1] + [9, 4] = [2, 7, 1]]
- 3
	- fibRecBN
	- fibListaBN
	- fibListaInfinitaBN
- 4
	- Compare as resoluções das alíneas 1 e 3 com tipos (Int -> Int), (Integer -> Integer) e (BigNumber -> BigNumber), comparando a sua aplicação a números grandes e verificando qual o maior número que cada uma aceita como argumento.
- 5
	- Acrescente ao módulo de big-numbers da alínea 2 a capacidade de detetar divisões por zero em compile-time. Para isso, a função divisão deverá retornar monads do tipo Maybe. A função alternativa para a divisão inteira deverá se chamar safeDivBN e ter o tipo: safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
