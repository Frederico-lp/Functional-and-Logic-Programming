{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module BigNumber (BigNumber,
                    scanner, algarismos, somaBN, subBN) where
import Data.Text.Internal.Read (digitToInt)
import Text.Printf (IsChar(toChar))
import Data.Time.Format.ISO8601 (yearFormat)

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
subBN a b = reverse (ajustar (mySomaZip (reverse a)  (reverse b) )  )



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

splitAtLenght :: BigNumber -> Int -> [BigNumber]
splitAtLenght bn len = if length bn == len
                            then [bn]
                            else ret
                                where
                                    aux_list = splitAt len bn
                                    ret = fst aux_list : splitAtLenght (snd aux_list) len

addNzeros :: Int -> BigNumber -> BigNumber
addNzeros 0 bn = bn
addNzeros 1 bn = bn ++ [0]
addNzeros n bn = addNzeros (n-1) (bn ++ [0])

indexAt :: [BigNumber] -> Int -> [BigNumber]
indexAt [] _ = []
indexAt (bn_list:bn_list_xs) i = addNzeros i bn_list : indexAt bn_list_xs (i+1)

somaRec :: [BigNumber] -> BigNumber
somaRec [] = [0]
somaRec (bn:bns) = somaBN bn (somaRec bns)

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
        multiplied_list = reverse [simpleMul a b | a <- reverse aux_list_2 , b <- reverse aux_list_1 ]
        list_splited = if length x > length y
                            then reverse (splitAtLenght multiplied_list (length x))
                            else reverse (splitAtLenght multiplied_list (length y))
        list_with_zeros = indexAt list_splited 0
        final_ret = if xor neg_check_list_one neg_check_list_two
                        then changeNeg (somaRec list_with_zeros)
                        else somaRec list_with_zeros
                        
-- Fim da implementação da função mulBN.


-- Começo da implementação da função simpleDiv.
simpleDiv :: Int -> Int -> Int
simpleDiv x y = x `div` y                           -- Divisão inteira simples de dois números inteiros.
-- Fim da implementação da função simpleDiv.

-- Começo da implementação da função simpleRem.
simpleRem :: Int -> Int -> Int
simpleRem x y = x `rem` y                           -- Resto inteiro simples de dois números inteiros
-- Fim da implementação da função simpleRem.


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



