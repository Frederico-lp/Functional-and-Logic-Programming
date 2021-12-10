{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
--import Prelude (Bool)
--import Prelude (Bool)
--import Prelude (Bool)
--import Prelude (Bool)
import Data.Char (isDigit, isUpper, isLower)
--NOTA:gerador avança primeiro o mais a direita de todos mas pela ordem indicada inicalmente
--     posso usar guarda para gerar lista especifica a partir dos geradores
-- :set +s para saber quanto tempo demora a correr a funçao

--2.1
soma :: Int
soma = sum(map (^2) [1..100])

--2.2
--a)
aprox:: Int -> Double
--aprox x = sum (zip  (fromInteger(-1**)/(2* + 1) )  [1..x]) 
aprox x = sum [fromIntegral((-1)^a)/fromIntegral(2*a + 1) | a<-[0..x-1] ]
--[padrao q se repete | gerador]

{--
--b)
aprox':: Int -> Double 
aprox' x = 
--}


--2.3
dotprod :: [Float] -> [Float] -> Float
dotprod a b = sum( zipWith (*) a b)

--2.4
divprop :: Integer -> [Integer]
divprop n = [x | x<-[1..n], n`mod` x == 0]

--2.11

myConcat:: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs

myConcat' l = [x | xs<-l, x <-xs]
{--ex: [ [1,2] [3]]
1º xs = [1,2]
2º x = 1
3º x = 2
etc..
--}
myReplicate::Integral a=>a->b->[b]
myReplicate 0_=[]
myReplicate n x
    |n>0 = x:(myReplicate(n-1) x)
    |otherwise = error"argumento invalido"

myReplicate' n x = [x | _<-[1..n]]

--2.12
forte::String->Bool
forte x = and [length(x) >= 8, any isDigit x, any isUpper x, any isLower x]

--2.14
{--
nub:: a ->[a] ->[a] 
nub n = [x | xs<-n, x<-xs ,x!=n]
--}

--2.15
myintersperse :: a ->[a] ->[a]
myintersperse _ [] = []
myintersperse _ [x] = [x]
myintersperse n (x:xs) = x : n : myintersperse n xs

--2.16
algarismos :: Int -> [Int]
algarismos x = reverse (algarismosrev x)
 
algarismosrev :: Int -> [Int]
algarismosrev 0 = []
algarismosrev x = x`mod`10 : algarismosrev  (x`div`10)

--2.19
mdc:: Int -> Int -> Int 
mdc x y 
    |y == 0 = x
    |otherwise = mdc y x`mod`y
--da mal
 
