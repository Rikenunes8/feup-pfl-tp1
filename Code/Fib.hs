-- TODO :: melhorar mensagens de erro!

-- 1.1) Funcao Recursiva
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec 2 = 1 -- acaba por nao ser necessario
fibRec n 
    | n > 0     = fibRec (n-1) + fibRec (n-2) 
    | otherwise = error "n invalido"


-- 1.2) Versao Otimizada
fibLista :: (Integral a) => a -> a
fibLista n 
    | n < 0                 = error "n invalido"
    | i < (length lista)    = lista !! i
    | otherwise             = fibLista (n-2) + fibLista (n-1)
    where lista = [0, 1, 1, 2, 3, 5, 8, 13]
          i     = fromIntegral(n)


-- 1.3) Versao com Lista Infinita
fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n 
    | n < 0     = error "n invalido"
    | otherwise = let fibs = (0 : 1 : [a + b | (a,b) <- zip fibs (tail fibs)])
                  in fibs !! fromIntegral(n) -- Nota: é apenas n -> fib de 0 = 0, 0 conta como ordem


-- NOTA:: aparece um exemplo da sequencia fibonacci nos exercicos do livro "Learning by solving problems"