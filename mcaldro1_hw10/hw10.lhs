> module Hw10F19
>     where

MARK CALDROPOLI

Rename this file to "hw10.lhs".
Add your code to this file in the positions indicated with "Problem N Answer:".
You will need to remove the spaces before ">" for the types to become part of
your code.

The names of the functions SHOULD NOT BE CHANGED. I may be grading these with
a script - if your code doesn't define the functions with the exact names
specified, they will be assumed skipped.

Once you've finished editing this file, submit it in a tar.gz directory as usual.

Problem 1:
Write a function "sumAll" that takes a list of numbers and returns their sum.
This must be a recursive solution.
Example:
...> sumALL [2,7,4]
13

Problem 1 Answer:

> sumALL :: Num a => [a] -> a
> sumALL [] = 0
> sumALL (h:t) = h + (sumALL t)

Problem 2:
Write a function "binOpALL op lst" that takes an arbitrary binary operator and
a list of numbers and returns the result of applying the 'op' to the values in
list. To make things easy use the prefix notation for the operators,
e.g. (*) 3 2 evaluates to 6.
Example:
...> binOpALL (*) [2,7,4]
56

Problem 2 Answer:

> binOpALL :: Num a => (a -> a -> a) -> [a] -> a
> binOpALL op [] = 0
> binOpALL op [x] = x
> binOpALL op lst = op (binOpALL op (init lst)) (last lst)

Problem 3:
Write a recursive function "insertAt v p lst" that inserts a value v at
position p in list lst. If p is greater than the length of lst, simply
insert it at the end.
Example:
...> insertAt 12 1 [1,2,3]
[1,12,2,3]
...> insertAt 12 10 [1,2,3]
[1,2,3,12]

Remember, Haskell is "pure", so you can not modify lst. Instead, you should
recurse and build a new list from lst with v inserted. 

Problem 3 Answer:

> insertAt :: (Eq a, Num a) => b -> a -> [b] -> [b]
> insertAt v p [] = [v]
> insertAt v p (h:t)
>       | p == 0    = [v,h] ++ t
>       | otherwise = [h] ++ (insertAt v (p-1) t)

Problem 4: Write a function "insert99At p lst" that inserts 99 at position p
in list lst. You must use a partial evaluation of insertAt defined in 
problem 3.
Example:
...> insert99At 1 [1,2,3]
[1,99,2,3]

Problem 4 Answer:

> insert99At :: (Eq a, Num a, Num b) => a -> [b] -> [b]
> insert99At p lst = insertAt 99 p lst

Problem 5. Thompson 10.3
Define a function composeList which composes a list of unary functions into a 
single function. You may assume the list of functions is not empty.
Define composeList using primitive recursion.
Example:
...> composeList [ (*) 2, (*) 2] 2
8
...> composeList [ (-) 3 , (*) 2, (+)5 ] 7 
-21
Notice how in the above example, the output of composeList [ (-) 3, (*) 2, (+) 5]
is the function f(x) = (3 - (2 * (5 + x))).

Problem 5 Answer:

> composeList [x] = x
> composeList (h:t) = h . composeList(t)

Problem 6:
In homework 2 we defined Ackermann's functions as follows  
    ack( m,n ) = n + 1                          if m = 0
    ack( m,n ) = ack(m - 1, 1)                  if n = 0 and m > 0 
    ack( m,n ) = ack( m-1, ack( m, n-1 ) )      if n > 0 and m > 0

Write a Haskell script for implementing the Ackermann's definition.

Problem 6 Answer:

> ack m n
>   | m == 0            = n + 1
>   | n == 0 && m > 0   = ack (m-1) 1
>   | n > 0 && m > 0    = ack (m-1) (ack m (n-1))
