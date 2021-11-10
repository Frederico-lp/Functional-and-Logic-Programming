module BigNumbers where
import Data.Text.Internal.Read (digitToInt)
import Text.Printf (IsChar(toChar))

type BigNumber = [Int]


scanner:: String -> BigNumber
scanner n = algarismos (read n::Int)

algarismos :: Int -> [Int]
algarismos x = reverse (algarismosrev x)

algarismosrev :: Int -> [Int]
algarismosrev 0 = []
algarismosrev x = x`mod`10 : algarismosrev  (x`div`10)

output :: BigNumber -> String
output = concatMap show

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN = zipWith (+)

subBN :: BigNumber -> BigNumber -> BigNumber
subBN = zipWith (-)

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN = zipWith (*)

--divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)