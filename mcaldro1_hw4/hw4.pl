/* MARK CALDROPOLI
   Homework Assignment 4 - Prolog 2
   Programming Languages
   CS471, Fall 2019
   Binghamton University */

/* Instructions */

/* 
After you change the filename to 'hw4.pl', You will be able to code
in and run this file in the Prolog interpreter directly.

We will be using swipl for our Prolog environment: To load/reload this file,
cd to its directory and run swipl. Then, in the prompt, type [hw4].

From then on you may execute queries (goals) in the prompt. As usual, you
should provide your answers in the designated spot. Once you have added some
code to the file, rerun [hw4]. in the swipl prompt to reload.

In addition, there are unit tests for each problem. These are there to help you
better understand what the question asks for, as well as check your code. They
are included in our "database" as queries and are initially commented out
-- % is a Prolog line comment.

%:- member_times(4,[3,3,2,3],0). % SUCCEED
%:- member_times(4,[1,2,3],3).   % FAIL

After you have finished a problem and are ready to test, remove the initial %
for each test for the associated problem and reload the assignment file
([hw4].). Each SUCCEED line should silently load and succeed, and each FAIL
line should throw a WARNING. If a SUCCEED line throws a WARNING, or a FAIL line
fails to, then you solution is not correct. If you pass the tests there is a
good chance that your code is correct, but not guaranteed; the tests are meant
as guided feedback and are not a check for 100% correctness. */

/* Submission */

/* For this assignment -- and the remaining Prolog assignments -- your
submission should only include this source file -- there is no need
to add an additional text file with answers. Please tar and gzip
this file as normal with a name like eway1_hw4.tar.gz. */

/* Homework 4 */

/* Due: Tuesday, Sept. 24 */

/* Purpose: To get comfortable with backtracking, recursion,
   become familar with reflective mechanism of Prolog,
   and Prolog as a symbolic programming language.
*/

my_append([],Ys,Ys).
my_append([X|Xs],Ys,[X|Zs]) :- my_append(Xs,Ys,Zs).

my_prefix(_,[]).
my_prefix([X|Xs], [X|Ys]) :- my_prefix(Xs,Ys).


/* Problem 0A (NOT GRADED):
Using the preceding predicates, draw the execution trees for the following
queries (goals). You should also enter the queries in swipl to test.

my_append([a,b],[c],Z).
my_append(Xs,[c],[a,b,c]).
my_append(Xs,Ys,[a,b,c]).
my_prefix([a,b,c],Z).

After drawing the execution trees, enable tracking on my_append and my_prefix
by running (two separate queries)

trace(my_append).
trace(my_prefix).

in swipl. Now, execute the above queries and try and match what you drew to
the way the actual query is executed in swipl. To turn off 'trace', type the
query 'nodebug'.

If you prefer a graphical debugger/trace, enter the query 'manpce.' . You will
see a small XPCE manual window. Under the 'Tools' menu select: "Prolog
graphical tracer".

*/

/* Problem 0B (NOT GRADED):
   Each line is an individual Prolog query; it's a good idea type them in your
   prompt (not the file itself) to get a feel for the way Prolog works. You
   should think about whether or not each query will succeed, and if so how the
   variables will be initialized (unified). It will help in doing some of the
   problems.

?- number(A), A = 5.6.
?- A = 5.6, number(A).
?- integer(4).
?- help(functor).
?- functor(foo(a,b,c),F,N).
?- functor(T,foo,3).
?- help(arg).
?- arg(3, foo(a,b,c),A).
?- help('=..').
?- T =.. [foo,x, y, z].
?- E =.. ['+',2,3], R is E.
?- foo(who, what) =.. T.
?- foo(who, what) =.. [A, B,C].
?- clause(ack(M,0,B),C).
?- clause(H,(B is 2*0)).
*/


/* Problem 1:
   A) What is the mathematical definition of:
     a) a relation?
     b) a function?
   B) Is every function a relation? If false, give a counter example.
   C) Is every relation a function? If false, give a counter example. */
	
/* Problem 1 Answer: */

/* Problem 2:
   Define homoiconic.
   Is Prolog homoiconic?
   What does it mean to say a language is fully reflective?
   Is Prolog fully reflective?

   (See page 584 and Chapter 12)
*/

