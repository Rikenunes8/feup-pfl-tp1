module BigNumber (BigNumber) where

import Data.Char (digitToInt)

-- 2.1) a definição do tipo BigNumber
data BigNumber = Positive [Int] 
               | Negative [Int]

instance Show BigNumber where
    show (Positive digits) = "Positive " ++ show digits
    show (Negative digits) = "Negative " ++ show digits

-- Funções auxiliares
zipDefault0::[Int] -> [Int] -> [(Int, Int)]
zipDefault0 [] []         = []
zipDefault0 (x:xs) []     = (x,0):(zipDefault0 xs [])
zipDefault0 [] (y:ys)     = (0,y):(zipDefault0 [] ys)
zipDefault0 (x:xs) (y:ys) = (x,y):(zipDefault0 xs ys)

bnToList::BigNumber -> [Int]
bnToList (Positive l) = l


cleanLeft0s::BigNumber -> BigNumber
cleanLeft0s (Positive l) = Positive (reverse (dropWhile (== 0) (reverse l)))


-- 2.2) converte uma string em big-number
stringToN :: String -> [Int]
stringToN "" = []
stringToN (x:xs) = (digitToInt x) : stringToN xs

scanner :: String -> BigNumber
scanner ('-':s) = Negative (stringToN s)
scanner ('+':s) = Positive (stringToN s)
scanner s       = Positive (stringToN s)


-- 2.3) converte um big-number em string
nToString :: [Int] -> String
nToString [] = ""
nToString (x:xs) = (show x) ++ nToString xs 

output :: BigNumber -> String
output (Negative bn) = "-" ++ nToString bn
output (Positive bn) = "+" ++ nToString bn


-- 2.4) soma dois big-numbers.
somaBN::BigNumber -> BigNumber -> BigNumber
somaBN a b  = let aux = [x+y | (x,y) <- zipDefault0 (bnToList a) (bnToList b)]
              in cleanLeft0s (Positive [ x `mod` 10 + y `div` 10 | (x, y) <- zipDefault0 aux (0:aux)])


-- 2.5) subtrai dois big-numbers.
subBN :: BigNumber -> BigNumber -> BigNumber
-- é preciso implementar o operador < para funcionar
--subBN a b | a >= b    = cleanLeft0s (Positive [ x `mod` 10 + y `div` 10 | (x, y) <- zipDefault0 (aux a b) (0:(aux a b))])
--          | otherwise = cleanLeft0s (Positive [ x `mod` 10 + y `div` 10 | (x, y) <- zipDefault0 (aux b a) (0:(aux b a))]) -- Não sei se isto funciona
--          where aux c d = [x-y | (x,y) <- zipDefault0 (bnToList c) (bnToList d)]
subBN a b = let aux = [x-y | (x,y) <- zipDefault0 (bnToList a) (bnToList b)]
            in Positive [ x `mod` 10 + y `div` 10 | (x, y) <- zipDefault0 aux (0:aux)]


-- 2.6) multiplica dois big-numbers.
-- mulBN :: BigNumber -> BigNumber -> BigNumber



-- 2.7) efetua a divisão inteira de dois big-numbers. Retornar um par “(quociente, resto)” 
-- [Assumindo que ambos os argumentos são positivos]
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)

