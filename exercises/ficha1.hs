import Distribution.Types.SourceRepo (RepoType(OtherRepoType))
--ORDEM: 1.3; 1.4; 1.6; 1.7; 1.8; 1.9; 1.12; 1.14; 1.15; 1.16
--1.3
metades :: [Int] -> ([Int], [Int])
metades x = (take (length(x)`div`2) x, drop (length(x)`div`2) x)
-- podia usar o fromIntegral

--1.4
--a)
last1 :: [Int] -> Int
last1 x = head(reverse x)

last2 :: [Int] -> Int
last2 x = head(drop( length x- 1 ) x)

--b)
init1 :: [Int] -> [Int]
init1 x = reverse(drop 1 (reverse x))

init2 :: [Int] -> [Int]
init2 x = reverse( tail(reverse x) )

--1.6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = ( -b / (-b + sqrt(2**2 - 4 * a * c) ), -b/ (b + sqrt(2**2 - 4 * a * c)) ) 
--NOTA: posso usar o let e o where para "guardar" restulados, na versade do serve para ajudar
--      na sintaxe, where vem dps da expressao e o let vem antes

--1.7
{-
a)[Char]
b)(Char, Char, Char)
c)[(Bool, Char)]
d)([Bool, Bool], [Char, Char])
e)
f)
-}

--1.8




--1.9
classifica :: Int -> String
classifica x
    |x <= 9 = "reprovado"
    |10 <= x && x <= 12 = "suficiente"
    |13 <= x && x <= 15 = "bom"
    |16 <= x && x <= 18 = "muito bom"
    |19 <= x && x <= 20 = "muito bom com distinção"
    |otherwise = "erro"
--Podia fazer varias classifica com a expressao a frente tb

--1.12
xor :: Bool -> Bool -> Bool
xor True True = False
xor True False = True
xor False True = True
xor False False = False

--1.14
--a)
curta1 :: [a] -> Bool
curta1 x
    |0 <= length(x) && length(x) <= 2 = True
    |otherwise = False 

--b)
curta2 :: [a] -> Bool
curta2 [_,_] = True
curta2 [_] = True
curta2 [] = True
curta2 _ = False




--1.15
mediana :: Int -> Int -> Int -> Int
mediana a b c
    |(a < b && b < c) || (a < c && b < a) = b
    |(b < a && a < c) || (c < a && a < b) = a
    |(b < c && c < a) || (a < c && c < b) = c
    |otherwise = 0


--1.16
{-
converte :: Int -> String
converte a
    |
    -}