/* Problem 2 Answer: */


/* Problem 3:
   Write a predicate prodlist(+List,?prod) which succeeds if prod is the total 
   product of all the elements of List. This will be a top down recursion.
   The recursion clause will add the current value to the result of the prod
   of the rest of the list.
   We have already provided the base case for this predicate underneath
   'Problem 3 Answer'. You just need to add the recursive clause.
*/

/* Problem 3 Answer */

prodlist([], 1).
prodlist([X|Xs], Y) :- prodlist(Xs, Z), Y is X * Z.

/* Problem 3 Test */
/* There should be no warnings when compiling,
   tests which are supposed to fail are written as such */

:- prodlist([], 1).
:- prodlist([], 0) -> fail ; true.
:- prodlist([1,2,3,4],24).
:- prodlist([0], 0).


/* Problem 4:
   Write the predicate prodlist2(+List,?prod) which succeeds if prod is the prod 
   total of all the elements of List. Instead of multiplying the current value 
   to the result of the prod of the tail, you will calculate the partial product
   of the all the elements you have reached so far. You will need an extra 
   argument to store the partial product, so you will write an auxilitary 
   predicate prodlist2/3 to handle the extra argument.

   Underneath 'Problem 4 Answer' we have provided prodlist2/2, which calls the
   auxiliary predicate prodlist2/3. We have also provided the base case for the
   auxiliary predicate. You just need to add the recursive clause for
   prodlist2/3.

*/

/* Problem 4 Answer */

prodlist2(List,Prod) :- prodlist2(List, 1, Prod).
prodlist2([], Prod, Prod).
prodlist2([X|Xs], Y, Z) :- Val is X * Y, prodlist2(Xs, Val, Z).

/* Problem 4 Test */

:- prodlist2([], 1).
:- prodlist2([], 0) -> fail ; true.
:- prodlist2([1,2,3,4], 24).
:- prodlist2([0], 0).


/* Problem 5:
   Write the predicate prodPartialR(+N, ?ProdLst), which succeeds as follows:
   given a number N, ProdLst is a sequence of prods such that first number in
   ProdLst is the prod of all the numbers from N to 1 (ie N!), the second number
   is the prod of all the numbers from N-1 down to 1 (ie (N-1)!), and so on.
   In other words, ProdLst = [N*(N-1)*..*1, (N-1)*(N-2)*..*1, ..., 1].
   For example:

     ?- prodPartialR(5,P).
     S = [120, 24, 6, 2, 1] .

   This problem can be solved in 2 clauses.
*/

/* Problem 5 Answer */

prodPartialR(1,[1]).
prodPartialR(_,[X,Y|Z]) :- N is (X/Y)-1, prodPartialR(N,[Y|Z]).

/* Problem 5 Test */

:- prodPartialR(1, [1]).
:- prodPartialR(1, []) -> fail ; true.
:- prodPartialR(3, [6, 2, 1]).
:- prodPartialR(5, [120, 24, 6, 2, 1]).

/* Problem 6:
   Write the predicate prodPartialL(+N, ?ProdLst). This problem is very similar to
   Problem 5, but with one key difference: the prod totals accumulate from left
   to right, so the ProdLst generated will be different. For example, the first
   value will be N, the second value will be N * (N-1), and so on.
   In other words, ProdLst = [N, N*(N-1), ..., N*(N-1)*(N-2)*...*1].
   For example,

     ?- prodPartialL(5,P).
     P = [5, 20, 60, 120, 120]

   It could be helpful to follow the idea to use an auxiliary predicate used in
   problem 4. So your first clause should be:

       prodPartialL(N,Lst):-prodPartialL(N,N,Lst).

   You need to add 2 additional clauses.*/

/* Problem 6 Answer */

 prodPartialL(N,Lst) :- prodPartialL(N,N,Lst).
 prodPartialL(1,N,[N]).
 prodPartialL(_,X,[X,Y|Z]) :- N is Y/X, prodPartialL(N,Y,[Y|Z]).

/* Problem 6 Test */

