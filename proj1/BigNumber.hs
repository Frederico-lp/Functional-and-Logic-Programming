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



subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b = reverse (ajustarSub (mySubZip (reverse a)  (reverse b) )  )

ajustarSub :: BigNumber -> BigNumber
ajustarSub []  = []

ajustarSub [x]
    |x > 0 = [x]
    |x < 0 = [x+1]
--    |x >= 0  =  [x]
--    |x < 10  =  [x`mod`10, x`div`10]
--    |x == 0 = [0, 1]
ajustarSub [x, y]
    |x >= 0 && y == 0 = [x]
    |x >= 0 = x: ajustar [y]
    |x < 0 && y == 0 = [x]
    |x < 0 && y - 1 == 0 = [10 - abs x]
    |x < 0 && y - 1 < 0 = 10 - abs x: ajustar [y-1]

ajustarSub (x:xs)
    |x <  0 = 10 - abs x :ajustarSub (head xs - 1 : tail xs)
    |x >= 0 = x : ajustarSub xs

mySubZip :: BigNumber -> BigNumber -> BigNumber
mySubZip [] [] = []
mySubZip a  [] = a
mySubZip [] b  = b
mySubZip a b = head a - head b : mySubZip (tail a) (tail b)



--faltam patterns nestas ultimas duas, ex [1] [1] ou [1,2,3] [1,1,1]

-- Começo da implementação da função simpleMul.
simpleMul :: Int -> Int -> Int
simpleMul x y = x * y                               -- Multiplicação simples de dois números inteiros.
-- Fim da implementação da função simpleMul.

checkNegSolo :: Int -> Bool
checkNegSolo x = x < 0

checkNeg :: Int -> Int -> Bool
checkNeg x y = x < 0 && y < 0

changeNeg :: BigNumber -> BigNumber
changeNeg x = ret
    where
        ret = [head x * (-1)] ++ [c | c <- reverse (take ((length x) - 1) (reverse x ))]

xor :: Bool -> Bool -> Bool
xor x y | x == True && y == False = True
        | x == False && y == True = True
        | otherwise = False

-- Começo da implementação da função mulBN.
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN x y = final_ret
    where
        neg_check_list_one = checkNegSolo (head x)
        neg_check_list_two = checkNegSolo (head y)
        aux_list_1 = if neg_check_list_one
                        then changeNeg x else x
        aux_list_2 = if neg_check_list_two
                        then changeNeg y else y
        multiplied_list = reverse [simpleMul a b | a <- reverse aux_list_2 , b <- reverse aux_list_1 ]    -- Põe numa lista revertida a multiplicação simples dos algarismos das duas listas representativas de BigNumbers distintos revertidos.
        list_splited = splitAt (length multiplied_list `div` 2) multiplied_list                           -- Divide a lista anterior em 2 e guarda as duas metades num tuplo.
        list_to_add_one = 0 : snd list_splited                                                            -- Adiciona um 0 no ínicio da segunda lista, por motivos do algoritmo de multiplicação usado.
        list_to_add_two = fst list_splited ++ [0]                                                         -- Adiciona um 0 no fim da primeira lista, por motivos do algoritmo de multiplicação usado.
        final_ret = if xor neg_check_list_one neg_check_list_two
                        then (changeNeg (somaBN list_to_add_one list_to_add_two))
                        else somaBN list_to_add_one list_to_add_two
-- Fim da implementação da função mulBN.


-- Começo da implementação da função simpleDiv.
simpleDiv :: Int -> Int -> Int
simpleDiv x y = x `div` y                           -- Divisão inteira simples de dois números inteiros.
-- Fim da implementação da função simpleDiv.

{-
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
-}

divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = (c, subBN a (mulBN c b ) )
    where c = divAux a b [0]

{-
--quociente
dixAux :: BigNumber -> BigNumber -> Int
divAux a b = if subBN(a b) != [0] 
                then divBN (subBN (a b) b)
            else [a]
-}

divAux :: BigNumber -> BigNumber -> BigNumber -> BigNumber
divAux a b i
    |largerThan a b =  divAux (subBN a b) b (somaBN i [1])
    |otherwise = i


largerThan :: BigNumber -> BigNumber -> Bool
largerThan [] [] = True
largerThan (x:xs) (y:ys)
    |length (x:xs) > length (y:ys) =   True
    |length xs == length ys && x > y = True
    |length xs == length ys && x == y = largerThan  xs ys
    |otherwise = False



safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN x [0] = Nothing 
safeDivBN x y = Just (divBN x y) 



