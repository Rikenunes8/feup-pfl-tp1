import BigNumber

-- Nésimo numero da sequencia corresponde ao valor de ordem n-1 (ordem inicia em 0)

-- 1.1) Funcao Recursiva
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n 
    | n < 0     = error "argumento negativo"
    | otherwise = fibRec (n - 2) + fibRec (n - 1) 


-- 1.2) Versao Otimizada
somaUltimos2 :: Num a => [a] -> a
somaUltimos2 xs = (last xs) + (last (init xs))

expandirSeq :: Num a => [a] -> Int -> [a]
expandirSeq xs 0 = xs
expandirSeq xs n = expandirSeq (xs ++ [somaUltimos2 xs]) (n - 1)

fibLista :: (Integral a) => a -> a
fibLista n 
    | n < 0     = error "argumento negativo"
    | i < len   = lista !! i
    | otherwise = (expandirSeq lista (i + 1 - len)) !! i
    where lista = [0, 1]
          len   = length lista
          i     = fromIntegral(n)
          

-- 1.3) Versao com Lista Infinita
fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n 
    | n < 0     = error "argumento negativo"
    | otherwise = let fibs = (0 : 1 : [a + b | (a,b) <- zip fibs (tail fibs)])
                  in fibs !! fromIntegral(n)






-- 3.1) Funcao Recursiva
fibRecBN :: (Integral a) => a -> BigNumber
fibRecBN 0 = Positive [0]
fibRecBN 1 = Positive [1]
fibRecBN n 
    | n < 0     = error "argumento negativo"
    | otherwise = somaBN (fibRecBN (n - 2)) (fibRecBN (n - 1))

fibRecBN' :: BigNumber -> BigNumber
fibRecBN' (Positive [0]) = Positive [0]
fibRecBN' (Negative [0]) = Positive [0]
fibRecBN' (Positive [1]) = Positive [1]
fibRecBN' n 
    | n < (Positive [0]) = error "argumento negativo"
    | otherwise         = somaBN (fibRecBN' (subBN n (Positive [2]))) (fibRecBN' (subBN n (Positive [1])))


-- 3.2) Versao Otimizada
somaUltimos2BN :: [BigNumber] -> BigNumber
somaUltimos2BN xs = somaBN (last xs) (last (init xs))

expandirSeqBN :: [BigNumber] -> Int -> [BigNumber]
expandirSeqBN xs 0 = xs
expandirSeqBN xs n = expandirSeqBN (xs ++ [somaUltimos2BN xs]) (n - 1)

fibListaBN :: (Integral a) => a -> BigNumber
fibListaBN n 
    | n < 0     = error "argumento negativo"
    | i < len   = lista !! i
    | otherwise = (expandirSeqBN lista (i + 1 - len)) !! i
    where lista = [Positive [0], Positive [1]]
          len   = length lista
          i     = fromIntegral(n)
          

-- 3.3) Versao com Lista Infinita
fibListaInfinitaBN :: (Integral a) => a -> BigNumber
fibListaInfinitaBN n 
    | n < 0     = error "argumento negativo"
    | otherwise = let fibs = (Positive [0] : Positive [1] : [somaBN a b | (a,b) <- zip fibs (tail fibs)])
                  in fibs !! fromIntegral(n)


(@@) :: [BigNumber] -> BigNumber -> BigNumber
(@@) [] _                   = error "index out of range"
(@@) (x:xs) (Positive [0])  = x
(@@) (x:xs) n               = (@@) xs (subBN n (Positive [1]))

fibListaInfinitaBN' :: BigNumber -> BigNumber
fibListaInfinitaBN' n 
    | n < (Positive [0])     = error "argumento negativo"
    | otherwise = let fibs = (Positive [0] : Positive [1] : [somaBN a b | (a,b) <- zip fibs (tail fibs)])
                  in (@@) fibs n

