Program bag;
Var
 S, S_Ost, N, S_Kvadrat:INTEGER;
 Ch :Char;
 Kvadrat: array [1..1000] of INTEGER ; 
 BEGIN
  WRITE('Введите площадь поля:  ');
  READLN(S);
  S_Ost:=S;
  N:=0;
  WHILE S_Ost>0
  DO
    BEGIN
      S_Kvadrat:=TRUNC(SQRT(S_Ost));
      N:=N+1;
      Kvadrat[N]:=S_Kvadrat*S_Kvadrat;
      S_Ost:=S_Ost-Kvadrat[N];
    END;
  WRITELN(N);    
  N:=1;    
   WHILE Kvadrat[N]>0
  DO
    BEGIN
      WRITE(Kvadrat[N],' ');
      N:=N+1;
    END;
  WRITELN;
  WRITE('Для выхода нажмите любую клавишу:  ');
  READLN(Ch);
    
END.
