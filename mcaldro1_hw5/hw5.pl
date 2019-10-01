/* MARK CALDROPOLI
   Homework Assignment 5
   Programming Languages
   CS471, Fall 19
   Binghamton University */

/* Instructions */

/* 

After you change the filename to 'hw5.pl', You will be able to code
in and run this file in the Prolog interpreter directly.

We will be using swipl for our Prolog environment: To load/reload this file,
cd to its directory and run swipl. Then, in the prompt, type [hw5].

From then on you may execute queries (goals) in the prompt. As usual, you
should provide your answers in the designated spot. Once you have added some
code to the file, rerun [hw5]. in the swipl prompt to reload.

In addition, there are unit tests for each problem. These are there to help you
better understand what the question asks for, as well as check your code. They
are included in our "database" as queries and are initially commented out
-- % is a Prolog line comment.

%:- member_times(4,[3,3,2,3],0). % SUCCEED
%:- member_times(4,[1,2,3],3) -> fail ; true.   % FAIL

After you have finished a problem and are ready to test, remove the initial %
for each test for the associated problem and reload the assignment file
([hw5].).
Each line should silently load without warnings. If you pass the tests there is a
chance that your code is correct, but it is not guaranteed; the tests are meant
as guided feedback and are not a check for 100% correctness. */

/* Submission */

/* For this assignment -- and the remaining Prolog assignments -- your
submission should only include this source file -- there is no need
to add an additional text file with answers. Please tar and gzip
this file as normal with a name like eway1_hw5.tar.gz. */

/* Homework 5 */

/* Due:Tuesday Oct 1, 2019 11:59 PM */

/* Purpose: To get comfortable with unfication and pattern matching. */

/* Problem 0A (NOT GRADED):
Each line is an individual Prolog query; it's a good idea type them in your prompt (not the file itself) to get a feel for the way Prolog works. You should think about whether or not each query will succeed, and if so how the variables will be initialized (unified). You may find these helpful in solving some of the problems in this assignment.

FYI https://www.swi-prolog.org/pldoc/man?section=builtin is a link to Built-in Predicates help manual.

?- S = 19, V = 3, C is S div V.
?- S = 19, V = 3, C is S // V.
?- S = 19, V = 3, C is S / V.
?- A = zzz, atom(A).
?- N = 23, number(N).
?- A = 12, atom(A).
?- X is pi.
?- sin(pi,X).
?- X is sin(pi).

*/
/* Problem 0B:

 In the assignment 4, you wrote Prolog rules for symbolic differentiation.
 Below is my solutions for this problem. 
 Keep in mind, though, that terms such as U+V are still trees with the functor
 at the root, and that evaluation of such terms requires additional processing
 which you will complete.

 IN ADDITION we will allow variables named 'a' through 'g' for constants. 


 Define the predicate eval(+Expr, ?Value, +VarValue) that uses the result
 from symbolic differentiation  and a list of items with the structure var:value
 (e.g. [a:5,x:6]) and computes the resulting value. e.g.

    ?- d(3*(x +2*x*x),x,Result), VarValue = [x:2,y:5], eval(Result,Value,VarValue).
    Result = 3* (1+ (2*x*1+x*2))+ (x+2*x*x)*0,
    VarValue = [x:2, y:5],
    Value = 27


    ?- d((3*x) ^ 4,x,Result), VarValue = [x:2,y:5] , eval(Result,Value,VarValue).
    Result = 4* (3*x)^3*3,
    VarValue = [x:2, y:5],
    Value = 2592.

 IN ADDITION we will allow variables named 'a' through 'g' for constants.  

 */

/* Problem 0B Answer:  */

d(x,x,1).
d(C,x,0):-number(C).
d(C*x,x,C):-number(C).
d(-U, X, -DU) :- d(U, X, DU).
d( U + V, x, RU + RV ):-d(U,x,RU), d(V,x,RV).
d( U - V, x, RU - RV ):-d(U,x,RU), d(V,x,RV).
d(U * V,x, U * DV + V * DU):- d(U,x,DU), d(V,x,DV).
d(U ^ N, x, N*U ^ N1*DU) :- integer(N), N1 is N-1, d(U, x, DU).

eval(Number, Number, _) :-
    number(Number), !.

eval(Atom, Value, VarDict) :-
    atom(Atom), !,
    member(Atom:Value, VarDict).

