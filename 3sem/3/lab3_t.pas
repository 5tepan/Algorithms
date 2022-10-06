{ 
1.В   некотором   институте   информация   об   имеющихся
компьютерах  задана двумя деревьями.  В первом из них сыновьям
корневой вершины соответствуют факультеты,  факультеты в  свою
очередь  делятся  на  кафедры,  кафедры  могут  иметь  в своем
составе лаборатории. Компьютеры могут быть установлены в общих
факультетских   классах,   на   кафедрах,   в  лабораториях  и
идентифицируются  уникальными  номерами.  Во   втором   дереве
сыновьям корня соответствуют учебные корпуса, корпуса включают
списки  аудиторий,  а  для  каждой  аудитории  заданы   номера
находящихся  в  них  компьютеров.  Некоторые  аудитории  могут
принадлежать  нескольким  факультетам.  Выдать  список   таких
аудиторий (12).
2.Фомин Степан ПС-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - задается пользователем 
  OUTPUT - задается пользователем
5.INPUT - два файла, по одному дереву в каждом
  OUTPUT - список аудиторий, принадлежащий нескольким факультетам
}






PROGRAM ClassList(INPUT, OUTPUT);
TYPE
  UKAZ = ^uzel;
  uzel = RECORD                                  
         name: STRING;     {имя вершины}
         left, right: UKAZ; {сыновья}
         fath: UKAZ;       {отец в исходном дереве}
         urov: INTEGER;    {уровень исходного дерева, начиная с 0}
       END;
VAR
  //t: UKAZ;
//  i, k, m, Len, NumFac: INTEGER;
  i, NumFac: INTEGER;
  S, R, NameFac: STRING;
  Fin, Fout: TEXT;
  FTree, BTree: UKAZ;
  NameFile, NameFile1: STRING;
  Ch: CHAR;
  
PROCEDURE FSerch(t, r: UKAZ);
VAR
  j: INTEGER;
  Father: UKAZ;
BEGIN
  IF t <> NIL 
  THEN
    BEGIN
      IF r^.name = t^.name 
      THEN
        BEGIN
          Father := t^.fath;
          WHILE Father^.urov > 1
          DO
            Father := Father^.fath;
          IF POS('- факультет ' + Father^.name + '.', NameFac) = 0
          THEN
            NumFac := NumFac + 1;
          IF NameFac <> ''
          THEN        
            NameFac := NameFac + char(10);
          NameFac := NameFac + 'Аудитория ' + r^.fath^.name + ',' + ' Корпус ' + r^.fath^.fath^.name + ',' + ' Номер компьютера ' + r^.name + ' + ' - факультет ' + Father^.name + '.';  
        END;       
      FSerch(t^.left, r);
      FSerch(t^.right, r);
    END
END;
  
PROCEDURE BSerch(t: UKAZ);
VAR
  j: INTEGER;
  Str: STRING;
BEGIN
  Str := '';
  IF t <> NIL 
  THEN
    BEGIN
      IF t^.urov = 2
      THEN
        BEGIN  
          NameFac := '';
          NumFac := 0;
        END;
      IF t^.urov = 3
      THEN
        FSerch(FTree, t);   
      BSerch(t^.left);
      IF (t^.urov = 2) AND (NumFac > 1)
      THEN
        WRITELN(Fout, NameFac);
      BSerch(t^.right);
    END
END;

PROCEDURE MakeTree(VAR root: ukaz);
VAR
  t, kon, p: UKAZ;
  k,m,Len: INTEGER;
BEGIN
  New(root);
  ReadLn(Fin, S);
  root^.name := S;
  root^.urov := 0;
  root^.fath := NIL;  {отец}
  m := 0;             {уровень вершины}
  t := root;          {предыдущая вершина для следующей в файле}
  WHILE NOT EOF(Fin) DO
    BEGIN
      ReadLn(Fin, S);
      k := 0;
      Len := Length(S);
      WHILE S[k + 1] = '+' DO k := k + 1;   {k-уровень вершины, начиная с 0}
      R := Copy(S, k + 1, Len - k);         {имя вершины}
      New(kon);
      kon^.name := R;
      kon^.left := NIL;
      kon^.right := NIL;
      kon^.urov := k;
      IF k > m THEN               {переход на следующий уровень}
        BEGIN
          t^.left := kon;
          kon^.fath := t;
        END
      ELSE
        IF k = m THEN             {тот же уровень}
          BEGIN
            t^.right := kon;
            kon^.fath := t^.fath; {отец тот же, что у брата}
          END
        ELSE                    {подъем по дереву на m-k уровней}
          BEGIN
            p := t;
            FOR i := 1 TO m - k DO
              p := p^.fath;
            {p-предыдущая вершина того же уровня}
            kon^.fath := p^.fath; {отец в исходном дереве тот же, что у брата}
            p^.right := kon;
          END;
      m := k;       {запомнили текущий уровень}
      t := kon;     {для работы со следующей вершиной}
    END;          {конец While}
END;
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
  //Assign(Fin,'input.txt');
  //Reset(Fin);
  FTree := NIL;
  MakeTree(FTree);
  CLOSE(Fin);      
  
  WRITE('Введите название входного файла 2: ');
  READLN(NameFile1);
  NameFile1 := NameFile1 + '.txt';
  ASSIGN(Fin, NameFile1);
  {$I-} RESET(Fin); {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('Файл ', NameFile1, ' не найден!');
      WRITELN('Работа программы завершена. Нажмите ENTER.');
      READ(Ch);
      EXIT;
    END;
  //Assign(Fin,'input1.txt');
  //Reset(Fin);
  BTree := NIL;
  MakeTree(BTree);
  CLOSE(Fin);
    
  WRITE('Введите название выходного файла: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fout, NameFile);
  REWRITE(Fout);
  //Assign(Fout,'output.txt');
  //Rewrite(Fout);
  BSerch(BTree);
  CLOSE(Fout);
END.

