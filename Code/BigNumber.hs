module BigNumber (BigNumber) where

import Data.Char (digitToInt)

-- 2.1) a definição do tipo BigNumber
data BigNumber = Positive [Int] 
               | Negative [Int]
               deriving (Eq)

instance Show BigNumber where
    show (Positive digits) = "Positive " ++ show digits
    show (Negative digits) = "Negative " ++ show digits

instance Ord BigNumber where
    (Positive a) <= (Positive b) = length a < length b || ((length a == length b) && (output (Positive a) <= output (Positive b))) 
    (Positive a) < (Positive b) = length a < length b || ((length a == length b) && (output (Positive a) < output (Positive b)))

-------- FUNÇÕES AUXILIARES ---------

-- Gera uma lista de pares de elementos de igual indice, associando com 0 os que não têm correspondencia
zip0 :: [Int] -> [Int] -> [(Int, Int)]
zip0 [] []         = []
zip0 xs []         = [(x, 0) | x <- xs]
zip0 [] ys         = [(0, y) | y <- ys]
zip0 (x:xs) (y:ys) = (x, y) : (zip0 xs ys)

-- Limpa os zeros à esquerda da lista, garantindo que pelo menos existe 1
cleanLeft0s :: [Int] -> [Int]
cleanLeft0s [] = []
cleanLeft0s l  = (dropWhile (== 0) (init l)) ++ [last l]

-- converte um BigNumber para uma lista de inteiros
bnList :: BigNumber -> [Int]
bnList (Positive l) = l
bnList (Negative l) = l

---------------------------------------

-- 2.2) converte uma string em big-number
stringToN :: String -> [Int]
stringToN = foldr (\x y -> digitToInt x : y) []

scanner :: String -> BigNumber
scanner ('-':s) = Negative (stringToN s)
scanner ('+':s) = Positive (stringToN s)
scanner s       = Positive (stringToN s)


-- 2.3) converte um big-number em string
nToString :: [Int] -> String
nToString = foldr (\x y -> show x ++ y) ""

output :: BigNumber -> String
output (Negative bn) = "-" ++ nToString bn
output (Positive bn) = "+" ++ nToString bn


-- 2.4) soma dois big-numbers.
-- TODO:: change name
sumPar :: [(Int, Int)] -> [Int]
sumPar [] = []
sumPar ((a,b):[]) = (a + b) `mod` 10 : let r = (a + b) `div` 10 
                                       in if (r /= 0) then [r] else []
sumPar ((a,b):(c,d):l) = (a + b) `mod` 10 : sumPar ((c, d + ((a + b) `div` 10)) : l)

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN (Negative a) (Negative b) = Negative (cleanLeft0s (reverse (sumPar (zip0 (reverse a) (reverse b)) ) ))
somaBN (Negative a) (Positive b) = subBN (Positive b) (Positive a)
somaBN (Positive a) (Negative b) = subBN (Positive a) (Positive b)
somaBN (Positive a) (Positive b) = Positive (cleanLeft0s (reverse (sumPar (zip0 (reverse a) (reverse b)) ) ))


-- 2.5) subtrai dois big-numbers.
-- TODO:: change name
subPar :: [(Int, Int)] -> [Int]
subPar [] = []
subPar ((a,b):[]) = [(a - b)]
subPar ((a,b):(c,d):l) 
    | a >= b    = (a - b) : subPar ((c, d) : l)
    | otherwise = (a + 10 - b) : subPar ((c, d + 1) : l)


subBN :: BigNumber -> BigNumber -> BigNumber
subBN (Negative a) (Negative b) = subBN  (Positive b) (Positive a)
subBN (Negative a) (Positive b) = somaBN (Negative a) (Negative b)
subBN (Positive a) (Negative b) = somaBN (Positive a) (Positive b)
subBN (Positive a) (Positive b) | Positive a < Positive b = Negative (cleanLeft0s (reverse (subPar (zip0 (reverse b) (reverse a)) ) ))
                                | otherwise               = Positive (cleanLeft0s (reverse (subPar (zip0 (reverse a) (reverse b)) ) ))


-- 2.6) multiplica dois big-numbers.
-- Isto está uma confusão, deve dar para simplificar e eventualmente por mais eficeiente
-- Além disso os nomes estão horríveis

