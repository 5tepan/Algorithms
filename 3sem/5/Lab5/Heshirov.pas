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
   h := Tel MOD M;        { ���������� � �������� 0-M1 }
   WHILE (Line=M) AND (i<LIM)
   DO
     BEGIN
       SEEK(Fin, h);
       READ(Fin, Buf);  
       IF (NOT Buf.Flag) AND Flag { ������� ��������� ����� } 
       THEN                
         Line :=h;    
       IF Buf.Flag AND (NOT Flag) AND (Buf.Number=Tel) {������ ����� } 
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
      IF (Code <> 0) or (Nom < 0)
      THEN
          WRITELN('��������� ���� !')
      ELSE
        BEGIN
          IF Flag
          THEN
            BEGIN
              WRITE('������� ��� ��������� ��������: ');
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
             WRITELN('�� �������� �������� ����� � ����������!');
          IF (Line = M) AND (NOT Flag)
          THEN
             WRITELN('��� ������ � �����������!');      
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
      WRITE('������� ����� ��������: ');
      READLN(Number);
      VAL(Number,Nom,Code);
  
      IF (Code <> 0)  or (Nom < 0)
      THEN
          WRITELN('��������� ���� !')
      ELSE
        BEGIN
          Line := M;
          InsHesh(Nom, FALSE, Line); 
          IF Line <> M
          THEN
            BEGIN
              SEEK(Fin, Line); 
              READ(Fin, Buf);         
              WRITELN('�������� �������� ',number,' ',Buf.name);
            END  
          ELSE
            WRITELN('���������� � �������� ',number,' �����������');
        END;
      WRITE('������ ���������� ����� (1/0) ? ');
      READLN(Otvet);
      IF Otvet='0'
      THEN
        FlagNotEnd := FALSE
    END;
END;        
BEGIN
  TableSize := M1;
  WRITE('������� �������� �������� �����: ');  
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  {$I-}
  REWRITE(Fin);
  {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('���� ',NameFile,' �� ��������');
      WRITELN('������ ��������� ���������.');
      ReadLn;
      EXIT;
    END;
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
  CLOSE(Fin);    
END.                            

