{-
1.
a) [ [1,2], [], [3,4], [5] ]
b) [3,4] X, inice começa no 0
c) 0 X, length é 2, pelos vistos so no final é q n conta...
d) [16,20,24,28,32]
e) [ (3,4), (4,3), (5,4), (6,5), (5,6), (6,8), (7,10), (8,12), (9,14), etc...] X, y é no maximo 4
f) [2,8,4,6]


g) [(x,6-x) | x<-[0..6]]

h) 15

i) [(Char, String)]

j) (Ord a, Num a) => a -> [a] -> Bool

k) [Bool] -> Bool

l) Eq a => a -> Bool ?????????????????????????????
fix f x = f x == x

-}
fix :: Eq a => (a -> a) -> a -> Bool
fix f x = f x == x

func1 = [[1,2]]++[[]]++[[3,4],[5]]

funcg = [(x,6-x) | x<-[0..6]]

h [] = 1
h [x] = x
h (x:y:xs) = x*y + h (y:xs)


teste = [(x+y,x*y)| x<-[1..4], y<-[x+1..4]]

ig :: [Bool] -> Bool
ig [] = True
ig [x] = True
ig (x1:x2:xs) = x1 == x2 && ig (x2:xs)

--2.
--a)
pitagoras :: Int -> Int -> Int -> Bool
pitagoras a b c
    |a*a + b*b == c = True
    |c*c + b*b == a = True
    |a*a + c*c == b = True
    |otherwise = False

--b)
hipotenusa :: Float -> Float -> Float
hipotenusa a b = sqrt(a*a + b*b)

--3.
--a)
--diferentes :: [a] -> [a]
diferentes [] = []
diferentes [a] = []
diferentes (x:xs)
    |x == head xs = diferentes xs
    |otherwise = x : diferentes xs

--b)
diferentes' xs = [x | (x,y)<- zip xs (tail xs), x /= y]


--4.
zip3' :: Eq a => [a] -> [b] -> [c] -> [(a,b,c)]
--zip3' as bs cs = [ (a,b,c) | a <-as, (b,c)<-zip bs cs]
zip3' xs ys zs = [ (x,y,z) | (x,(y,z)) <- zip xs (zip ys zs)]


--5.

partir ::  Eq a => a -> [a] -> ([a], [a])
partir a [] = ([], [])
partir a x 
    |a == head x =  ([], tail x)
    |a /= head x =  (head x: xi , xd)
    where (xi, xd) = partir a (tail x)
    



--6.
parts:: [a] -> [[[a]]]
parts xs = [take n xs:ps | n <- [1..length xs], ps <- parts (drop n xs)]

