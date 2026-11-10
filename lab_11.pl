

:- dynamic letter/1.

% ---------- Entry point ----------
start :-
    retractall(letter(_)),
    assertz(letter(a)),
    assertz(letter(b)),
    assertz(letter(c)),
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

% ---------- Menu loop ----------
menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    do(Choice).

% ---------- Actions ----------
% 1- Display
do(1) :- !,
    show_letters,
    menu.

% 2- Add a letter (at the end of the set)
do(2) :- !,
    write('Enter the letter to add (end with a full stop): '), nl,
    read(L),
    assertz(letter(L)),
    menu.

% 3- Add a letter at the top  (asserta = first clause)
do(3) :- !,
    write('Enter the letter to add at the top (end with a full stop): '), nl,
    read(L),
    asserta(letter(L)),
    menu.

% 4- Add a letter at the bottom (assertz = last clause)
do(4) :- !,
    write('Enter the letter to add at the bottom (end with a full stop): '), nl,
    read(L),
    assertz(letter(L)),
    menu.

% 5- Delete a letter (retract removes the first match, fails if none)
do(5) :- !,
    write('Enter the letter to delete (end with a full stop): '), nl,
    read(L),
    (   retract(letter(L))
    ->  write('Letter deleted.'), nl
    ;   write('This letter is not in the set.'), nl
    ),
    menu.

% 6- Delete all letters (retractall always succeeds)
do(6) :- !,
    retractall(letter(_)),
    write('All letters were deleted.'), nl,
    menu.

% 7- Exit
do(7) :- !,
    write('Goodbye!'), nl.

% Any other input
do(_) :-
    write('Invalid choice, please enter a number from 1 to 7.'), nl,
    menu.

% ---------- Helper ----------
show_letters :-
    findall(L, letter(L), Letters),
    (   Letters == []
    ->  write('The set is empty.'), nl
    ;   write('Current letters: '), write(Letters), nl
    ).
