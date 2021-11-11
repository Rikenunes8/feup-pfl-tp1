module BigNumber (BigNumber) where

-- 2.1) a definição do tipo BigNumber
data BigNumber = Positive [Int] 
               | Negative [Int]


-- 2.2) converte uma string em big-number
-- scanner :: String -> BigNumber



-- 2.3) converte um big-number em string
-- output :: BigNumber -> String



-- 2.4) soma dois big-numbers.
bnToList::BigNumber -> [Int]
bnToList (Positive l) = l

zipDefault0::[Int] -> [Int] -> [(Int, Int)]
zipDefault0 [] []         = []
zipDefault0 (x:xs) []     = (x,0):(zipDefault0 xs [])
zipDefault0 [] (y:ys)     = (0,y):(zipDefault0 [] ys)
zipDefault0 (x:xs) (y:ys) = (x,y):(zipDefault0 xs ys)

cleanLeft0s::BigNumber -> BigNumber
cleanLeft0s (Positive l) = Positive (reverse (dropWhile (== 0) (reverse l)))

somaBN::BigNumber -> BigNumber -> BigNumber
somaBN a b  = let aux = [x+y | (x,y) <- zipDefault0 (bnToList a) (bnToList b)]
              in cleanLeft0s (Positive [ x `mod` 10 + y `div` 10 | (x, y) <- zipDefault0 aux (0:aux)])


-- 2.5) subtraí dois big-numbers.
-- subBN :: BigNumber -> BigNumber -> BigNumber



-- 2.6) multiplica dois big-numbers.
-- mulBN :: BigNumber -> BigNumber -> BigNumber



-- 2.7) efetua a divisão inteira de dois big-numbers. Retornar um par “(quociente, resto)” 
-- [Assumindo que ambos os argumentos são positivos]
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)

