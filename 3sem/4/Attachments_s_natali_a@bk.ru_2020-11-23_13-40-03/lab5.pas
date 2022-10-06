{ 
1.Имеется сеть автомобильных дорог. По каждой дороге можно
проехать в любом направлении. Известна длина всех дорог. Один из
городов является столицей. Требуется вывести список длин вторых
по минимальности путей из столицы в другие города.  Допускается
присутствие циклических путей (12).
2.Фомин Степан ПС-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - задается пользователем 
  OUTPUT - задается пользователем
5.INPUT - матрица смежности с названием городов
  OUTPUT - список длин вторых по минимальности путей из столицы в другие города
}

              

PROGRAM TheSecondMinPath(INPUT, OUTPUT);
CONST
  MaxN = 50;
  Inf = 1000000000; //"бесконечность"
 
TYPE
  Matrix = ARRAY[1..MaxN,1..MaxN] of LONGINT; //тип матрицы смежности. M[i,j] = true, если существует ребро, идущее от вершины i к j
  MatrixUse = ARRAY[1..MaxN,1..MaxN] of BOOLEAN; // включение/ выключение ребра
  Pred = ARRAY[1..MaxN] of INTEGER; 
  TypeName = ARRAY[1..MaxN] of STRING; 
VAR
  A: Matrix;
  AUse: MatrixUse;
  Name: TypeName;
  N, S0, S1: INTEGER;
  Fin, Fout: TEXT;
  NameFile: STRING;
  Ch: CHAR;
  PMin, PMin2,P_: Pred; 
  Way, MinWay: LONGINT;
  i, j, z, z1 : LONGINT;

PROCEDURE MakeGraf(VAR A : Matrix; VAR NMax : INTEGER);  
VAR
  S: STRING;
  Ch: CHAR;
  I, J, Way, Code: INTEGER;
  FName: BOOLEAN;
BEGIN
  I :=0;
  J :=0; 
  NMax :=0; 
  WHILE NOT EOF(Fin)
  DO
    BEGIN
      J :=1;
      I := I + 1;
      S := "";
      FName := FALSE;
      WHILE NOT EOLN(Fin)
      DO
      BEGIN
        Read(Fin, Ch);
        IF EOLN(Fin)
        THEN 
          BEGIN
            S := S + Ch;
            Ch := ' ';
          END;  
        IF Ch<>' '
        THEN
          S :=S + Ch
        ELSE
          BEGIN
            IF FName = FALSE
            THEN 
              Name[I] := S  
            ELSE
              BEGIN
                VAL(S,Way,Code);
                A[I,J] := Way;
                J := J + 1;
              END;  
            S := "";  
            FName := TRUE;
          END;
      END;     
      NMax := MAX(NMax, J-1);
      ReadLn(Fin);
    END;       
  NMax := MAX(NMax, I);
  FOR i := 1 TO NMax  // проходим выставляем бесконечный путь для не связанных
  DO
    BEGIN
      FOR j := 1 TO NMax
      DO
        BEGIN
          IF (a[i,j] = 0) AND (i <> j)
          THEN
            a[i,j] := Inf; //вершины, которые не связаны ребром, будем обзначать "бесконечностью" ввиду ограничения на вес рёбер
          AUse[i,j] :=TRUE;  
        END;
    END;    
END;

PROCEDURE Print(VAR A : Matrix; NMax : INTEGER);  
VAR
  I,J: INTEGER;
BEGIN
  FOR I := 1 TO NMax
  DO
    WRITE(Fout, ' ',Name[I]);
  WRITELN(Fout);    
  FOR I := 1 TO NMax 
  DO
    BEGiN
      FOR J := 1 TO NMax 
      DO
        WRITE(Fout, ' ',A[I,J]);
    WRITELN(Fout);  
   END;   
END;  

PROCEDURE PrintWay(p : Pred; s1 : INTEGER; Way: LONGINT);
VAR
  i, j, v, min, z : longint;
  st, c : string;
