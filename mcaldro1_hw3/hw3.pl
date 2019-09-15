/* MARK CALDROPOLI
   Homework Assignment 3
   Programming Languages
   CS471, Fall 2019
   Binghamton University */

/* Instructions */

/*
You will be able to code in and run this file in the prolog interpreter directly. I
recommend reading this assignment directly from the source file.

We will be using swipl for our prolog environment.
To load/reload this file, cd to its directory and run swipl. Then, in the prompt, type '[hw3].'

From then on you may execute queries (goals) in the prompt. As usual,
you should provide your answers in the designated spot. Once you have
added some code to the file, rerun '[hw3].' in the swipl prompt to
reload.

In addition, there are "unit tests provided" for each problem. These are 
there to help you better understand what the question asks for, as well as
check your code. They are included in our knowledge base as queries
and are initially commented out (% denotes a Prolog line comment).

%:- member_times(4,[3,3,2,3],0). % SUCCEED
%:- member_times(4,[1,2,3],3).   % FAIL

After you have finished a problem and are ready to test, remove the
initial % for each test for the associated problem and reload the
assignment file ([hw3].). Each SUCCEED line should silently load and
succeed, and each FAIL line should throw a WARNING. If a SUCCEED line
throws a WARNING, or a FAIL line fails too, then your solution is not
correct. If you pass the tests there is a good chance that your code
is correct, but not guaranteed; the tests are meant as guided feedback
and are not a check for 100% correctness.

*/

/* Submission */

/*
For this assignment -- and the remaining Prolog assignments -- your
submission should only include this source file -- there is no need
to add an additional text file with answers. Please tar and gzip
this file as normal with a name like eway1_hw3.tar.gz.
*/

/* Homework 3 */

/* Due: Tuesday, 9/17, 11:59 PM */

/*
Purpose: To get comfortable with Logic programming, and get a good
grasp on list manipulation in Prolog.
*/

/* The following 3 problems will not be graded and are intended
   as examples and to get you used to prolog terminology and swipl.
   

   Problem 0A (NOT GRADED):
   Programming with matching.  A line can be defined by 2 points. A point has an
   x and y coordinate. A line is vertical if both points have the same x value.
   A line is horizontal if both points have the same y values.  The following
   is a knowledge base which specify what is meant for a line to be vertical
   or horizontal respectively. This example is due to Ivan Bratko.
*/

vertical(line(point(X,_),point(X,_))).
horizontal(line(point(_,Y),point(_,Y))).

/* 1. Name the clauses, predicates, rules, and facts.
   2. Name the constants, variables, and complex structures. */

/*
1. Each line ending with a . is a clause. Both are rules.
2. No constants. Variables X,Y,Z. Both are complex structures.
*/

/* Problem 0B (NOT GRADED):
    A way of writing numerals, which is sometimes used in mathematical logic, makes
    use of just four symbols: 0, succ, and the left and right parentheses.
    The following is the knowledge base for this representation of a numeral.
    The predicate 'add' is the definition of adding this representation of numbers.

    Use this base you should use to answer the question.
    (Reference 3.1 example 3 Learn Prolog Now!
      http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse9)
*/

numeral(0).
numeral(succ(X))  :-  numeral(X).

add(0,Y,Y).
add(succ(X),Y,succ(Z))  :-
                    add(X,Y,Z).


/* 1. Name the clauses, predicates, rules, and facts.
   2. Name the constants, variables, and complex structures. */

/*
 1. Clauses anything that ends with a period. Predicates, succ, add. Fact - numeral(0). Rules - add.
 2. Constants - 0. Variables X, Y, Z. Complex - numeral, add.
*/

