module BigNumbers where
import Data.Text.Internal.Read (digitToInt)
import Text.Printf (IsChar(toChar))

type BigNumber = [Int]

scanner:: String -> BigNumber
scanner n = algarismos (read n::Int)

algarismos :: Int -> [Int]
algarismos x
    |x > 0 = reverse (algarismosrev x)
    |x < 0 = negate (head ((reverse (algarismosrev x))) ) : tail (reverse (algarismosrev x))
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
somaBN = checkSum(zipWith (+))

checkSum :: BigNumber -> BigNumber
checkSum x. = [] 

subBN :: BigNumber -> BigNumber -> BigNumber
subBN = zipWith (-)

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN = zip (*) 

divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = (y , z)
    where y = zipWith (div) a b
          z = zipWith (mod) a b
