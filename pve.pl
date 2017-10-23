:-module('pve',[play/0]).
:-use_module([library(lists),io,fill,end,utils,ai1]).

play :-
    io:welcome,
    utils:initialBoard( Board ),
    io:displayBoard( Board ),
    chooseColor(_,AI),
    chooseLevel(D),
    (   D=:=1->play1(-1,AI,Board)).

chooseColor(Player,AI):-
    writeln('play white or black?(1 for white, -1 for black)'),
    read(Player),
    utils:changePlayer(Player,AI).

chooseLevel(D):-
    writeln('play with which level of AI?(...)'),
    read(D).

play1(Player,AI,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play1(NewPlayer,AI,Board);
        io:reportTurn(Player),
        (   Player=:=AI->ai1:chooseMove(AI,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),utils:changePlayer(Player,NewPlayer),play1(NewPlayer,AI,NewBoard);
            utils:readInput(Player,X,Y,Board),
            write(X),
            write(','),
            writeln(Y),
            fill:fillAndFlip(X,Y,Player,Board,NewBoard),
            io:displayBoard(NewBoard),
            utils:changePlayer(Player,NewPlayer),
            play1(NewPlayer,AI,NewBoard)    )).
