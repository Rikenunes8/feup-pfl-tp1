fibRec::(Integral a) => a -> a
fibRec 1 = 0 
fibRec 2 = 1
fibRec n = fibRec (n-1) + fibRec (n-2) 

-- fibLista::(Integral a) => a -> [a]
-- TODO

fibListaInfinita::(Integral a) => a -> a
fibListaInfinita n = fibs !! fromIntegral(n-1)
               where fibs = (0:1:[a+b | (a,b) <- zip fibs (tail fibs)])