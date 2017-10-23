:-module('utils',[getVal/4,isOnBoard/2,initialBoard/1,isBlack/1,isWhite/1,readInput/4,changePlayer/2]).
:-use_module([io]).

getVal(Board, X, Y, Val) :-
  nth0(X, Board, Column),
  nth0(Y, Column, Val).

isOnBoard(X,Y):-
  between(0,7,X),
  between(0,7,Y).

initialBoard(Board):-
  Board = [[0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,1,-1,0,0,0],
            [0,0,0,-1,1,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0]].

isBlack(Player):-
  Player = -1.

isWhite(Player):-
  Player = 1.

transformeY(Al,N):-
  (Al == a -> N = 0;
   Al == b -> N = 1;
   Al == c -> N = 2;
   Al == d -> N = 3;
   Al == e -> N = 4;
   Al == f -> N = 5;
   Al == g -> N = 6;
   Al == h -> N = 7).

transformeX(N,NN):-
  (N =:= 1->NN = 0;
   N =:= 2->NN = 1;
   N =:= 3->NN = 2;
   N =:= 4->NN = 3;
   N =:= 5->NN = 4;
   N =:= 6->NN = 5;
   N =:= 7->NN = 6;
   N =:= 8->NN = 7).

readInput(Player,X,Y,Board):-
    write('play where?'),
    read([N,Al]),
    transformeX(N,XX),
    transformeY(Al,YY),
    (   io:getLegalMove(Player,XX,YY,Board)->X is XX, Y is YY, io:reportMove(Player,N,Al);
    writeln('Wrong Move!'),readInput(Player,X,Y,Board)).
    %il faut un input comme "[3,5]."
    %reportMove(Player,X,Y).

changePlayer(Player,NewPlayer):-
     (Player =:= 1->NewPlayer = -1;
     Player =:= -1->NewPlayer = 1).

isCorner(X,Y):-
    X = 0, Y = 0;
    X = 0, Y = 7;
    X = 7, Y = 0;
    X = 7, Y = 7.

isSurroundedCorner(X,Y):-
    X = 0, Y = 1;
    X = 1, Y = 0;
    X = 1, Y = 1;
    X = 0, Y = 6;
    X = 1, Y = 6;
    X = 1, Y = 7;
    X = 6, Y = 0;
    X = 6, Y = 1;
    X = 7, Y = 1;
    X = 6, Y = 6;
    X = 6, Y = 7;
    X = 7, Y = 6.
