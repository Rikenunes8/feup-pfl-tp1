-- Nésimo numero da sequencia corresponde ao valor de ordem n-1 (ordem inicia em 0)

-- 1.1) Funcao Recursiva
fibRec :: (Integral a) => a -> a
fibRec 1 = 0
fibRec 2 = 1
fibRec n 
    | n > 0     = fibRec (n - 2) + fibRec (n - 1) 
    | otherwise = error "argumento não positivo"


-- 1.2) Versao Otimizada
somaUltimos2 :: Num a => [a] -> a
somaUltimos2 xs = (last xs) + (last (init xs))

expandirSeq :: Num a => [a] -> Int -> [a]
expandirSeq xs 0 = xs
expandirSeq xs n = expandirSeq (xs ++ [somaUltimos2 xs]) (n - 1)

fibLista :: (Integral a) => a -> a
fibLista n 
    | n <= 0    = error "argumento não positivo"
    | i < len   = lista !! i
    | otherwise = (expandirSeq lista (i + 1 - len)) !! i
    where lista = [0, 1, 1, 2, 3, 5, 8, 13]
          len   = length lista
          i     = fromIntegral(n - 1)
          

-- 1.3) Versao com Lista Infinita
fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n 
    | n <= 0     = error "argumento não positivo"
    | otherwise = let fibs = (0 : 1 : [a + b | (a,b) <- zip fibs (tail fibs)])
                  in fibs !! fromIntegral(n - 1)
