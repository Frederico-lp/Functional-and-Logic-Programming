import BigNumber

-- Implementação da função fibRec
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec(n-1) + fibRec(n-2)



-- Implementação da função fibLista
fibLista :: (Integral a) => a -> a
fibLista n = fib !! fromIntegral n
    where fib = 0: 1: [fib!! (fromIntegral i-1) + fib !! (fromIntegral i-2) | i<-[2..n]]



-- Implementação da função fibListaInfinita
fibListaInfinita :: Integer -> Integer
fibListaInfinita i =  fib!!fromIntegral i
    where fib = 0: 1: zipWith (+) fib (tail fib)




-- Implementação da função fibRecBN
fibRecBN :: Int -> BigNumber
fibRecBN 0 = [0]
fibRecBN 1 = [1]
fibRecBN n = somaBN (fibRecBN(n-1)) (fibRecBN(n-2))



-- Implementação da função fibListaBN
fibListaBN :: Int -> BigNumber
fibListaBN i = fib!!i
    where fib = [0]: [1]: [somaBN (fib!!(i-1)) (fib!!(i-2)) |i<-[2..i]]



-- Implementação da função fibListaInfinitaBN
fibListaInfinitaBN :: Int -> BigNumber
fibListaInfinitaBN i =  fib!!i
    where fib = [0]: [1]: zipWith somaBN fib (tail fib)