/* Problem 0C (NOT GRADED):
Each line is an individual Prolog query; it's a good idea type them in your prompt (not the file itself) to get a feel for the way Prolog works. You should think about whether or not each query will succeed, and if so how the variables will be instantiated (as result of unification). You can expect these sort of questions on the test.

X = 1+2.
X is 1+2.
1+2=1+2.
1+2=2+1.
1+2=3.
1+2 is 3.
3 is 1+2.
3 =< 6.
6 =< 3.
X = Y, Y = Z, Z = 3.
X = Y, Y = Z, Z = 3, X = 4.
T = (X,Y), X = a, Y = b.
X = [1,2,3], [H|T] = X.
X = [1,2,3], [H1,H2|T] = X.
X = [1], [H|T] = X.
X = [1], Y = [2|X].
add(0,succ(succ(0)),Y).

help(member).
X = 3, member(X, [Y]).
*/

/* Problem 1:

The following are two basic predicates for list manipulation:
my_first/2 and my_last/2. We may refer to a predicate by writings it
as name/arity; hence, my_first/2 means a predicate named my_first with
two arguments.

my_first(X,Y) succeeds if X is the first element of list Y.
my_last(X,Y) succeeds if X is the last element of list Y.
*/

my_first(X,[X|_]).

my_last(X,[X]).
my_last(X,[_|Ys]) :- my_last(X,Ys).

/*
Note my use of the _ (wildcard). It is used to say to Prolog "I don't
care, match anything" and should be used to avoid singleton warnings
(a variable that is not unified). We will discuss this during lab.

Try the following queries before moving on. Note that they are
included in the comment section for a reason: They would be
interpreted as facts in the database otherwise.

my_first(X,[3,a,dd]).
my_last(X,[3,a,dd]).
my_first(3,[3,a,dd]).
my_first(a,[3,a,dd]).
my_last(dd,[3,a,dd]).
my_last(a,[3,a,dd]).

Now, write a predicate my_member(X,Y) that succeeds if X is a member
of the list Y.

NOTE: my_first/2 and my_last/2 are provided as examples for
manipulating lists. You should not use them in definition of
my_member/2.

*/

/* Problem 1 Answer: */

my_member(X,[X|_]).
my_member(X,[_|Y]) :- my_member(X,Y).

/* Problem 1 Test: */
%:- my_member((1,3),[(1,2),(1,3)]).     % SUCCEED
%:- my_member(3,[3]).                   % SUCCEED
%:- my_member(4,[1,2,3]).               % FAIL

/* Problem 2:
 Write a predicate init(All, Blst) that succeeds if Blst has all the items of All
 except the last item.  The items in BLst are in the same order as All.
*/

/* Problem 2 Answer: */

init([_],[]).
init([X1|Y1],[X2|Y2]) :-
    X1 = X2,
    init(Y1,Y2).

/* Problem 2 Test: */
%:- init([1], []).          % SUCCEED
%:- init([1,2,3], [1,2]).   % SUCCEED
%:- init([1,2], [1,2]).     % FAIL
%:- init([1,2], [2]).       % FAIL

/* Problem 3:
Write a predicate is_increasing(X) that succeeds if X is a list of increasing numbers -- Each number is either the same or higher than the preceding number.

NOTE: You may match two elements at a time against a list:
some_rule(List) :-
	[X,Y|Xs] = List,
	...
However, it's preferable to simply do this in the rule head:
some_rule([X,Y|Xs]) :- ...  */

/* Problem 3 Answer: */

is_increasing([]).
is_increasing([_]).
is_increasing([X,Y|Ys]) :-
    X =< Y,
    is_increasing([Y|Ys]).

/* Problem 3 Test: */
%:- is_increasing([]).              % SUCCEED
%:- is_increasing([10]).            % SUCCEED
%:- is_increasing([10,100]).        % SUCCEED
%:- is_increasing([10,11,12]).      % SUCCEED
%:- is_increasing([1,8,8,17,20]).   % SUCCEED
%:- is_increasing([1,1,1,1,1]).     % SUCCEED
%:- is_increasing([10,19,17,9]).    % FAIL
%:- is_increasing([2,3,1]).         % FAIL
%:- is_increasing([3,2,1]).         % FAIL
%:- is_increasing([7,5]).           % FAIL

