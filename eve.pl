:-module('eve',[playEvE/0]).
:-use_module([library(lists),io,fill,end,utils,ai1,ai3,ai4,ai2,ai5]).

playEvE :-
    io:welcome,
    utils:initialBoard( Board ),
    io:displayBoard( Board ),
    play(-1,Board).

play(Player,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_),!;
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play(NewPlayer,Board);
     (   Player =:= -1 -> ai5:chooseMove5(-1,X,Y,Board),fill:fillAndFlip(X,Y,-1,Board,NewBoard),play(1,NewBoard);
     ai4:chooseMove4(1,X,Y,Board),fill:fillAndFlip(X,Y,1,Board,NewBoard),play(-1,NewBoard))).