
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