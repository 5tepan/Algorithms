{ 
1.� ����� ������� ���������� ����������,  ���������� �����
���������� ���������.  ������������ ������� �����  ��  �������
���������   �   �������   �����������.  ����������  ����������
� �������� ������� ����������� (10).
2.����� ������ ��-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - �������� ������������� 
  OUTPUT - �������� ������������� � �� �����
5.INPUT - ���������� � �������� ���������  � ������� ����������
  OUTPUT - �����, ������� ����� ���� �����
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
      WRITELN('���� ',NameFile,' �� ��������');
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
    Str := '������ ���������� ���� (1/0) ? '
  ELSE
    Str := '������ ���������� �������� (1/0) ? ';        
  FlagNotEnd := TRUE;
  WHILE FlagNotEnd
  DO
    BEGIN
      WRITE('������� ����� ��������: ');
      READLN(Number);
      VAL(Number,Nom,Code);
      IF (Code <> 0) or ((Nom > TableSize) or (Nom < 0))
      THEN
          WRITELN('��������� ���� !')
      ELSE
        BEGIN
          IF Flag
          THEN
            BEGIN
              WRITE('������� ��� ��������� ��������: ');
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
      WRITELN('���� ',NameFile,' �� ��������');
      READLN;
      EXIT
    END; 
  FlagNotEnd := TRUE;
  WHILE FlagNotEnd
  DO
    BEGIN
      WRITE('������� ����� ��������: ');
      READLN(Number);
      VAL(Number,Nom,Code);
      IF (Code <> 0) or ((Nom > TableSize) or (Nom < 0))
      THEN
          WRITELN('��������� ���� !')
      ELSE
        BEGIN
          SEEK(Fin, Nom);
          READ(Fin, Buf);   
          IF (Buf.Flag)
          THEN
            WRITELN('�������� �������� ',number,' ',Buf.name)
          ELSE
            WRITELN('���������� � �������� ',number,' �����������');
        END;
      WRITE('������ ���������� ����� (1/0) ? ');
      READLN(Otvet);
      IF Otvet='0'
      THEN
        FlagNotEnd := FALSE
    END;
  CLOSE(Fin);
END;        
BEGIN
  TableSize := ROUND(EXP(N*LN(10)))-1;
  WRITE('������� �������� �������� �����: ');  
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  {$I-}
  RESET(Fin);
  {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('���� ',NameFile,' �� ��������');
      WRITELN('������ ��������� ���������.');
      ReadLn;
      EXIT;
    END;
  CLOSE(Fin);   
  FlagNotEnd := TRUE;
  WHILE FlagNotEnd 
  DO
    BEGIN
      WRITE('������� �������� (1 - �������� �����������, 2 - ���������� �����������, 3 - ��������, 4 - �����, 0 - �����): ');            
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

