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
-- O mesmo que zip mas em vez de descartar os elementos a mais de uma lista acrescenta 0s na menor lista
zipDefault0::[Int] -> [Int] -> [(Int, Int)]
zipDefault0 [] []         = []
zipDefault0 (x:xs) []     = (x,0):(zipDefault0 xs [])
zipDefault0 [] (y:ys)     = (0,y):(zipDefault0 [] ys)
zipDefault0 (x:xs) (y:ys) = (x,y):(zipDefault0 xs ys)
-- converte um BigNumber para uma lista de inteiros
bnToList::BigNumber -> [Int]
bnToList (Positive l) = l
-- Limpa os zeros à esquerda
cleanLeft0s::BigNumber -> BigNumber
cleanLeft0s (Positive l) = Positive (dropWhile (== 0) l)
cleanLeft0s (Negative l) = Negative (dropWhile (== 0) l)
---------------------------------------

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
-- TODO: Change sumDigit name
sumDigit::[(Int, Int)] -> Int -> [Int]
sumDigit [] r = [r]
sumDigit ((a,b):l) r = (a+b+r)`mod`10:(sumDigit l ((a+b+r)`div`10))

somaBN::BigNumber -> BigNumber -> BigNumber
somaBN (Negative a) (Negative b) = cleanLeft0s (Negative (reverse ((sumDigit (zipDefault0 (reverse a) (reverse b)) 0))))
somaBN (Negative a) (Positive b) = subBN (Positive b) (Positive a)
somaBN (Positive a) (Negative b) = subBN (Positive a) (Positive b)
somaBN (Positive a) (Positive b) = cleanLeft0s (Positive (reverse ((sumDigit (zipDefault0 (reverse a) (reverse b)) 0))))

-- 2.5) subtrai dois big-numbers.
-- TODO: Change subDigit name
subDigit::[(Int, Int)] -> Int -> [Int]
subDigit [] r = []
subDigit ((a,b):l) r = (a-b+r)`mod`10:(subDigit l ((a-b+r)`div`10))

subBN :: BigNumber -> BigNumber -> BigNumber
subBN (Negative a) (Negative b) = subBN  (Positive b) (Positive a)
subBN (Negative a) (Positive b) = somaBN (Negative a) (Negative b)
subBN (Positive a) (Negative b) = somaBN (Positive a) (Positive b)
subBN (Positive a) (Positive b) | Positive a < Positive b = cleanLeft0s (Negative (reverse (((subDigit (zipDefault0 (reverse b) (reverse a)) 0)))))
                                | otherwise               = cleanLeft0s (Positive (reverse (((subDigit (zipDefault0 (reverse a) (reverse b)) 0)))))


-- 2.6) multiplica dois big-numbers.
-- mulBN :: BigNumber -> BigNumber -> BigNumber



-- 2.7) efetua a divisão inteira de dois big-numbers. Retornar um par “(quociente, resto)” 
-- [Assumindo que ambos os argumentos são positivos]
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)