eval(Expr, Value, VarDict) :-
    Expr =.. [Op, Arg1, Arg2], !,
    eval(Arg1, Value1, VarDict),
    eval(Arg2, Value2, VarDict),
    OutputExpr =.. [Op, Value1, Value2],
    Value is OutputExpr.

eval(Expr, Value, VarDict) :-
    Expr =.. [Op, Arg1], !,
    eval(Arg1, Value1, VarDict),
    OutputExpr =.. [Op, Value1],
    Value is OutputExpr.

/* Problem 0B Tests:  */
:- eval(x*y, 6, [x:2, y:3]).
:- eval(x*y, 8, [x:2, y:3]) -> fail ; true.
:- eval(x^3, 8, [x:2]).
:- eval(2*8, 16, []).
:- eval(2*8, 0, []) -> fail ; true.
:- eval(2*y, 16, [y:8]).

:- d(3*(x +2*x*x),x,Result), VarValue = [x:2,y:5], eval(Result,Value,VarValue),
    Result = 3* (1+ (2*x*1+x*2))+ (x+2*x*x)*0,
    VarValue = [x:2, y:5],
    Value = 27.

:- d((3*x) ^ 4,x,Result), VarValue = [x:2,y:5] , eval(Result,Value,VarValue),
    Result = 4* (3*x)^3*3,
    VarValue = [x:2, y:5],
    Value = 2592.

/* Problem 1:
In class we discussed that we can encode a binary search tree in Prolog using complex terms: i.e, the following BST

        5
       / \
      3   7
     / \
    1   4

can be encoded as node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)).

Write a predicate insert(+X,+Y,?Z) that succeeds if Z is the tree Y with X inserted (insert X into Y). You may assume you have a binary search tree. */

/* Problem 1 Answer: */

insert(X, node(nil,nil,nil), Ans) :- Ans = node(X,nil,nil).
insert(X, node(Root,nil,R), Ans) :- X < Root, Ans = node(Root,node(X,nil,nil),R).
insert(X, node(Root,L,nil), Ans) :- X > Root, Ans = node(Root,L,node(X,nil,nil)).
insert(X, node(Root,L,_), node(_,L2,_)) :- X < Root, insert(X, L, L2).
insert(X, node(Root,_,R), node(_,_,R2)) :- X > Root, insert(X, R, R2).

/* Problem 1 Test: */
:- insert(3,node(5,nil,nil),X), X = node(5,node(3,nil,nil),nil).     %SUCCEED
:- insert(7,node(5,nil,nil),X), X = node(5,nil,node(7,nil,nil)).     %SUCCEED
:- insert(1,node(5,node(3,nil,nil),node(7,nil,nil)),X), X = node(5,node(3,node(1,nil,nil),nil),node(7,nil,nil)).                 %SUCCEED
:- insert(1,node(5,node(3,node(2,nil,nil),nil),node(7,nil,nil)),X), X = node(5,node(3,node(2,node(1,nil,nil),nil),nil),node(7,nil,nil)). %SUCCEED

:- (insert(3,node(5,node(3,node(2,nil,nil),nil),node(7,nil,nil)),X), X = node(5,node(3,node(2,node(3,nil,nil),nil)),node(7,nil,nil))) -> fail ; true. %FAIL


/* Problem 2:
Using the same encoding for a binary search tree, write a predicate to_list(+X,?Y) that succeeds if Y is an in-order list of the elements of all the nodes of tree X (Y should show an inorder traversal of X). If you are rusty and do not remember what an inorder traversal is, give https://en.wikipedia.org/wiki/Tree_traversal#In-order a quick glance.

For example...
to_list(node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)),X) will succeed with X = [1,3,4,5,7]. */

/* Problem 2 Answer:  */

to_list(nil,[]).
to_list(node(Root,L,R),List) :- to_list(L,LList), to_list(R,RList), append(LList,[Root|RList], List).

/* Problem 2 Tests:  */
:- to_list(node(3,nil,nil),L), L = [3]. %SUCCEED
:- to_list(node(5,node(3,nil,nil),nil),L), L = [3,5].  %SUCCEED
:- to_list(node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)),L), L = [1,3,4,5,7]. %SUCCEED

:- (to_list(node(3,nil,nil),L), L = [5]) -> fail ; true.


