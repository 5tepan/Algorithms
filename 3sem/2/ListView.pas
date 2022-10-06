{ 
1.? ????????? ???????,  ??????????? ?????? ??? ??????????
??????????     ???????,    ???????    ????????????    ???????.
?????????????? ??????? ?? ????  ???????.  ???  ???????  ??????
?????   ??????   ??????????   ?  ???????  ?  ??????????  ?????
?????????? ? ???????. ????? ?????????? ?????? ????? ??????????
?????  ?  ?????  ???????.  ???  ??????  ??? ??????-???? ??????
???????? ?????????? ????? ?????????? ? ???????, ?? ???????? ??
(????  ????  ?  ???? ?????? ??????? ????????) ? ???????????? ?
?????????. ??????? ???????? ?????????? ??????? ?? ????????(9)..
2.‘омин —тепан ѕ—-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - задаетс€ пользователем 
  OUTPUT - задаетс€ пользователем
5.INPUT - список агентов
  OUTPUT - протокол наблюдени€
}




PROGRAM ListView;
CONST
  MaxAgent = 100;
TYPE
  Agent = RECORD
    Name: STRING;
    ObservationPeriod, TheTimeLimit: INTEGER
  END;
VAR
  Turn: ARRAY [1..MaxAgent] OF Agent;
  Bego, Endo: INTEGER;
  FIn, FOut: TEXT;
  NameFile: STRING;
  Ch: CHAR;
  N, I,  AllTime, ViewTime, MaxTime: INTEGER;  {ViewTime врем наблюдени€ текущего агента. 
                                                  AllTime общее врем€ наблюдени€. N количество агентов. MaxTime максимальный период сто€ни€ в очереди}

//procedure Val(S: String; Var V; var Code : Integer);
//где:
//S - переменна€ со строковым типом (string). ƒолжна представл€ть последовательность символов, формирующих знаковое целое число - это та строка, которую мы будем преобразовывать.
//V - переменна€ типа Real или Integer (здесь имеет место перегрузка процедуры). ¬ этой переменной будет содержатьс€ число, если преобразование пройдЄт успешно
//Code - переменна€ типа Integer Ч позици€, в которой произошла ошибка при преобразовании, или нуль, если ошибки не было. 

PROCEDURE ReadQueue();
VAR 
  AllStr, S1: STRING;
  Code: INTEGER;
  BEGIN
    WRITE('¬ведите название входного файла: ');
    READLN(NameFile);
    NameFile := NameFile + '.txt';
    ASSIGN(FIn, NameFile);
    {$I-} RESET(FIn); {$I+}
    IF IORESULT <> 0
    THEN
      BEGIN
        WRITELN('‘айл ', NameFile, ' не найден!');
        WRITELN('–абота программы завершена. Ќажмите ENTER.');
        READ(Ch);
        EXIT;
      END;
    WRITE('¬ведите название выходного файла: ');
    READLN(NameFile);
    NameFile := NameFile + '.txt';
    ASSIGN(FOut, NameFile);
    REWRITE(FOut);
    N := 0;
    MaxTime := 0;
    WHILE NOT EOF(FIn) AND (N <= MaxAgent) 
    DO 
      BEGIN
        N := N + 1;
        WITH Turn[N]
        DO
          BEGIN
            READLN(FIn, AllStr);
            Name := COPY(AllStr, 1, POS(' ', AllStr) - 1); //подстрока до 1 пробела -записываем в Name           
            DELETE(AllStr, 1, POS(' ', AllStr)); //удал€ем из общей строки »м€ 
            S1 := COPY(AllStr, 1, POS(' ', AllStr) - 1);
            VAL(S1, ObservationPeriod, Code); //подстроку переводим в число -записываем в ObservationPeriod           
            DELETE(AllStr, 1, POS(' ', AllStr)); //удал€ем из общей строки ObservationPeriod 
            VAL(AllStr, TheTimeLimit, Code); //оставшуюс€ подстроку переводим в число -записываем в TheTimeLimit           
            IF (ObservationPeriod > 0) 
            THEN
              MaxTime := MAX(MaxTime, TheTimeLimit); 
          END;
      END
  END;
  
 PROCEDURE CheckQueue(Time1, Time2: INTEGER);
 VAR
   I: INTEGER;
 BEGIN
   WHILE Time1 < Time2
   DO
     BEGIN
       FOR I := 1 TO N
       DO
         WITH Turn[I]
         DO
         IF Time1 = TheTimeLimit
         THEN
           WRITELN(FOUT, Time1, ': ', Name, '- вышел из очереди');
           Time1 := Time1 + 1;  
     END;          
  END; 
  BEGIN
    ReadQueue();
    AllTime := 0;
    WHILE AllTime < MaxTime
    DO
      FOR I := 1 TO N
      DO
        WITH Turn[I]
        DO
          BEGIN
            ViewTime := MIN(ObservationPeriod, TheTimeLimit - AllTime);
            ViewTime := MAX(ViewTime, 0);

            IF ViewTime > 0
            THEN
              BEGIN
                WRITELN(FOUT, AllTime, ': ', Name, '- начал наблюдение');
                CheckQueue(AllTime, AllTime + ViewTime);
                WRITELN(FOUT, AllTime + ViewTime, ': ' ,Name , '- окончил наблюдение');
              END;  
            AllTime := AllTime + ViewTime;             
          END;
          CheckQueue(AllTime, AllTime + 1);          
  END.
