> module Hw11F19
>    where

MARK CALDROPOLI

Problem 1: (This is problem 3 done in lab)
(from https://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
"In mathematics, the Thue-Morse sequence, or Prouhet-Thue-Morse sequence, is a 
binary sequence that begins:

  0 01 0110 01101001 0110100110010110 01101001100101101001011001101001 ...

  (if your sequence starts with one..)
  1 10 1001 10010110 1001011001101001 ...

"Characterization using bitwise negation

The Thueâ€“Morse sequence in the form given above, as a sequence of bits, 
can be defined recursively using the operation of bitwise negation. So, the 
first element is 0. Then once the first 2n elements have been specified, 
forming a string s, then the next 2n elements must form the bitwise negation of 
s. Now we have defined the first 2n+1 elements, and we recurse.

Spelling out the first few steps in detail:

    * We start with 0.
    * The bitwise negation of 0 is 1.
    * Combining these, the first 2 elements are 01.
    * The bitwise negation of 01 is 10.
    * Combining these, the first 4 elements are 0110.
    * The bitwise negation of 0110 is 1001.
    * Combining these, the first 8 elements are 01101001.
    * And so on.
So
    * T0 = 0.
    * T1 = 01."
    
Define a primitive recursive function 'thue' given the nth thue element returns
the next thue element. The elements will be represented as a list of 0s and 1s.
e.g.
   Hw11F19> thue [0,1,1,0]
   [0,1,1,0,1,0,0,1]

Problem 1 Answer:

> thue lst = lst ++ thue_recursive lst
> thue_recursive [] = []
> thue_recursive (0:tail) = 1:thue_recursive tail
> thue_recursive (1:tail) = 0:thue_recursive tail

Problem 2: 
Implement Newton's method for calculating the square root of N. Your definition should use primitive recursive style. See (http://bingweb.binghamton.edu/~head/CS471/HW/Haskell2F19.html) webpage for definition of Newton method for the approximation of roots. 
Your definition should include a user defined (input) "guess" value and a user defined "nearEnough" value.  
 "nearEnough" is use to determine when the guess is close enough to the square root. (guess*guess = number) 
You should use locally defined helper functions to make your code more readable. 
You may use guards or "if expression"

e.g. 
   Hw11F19> newtonAppr 144 1 0.1             
   12.000545730742438 
   Hw11F19> newtonAppr 144 1 0.0001
   12.0000000124087
   Hw11F19> newtonAppr 144 1 0.000000000000001
   12.0
   Hw11F19> newtonAppr 5e+30 1 1000000000000000000000000000000  
   2.317148867384728e15
   Hw11F19> newtonAppr 5e+30 1 100000000000000000000000000    
   2.2360684271923805e15

Problem 2 Answer:
Note you may have a slightly different type depending on your solution.

> makeGuess x guess = ((x / guess) + guess) / 2
> newtonAppr :: (Fractional a, Ord a) => a -> a -> a -> a
> newtonAppr square guess nearEnough
>       | value <= nearEnough   = guess
>       | otherwise             = newtonAppr square (makeGuess square guess) nearEnough
>       where value             = (abs ((guess * guess) - square))

Problem 3:
A Define sumHarmonic using a simple recursive style:

The harmonic series is the following infinite series:
                            1   1   1   1               1
                      1 +   - + - + - + - + ...   + ... - ..
                            2   3   4   5               i
(http://en.wikipedia.org/wiki/Harmonic_series_(mathematics))
Write a function sumHarmonic such that sumHarmonic i is the sum of the first i
terms of this series. For example, sumHarmonic 4 ~> 1 + 1 + 1 + 1 ~> 2.08333...
                                                        2   3   4

Problem 3 Answer:
Note you may have a slightly different type depending on your solution.

> sumH :: (Ord p, Fractional p) => p -> p
> sumH x
>   | x < 1     = error "must be > 0"
>   | x == 1    = 1
>   | x > 1     = (1/x) + sumH (x-1)

Problem 4:
 a) Define the sum of the squares of the natural numbers 1 to n you should use
    map and foldr.
   (Complete this definition 
      > sumSq n =  

      Hw11F19> sumSq 4
      30

  b) Define the sum of the squares of natural numbers from a list. You should
     use map and foldr and (.). You should NOT have explicit arguments.  
   (Complete this definition 
      > sumSq2 = ???


      Hw11F19> sumSq2 [1,5,2]
      30

Problem 4 Answer:

> sumSq n = foldr (+) 0 (map (^2) [1..n])
> sumSq2 = foldr (+) 0 . map (^2) 

Problem 5: (from http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
In problem 1 you wrote a primitive recursive function to produce the next
element in the Thue-Morse sequence, (also know as Prouhet-Thue-Morse sequence)


  a) Redefine thue using 'map' instead of explicit recursion. My solution 
     was coded using (++), map, lambda expression and mod. Call this
     function 'thueMap'. This can be done with 1 line of code.

  b) Define thueSeq which is a sequence of "thue elements" using the circular
     list illustrated in class for fibseq
     (http://bingweb.binghamton.edu/~head/CS471/NOTES/HASKELL/4hF02.html)
     You may use thue OR thueMap in your definition of thueMap. Your solution
	 should use zipWith similar to fibseq.
	 This can be done with one line of code.
 
     *.......> thueMap [0,1,1,0,1,0,0,1]
      [0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0]
     *.......> take 4 thueSeq 
      [[0],[0,1],[0,1,1,0],[0,1,1,0,1,0,0,1]]

Your answer should define thueMap and thueSeq.

Problem 5 Answer:  

> thueMap lst = lst ++ (map (\x -> if x == 0 then 1 else 0) lst)
> thueSeq = [0]:[0,1]:[x | x <- map thueMap (tail thueSeq)]
  
Problem 6:
Using a fold in your solution:

a) Define "allTrue" to evaluate a list of expression of Bools to True if all 
   the expression in a list are true. Your definition 
   should be a curried (partially evaluated) function.
   (i.e. do not have an explicit parameters. allTrue = ???)

b)  define "noneTrue" which evaluates to True if none of the boolean 
    expression in a list are true. Your definition 
   should be a curried (partially evaluated) function.
   (i.e. do not have an explicit parameters. noneTrue = ???)
   (Hint: You should use compose to 
    "glue" some of the functions so you don't need explicit parameters.)

Your answer should define allTrue and noneTrue.
	
Problem 6 Answer:  

> allTrue :: (Foldable t0) => t0 Bool -> Bool
> allTrue = (\x -> foldl1 (&&) x)
> noneTrue = (\x -> foldl1 (&&) (map not x))

Problem 7: Write new definition of this function, func, called funcR:

> func = \xs -> [ x * 2 | x <- xs, x > -1 ]
  
   ...> func [1,20,-3,15,2]
   [2,40,30,4]


   Using explicit recursion and pattern-matching, without guards
   -- OR --
   using explicit recursion with guards but without pattern-matching. You
   may use explicit arguments.

   
Problem 7 Answer:  

> funcR :: (Ord t, Num t) => [t] -> [t]
> funcR [] = []
> funcR (x:xs)
>   | x > -1    = x*2:funcR xs
>   | otherwise = funcR xs

Problem 8:
Define a function replicate' which given a list of numbers returns a 
list with each number duplicated its value. The ' is not a typo - this is to
avoid the existing replicate.
Use primitive recursion in your definition.
You may use a nested helper definition.
Example:
...> replicate' [2, 4, 1]
[2,2,4,4,4,4,1]

Problem 8 Answer:

> replicate' :: (Ord a, Num a) => [a] -> [a]
> replicate' lst = rep_helper lst 0
> rep_helper [] 0 = []
> rep_helper lst n
>       | n < (head lst) = (head lst):rep_helper lst (n+1)
>       | n == (head lst) = rep_helper (tail lst) 0

Problem 9: Redo problem 8. Call the new function replicateLC. Your definition
should use list comprehension.

Problem 9 Answer:

> replicateLC lst = [x | x <- lst, _ <- [1..x]]
