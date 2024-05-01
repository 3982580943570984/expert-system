:- dynamic known/3.

main :- greeting, repeat, write('--> '), read_command(Command), do(Command), Command == quit.

greeting :- writeln('This is the native Prolog shell.'), native_help.

native_help :- writeln('Type `help`, `load`, `solve`, `clear`, `how(Goal)`, `whynot(Goal)` or `quit` at the prompt.').

read_command(Command) :- read_line_to_string(user_input, Line), string_lower(Line, Lower), atom_string(Command, Lower).

do(help) :- native_help, !.
do(load) :- load_knowledge_base, !.
do(solve) :- solve, !.
do(quit) :- halt(0), !.
do(clear) :- write('\033c'), !.
do(X) :- format('`~w` is not a legal command.~n', [X]), !.

load_knowledge_base :-
    write('Enter file name (e.g., `fragrances.pro`): '),
    read_line_to_string(user_input, Filename),
    ( Filename \= ""
        -> ( exists_file(Filename)
                ->  consult(Filename),
                    list_loaded_predicates(Filename)
                ;   format('File `~w` does not exist.~n', [Filename])
            )
        ; writeln('No filename entered.')
    ).

list_loaded_predicates(Filename) :-
    file_base_name(Filename, Base),
    file_name_extension(ModuleName, _, Base),
    format('Listing predicates from module `~w`:~n', [ModuleName]),
    forall(current_predicate(ModuleName:Predicate/Arity), format('~w/~w~n', [Predicate, Arity])).

solve :-
    retractall(known(_, _, _)),
    ( 
        resolve_goal(top_goal(X), []) ->  format('The answer is ~w~n', [X]);
        format('No answer found.~n')
    ).    

resolve_goal(true, _) :- !.
resolve_goal((Goal, Rest), History) :- evaluate_goal(Goal, [Goal|History]), resolve_goal(Rest, History).
resolve_goal(Goal, History) :- evaluate_goal(Goal, [Goal|History]).

evaluate_goal(true, _) :- !.
evaluate_goal(menuask(X, Y, Z), History) :- menuask(X, Y, Z, History), !.
evaluate_goal(ask(X, Y), History) :- ask(X, Y, History), !.
evaluate_goal((G1, G2), History) :- !, evaluate_goal(G1, History), evaluate_goal(G2, History).
evaluate_goal(Goal, History) :- clause(Goal, Body), resolve_goal(Body, History).

menuask(Attribute, AskValue, Menu, History) :-
    (
        known(yes, Attribute, AskValue) ->  true;
        known(yes, Attribute, _) ->  fail; 
        prompt_for_attribute(Attribute, AskValue, Menu, History)
    ).

prompt_for_attribute(Attribute, AskValue, Menu, History) :-
    format('What is the value for ~w?~n', [Attribute]),
    display_menu(Menu),
    format('Enter the number of choice'),
    get_user_input(NumberAtom, History),
    atom_number(NumberAtom, Number),    
    pick_menu(Number, AnswerValue, Menu),
    asserta(known(yes, Attribute, AnswerValue)),
    AskValue = AnswerValue.

display_menu(MenuItems) :- display_menu_items(1, MenuItems).
display_menu_items(_, []).
display_menu_items(Index, [Item | RestItems]) :-
    format('~d : ~w~n', [Index, Item]),
    NextIndex is Index + 1,
    display_menu_items(NextIndex, RestItems).

get_user_input(InputAtom, History) :-
    repeat, 
    write(' --> '), 
    read_line_to_string(user_input, Input), 
    atom_string(InputAtom, Input), 
    process_answer(InputAtom, History), !. 

process_answer(why, History) :- writeln(History), !, fail. 
process_answer(_, _).

pick_menu(N, Val, Menu) :- integer(N), pic_menu(1, N, Val, Menu), !. 
pick_menu(Val, Val, _).

pic_menu(_, _, none_of_the_above, []).
pic_menu(N, N, Item, [Item|_]). 
pic_menu(Ctr, N, Val, [_|Rest]) :- NextCtr is Ctr + 1, pic_menu(NextCtr,N,Val,Rest). 

ask(Attribute, Value, History) :-
    (
        known(yes, Attribute, Value) ->  true;
        known(_, Attribute, Value) ->  fail;
        not(multivalued(Attribute)), known(yes, Attribute, _) ->  fail;
        query_user(Attribute, Value, History)
    ).

query_user(Attribute, Value, History) :-
    format('<~w> equals <~w> (yes or no)', [Attribute, Value]), 
    get_user_input(Input, History), 
    asserta(known(Input, Attribute, Value)), 
    Input == yes.