/* Problem 4:
Write a predicate element_at(X,Y,N) that succeeds if X is the Nth element of list Y. Y is 0-indexed.

NOTE: Don't worry about the error cases: i.e, N greater than the length of Y.  */

/* Problem 4 Answer: */

element_at(X,[X|_],0).
element_at(X,[_|Y],N) :-
    M is N - 1,
    element_at(X,Y,M).

/* Problem 4 Test: */
%:- element_at(3,[1,2,3],2).     % SUCCEED
%:- element_at(1,[1,2,3],0).     % SUCCEED
%:- element_at(1,[1,2,3],1).     % FAIL

/* Problem 5:
Write a predicate insert_at(X,Y,N,Z) that succeeds if Z is the list Y with X inserted at index N -- Insert X at index N in Y.

NOTE: Don't worry about the error cases: i.e, N greater than the length of Y.  */

/* Problem 5 Answer: */

insert_at(X,E,0,[X|E]).
insert_at(X,[H|Y],N,[H|T]) :-
    M is N - 1,
    insert_at(X,Y,M,T).

/* Problem 5 Test: */
%:- insert_at(3,[1,2,3],2,[1,2,3,3]).  % SUCCEED
%:- insert_at(1,[1,2,3],0,[1,1,2,3]).  % SUCCEED
%:- insert_at(a,[1,2,3],1,[1,a,2,3]).  % SUCCEED
%:- insert_at(1,[1,2,3],0,[1,2,3]).    % FAIL

/* Problem 6:
Write a predicate zip(Xs,Ys,Zs) that succeeds if Zs is a list where each element is a tuple, (X,Y), with Xs and Ys paired together.
NOTE: You may assume X and Y have the same length.

For example...
zip([1,2,3],[a,b,c],Zs) should give Zs = [(1,a),(2,b),(3,c)]
zip([1],[a],Zs) should give Zs = [(1,a)] */

/* Problem 6 Answer: */

zip([],[],[]).
zip([X|Xs],[Y|Ys],[(X,Y)|Zs]) :- zip(Xs,Ys,Zs).

/* Problem 6 Test: */
%:- zip([1,2,3],[a,b,c],[(1,a),(2,b),(3,c)]).    % SUCCEED
%:- zip([],[],[]).                               % SUCCEED
%:- zip([1],[2],[(1,2)]).                        % SUCCEED
%:- zip([1],[2],[(2,3)]).                        % FAIL
%:- zip([1],[2,3],[(1,2)]).                      % FAIL

/* Problem 7:

Write a predicate zip2(Xs,Ys,Zs) that succeeds if Zs is a list where each element is a tuple, (X,Y), with Xs and Ys paired together.
However, this time X and Y may be of different length. The length of Zs will be equal to the length of Xs or Ys, which ever is less.

For example...
zip2([1,2,3,4],[a,b,c],Zs) should give Zs = [(1,a),(2,b),(3,c)]
zip2([1],[a,b],Zs) should give Zs = [(1,a)] */

/* Problem 7 Answer: */

zip2([],[],[]).
zip2([_|_],[],[]).
zip2([],[_|_],[]).
zip2([X|Xs],[Y|Ys],[(X,Y)|Zs]) :- zip2(Xs,Ys,Zs).

/* Problem 7 Test: */
%:- zip2([1,2,3],[a,b,c],[(1,a),(2,b),(3,c)]).   % SUCCEED
%:- zip2([],[a,b,c],[]).                         % SUCCEED
%:- zip2([1,3],[],[]).                           % SUCCEED
%:- zip2([1,3],[2],[(1,2)]).                     % SUCCEED
%:- zip2([1],[2],[(2,3)]).                       % FAIL
%:- zip2([1],[a,b],[(1,a),(1,b)]).               % FAIL

