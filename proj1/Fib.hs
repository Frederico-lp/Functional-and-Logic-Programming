--import BigNumber

fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec(n-1) + fibRec(n-2)



fibLista :: (Integral a) => a -> a
fibLista n = fib !! fromIntegral n
    where fib = 0: 1: [fib!! (fromIntegral i-1) + fib !! (fromIntegral i-2) | i<-[2..n]]


fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita i =  fib!!fromIntegral i
    where fib = 0: 1: zipWith (+) fib (tail fib)
