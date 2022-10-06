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




PROGRAM Heshirov;
CONST
  N = 11;
  M = 997;
  M1=M-1; 
  Lim = 500;
TYPE
  Telefon=RECORD
    Flag: BOOLEAN;
    Number: LONGINT;
    Name: STRING[30]  
  END;
VAR
  Fin: FILE OF Telefon;
  TableSize, Choose, i, code, Line: INTEGER;
  Nom: LONGINT;
  Number: STRING[N];
  Buf: Telefon;
  NameFile, Otvet: STRING;
  FlagNotEnd: BOOLEAN;

PROCEDURE InsHesh(Tel: LONGINT; Flag: BOOLEAN; VAR Line: INTEGER); 
VAR
  i: INTEGER;  
  h: LONGINT; 
  Buf: Telefon;
BEGIN
   i := 0;
   h := Tel MOD M;        { приведение в диапазон 0-M1 }
   WHILE (Line=M) AND (i<LIM)
   DO
     BEGIN
       SEEK(Fin, h);
       READ(Fin, Buf);  
       IF (NOT Buf.Flag) AND Flag { найдено свободное место } 
       THEN                
         Line :=h;    
       IF Buf.Flag AND (NOT Flag) AND (Buf.Number=Tel) {найден номер } 
       THEN                
         Line :=h;       
       INC(i);
       h := (Tel+i*i)MOD M
     END;
END;
PROCEDURE InsFile(Flag, FlagNew: BOOLEAN); 
VAR
  FlagNotEnd: BOOLEAN;
  Str: STRING;
BEGIN
  IF FlagNew
  THEN   
    FOR i := 0 TO TableSize
    DO
      BEGIN
        Buf.Flag := False;
        WRITE(Fin,Buf)
      END;
    
  IF Flag  
  THEN
    Str := 'Будете продолжать ввод (1/0) ? '
  ELSE
    Str := 'Будете продолжать удаление (1/0) ? ';       
  FlagNotEnd := TRUE;
  WHILE FlagNotEnd
  DO
    BEGIN
      WRITE('Введите номер телефона : ');
      READLN(Number);
      VAL(Number,Nom,Code);
      IF (Code <> 0) or (Nom < 0)
      THEN
          WRITELN('Ошибочный ввод !')
      ELSE
        BEGIN
          IF Flag
          THEN
            BEGIN
              WRITE('Введите имя владельца телефона : ');
              READLN(Buf.name);
            END
          ELSE
            Buf.name := '';    
          Buf.Flag:=Flag;
          Buf.Number:=Nom;
          Line := M;
          InsHesh(Nom, Flag, Line); 
          IF Line <> M
          THEN
            BEGIN
              SEEK(Fin,Line);
              WRITE(Fin,Buf);
            END;
          IF (Line = M) AND Flag
          THEN
             WRITELN('Не возможно записать номер в справочник!');
          IF (Line = M) AND (NOT Flag)
          THEN
             WRITELN('Нет номера в справочнике!');      
        END;
      WRITE(Str);
      READLN(Otvet);
      IF Otvet='0'
      THEN
        FlagNotEnd:=FALSE
    END;
END;   
  
PROCEDURE FindHesh();  
VAR
  FlagNotEnd: BOOLEAN;
BEGIN
  FlagNotEnd := TRUE;
  WHILE FlagNotEnd
  DO
    BEGIN
      WRITE('Введите номер телефона : ');
      READLN(Number);
      VAL(Number,Nom,Code);
  
      IF (Code <> 0)  or (Nom < 0)
      THEN
          WRITELN('Ошибочный ввод !')
      ELSE
        BEGIN
          Line := M;
          InsHesh(Nom, FALSE, Line); 
          IF Line <> M
          THEN
            BEGIN
              SEEK(Fin, Line); 
              READ(Fin, Buf);         
              WRITELN('Владелец телефона  ',number,' ',Buf.name);
            END  
          ELSE
            WRITELN('Информация о телефоне ',number,' отсутствует');
        END;
      WRITE('Будете продолжать поиск (1/0) ? ');
      READLN(Otvet);
      IF Otvet='0'
      THEN
        FlagNotEnd := FALSE
    END;
END;        
BEGIN
  TableSize := M1;
  WRITE('Введите название входного файла: ');  
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  {$I-}
  REWRITE(Fin);
  {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('Файл ',NameFile,' не доступен');
      WRITELN('Работа программы завершена.');
      ReadLn;
      EXIT;
    END;
  FlagNotEnd := TRUE;
  WHILE FlagNotEnd 
  DO
    BEGIN
      WRITE('Введите действие (1 - создание справочника, 2 - пополнение справочника, 3 - удаление, 4 - поиск, 0 - выход): ');            
      READLN(Choose);
      CASE Choose OF 
        1:
          InsFile(TRUE, TRUE);
        2:
          InsFile(TRUE, FALSE);                                   
        3: 
          InsFile(FALSE, FALSE);
        4:
          FindHesh();              
        ELSE 
          FlagNotEnd :=FALSE;
        END;    
    END;
  CLOSE(Fin);    
END.                            

