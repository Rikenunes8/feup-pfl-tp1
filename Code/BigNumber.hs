module BigNumber (BigNumber(Positive, Negative), scanner, output, somaBN, subBN, mulBN, divBN, safeDivBN) where

import Data.Char (digitToInt)
import Data.Maybe

-- 2.1) A definição do tipo BigNumber
data BigNumber = Positive [Int] 
               | Negative [Int]
               deriving (Show, Eq)

instance Ord BigNumber where
    (Positive a) <= (Positive b) = length a < length b || ((length a == length b) && (output (Positive a) <= output (Positive b))) 

-------- FUNÇÕES AUXILIARES ---------

-- Gera uma lista de pares de elementos de igual indice, associando com 0 os que não têm correspondencia
zip0 :: [Int] -> [Int] -> [(Int, Int)]
zip0 [] []         = []
zip0 xs []         = [(x, 0) | x <- xs]
zip0 [] ys         = [(0, y) | y <- ys]
zip0 (x:xs) (y:ys) = (x, y) : (zip0 xs ys)

-- Varre os zeros à esquerda da lista, garantindo que pelo menos existe 1
cleanLeft0s :: [Int] -> [Int]
cleanLeft0s [] = []
cleanLeft0s l  = (dropWhile (== 0) (init l)) ++ [last l]

-- Retorna a lista de dígitos de um BigNumber, independentemente do sinal
bnList :: BigNumber -> [Int]
bnList (Positive l) = l
bnList (Negative l) = l

---------------------------------------

-- 2.2) Converte uma string em big-number
stringToN :: String -> [Int]
stringToN = foldr (\x y -> digitToInt x : y) []

scanner :: String -> BigNumber
scanner ('-':s) = Negative (cleanLeft0s (stringToN s))
scanner ('+':s) = Positive (cleanLeft0s (stringToN s))
scanner s       = Positive (cleanLeft0s (stringToN s))


-- 2.3) Converte um big-number em string
nToString :: [Int] -> String
nToString = foldr (\x y -> show x ++ y) ""

output :: BigNumber -> String
output (Negative bn) = "-" ++ nToString (cleanLeft0s bn)
output (Positive bn) = "+" ++ nToString (cleanLeft0s bn)


-- 2.4) Soma dois big-numbers.
sumDigits :: [(Int, Int)] -> [Int]
sumDigits [] = []
sumDigits ((a,b):[]) = (a + b) `mod` 10 : let r = (a + b) `div` 10 
                                       in if (r /= 0) then [r] else []
sumDigits ((a,b):(c,d):l) = (a + b) `mod` 10 : sumDigits ((c, d + ((a + b) `div` 10)) : l)

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN (Negative a) (Negative b) = Negative (cleanLeft0s (reverse (sumDigits (zip0 (reverse a) (reverse b)) ) ))
somaBN (Negative a) (Positive b) = subBN (Positive b) (Positive a)
somaBN (Positive a) (Negative b) = subBN (Positive a) (Positive b)
somaBN (Positive a) (Positive b) = Positive (cleanLeft0s (reverse (sumDigits (zip0 (reverse a) (reverse b)) ) ))


-- 2.5) Subtrai dois big-numbers.
subDigits :: [(Int, Int)] -> [Int]
subDigits [] = []
subDigits ((a,b):[]) = [(a - b)]
subDigits ((a,b):(c,d):l) 
    | a >= b    = (a - b) : subDigits ((c, d) : l)
    | otherwise = (a + 10 - b) : subDigits ((c, d + 1) : l)

subBN :: BigNumber -> BigNumber -> BigNumber
subBN (Negative a) (Negative b) = subBN  (Positive b) (Positive a)
subBN (Negative a) (Positive b) = somaBN (Negative a) (Negative b)
subBN (Positive a) (Negative b) = somaBN (Positive a) (Positive b)
subBN (Positive a) (Positive b) | Positive a < Positive b = Negative (cleanLeft0s (reverse (subDigits (zip0 (reverse b) (reverse a)) ) ))
                                | otherwise               = Positive (cleanLeft0s (reverse (subDigits (zip0 (reverse a) (reverse b)) ) ))


-- 2.6) Multiplica dois big-numbers.

-- Multiplica um numero por um unico digito, transportando o resto entre multiplicações digito a digito
mulDigit :: [Int] -> Int -> Int -> [Int]
mulDigit _  0 _ = [0]
mulDigit xs 1 _ = xs
mulDigit [] _ r = if (r /= 0) then [r] else []
mulDigit (x:xs) d r = (x*d + r) `mod` 10 : (mulDigit xs d ((x*d + r) `div` 10))

-- Forma as parcelas da multiplicacao de um número por cada um dos digitos do segundo 
-- já deslocados com o numero de 0's correspondentes à sua posição no segundo número
mulParcelas :: [Int] -> [Int] -> [[Int]]
mulParcelas xs ys = [(take i (repeat 0)) ++ (mulDigit xs y 0) | (y, i) <- zip ys [0..] ]

-- Soma todas as parcelas que resultam da multiplicacao do primeiro numero pelos algarismos do segundo
mulNs :: [Int] -> [Int] -> [Int]
mulNs a b = bnList (foldr somaBN (Positive []) [Positive (reverse p) | p <- mulParcelas (reverse a) (reverse b)])

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN (Negative a) (Negative b) = Positive (mulNs a b)
mulBN (Negative a) (Positive b) = Negative (mulNs a b)
mulBN (Positive a) (Negative b) = Negative (mulNs a b)
mulBN (Positive a) (Positive b) = Positive (mulNs a b)


-- 2.7) Efetua a divisão inteira de dois big-numbers. Retornar um par “(quociente, resto)” 
-- [Assumindo que ambos os argumentos são positivos]

-- Produz uma sucessão infinita a partir de i
sucBN :: BigNumber -> [BigNumber]
sucBN i = i : sucBN (somaBN i (Positive [1]))

-- Procura o ultimo multiplo do divisor menor ou igual ao dividento. Calcula o quociente e o resto em função destes paramentros.
-- Quociente = valor que multiplicado pelo divisor resultada no multiplo a procurar
-- Resto = dividento - (divisor * quociente) <=> dividendo - ultimoMultiplo
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = (q, subBN a dq)
    where (q, dq) = last (takeWhile (\(q, dq) -> dq <= a) [ (i, mulBN b i) | i <- sucBN (Positive [0]) ])



-- 5) Deteta divisões por zero em compile-time. Como tal, retorna monads do tipo Maybe. 
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN a b
    | cleanLeft0s (bnList b) == [0] = Nothing
    | otherwise                     = Just (divBN a b)