:- prodPartialL(1, [1]).
:- prodPartialL(1, []) -> fail ; true.
:- prodPartialL(5, [5, 20, 60, 120, 120]).

/* Problem 7:
   (From Learn Prolog NOW!) Binary trees are trees where all internal nodes have 
   exactly two children. The smallest binary trees consist of only one leaf node.
   We will represent leaf nodes as leaf(Label). For instance, leaf(3) and leaf(7)
   are leaf nodes, and therefore small binary trees. Given two binary trees B1 
   and B2 we can combine them into one binary tree using the predicate tree: 
   tree(B1,B2). So, from the leaves leaf(1) and leaf(2) we can build the binary
   tree tree(leaf(1), leaf(2)). And from the binary trees tree(leaf(1), leaf(2)) 
   and leaf(4) we can build the binary tree
   tree(tree(leaf(1), leaf(2)), leaf(4)).

Now define a predicate isBinaryTree(+BT) which succeeds if BT is a binary tree. The "+" indicates that it is assumed BT is instantiate in the query.
For example:
If BT = tree( leaf(1), tree( leaf(2),leaf(4)) ), then isBinaryTree(BT) succeeds.

*/

/* Problem 7 Answer: */

isBinaryTree(leaf(_)).
isBinaryTree(tree(X,Y)) :- isBinaryTree(X), isBinaryTree(Y).

/* Problem 7 Test: */
:- isBinaryTree(leaf(1)).                                                                       %SUCCEED
:- isBinaryTree(tree(leaf(a),leaf(b))).                                                         %SUCCEED
:- BT = tree( leaf(b), tree( leaf(x),leaf(y)) ), isBinaryTree(BT).                              %SUCCEED
:- BT = tree(tree(leaf(9), leaf(2)), tree(leaf(3), tree(leaf(4), leaf(1)))), isBinaryTree(BT).  %SUCCEED
:- isBinaryTree( tree(leaf(1)) ).                                                               % FAIL
:- isBinaryTree( tree() ).                                                                      % FAIL

/* Problem 8:
(Exercise 3.5 from Learn Prolog Now!)
   Problem 8 uses the same idea of a binary tree as problem 7.
   Define a predicate swap/2, which produces the mirror image of the binary
   tree that is its first argument. For example:

?- swap( tree( tree(leaf(1), leaf(2)), leaf(4)), T).
T = tree( leaf(4), tree(leaf(2), leaf(1))).
*/

/* Problem 8 Answer: */

swap(leaf(X),leaf(X)).
swap(tree(X,Y),tree(YSwapped,XSwapped)) :- swap(X,XSwapped), swap(Y,YSwapped).

/* Problem 8 Test: */
:- swap( tree( tree(leaf(1), leaf(2)), leaf(4)), T), T  =  tree( leaf(4), tree(leaf(2), leaf(1))).
:- swap(leaf(1), leaf(1)).
:- swap(tree(leaf(1), leaf(2)), tree(leaf(1), leaf(2))) -> fail ; true.


/* Problem 9:
   We will use a predicate edge(X,Y) to encode a graph.
   edge(X,Y) is true if there is a directed edge from X to Y.
   The following is a mini graph encoded in Prolog. */

edge(a,b).
edge(a,e).
edge(b,a).
edge(b,c).
edge(b,d).
edge(c,e).
edge(f,e).

/* Using your knowledge of backtracking and the findall predicate, write
   predicates outgoing/2 and incoming/2.

   outgoing(X,Y) should succeed if Y is a list of all immediate vertices
   reached from X's outgoing edges. incoming(X,Y) should succeed if Y is a
   list of all vertices that have outgoing edges to X.
*/

/* Problem 9 Answer */

outgoing(X,Y) :- findall(Z,edge(X,Z),Y).
incoming(X,Y) :- findall(Z,edge(Z,X),Y).

/* Problem 9 Test */
:- outgoing(a,X), X = [b,e].
:- outgoing(e,X), X = [].
:- outgoing(b,X), X = [a,c,d].
:- incoming(a,X), X = [b].
:- incoming(f,X), X = [].

:- outgoing(e,X), X = [a] -> fail ; true.
:- incoming(e,X), X = [] -> fail ; true.



