import Stack
import Data.Bool 

checkMod3ThenOdd :: Integral a => [a] -> Bool
checkMod3ThenOdd l = and[mod x 2 == 1| x <- l, mod x 3 == 0]

--UT-9

data Country  = Country { name::String, population::Int, surfaceArea::Float, continent::String } deriving (Show, Eq)
--data Country  = Country name population surfaceArea continent  deriving (Show, Eq)

populationDensity:: Country -> Float
populationDensity c = fromIntegral(population c) / surfaceArea c


--countContinent:: String -> [Country] -> Int
--countContinent 


-- USAR LENGTH FILTER F LISTA PARA FAZER DE CONTADOR

{-
checkParentheses :: [Char] -> Bool
checkParentheses str = checkParenthesesAux str createEmptyStack


checkParenthesesAux :: [Char] -> Stack Char -> Bool
checkParenthesesAux [] st = True
checkParenthesesAux (x:xs) st 
    |x == '(' = 
    |x == ')' = 
        -}





{-
DUVIDAS:
1º
pq data Stack a = St [a] e nao Stack = St [a] ?
pode ter construtor na mm como tem data Country  = Country { name::String, 
    population::Int, surfaceArea::Float, continent::String } deriving (Show, Eq)
portanto qual é a diferença?

2º
data SyntaxTree a = Const a
| Unary (a -> a) (SyntaxTree a)
| Binary (a -> a -> a) (SyntaxTree a) (SyntaxTree a)

o q é aqueles a->a neste caso?






-}


    