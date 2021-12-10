module Stack (Stack, createEmptyStack, isEmpty, push, pop, top) where

data Stack a = St [a]


createEmptyStack :: Stack a
createEmptyStack = St []

isEmpty :: Stack a -> Bool
isEmpty (St []) = True 
isEmpty (St a) = False


push :: a -> Stack a -> Stack a
push a (St s) = St (a:s)

pop :: Stack a -> Stack a
pop (St []) = error "Empty stack"
pop (St (s:ss) ) = St ss

top :: Stack a -> a
top (St []) = error "Empty stack"
top (St (s:ss)) = s


