fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec(n-1) + fibRec(n-2)


{--
fibLista :: (Integral a) => Int -> a 
fibLista n = x!!(n-1) + x!!(n-2)
    where x = 0:1:
--}




fibListaInfinita :: (Integral a) => Int -> a
fibListaInfinita i =  fib!!i
    where fib = 0: 1: zipWith (+) fib (tail fib)
