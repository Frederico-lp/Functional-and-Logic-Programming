fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec(n-1) + fibRec(n-2)



fibLista :: (Integral a) => a -> a
fibLista 0 = 0
fibLista 1 = 1
fibLista n = x!!fromIntegral n
    where x = createList n

createList :: a -> [a]
createList n = [x | y<-[0..n], x<-[head y + y!!1..n]]




fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita i =  fib!!fromIntegral i
    where fib = 0: 1: zipWith (+) fib (tail fib)