BEGIN
  st := ''; //осталось преобразовать в формат вывода (мы проидёмся по всем вершинам кратчайшего пути от s до s1, но только в обратном порядке)
  z := p[s1]; //пока есть корневая вершина
  WHILE z <> 0
  DO
    BEGIN
      st := Name[z] + '->' + st; //заносим в маршрут
      z := p[z]; //переходим к следующей вершине
    END;
    st := st + Name[s1];
    WRITELN(Fout,' ',st, ' = ',Way);
END; 

PROCEDURE Deikstr(s, s1 : INTEGER; VAR  P : Pred; VAR Way: LONGINT); //s, s1 - искомые вершины (необходимо найти путь от s до s1)
VAR
  i, j, v, min, z : LONGINT;
  st, c : STRING;
  Visited : ARRAY[1..MaxN] OF BOOLEAN; //массив посещённости вершин
  D : ARRAY[1..MaxN] of LONGINT; //массив кратчайших расстояний
BEGIN
  FOR i := 1 TO N 
  DO
    BEGIN
        p[i] := s;
        Visited[i] := FALSE;
    END;
  visited[s] := TRUE; //вершина S посещена
  FOR i := 1 TO N 
  DO 
    IF AUse[s, i]  //изначальный массив расстояний
    THEN
      D[i] := A[s, i]
    ELSE
      D[i] := INF;
       
  D[s] := 0;
  p[s] := 0; 
 
  FOR i := 1 TO N-1
  DO //на каждом шаге находим минимальное решение и пытаемся его улучшить
    BEGIN
      min := Inf;
      FOR j := 1 TO N
      DO
        IF (NOT Visited[j]) AND (D[j] < min)
        THEN
        BEGIN
          min := D[j]; //минимальное расстояние
          v := j; //найденная вершина
        END;
        FOR j := 1 TO N
        DO
          IF (D[j] > D[v] + A[v, j]) AND (D[v] < INF) AND (A[v, j] < INF)  AND AUse[v, j]
          THEN
            BEGIN
              D[j] := D[v] + A[v, j]; //пытаемся улучшить решение. Если в ней расстояние больше, чем сумма расстояния до текущей вершины и длины ребра, то уменьшаем его.
              p[j] := v;
            END;
        s := v; //новая текущая вершина
        Visited[v] := TRUE; //и она отмечается посещенной
    END;
    Way :=D[s1];
end;
 
BEGIN
 WRITE('Введите название входного файла: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  {$I-} RESET(Fin); {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('Файл ', NameFile, ' не найден!');
      WRITELN('Работа программы завершена. Нажмите ENTER.');
      READ(Ch);
      EXIT;
    END;
  MakeGraf(A, N);
  
  WRITE('Введите название выходного файла: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fout, NameFile);
  REWRITE(Fout);
  //Print(A, N);
  
  S0 := 1;
  WHILE S0 <= N
  DO
    BEGIN
      WRITELN('Введите номер столицы для расчета нового пути или введите номер столицы больше ', N, ' для того, чтобы выйти из программы');  
      READLN(S0);
      IF S0 > N
      THEN                       
        EXIT;
  //S0 :=1;  // номер столицы  
  FOR S1:=1 TO N
  DO
    IF S1<> S0 
    THEN
      BEGIN
        Deikstr(S0, S1, PMin,MinWay);  //минимальный путь
        PrintWay(PMin, s1, MinWay);

        MinWay := INF;
        z1 := s1;
        z  := PMin[s1]; //пока есть корневая вершина
        WHILE z <> 0
        DO  //удаляем одно из ребер
          BEGIN
            AUse[z,z1] := FALSE;
            Deikstr(S0, S1, P_, Way);
            AUse[z,z1] := TRUE;        
            IF MinWay > Way// запоминаем
            THEN
              BEGIN
                MinWay := Way;
                FOR j := 1 to N
                DO
                  PMin[j] := P_[j];
              END;    
            z1 := z;    //переходим к следующей вершине
            z := PMin[z]; 
      END;            
      IF MinWay < INF
      THEN // нашли второй по минимальности путь
        PrintWay(p_, s1, MinWay)
      ELSE
        WRITELN(Fout,' нет второго минимального маршрута'); //2 круга мин маршрута?
      END;
    END;  
  CLOSE(Fin);
  CLOSE(Fout); 
END.   
