{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module BigNumber (BigNumber,
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
somaBN a b = reverse (ajustar (mySomaZip (reverse a)  (reverse b) )  )
--trocar zipwith por outra funçao
-- ver novaSoma [1,8,0] [9,8,1]
ajustar :: BigNumber -> BigNumber
ajustar []  = []

ajustar [x]
    |x < 10  =  [x]
    |x >= 10  =  [x`mod`10, x`div`10]
--    |x == 0 = [0, 1]
ajustar [x, y]
    |x < 10 && y >= 10 = x`mod`10: ajustar [y]
    |x < 10 && y < 10 = [x,y]
    |x >= 10 = x`mod`10:  ajustar [y+x`div`10]
    
ajustar (x:xs) 
    |x < 10 = x: ajustar xs
    |x >= 10 = x`mod`10: ajustar (head xs + x`div`10: tail xs)

mySomaZip :: BigNumber -> BigNumber -> BigNumber
mySomaZip [] [] = []
mySomaZip a  [] = a
mySomaZip [] b  = b
mySomaZip a b = head a + head b : mySomaZip (tail a) (tail b)


--NOTA: posso colocar a guarda quando for para por aquele 0
--quando algarismo mais singificativo é 10 da mal
--abs(x1+y1)`div`10 :
--n funciona para negativos
{-
subBN :: BigNumber -> BigNumber -> BigNumber
subBN x y = reverse (sub (reverse x) (reverse y))

sub :: BigNumber -> BigNumber -> BigNumber
sub  []     []     = []
sub xs     []     = xs
sub []     ys     = ys
sub [x]    [y]    = [x-y]
sub [x0, x1] [y]
    |x0 - y > 0 = [abs(x0 - y)`mod`10, x1 + abs(x0 - y)`div`10]
    |x0 - y < 0 = [10 - abs(x0 - y)`mod`10, x1 - abs(10-x0 + y)`div`10 ]
sub [x0, x1] [y0, y1]
    |x0 - y0 > 0 = [abs(x0 - y0)`mod`10, abs(x1 - y1)`mod`10]
    |x0 - y0 < 0 = [10 - abs(x0 - y0)`mod`10, x1 - (y1 + abs(10-x0 + y0)`div`10)]
sub (x:xs) (y:ys)   = abs((x - y)`mod`10): (head xs - (head ys + (abs(x+y)`div`10)) )`mod`10: sub (tail xs) (tail ys)
--sub (x0:x1:xs) (y0:y1:ys) = abs((x0 - y0)`mod`10): (x1 - (y1 + (abs(x0+y0)`div`10)) )`mod`10: sub xs ys
-}

subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b = reverse (ajustar (mySomaZip (reverse a)  (reverse b) )  )



--faltam patterns nestas ultimas duas, ex [1] [1] ou [1,2,3] [1,1,1]

-- Começo da implementação da função simpleMul.
simpleMul :: Int -> Int -> Int
simpleMul x y = x * y                               -- Multiplicação simples de dois números inteiros.
-- Fim da implementação da função simpleMul.

-- Começo da implementação da função mulBN.
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN x y = final_ret
    where
        multiplied_list = reverse [simpleMul a b | a <- reverse y , b <- reverse x ]    -- Põe numa lista revertida a multiplicação simples dos algarismos das duas listas representativas de BigNumbers distintos revertidos.
        list_splited = splitAt (length multiplied_list `div` 2) multiplied_list         -- Divide a lista anterior em 2 e guarda as duas metades num tuplo.
        list_to_add_one = 0 : snd list_splited                                          -- Adiciona um 0 no ínicio da segunda lista, por motivos do algoritmo de multiplicação usado.
        list_to_add_two = fst list_splited ++ [0]                                       -- Adiciona um 0 no fim da primeira lista, por motivos do algoritmo de multiplicação usado.
        final_ret = novaSoma list_to_add_one list_to_add_two                              -- Soma os dois números anteriores, sendo a soma o resultado final.
-- Fim da implementação da função mulBN.


-- Começo da implementação da função simpleDiv.
simpleDiv :: Int -> Int -> Int
simpleDiv x y = x `div` y                           -- Divisão inteira simples de dois números inteiros.
-- Fim da implementação da função simpleDiv.

-- Começo da implementação da função simpleRem.
simpleRem :: Int -> Int -> Int
simpleRem x y = x `rem` y                           -- Resto inteiro simples de dois números inteiros
-- Fim da implementação da função simpleRem.

-- Começo da implementação da função divBN.
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = (quocient , remainder)
    where
        quocient = []
        remainder = []
        dividend = 0
        divisor = 0
-- Fim da implementação da função divBN.

