{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
-- Módulos a serem importados para o funcionamento correto do programa
module BigNumber (BigNumber, scanner, algarismos, somaBN, subBN) where
import Data.Text.Internal.Read (digitToInt)
import Text.Printf (IsChar(toChar))
import Data.Time.Format.ISO8601 (yearFormat)

type BigNumber = [Int]

-- Implementação da função scanner
scanner:: String -> BigNumber
scanner n = algarismos (read n::Int)

-- Funções auxiliares à função scanner (começo)
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
-- Funções auxiliares à função scanner (fim)



-- Implementação da função output
output :: BigNumber -> String
output = concatMap show



-- Implementação da função somaBN
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN a b = reverse (ajustar (mySomaZip (reverse a)  (reverse b) )  )

-- Funções auxiliares à função somaBN (começo)
ajustar :: BigNumber -> BigNumber
ajustar []  = []
ajustar [x]
    |x < 10  =  [x]
    |x >= 10  =  [x`mod`10, x`div`10]
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
-- Funções auxiliares à função somaBN (fim)



-- Implementação da função subBN
subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b = reverse (ajustarSub (mySubZip (reverse a)  (reverse b) )  )

-- Funções auxiliares à função mulBN (começo)
ajustarSub :: BigNumber -> BigNumber
ajustarSub []  = []

ajustarSub [x]
    |x > 0 = [x]
    |x < 0 = [x+1]

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
-- Funções auxiliares à função subBN (fim)



-- Funções auxiliares à função mulBN (começo)
simpleMul :: Int -> Int -> Int
simpleMul x y = x * y                               

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
-- Funções auxiliares à função mulBN (fim)

-- Implementação da função mulBN
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
                        


-- Implementação da função divBN
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = (c, subBN a (mulBN c b ) )
    where c = divAux a b [0]

-- Funções auxiliares à função divBN (começo)
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
-- Funções auxiliares à função divBN (fim)



-- Implementação da função safeDivBN
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN x [0] = Nothing
safeDivBN x y = Just (divBN x y)

