{ 
1.�   ���������   ���������   ����������   ��   ���������
�����������  ������ ����� ���������.  � ������ �� ��� ��������
�������� ������� ������������� ����������,  ���������� �  ����
�������  �������  ��  �������,  �������  �����  �����  � �����
������� �����������. ���������� ����� ���� ����������� � �����
�������������   �������,   ��   ��������,   �  ������������  �
����������������  �����������  ��������.  ��   ������   ������
�������� ����� ������������� ������� �������, ������� ��������
������  ���������,  �  ���  ������  ���������  ������   ������
�����������  �  ���  �����������.  ���������  ���������  �����
������������  ����������  �����������.  ������  ������   �����
��������� (12).
2.����� ������ ��-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - �������� ������������� 
  OUTPUT - �������� �������������
5.INPUT - ��� �����, �� ������ ������ � ������
  OUTPUT - ������ ���������, ������������� ���������� �����������
}






PROGRAM ClassList(INPUT, OUTPUT);
TYPE
  UKAZ = ^uzel;
  uzel = RECORD                                  
         name: STRING;     {��� �������}
         left, right: UKAZ; {�������}
         fath: UKAZ;       {���� � �������� ������}
         urov: INTEGER;    {������� ��������� ������, ������� � 0}
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
          IF POS('- ��������� ' + Father^.name + '.', NameFac) = 0
          THEN
            NumFac := NumFac + 1;
          IF NameFac <> ''
          THEN        
            NameFac := NameFac + char(10);
          NameFac := NameFac + '��������� ' + r^.fath^.name + ',' + ' ������ ' + r^.fath^.fath^.name + ',' + ' ����� ���������� ' + r^.name + ' + ' - ��������� ' + Father^.name + '.';  
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
  root^.fath := NIL;  {����}
  m := 0;             {������� �������}
  t := root;          {���������� ������� ��� ��������� � �����}
  WHILE NOT EOF(Fin) DO
    BEGIN
      ReadLn(Fin, S);
      k := 0;
      Len := Length(S);
      WHILE S[k + 1] = '+' DO k := k + 1;   {k-������� �������, ������� � 0}
      R := Copy(S, k + 1, Len - k);         {��� �������}
      New(kon);
      kon^.name := R;
      kon^.left := NIL;
      kon^.right := NIL;
      kon^.urov := k;
      IF k > m THEN               {������� �� ��������� �������}
        BEGIN
          t^.left := kon;
          kon^.fath := t;
        END
      ELSE
        IF k = m THEN             {��� �� �������}
          BEGIN
            t^.right := kon;
            kon^.fath := t^.fath; {���� ��� ��, ��� � �����}
          END
        ELSE                    {������ �� ������ �� m-k �������}
          BEGIN
            p := t;
            FOR i := 1 TO m - k DO
              p := p^.fath;
            {p-���������� ������� ���� �� ������}
            kon^.fath := p^.fath; {���� � �������� ������ ��� ��, ��� � �����}
            p^.right := kon;
          END;
      m := k;       {��������� ������� �������}
      t := kon;     {��� ������ �� ��������� ��������}
    END;          {����� While}
END;
BEGIN
  WRITE('������� �������� �������� �����: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  {$I-} RESET(Fin); {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('���� ', NameFile, ' �� ������!');
      WRITELN('������ ��������� ���������. ������� ENTER.');
      READ(Ch);
      EXIT;
    END;
  //Assign(Fin,'input.txt');
  //Reset(Fin);
  FTree := NIL;
  MakeTree(FTree);
  CLOSE(Fin);      
  
  WRITE('������� �������� �������� ����� 2: ');
  READLN(NameFile1);
  NameFile1 := NameFile1 + '.txt';
  ASSIGN(Fin, NameFile1);
  {$I-} RESET(Fin); {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('���� ', NameFile1, ' �� ������!');
      WRITELN('������ ��������� ���������. ������� ENTER.');
      READ(Ch);
      EXIT;
    END;
  //Assign(Fin,'input1.txt');
  //Reset(Fin);
  BTree := NIL;
  MakeTree(BTree);
  CLOSE(Fin);
    
  WRITE('������� �������� ��������� �����: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fout, NameFile);
  REWRITE(Fout);
  //Assign(Fout,'output.txt');
  //Rewrite(Fout);
  BSerch(BTree);
  CLOSE(Fout);
END.