/* Problem 10:
   Write a predicate computeS/4. computeS(Op, Arg1, Arg2, Result) succeeds if
   Result is the value after computing Arg1 Op Arg2. Use the insight you gained
   in Problem 0B. Op must be a builtin Prolog operator.
*/

/* Problem 10 Answer: */

computeS(Op, Arg1, Arg2, Result) :- X =.. [Op, Arg1, Arg2], Result is X.

/* Problem 10 Test: */
:- computeS(-, 19, 7, 12).
:- computeS(div, 19, 7, 2).
:- computeS(div, 19, 7, R), R = 2.

:- computeS(/, 19, 7, 2) -> fail ; true.
:- catch((computeS(sin, 90, 1, _), fail), error(_Err, _Context), true).

/* Problem 11:
   In class we discussed the 'is' predicate for evaluating expressions. Write a
   predicate results/2.
   result(Elst,RLst) succeeds if Rlst is unifies with the values computed from
   the list of expressions, Elst.
*/

/* Problem 11 Answer: */

result([],[]).
result([X1|Y1],[X2|Y2]) :- X2 is X1, result([Y1],[Y2]).

/* Problem 11 Test */
:- result([],[]).
:- result([+(3,7),mod(104,7),-(5)],[10, 6, -5]).
:- result([+(3,7),+(15, -(3,11))],X), X = [10, 7].

:- result([+(3,7), mod(104,7)],[10,13]) -> fail ; true.

/* Problem 12:
   A good example of symbolic computation is symbolic differentiation. Below
   are the rules for symbolic differentiation where U, V are mathematical
   expressions, C is a number constant, N is an integer constant and x is a
   variable:

        dx/dx = 1
        d(C)/dx = 0.
        d(Cx)/dx = C
        d(-U)/dx = -(dU/dx)
        d(U+V)/dx = dU/dx + dV/dx
        d(U-V)/dx = dU/dx - dV/dx
        d(U*V)/dx = U*(dV/dx) + V*(dU/dx)
        d(U^N)/dx = N*U^(N-1)*(dU/dx)

   Translate these rules into Prolog. (Please keep the order of the rules the
   same for testing purposes).
*/

/* Problem 12 Answer: */

d(x,x,1) :- !.
d(C,x,0) :- number(C).
d(C*x,x,C) :- number(C).
d(-U,x,-R) :- d(U,x,R).
d(U+V,x,UR+VR) :- d(U,x,UR), d(V,x,VR).
d(U-V,x,UR-VR) :- d(U,x,UR), d(V,x,VR).
d(U*V,x,U*VR+V*UR) :- d(U,x,UR), d(V,x,VR).
d(U^N,x,N*U^Z*UR) :- d(U,x,UR), Z is N-1.

/* Problem 12 Test: */
:- d(x,x,R), R = 1 .
:- d(7*x,x,R), R = 7 .
:- d(x +2*(x^3 + x*x),x,Result), Result = 1+ (2* (3*x^2*1+ (x*1+x*1))+ (x^3+x*x)*0) .
:- d(-(1.24*x -x^3),x,Result), Result = - (1.24-3*x^2*1) .
:- d(-(1.24*x -2*x^3),x,Result), Result = - (1.24- (2* (3*x^2*1)+x^3*0)) .

% Pay careful attention to why this fails.
:- d(x +2*(x^3 + x*x),x,Result), Result = 1+ (2* (3*x^(3-1)*1+ (x*1+x*1))+ (x^3+x*x)*0) -> fail ; true.

:- d(x,x,R), R = 1 .
:- d(7*x,x,R), R = 7 .
:- d(x +2*(x^3 + x*x),x,Result), Result = 1+ (2* (3*x^2*1+ (x*1+x*1))+ (x^3+x*x)*0) .
:- d(-(1.24*x -x^3),x,Result), Result = - (1.24-3*x^2*1) .
:- d(-(1.24*x -2*x^3),x,Result), Result = - (1.24- (2* (3*x^2*1)+x^3*0)) .

% Pay careful attention to why this fails.
:- d(x +2*(x^3 + x*x),x,Result), Result = 1+ (2* (3*x^(3-1)*1+ (x*1+x*1))+ (x^3+x*x)*0) -> fail ; true.