/* Problem 8:
Write a predicate merge(A,B,M) that succeed if the list M has all the items from lists A and B in decreasing order.  Assume that A and B are sorted in decreasing order.  Items do not need to be unique.

For example:
merge([10,3,2], [11,5,2], M) should give M =[11,10,5,3,2,2].

*/

/* Problem 8 Answer: */
merge([],[],[]).
merge([X],[],[X]).
merge([],[Y],[Y]).
merge([X|Xs],[Y|Ys],[X|Zs]) :-
    X >= Y,
    merge(Xs,[Y|Ys],Zs).
merge([X|Xs],[Y|Ys],[Y|Zs]) :-
    X < Y,
    merge([X|Xs],Ys,Zs).

/* Problem 8 Test: */
%:- merge([10,3,2],[11,5,2],[11,10,5,3,2,2]) .       % SUCCEED
%:- merge([0],[],[0]).                               % SUCCEED
%:- merge([],[3],[3]).                               % SUCCEED
%:- merge([4,3],[3],[3]).                            % FAIL

/* Problem 9:
   See Problem 0B above for the knowledge base used for defining less_than/2.
  
   Define a predicate less_than/2 that takes two numerals in the notation
   that we introduced in the text (that is, 0, succ(0), succ(succ(0)), and so on)
   as arguments and decides whether the first one is less than the second one.
*/

/* Problem 9 Answer: */

less_than(0,succ(_)).
less_than(succ(X),succ(Y)) :- less_than(X,Y).

/* Problem 9 Test: */
%:- less_than(succ(succ(succ(0))),succ(0)).        % FAIL
%:- less_than(succ(succ(0)),succ(succ(succ(0)))).  % SUCCEED

/* Problem 10:
   See Problem 0B above for the knowledge base used for defining subtract/3 .
   Define substract(Num1,Num2,Result) to succeed if Result is the result of
   Num1 - Num2. Num1, Num2 and Result use four symbols: 0, succ , and the left and right parentheses
   to represent numbers.

   Use the add/3, from problem 0B, definition to define subtract/3. Do not
   write a recursive definition for subtract/3.
*/

/* Problem 10 Answer: */

subtract(Num1,Num2,Result) :- add(Num2,Result,Num1).

/* Problem 10 Test: */
%:- subtract(succ(succ(0)), succ(0), succ(0)).       % SUCCEED
%:- subtract(succ(succ(0)), 0, succ(succ(0))).       % SUCCEED
%:- subtract(succ(succ(0)), succ(succ(0)), 0).       % SUCCEED
%:- subtract(succ(succ(0)), 0, 0).	            % FAIL
%:- subtract(succ(succ(0)), succ(0), succ(succ(0))). % FAIL

/* Problem 11:  
   In assignment 2 problem 12, you were given the following definition of Ackermann's function.
	ack( m,n ) =	n + 1                           if m = 0
	ack( m,n ) =	ack(m - 1, 1)                   if n = 0 and m > 0 
	ack( m,n ) =	ack( m-1, ack( m, n-1 ) )      	if n >0 and m > 0

   Convert this definition to a Prolog program. In addition provide 3 test cases. At least one test case
   m should have a value greater than 0.
*/

/* Problem 11 Answer: */
 ack(0,N,X) :- X is N + 1.
 ack(M,0,X) :-
     M > 0,
     M1 is M - 1,
     ack(M1,1,X).
 ack(M,N,X) :-
     N > 0,
     M > 0,
     M1 is M - 1,
     N1 is N - 1,
     ack(M,N1,X1),
     ack(M1,X1,X).

/* Problem 11 Test: (yours) */
%:- ack(1,0,X), X=:=2.    % SUCCEED
%:- ack(0,3,X), X=:=4.    % SUCCEED
%:- ack(1,1,X), X=:=1.    % FAIL - Should be X = 3