-- Exemplo para demonstrar a ideia: 5194 * 76 = 394744
-- a = [4, 9, 1, 5], b = [6, 7]
-- Com o pairMulOp fica [[(4,6),(9,6),(1,6),(5,6)],[(4,7),(9,7),(1,7),(5,7)]]
-- Com o mulDigit aplicado ao primeiro elemento da lista anterior por exemplo ficaria [0+4, 2+4, 5+6 (mod 10), 1+0, 3+nada] = [4, 6, 1, 1, 3], 
-- ou seja o mesmo que fazer 5194*6 e depois fazer-se-ia 5194*7
-- o listSumsToDo faz uma lista de listas: aplica o mulDigit a cada lista do pairMulOp
-- o mul10expN pega na lista de lista anteriores e vai acrescentando um 0 ao inicio de cada uma, tipo ir multiplicando por 10 mas recursivamente e excluindo o primeiro a cada iteração
-- o mulBN dps soma essas listas todas obtidas no anterior

pairMulOp::[Int] -> [Int] -> [[(Int, Int)]]
pairMulOp xs [] = []
pairMulOp xs (y:ys) = [(a, y) | a <- xs]:pairMulOp xs ys

mulDigit::[(Int, Int)] -> Int -> [Int]
mulDigit [] r = [r]
mulDigit ((a,b):l) r = (a*b+r)`mod`10:(mulDigit l ((a*b+r)`div`10))

listSumsToDo::[Int] -> [Int] -> [[Int]]
listSumsToDo xs ys = [mulDigit l 0 | l <- pairMulOp xs ys]

mul10expN::[[Int]] -> [[Int]]
mul10expN [] = []
mul10expN (x:xs) = x:[(0:a) | a <- mul10expN xs] 

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN (Negative a) (Negative b) = Positive (bnList (foldl (somaBN) (Positive []) [Positive (reverse x) | x <- (mul10expN(listSumsToDo (reverse a) (reverse b)))]))
mulBN (Negative a) (Positive b) = Negative (bnList (foldl (somaBN) (Positive []) [Positive (reverse x) | x <- (mul10expN(listSumsToDo (reverse a) (reverse b)))]))
mulBN (Positive a) (Negative b) = Negative (bnList (foldl (somaBN) (Positive []) [Positive (reverse x) | x <- (mul10expN(listSumsToDo (reverse a) (reverse b)))]))
mulBN (Positive a) (Positive b) = Positive (bnList (foldl (somaBN) (Positive []) [Positive (reverse x) | x <- (mul10expN(listSumsToDo (reverse a) (reverse b)))]))

----- 2.6) TENTATIVA 2 ----
-- Multiplica um numero por um unico digito, levando o que fica como resto (?-TODO tentar arranjar mecanismo que nao precisa do r-?)
mulDigit' :: [Int] -> Int -> Int -> [Int]
mulDigit' _  0 _ = [0]
mulDigit' xs 1 _ = xs
mulDigit' [] _ r = if (r /= 0) then [r] else []
mulDigit' (x:xs) d r = (x*d + r) `mod` 10 : (mulDigit' xs d ((x*d + r) `div` 10))

-- Forma as parcelas da multiplicacao de um número por cada um dos digitos do segundo 
-- já deslocados com o numero de 0's correspondentes à sua posição 
mulParcelas :: [Int] -> [Int] -> [[Int]]
mulParcelas xs ys = [(take i (repeat 0)) ++ (mulDigit' xs y 0) | (y, i) <- zip ys [0..] ]

-- TODO :: nao queria repetir 4 vezes a mesma coisa em baixo uma vez que so muda o sinal, mas tambem nao gosto muito assim...
mulNs :: [Int] -> [Int] -> [Int]
mulNs a b = bnList (foldr somaBN (Positive []) [Positive (reverse p) | p <- mulParcelas (reverse a) (reverse b)])

mulBN' :: BigNumber -> BigNumber -> BigNumber
mulBN' (Negative a) (Negative b) = Positive (mulNs a b)
mulBN' (Negative a) (Positive b) = Negative (mulNs a b)
mulBN' (Positive a) (Negative b) = Negative (mulNs a b)
mulBN' (Positive a) (Positive b) = Positive (mulNs a b)

-- 2.7) efetua a divisão inteira de dois big-numbers. Retornar um par “(quociente, resto)” 
-- [Assumindo que ambos os argumentos são positivos]
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)

