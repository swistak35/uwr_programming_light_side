conn(wroclaw, lodz). 
conn(lodz, warszawa). 
conn(lodz, siedlce). 
conn(warszawa, biala_podl). 
conn(warszawa, krakow). 
conn(krakow, wroclaw). 
conn(krakow, lodz). 
conn(siedlce, biala_podl). 
conn(siedlce, warszawa).

trip(Source, Destination, [Source|Route]):-
  trip(Source, Destination, Route, [Destination]).

trip(Source, Destination, Route, Route):-
  conn(Source, Destination).

trip(Source, Destination, Route, Visited):-
  conn(Current, Destination),
  \+ member(Current, Visited),
  trip(Source, Current, Route, [Current|Visited]).