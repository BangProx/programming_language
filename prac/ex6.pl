isIn(In,List):-
    \+member(In,List)->
    write('no!');
    write('yes!').