/* Problem 3:
Write a predicate right_rotate(?X,?Y) that succeeds if Y is the tree X rotated right at its root. Read https://en.wikipedia.org/wiki/Tree_rotation to refresh tree rotation in full. This problem may seem hard at first, but once you "see" the answer it really demonstrates the elegance of unfication/pattern matching. You do not need to handle error cases.

For example, the following shows a right rotation at the root.

        5                        3
       / \                      / \
      3   7         -->        2   5
     / \                          / \
    2   4                        4   7

*/

/* Problem 3 Answer: */

right_rotate(node(Root,node(LRoot,LList,RList),X), node(LRoot,LList,node(Root,RList,X))).

/* Problem 3 Test: */
:- right_rotate(node(5,node(3,node(2,nil,nil),node(4,nil,nil)),node(7,nil,nil)),X), X = node(3, node(2, nil, nil), node(5, node(4, nil, nil), node(7, nil, nil))). %SUCCEED
:- right_rotate(node(5,node(3,nil,node(4,nil,nil)),node(7,nil,nil)),X), X = node(3, nil, node(5, node(4, nil, nil), node(7, nil, nil))). %SUCCEED
:- right_rotate(node(3,node(2,node(1,nil,nil),nil),nil),X), right_rotate(X,Y), Y = node(1,nil,node(2,nil,node(3,nil,nil))). %SUCCEED

:- right_rotate(node(5,nil,node(7,nil,nil)),_) -> fail ; true. %FAIL

/* Problem 4:
We will encode a mini-AST in Prolog using complex data structures. A "node" will consist of either a ast(Functor,LeftExpr,RightExpr), ast(Functor,Expr) or ast(Number).  Note a Number can be a number, pi or e.

ast(Functor,LeftExpr,RightExpr) -- "abstract syntax tree binary node", Functor is guaranteed to be a binary arithmetic predicate that can be evaluated with `is`. LeftExpr and RightExpr are recursively defined "nodes".

ast(Functor,Expr) -- "abstract syntax tree node unary", Functor is guaranteed to be a unary arithmetic predicate that can be evaluated with `is`. Expr is a recursively defined "node".

ast(Number) -- "node number", Number or pi or e is guaranteed to be just that.

Hence, the following AST
       *
     /   \
   min    -
   / \   / \
 -3   2 5  -
          /
         2
would be encoded as ast('*', 
                     ast(min, ast(-3), ast(2)), 
                     ast('-',ast(5), ast('-', ast(2)))
                    )

Write a predicate run(+X,?Y) that succeeds if Y is the result obtained from "running" (evaluating) X. You will need to use the =.. predicate. It may be helped to view some of the binary and unary arithmetic predicates -- http://www.swi-prolog.org/man/arith.html. Your predicate should involve "is" to do arithmetic -- you shouldn't need to implement a different calculation for every possible operator. */

/* Problem 4 Answer: */

run(ast(X),X).
run(ast(Op,X),Res) :- run(X,X2), F =.. [Op,X2], Res is F.
run(ast(Op,L,R),Res) :- run(L,L2), run(R,R2), F =.. [Op,L2,R2], Res is F.

/* Problem 4 Tests: */

:- run(ast(float, ast(sin, ast('/', ast(pi), ast(2))) ),E), E = 1.0. %SUCCEED
:- run(ast(+,ast(*,ast(2),ast(3)),ast(random,ast(5))),_).   %SUCCEED
:- run(ast(+,ast(*,ast(2),ast(3)),ast(3)),E), E=9.   %SUCCEED
:- run(ast(+,ast(*,ast(2),ast(3)),ast(-,ast(6),ast(3))),E), E=9.   %SUCCEED
:- run(ast(2),E), E=2.   %SUCCEED
:- run(ast(abs,ast(-2)),E), E=2.   %SUCCEED

:- (run(ast(+,ast(*,ast(2),ast(3)),ast(-,ast(6),ast(3))),E), E=8) -> fail ; true.  %FAILS

/* Problem 5:
Using the AST as described in problem 5, write a predicate binaryAP/2. (binary All Predicates).
binaryAP(+AST, ?BPlst) succeeds if all the binary arithmetic predicates that occur in AST are collected into BPlst.
BPlst should not include any unary predicates. Use an inorder traversal of AST.  */

/* Problem 5 Answer: */

binaryAP(ast(_),[]).
binaryAP(ast(_,Y),List) :- binaryAP(Y,List).
binaryAP(ast(X,L,R),List) :- binaryAP(L,L2), binaryAP(R,R2), append(L2,[X|R2],List).

