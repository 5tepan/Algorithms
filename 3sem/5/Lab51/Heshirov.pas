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
  M = 997;
  M1=M-1; 
  Lim = 500;
TYPE
  String30 = STRING[30];
  String10 = STRING[10];
  TSpravochnik = RECORD
    Number:String10;
    Surname:String30;
  END; 
  Field = RECORD
    Key : WORD;
    Flag : BOOLEAN;
  END;
     
VAR
  Fin1 : TEXT;
  Fin: FILE OF TSpravochnik;
  NameFile: STRING;
  Tel: LONGINT;
  Choose, b, i: INTEGER;
  Ch: CHAR; 
  Client:TSpravochnik;  
  FIO: String30;
  FlagEnd: BOOLEAN;
  Table: ARRAY[0..M1] OF Field;
  
PROCEDURE InsHesh(Tel: LONGINT; Line: INTEGER); 
VAR
  i,h: INTEGER;
BEGIN
   i := 0;
   h := Tel MOD M;        { приведение в диапазон 0-M1 }
   WHILE (NOT (Table[h].Flag)) AND (Table[h].Key<>Line) AND (i<LIM)
   DO
  { пока не найдено свободное место  }
     BEGIN
       INC(i);
       h := (Tel+i*i)MOD M
     END;
   IF Table[h].Key <> Line
   THEN   { найдено свободное место }
     BEGIN
       Table[h].Key := Line;
       Table[h].Flag := FALSE;  { признак заполнения }
     END;
END;

PROCEDURE InsFile(Tel: LONGINT; FIO: String30);
BEGIN
  STR(Tel,Client.Number);
  Client.Surname := FIO;
  SEEK(Fin,FileSize(Fin));
  WRITE(Fin, Client);
  InsHesh(Tel,FileSize(Fin));
END;

PROCEDURE FindHesh(Tel: longint; FlagDel: BOOLEAN); 
VAR
  FlagEnd: BOOLEAN;
  i,h: INTEGER;
  TelStr: String10; 
BEGIN
  i := 0;
  Str(Tel,TelStr);
  h := Tel mod M;        { приведение в диапазон 0-M1 }
  FlagEnd := FALSE;
  WHILE (NOT (Table[h].Flag))  AND (i < LIM) AND (NOT FlagEnd)
  DO
    BEGIN   
      IF Table[h].Key > 0
      THEN
        BEGIN
          SEEK(Fin,Table[h].Key-1);
          READ(Fin,Client);
          IF Client.Number=TelStr
          THEN
            BEGIN
              WRITELN('ФИО: ', Client.Surname);  
              FlagEnd:=TRUE; 
            END;    
        END;
       IF (NOT FlagEnd)
       THEN
         BEGIN
           INC(i);
           h := (Tel+i*i)MOD M;
         END;   
    END;
  IF NOT FlagEnd  
  THEN
    WRITELN('Номер не найден ', TelStr);
  IF FlagEnd AND FlagDel
  THEN
    Table[h].Key := 0;
END;
PROCEDURE SaveInput(); 
VAR
  i, j: WORD;
BEGIN      
  RESET(Fin);      
  REWRITE(Fin1);
  FOR i := 1 TO FileSize(Fin) 
  DO
    FOR j := 0 TO M1
    DO
      BEGIN
        IF Table[j].Key = i
        THEN 
          BEGIN
            READ(Fin,Client);
            WRITELN(Fin1,Client.Number);
            WRITELN(Fin1,Client.Surname);
          END;
      END;    
END;

BEGIN
  WRITE('Введите название входного файла: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin1, NameFile);
  {$I-} RESET(Fin1); {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('Файл ', NameFile, ' не найден!');
      WRITELN('Работа программы завершена. Нажмите ENTER.');
      READ(Ch);
      EXIT;
    END;
    
  ASSIGN(Fin, 'temp.txt');
  REWRITE(Fin);
  WHILE NOT EOF(Fin1) {Запись в типисированный файл}
  DO
    BEGIN
      READLN(Fin1,Client.Number);
      READLN(Fin1,Client.Surname);
      WRITE(Fin,Client);      
    END;
  CLOSE(Fin1);  
  CLOSE(Fin);
  RESET(Fin); 
  FOR i:=0 TO M1
  DO  { очистка таблицы }
    Table[i].Flag:=TRUE;
  FOR i := 1 TO FileSize(Fin) 
  DO
    BEGIN
      READ(Fin,Client);
      VAL(Client.Number,Tel,b);      
      InsHesh(Tel, i);
    END;
  FlagEnd :=FALSE;
  WHILE NOT FlagEnd 
  DO
    BEGIN
      WRITE('Введите номер (0 - выход): ');
      READLN(Tel);
      IF   Tel = 0
      THEN
        BEGIN
          FlagEnd :=TRUE;
          WRITE('Не корректный номер.')
        END  
      ELSE  
        BEGIN   
          WRITE('Введите действие (1- добавление, 2 - удаление, 3- поиск, любая другая цифра - выход): ');            
          READLN(Choose);
          CASE Choose OF 
          1:
            BEGIN
              WRITE('Введите ФИО ');            
              READLN(FIO);                  
              InsFile(Tel, FIO);
              WRITELN('Номер добавлен.');                                
            END;  
          2: 
            FindHesh(Tel, TRUE);           
          3:
            FindHesh(Tel, FALSE);              
          ELSE 
            FlagEnd :=TRUE;
          END;    
        END; 
    END;  
  SaveInput();  
  CLOSE(Fin);
  CLOSE(Fin1);
END.                            

