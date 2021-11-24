{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module BigNumbers (BigNumber,
                    scanner, algarismos, somaBN, subBN) where
import Data.Text.Internal.Read (digitToInt)
import Text.Printf (IsChar(toChar))
import Data.Time.Format.ISO8601 (yearFormat)
import Distribution.Compat.Lens (_1)

type BigNumber = [Int]

scanner:: String -> BigNumber
scanner n = algarismos (read n::Int)

algarismos :: Int -> [Int]
algarismos x
    |x > 0 = reverse (algarismosrev x)
    |x < 0 = negate (head (reverse (algarismosrev x)) ) : tail (reverse (algarismosrev x))
    |x == 0 = []
    |otherwise = [-1]

algarismosrev :: Int -> [Int]
algarismosrev x
    |x > 0 = x`mod`10 : algarismosrev  (x`div`10)
    |x < 0 =  negate x`mod`10 : algarismosrev (negate x`div`10)
    |x == 0 = []
    |otherwise = [-1]

output :: BigNumber -> String
output = concatMap show

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN x y = reverse (soma (reverse x) (reverse y))

--estao ao contrario 123->321
soma :: BigNumber -> BigNumber -> BigNumber
soma []     []     = []
soma xs     []     = xs
soma []     ys     = ys
soma [x]    [y]    
    |(x + y)`div`10>0 = [(x+y)`mod`10,(x+y)`div`10]
    |(x + y)`div`10==0 = [x+y]
soma [x0,x1] [y0,y1] 
    |(x1 + y1)`div`10>0 = [abs(x0+y0)`mod`10, (x1 + y1)`mod`10 + abs(x0+y0)`div`10, (x1 + y1)`div`10]
    |(x1 + y1)`div`10==0 = [abs(x0+y0)`mod`10, (x1 + y1)`mod`10 + abs(x0+y0)`div`10]
soma [x0,x1] [y]   = [abs(x0+y)`mod`10, x1 + abs(x0+y)`div`10]
soma [x]    [y0, y1] = [abs(y0+x)`mod`10, y1 + abs(y0+x)`div`10]
soma  (x0:x1:xs) (y0:y1:ys) = abs(x0+y0)`mod`10: (x1 + y1)`mod`10 + abs(x0+y0)`div`10: soma xs ys
--NOTA: posso colocar a guarda quando for para por aquele 0
--abs(x1+y1)`div`10 :
--n funciona para negativos

subBN :: BigNumber -> BigNumber -> BigNumber
subBN x y = reverse (sub (reverse x) (reverse y))

sub :: BigNumber -> BigNumber -> BigNumber
sub  []     []     = []
sub xs     []     = xs
sub []     ys     = ys
sub [x]    [y]    = [x-y]
sub [x0, x1] [y] 
    |x0 - y > 0 = [abs(x0 - y)`mod`10, x1 + abs(x0 - y)`div`10]
    |x0 - y < 0 = [10 - abs(x0 - y)`mod`10, x1 - abs(x0 + y)`div`10 ]
sub (x0:x1:xs) (y0:y1:ys) = abs((x0 - y0)`mod`10): (x1 - (y1 + (abs(x0+y0)`div`10)) )`mod`10: sub xs ys
--sub (x:xs) (y:ys)   = abs((x - y)`mod`10): (head xs - (head ys + (abs(x+y)`div`10)) )`mod`10: sub xs ys

--faltam patterns nestas ultimas duas, ex [1] [1] ou [1,2,3] [1,1,1]

-- mulBN implementation start
simpleMul :: Int -> Int -> Int 
simpleMul x y = x * y

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN x y = final_ret_1
    where 
        multiplied_list = reverse [simpleMul a b | a <- reverse y , b <- reverse x ] -- lista da multiplicação
        list_splited = splitAt (length multiplied_list `div` 2) multiplied_list -- returns a tuple with two lists
        list_to_add_one = 0 : snd list_splited 
        list_to_add_two = fst list_splited ++ [0]
        final_ret_1 = somaBN list_to_add_one list_to_add_two

-- mulBN implementation end









--posso chamar soma no final
--mulBN :: BigNumber -> BigNumber -> BigNumber
--mulBN x y = reverse (mul (reverse x) (reverse y))
--mulBN x y = somaBN(mul()) 
{--

--
-}
{-
--lista de resultados de multiplicaçoes
mul :: BigNumber -> BigNumber -> BigNumber
mul  []    _ = []
mul (x0:x1:xs) y =  soma(mul' x0 y)  (mul' x1 y)

--concatena ultima multiplicaçao com a funçao abaixo para 
--n se perder algarismo mais significativo em case do overflow
--mulconc :: Int -> BigNumber -> BigNumber
--mulconc x  y = x * head y : reverse(tail(mul' x y))

-- multiplica n * xxxx
mul' :: Int -> BigNumber -> BigNumber
mul' x     []     = []
mul' x (y0:y1:ys) = (x*y0)`mod`10: (x*y1)`mod`10 + (x*y0)`div`10: mul' x ys

--              abs(x0+y0)`mod`10: (x1 + y1)`mod`10 + abs(x0+x1)`div`10: soma xs ys

-}


divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = (y , z)
    where y = zipWith (div) a b
          z = zipWith (mod) a b


--isto tem de ir pra Fib.hs
fibRecBN :: Int -> BigNumber
fibRecBN 0 = [0]
fibRecBN 1 = [1]
fibRecBN n = somaBN (fibRecBN(n-1)) (fibRecBN(n-2))

fibListaBN :: Int -> BigNumber
fibListaBN i = fib!!i
    where fib = [0]: [1]: [somaBN (fib!!(i-1)) (fib!!(i-2)) |i<-[2..i]]

fibListaInfinitaBN :: Int -> BigNumber
fibListaInfinitaBN i =  fib!!i
    where fib = [0]: [1]: zipWith somaBN fib (tail fib)

--em ultimo caso passo para string e para bignumb
