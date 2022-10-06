{ 
1.В файле имеется телефонный справочник,  включающий имена
владельцев телефонов.  Организовать быстрый поиск  по  номерам
телефонов   с   помощью   хеширования.  Обеспечить  дополнение
и удаление записей справочника (10).
2.Фомин Степан ПС-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - задается пользователем 
  OUTPUT - задается пользователем и на экран
5.INPUT - справочник с номерами телефонов  и именами владельцев
  OUTPUT - номер, который нужно было найти
}







Program Heshirov;
Const
  TableSize = 999;
  Lett_Int = ['0'..'9'];
Type
  ukaz=^uzel;
  uzel=record              
         Tel: STRING;        
         FIO: STRING;        
         Next :ukaz;   
       end;
  tsize=0..TableSize;
  table=array [tsize] of ukaz;
Var
  Fin, Fout: TEXT;
  NameFile: STRING;
  Ch: CHAR;  
  t:table;               { заполняемая таблица }
  h:tsize;               { индекс в таблице    }
  root: ukaz;
  Tel, FIO: STRING;
  FlagEnd: BOOLEAN;
  Choose: INTEGER; 
PROCEDURE MakeTel(VAR Tel: STRING);
VAR
 i: INTEGER;
 S1: STRING;
BEGIN 
  S1:=Tel;
  Tel:='';
  FOR i:=1 TO LENGTH(S1)
  DO
    IF S1[i] IN Lett_Int
    THEN Tel:=Tel+S1[i];
END;
 
PROCEDURE MakeKey(VAR key: INTEGER; Tel: STRING);
VAR
 k, Code: INTEGER;
 SubTel: STRING;
BEGIN 
  SubTel :="000"+Tel;
  SubTel := COPY(SubTel, LENGTH(SubTel)-2,3);
  VAL(SubTel, key, Code);
  key := key mod (TableSize);        { приведение в диапазон 0-M1 }
END;
  
PROCEDURE InsHesh(Tel, FIO: STRING);
VAR
  key: INTEGER;
BEGIN
  key := 0;
  MakeKey(key, Tel);
  New(root);
  root^.Tel := Tel;
  root^.FIO := FIO;
  root^.Next := t[key];
  t[key] := root;
END;

PROCEDURE FindHesh(Tel: STRING; FlagDel: BOOLEAN);
VAR
  key: INTEGER;
  Found: BOOLEAN;  
  rootPrev: ukaz;
BEGIN
  key := 0;
  MakeKey(key, Tel);
  root:=t[key];
  IF (t[key] <> NIL) AND  (root^.Tel = Tel)
  THEN
    Found := TRUE
  ELSE
    Found:=FALSE;
  WHILE (root<>NIL) and (NOT Found)
  DO
    BEGIN
      IF root^.Tel = Tel
      THEN
        Found := TRUE
      ELSE
        BEGIN
          rootPrev := root;
          root := root^.next;
        END;  
    END;
  IF Found AND NOT FlagDel
  THEN
    BEGIN
      WRITELN('ФИО - ',root^.FIO);            
      WRITELN(Fout,'Найден номер ', Tel, 'ФИО - ',root^.FIO);            
    END;  
  IF Found AND FlagDel
  THEN  
    BEGIN
      IF (t[key] <> NIL) AND (t[key]^.Tel = Tel)
      THEN
        t[key] :=t[key]^.next
      ELSE
        rootPrev^.next := rootPrev^.next^.next;
      WRITELN('Удален телефон ',Tel);            
      WRITELN(Fout, 'Удален телефон ',Tel);            
    END;  
  IF NOT Found 
  THEN 
    BEGIN 
      WRITELN('Не найден телефон  ',Tel);                 
      WRITELN(Fout,'Не найден телефон  ',Tel);                 
    END;    
END;

PROCEDURE MakeHesh();
VAR
  S1, S2: STRING;
  Ch: CHAR;
  key: INTEGER;
BEGIN
  FOR key := 0 TO TableSize
  DO
    t[key] :=NIL;
  WHILE NOT EOF(Fin)
  DO
    BEGIN
      S1 := "";
      S2 := "";
      WHILE NOT EOLN(Fin)
      DO
      BEGIN
        Read(Fin, Ch);
        IF Ch<>','
        THEN
          S2 := S2 + Ch        
        ELSE
          BEGIN
            S1 := S2;
            S2 := "";
          END;  
      END;   
      MakeTel(S1);
      InsHesh(S1, S2); 
      ReadLn(Fin);
    END;       
END;

PROCEDURE PrintHesh();
VAR
  key: INTEGER;
BEGIN
  FOR key := 0 TO TableSize
  DO
    BEGIN
      root := t[key];
      WHILE root <>  NIL
      DO
        BEGIN
          WRITELN(Fout, key,' : ' ,root^.Tel,' ', root^.FIO);
          root := root^.Next;
        END;  
    END;      
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
  MakeHesh();
  WRITE('Введите название выходного файла: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fout, NameFile);
  REWRITE(Fout);
  PrintHesh();
  FlagEnd :=FALSE;
  WHILE NOT FlagEnd 
  DO
    BEGIN
      WRITE('Введите номер: (или Enter для выхода)');
      READLN(Tel);
      IF   Tel = ''
      THEN
        FlagEnd :=TRUE
      ELSE  
        BEGIN
          MakeTel(Tel);
          IF   Tel = ''
          THEN
            WRITE('Не корректный номер: ')
          ELSE 
            BEGIN   
              WRITE('Введите действие (1- добавление, 2 - удаление, 3- поиск): ');            
              READLN(Choose);
              CASE Choose OF 
                1:
                  BEGIN
                    WRITE('Введите ФИО ');            
                    READLN(FIO);                  
                    InsHesh(Tel, FIO);
                    WRITELN('Номер добавлен.');                                
                    WRITELN(Fout,'Номер добавлен. ', Tel,' ',FIO);                                
                    PrintHesh();
                  END;  
                2: 
                  BEGIN
                    FindHesh(Tel, TRUE);              
                    PrintHesh();
                  END;  
                3:
                  FindHesh(Tel, FALSE);              
                ELSE 
                  FlagEnd :=TRUE;
              END;    
            END; 
        END;
    END;
END.
