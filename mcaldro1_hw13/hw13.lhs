> module Hw13
>    where

MARK CALDROPOLI

> hLen :: (Num u, Eq t) => ([t] -> u) -> [t] -> u 
> hLen = (\f x -> if x == [] then 0 else 1 + (f (tail x)))
> myLength ls = if ls == [] then 0 else 1 + myLength (tail ls)

> factorial :: Integral a => a -> a
> factorial n = if n == 0 then 1 else n * (factorial (n - 1))

> hFact :: Integral a => (a -> a) -> a -> a
> hFact = (\f n -> if n == 0 then 1 else n * (f (n-1)))

> factorial' = hFact factorial'

> fix f = f (fix f )
