{ 
1.Имеется текстовый файл с некоторым описанием. Переносов
слов нет. Требуется каждые 3 предложения отдельно в отдельный
абзац. Каждое предложение может заканчиваться точкой,
вопросительным либо восклицательным знаком (6).
2.Фомин Степан ПС-21
3. Dev+GNU Pascal 1.9.4.13
   Кодировка - 1251
4.INPUT - FIn.txt
  OUTPUT - FOut.txt
5.INPUT - текст в файле
  OUTPUT - отредактированяй текст в файле
}



PROGRAM NewParagraph(INPUT, OUTPUT);
CONST
  EndOfSentence: SET OF CHAR = ['.', '!', '?'];
  CountSentence = 3;
VAR
  Ch: CHAR;
  Count: INTEGER;
  FIn, FOut: TEXT;
  RedStr: BOOLEAN;
  NameFile:string;
BEGIN
  RedStr := TRUE;
  Count := 0; 
  WRITE('Введите название входного файла: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(FIn, NameFile);
  {$I-} RESET(FIn); {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('Файл ', NameFile, ' не найден!');
      WRITELN('Работа программы завершена. Нажмите ENTER.');
      READ(Ch);
      EXIT;
    END;
  WRITE('Введите название выходного файла: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(FOut, NameFile);
  RESET(FIn);
  REWRITE(FOut);
  WHILE NOT EOF(FIn)   
  DO
    BEGIN
      IF RedStr
      THEN
        WRITE(FOut, '   ');
      RedStr := FALSE;
      READ(FIn, Ch);
      WRITE(FOut, Ch); 
      IF EOLN(FIn)
      THEN
        BEGIN
          READLN(FIn);
          WRITELN(FOut);
        END; 
      IF Ch IN EndOfSentence
      THEN
        Count := Count + 1;
      IF Count = CountSentence
      THEN
        BEGIN
          WRITELN(FOut);
          RedStr := TRUE;
          Count := 0 
        END;
    END;  
    CLOSE(FIn);
    CLOSE(FOut);
END.
    
