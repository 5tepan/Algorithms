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
  N = 3;
TYPE
  Telefon=RECORD
    Flag: BOOLEAN;
    Name: STRING[30]  
  END;
VAR
  Fin: FILE OF Telefon;
  TableSize, Choose, i, nom, code: INTEGER;
  Number: STRING[N];
  Buf: Telefon;
  NameFile, Otvet: STRING;
  FlagNotEnd: BOOLEAN;
PROCEDURE InsFile(Flag, FlagNew: BOOLEAN); 
VAR
  FlagNotEnd: BOOLEAN;
  Str: STRING;
BEGIN
  ASSIGN(Fin, NameFile);
  {$I-}
  REWRITE(Fin);
  {$I+}  
  IF IOResult <> 0
  THEN
    BEGIN
      WRITELN('Файл ',NameFile,' не доступен');
      READLN;
      EXIT
    END;
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
      IF (Code <> 0) or ((Nom > TableSize) or (Nom < 0))
      THEN
          WRITELN('Ошибочный ввод !')
      ELSE
        BEGIN
          IF Flag
          THEN
            BEGIN
              WRITE('Введите имя владельца телефона : ');
              READLN(Buf.name);
            END;  
          Buf.Flag:=Flag;
          SEEK(Fin,Nom);
          WRITE(Fin,Buf);
        END;
      WRITE(Str);
      READLN(Otvet);
      IF Otvet='0'
      THEN
        FlagNotEnd:=FALSE
    END;
  CLOSE(Fin);
END;   
  
PROCEDURE FindHesh();  
VAR
  FlagNotEnd: BOOLEAN;
BEGIN
  ASSIGN(Fin, NameFile);
  {$I-}
  RESET(Fin);
  {$I+}
  IF IOResult <> 0
  THEN
    BEGIN
      WRITELN('Файл ',NameFile,' не доступен');
      READLN;
      EXIT
    END; 
  FlagNotEnd := TRUE;
  WHILE FlagNotEnd
  DO
    BEGIN
      WRITE('Введите номер телефона : ');
      READLN(Number);
      VAL(Number,Nom,Code);
      IF (Code <> 0) or ((Nom > TableSize) or (Nom < 0))
      THEN
          WRITELN('Ошибочный ввод !')
      ELSE
        BEGIN
          SEEK(Fin, Nom);
          READ(Fin, Buf);   
          IF (Buf.Flag)
          THEN
            WRITELN('Владелец телефона  ',number,' ',Buf.name)
          ELSE
            WRITELN('Информация о телефоне ',number,' отсутствует');
        END;
      WRITE('Будете продолжать поиск (1/0) ? ');
      READLN(Otvet);
      IF Otvet='0'
      THEN
        FlagNotEnd := FALSE
    END;
  CLOSE(Fin);
END;        
BEGIN
  TableSize := ROUND(EXP(N*LN(10)))-1;
  WRITE('Введите название входного файла: ');  
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  {$I-}
  RESET(Fin);
  {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('Файл ',NameFile,' не доступен');
      WRITELN('Работа программы завершена.');
      ReadLn;
      EXIT;
    END;
  CLOSE(Fin);   
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
END.                            