/* Problem 5 Tests: */
:- T = ast(+,ast(*,ast(2),ast(3)),ast(random,ast(5))), binaryAP(T,L), L = [*, +].  %SUCCEED
:- T = ast(+, ast(*, ast(2), ast(3)), ast(-,ast(3), ast(5))),  binaryAP(T,L), L = [*, +, -]. %SUCCEED
:- T = ast(+, ast(*, ast(2),  ast(-,ast(3), ast(//, ast(2), ast(5)))),ast(9)) ,  binaryAP(T,L), L = [*, -, //, +]. %SUCCEED

:- (T = ast(+,ast(*,ast(2),ast(3)),ast(random,nn(5))), binaryAP(T,L), L = [+,*]) -> fail ; true.      %FAIL

/* Problem 6:
   Write a predicate numAtoms/2.  numAtoms(+NestedLists, ?C) that counts the atoms in the
   NestedLists. The NestedLists contains only lists or atoms.  You may assume that no numbers
   or variables are in any of the lists.

   ?- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],C).
   C = 12.
   ?- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,[[]],b]],C).
   C = 11.

   Think What NOT how.  */

/* Problem 6 Answer: */

 numAtoms([],0) :- !.
 numAtoms(X,1) :- atom(X).
 numAtoms([H|T],N) :- numAtoms(H,X), numAtoms(T,Y), N is X + Y.

/* Problem 6 Tests: */
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],12).
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],19) -> fail ; true.
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],10) -> fail ; true.
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,[[]],b]],11).
:- numAtoms([r], 1).
:- numAtoms([r], 3) -> fail ; true.
:- numAtoms([[[r]]], 1).

/* Problem 7:

Write a predicate change/2 that given the change amount, computes the way in which exact change can be given. Use the following USA's coin facts at your solution. */

coin(dollar, 100).
coin(half, 50).
coin(quarter, 25).
coin(dime,10).
coin(nickel,5).
coin(penny,1).

/* The predicate change(+S,-CL) succeeds if given a positive integer S, CL is a list of tuples that contains the name of the coin and the number of coins needed to return the correct change.
The change should be in the smallest number of coins, ie if we have 5 cents,
the first output should be (nickel, 1) not (penny, 5).
However, it is okay if alternative change combinations still unify, that is,
different combinations come up if you use a semicolon:
?- change(5,CL).
CL=[(nickel,1)] ;
CL=[(penny,5)].
?- change(5,[(penny,5)]).
true.

The Coin Changing problem is an interesting problem usually studied in Algorthms.
http://condor.depaul.edu/~rjohnson/algorithm/coins.pdf is a nice discussion.
Think about (no need to turn in)
   1) How could we generalize this problem to handle coins from other currencies?
   2) What are the different techinques to find the change with the fewest number of coins ?
   3) What happens if the order of the "coin" facts change?  */

/* Problem 7 Answer: */

change(0,[]).
change(X, [(CoinType, NumCoins)|T]) :-
    coin(CoinType, Value),
    X >= Value,
    NumCoins is div(X, Value),
    Left is mod(X, Value),
    change(Left, T).

/* Problem 7 Tests: */
:- change(168,C), C = [ (dollar, 1), (half, 1), (dime, 1), (nickel, 1), (penny, 3)] .  %SUCCEED
:- change(75,C),  C = [ (half, 1), (quarter, 1)] .                                     %SUCCEED

:- (change(75,C), C = [(half, 2)]) -> fail ; true.             %FAIL

/* Problem 8:

In class we discussed difference lists and how to append two of them in "constant" time.

Write a predicate, append3DL(+A,+B,+C,?D) that succeeds if D is the difference lists A, B, and C appended.
*/

/* Problem 8 Answer: */

append3DL(A-B,B-C,C-D,A-D).

/* Problem 8 Tests: */
:- append3DL([1,2|A]-A,[3,4|B]-B,[5,6|[]]-[],L), L = [1,2,3,4,5,6]-[]. % SUCCEED
:- append3DL([a,b|A]-A,[b,1,2|B]-B,[3|C]-C,L), L = [a, b, b, 1, 2, 3|C]-C. % SUCCEED

:- (append3DL([1,2|A]-A,[3,4|B]-B,[5,6|[]]-[],L), L = [1,2,3,4,5]-[]) -> fail ; true.  % FAIL

