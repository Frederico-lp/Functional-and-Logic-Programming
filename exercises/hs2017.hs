{-
1.
a)[1,5,4,3]

b)[5,6,9]

c)[2,3] MAL!!, se fosse : era assim, com ++ fica tudo na mm lista

d) [15,18,21,24,27,30]

e) 4


j) ([Char], [Float])
([’1’,’2’,’3’],[1.0,2.0,3.0])

k) (a, a) -> a
fst (x,y) = x

l) Ord a => a -> a -> a-> Bool
h x y z = x >= z && y <= z

m) [a] -> a
f xs = xs!!2
-}

funcg = [x*(-1)^x |x<-[0..10] ]

fun :: ([Char], [Float])
fun = (['1','2','3'],[1.0,2.0,3.0])

fst :: (a, a) -> a
fst (x,y) = x

h:: Ord a => a -> a -> a-> Bool
h x y z = x >= z && y <= z

f :: [a] -> a
f xs = xs!!2


--2.
numEqual:: Eq a => a-> a-> a -> Int
numEqual a b c
    |a == b && b ==c = 3
    |a == b && b /= c = 2
--  etc fds

--3.
--n interessa

--4.
enquantoPar = takeWhile even


--5.
natZip :: [a] -> [(Int, a)]
natZip ys= [(x, y) | (x,y)<-zip lista ys ]
    where lista = [1..length ys]

--6.
--a)
quadrados :: [Int] -> [Int]
quadrados [] = []
--quadrados [x] = [x^2]
quadrados (x:xs) = x^2: quadrados xs

quadrados' :: [Int] -> [Int]
quadrados' xs = [x *x | x<-xs]