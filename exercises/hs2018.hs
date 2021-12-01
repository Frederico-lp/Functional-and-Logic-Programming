{-
1.
a)[[1,2,3],[],[4,5]]
b)5
c) [8,6,4,2,0]
d) 9
e) [ (1,1), (2,1), (3,1), (4,1), (2,2), (3,2), (4,2)]
f) [2, 4, 8, 16, 32]
g) [2^x - 1 | x<-[1..10]]
h) 15
i) a ([Bool],[Char]):
j) a -> b -> (a,b)
k) Eq a => [a] -> [a] -> [a]
l) Eq a => [a] -> a
feql xs = head xs == head (reverse (tail xs))

-}

feql :: Eq a => [a] -> Bool
feql xs = head xs == last (tail xs)

p :: a -> b -> (a, b)
p x y = (x,y)

funcg = [2^x - 1 | x<-[1..10]]

f [] = 1
f [x] = x
f (x:xs) = x + f xs

test :: ([Bool], [Char])
test = ([False ,True],['1','2'])


h :: Eq a => [a] -> [a] -> [a]
h [] l = l
h [x] l = x:l
h (x:y:ys) l = if x == y then h ys (x:l) else h (y:ys) (x:l)

--2.
--a)
distancia :: (Float, Float) -> (Float, Float) -> Float
distancia (x1,y1) (x2,y2) = sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1))

--b)
--colineares


--3.
--a)
niguais :: Int -> a -> [a]
niguais 0 _ = []
niguais a x = x : niguais (a-1) x


--b)
niguais' :: Int -> a -> [a]
niguais' a x = [xs | xs<-[x], _<-[1..a] ]

--4.
merge' :: (Eq a ,Ord a) => [a] -> [a] -> [a]
merge' [] [] = []
merge' a [] = a
merge' [] b = b
merge' (x:xs) (y:ys)
    |x < y = x : merge' xs (y:ys)
    |x > y = y : merge' (x:xs) ys
    |otherwise = x : merge' xs (y:ys)


--5.
lengthZip :: Eq a => [a] -> [(Int, a)]
lengthZip [x] = [(1, x)]
lengthZip x
    |length x > 1 = (length x, head x ): lengthZip (tail x)

lengthZip' :: Eq a => [a] -> [(Int, a)]
lengthZip' xs = [(x,y) | (x,y)<-zip len xs  ]
    where len = [length xs, length xs - 1 .. 0]

--6.





