:- dynamic known/4.

main :- greeting, repeat, write('--> '), read_command(Command), do(Command), Command == quit.

greeting :- writeln('This is the native Prolog shell.'), native_help.

native_help :- writeln('Type `help`, `load`, `solve`, `clear`, `how(Goal)`, `whynot(Goal)` or `quit` at the prompt.').

read_command(Command) :- read_line_to_string(user_input, Line), string_lower(Line, Lower), atom_string(Command, Lower).

do(help)    :- native_help, !.
do(load)    :- load_knowledge_base, !.
do(solve)   :- solve_all, !.
do(quit)    :- halt(0), !.
do(clear)   :- write('\033c'), !.
do(X)       :- format('`~w` is not a legal command.~n', [X]), !.

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

solve_all :-
    retractall(known(_, _, _, _)),
    findall((X, CF), resolve_goal(top_goal(X, CF), []), Solutions),
    sort(Solutions, UniqueSolutions),
    filter_uncertain_solutions(UniqueSolutions, FilteredSolutions),
    (
        FilteredSolutions \= [] -> print_solutions(FilteredSolutions);
        otherwise               -> writeln('No answer found.')
    ).

filter_uncertain_solutions([], []).
filter_uncertain_solutions([(X, CF)|Rest], [(X, CF)|FilteredRest]) :-
    CF >= 0.05,
    filter_uncertain_solutions(Rest, FilteredRest).
filter_uncertain_solutions([(_, CF)|Rest], FilteredRest) :-
    CF < 0.05,
    filter_uncertain_solutions(Rest, FilteredRest).

print_solutions([]).
print_solutions([(X, CF)|Rest]) :-
    format('The answer is ~w with certainty ~w~n', [X, CF]),
    print_solutions(Rest).

resolve_goal(true, _) :- !.
resolve_goal((Goal, Rest), History) :- evaluate_goal(Goal, [Goal|History]), resolve_goal(Rest, History).
resolve_goal(Goal, History) :- evaluate_goal(Goal, [Goal|History]).

evaluate_goal(true, _) :- !.
evaluate_goal(evaluate_certainty_factors(ListOfCFs, FinalCF), _) :- evaluate_certainty_factors(ListOfCFs, FinalCF), !.
evaluate_goal(menuask(X, Y, CF, Z), History) :- menuask(X, Y, CF, Z, History), !.
evaluate_goal(ask(X, Y, CF), History) :- ask(X, Y, CF, History), !.
evaluate_goal((G1, G2), History) :- !, evaluate_goal(G1, History), evaluate_goal(G2, History).
evaluate_goal(Goal, History) :- clause(Goal, Body), resolve_goal(Body, History).

menuask(Attribute, Value, CF, Menu, History) :-
    (
        known(yes, Attribute, Value, KnownCF)                       -> (CF = KnownCF, true);        % Ответ на атрибут известен и соответствует значению
        known(yes, Attribute, _, _)                                 -> fail;                        % Ответ на атрибут известен и не соответствует значению
        known(dont_know, Attribute, _, KnownCF)                     -> (CF = KnownCF, true);        % Ответ на атрибут равен 'dont_know', поэтому продолжаем
        known(_, Attribute, Value, _)                               -> fail;                        % Атрибут с таким значением получил ответ, отличный от 'yes' или 'dont_know'
        menuask_prompt(Attribute, Value, CF, Menu, History)                                         % Ответ на атрибут не известен и мы его запрашиваем
    ).

menuask_prompt(Attribute, Value, CF, Menu, History) :-
    format('What is the value for ~w? (Enter the number of choice or dont_know)~n', [Attribute]),   % Задаем вопрос
    display_menu(Menu),                                                                             % Отображаем меню
    get_user_input(Input, History),                                                                 % Получаем ответ
    (                                                                                               % Получаем коэффициент уверенности
        Input == dont_know ->
        (
            CF = 0.5, 
            asserta(known(dont_know, Attribute, none_of_the_above, CF)),                            % Запоминаем значение пользователя
            true
        );
        atom_number(Input, Number),                                                                 % Переводим ответ в число
        pick_menu(Number, AnswerValue, Menu),                                                       % Для числа получаем значение
        CF = 1.0,
        asserta(known(yes, Attribute, AnswerValue, CF))
    ),
    Value = AnswerValue.

ask(Attribute, Value, CF, History) :-
    (
        known(yes, Attribute, Value, KnownCF)                       -> (CF = KnownCF, true);        % Ответ на атрибут известен и соответствует значению
        known(yes, Attribute, _, _)                                 -> fail;                        % Ответ на атрибут не многозначен и не соответствует значению
        known(dont_know, Attribute, _, KnownCF)                     -> (CF = KnownCF, true);        % Ответ на атрибут равен 'dont_know', поэтому продолжаем
        known(_, Attribute, Value, _)                               -> fail;                        % Атрибут с таким значением получил ответ, отличный от 'yes' или 'dont_know'
        ask_prompt(Attribute, Value, CF, History)                                                   % Ответ на атрибут не известен и мы его запрашиваем
    ).

ask_prompt(Attribute, Value, CF, History) :-
    format('<~w> equals <~w> (yes, no or dont_know)', [Attribute, Value]),                          % Задаем вопрос
    get_user_input(Input, History),                                                                 % Получаем ответ
    (                                                                                               % Получаем коэффициент уверенности
        Input == yes        -> CF = 1.0;
        Input == no         -> CF = 0.0;
        Input == dont_know  -> CF = 0.5;
        otherwise           -> CF = 0.0
    ),
    asserta(known(Input, Attribute, Value, CF)),                                                    % Запоминаем значение пользователя
    (Input == yes; Input == dont_know).    

% Переводим ответ пользователя в atom
get_user_input(InputAtom, History) :- repeat, write(' --> '), read_line_to_string(user_input, Input), atom_string(InputAtom, Input), process_answer(InputAtom, History), !.

% Отображение меню
display_menu(MenuItems) :- display_menu_items(1, MenuItems).
display_menu_items(_, []).
display_menu_items(Index, [Item | RestItems]) :- format('~d : ~w~n', [Index, Item]), NextIndex is Index + 1, display_menu_items(NextIndex, RestItems).

% Получение ответа среди вариантов меню
pick_menu(N, Val, Menu) :- integer(N), pic_menu(1, N, Val, Menu), !. 
pick_menu(Val, Val, _).
pic_menu(_, _, none_of_the_above, []).
pic_menu(N, N, Item, [Item|_]). 
pic_menu(Ctr, N, Val, [_|Rest]) :- NextCtr is Ctr + 1, pic_menu(NextCtr,N,Val,Rest). 

% Дополнительная обработка ответа
process_answer(why, History) :- writeln(History), !, fail. 
process_answer(_, _).
