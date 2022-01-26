%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).

same_day(UC1, UC2) :-
    class(UC1, _, Day_, _, _),
    class(UC2, _, Day_, _, _),
    UC1 \== UC2.

daily_courses(Day, Courses) :-
    setof(Course, CT^T^D^class(Course, CT, Day, T, D), Courses).

short_classes(L) :-
    findall(UC-Day/Hour, (class(UC, _, Day, Hour, D), D < 2), L).

course_classes(Course, Classes) :-
    findall(Day/Hour-Type, class(Course, Type, Day, Hour, _), Classes).

courses(L) :-
    setof(Course, (Type, Day, Time, D)^class(Course, Type, Day, Time, D), L).

schedule :-
    setof(Day/Time/Duration/Course/Type, class(Course, Type, Day, Time, Duration), Classes),
    schedule(Classes).

schedule([Day/Time/Duration/Course/Type | Classes]) :-
    num_day(Day, Res),
    write(Course/Type/Res/Time/Duration),
    nl,
    schedule(Classes).

num_day('1 Seg', seg).
num_day('2 Ter', ter).
num_day('3 Qua', qua).
num_day('4 Qui', qui).
num_day('5 Sex', sex).
