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
  REZULTAT = ^Rezuzel;
  Rezuzel = RECORD                                  
         Fname, CompName,Aname,Corpname: STRING;     {���������, ����}
         left: REZULTAT; 
         Kol: INTEGER;    {����������}         
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
  Rez: Rezultat;
  
PROCEDURE FSerch(t, r: UKAZ; Var Rez: Rezultat);
VAR
  j: INTEGER;
  Father: UKAZ;
  root,p: Rezultat;
  FlagFind: BOOLEAN;
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

          New(root);
          root^.Fname := Father^.name;
          root^.CompName := r^.name;
          root^.AName := r^.fath^.name;
          root^.Corpname := r^.fath^.fath^.name;          
          root^.Kol := 0;
          root^.left := Rez;             
          IF Rez<>NIL
          THEN
            root^.Kol := Rez^.Kol;
          FlagFind:=  FALSE;
          WHILE Rez<>NIL
          DO
           BEGIN
             IF Rez^.Fname=Father^.name
             THEN 
               FlagFind :=  TRUE;
              Rez := Rez^.left;
           END; 
          IF FlagFind =  FALSE 
          THEN  
            root^.Kol := root^.Kol+1;  
          Rez:=root; 
          //IF POS('- ��������� ' + Father^.name + '.', NameFac) = 0
          //THEN
          //  NumFac := NumFac + 1;
          //IF NameFac <> ''
          //THEN
          //  NameFac := NameFac + char(10);
          //NameFac := NameFac + '��������� ' + r^.fath^.name + ',' + ' ������ ' + r^.fath^.fath^.name + ',' + ' ����� ���������� ' + r^.name + ' - ��������� ' + Father^.name + '.';  
        END;       
      FSerch(t^.left, r, Rez);
      FSerch(t^.right, r, Rez);
    END
END;
  
PROCEDURE BSerch(t: UKAZ);
VAR
  j: INTEGER;
BEGIN
  IF t <> NIL 
  THEN
    BEGIN
      IF t^.urov = 2
      THEN
        BEGIN  
          Rez := NIL;
//          NameFac := '';
//          NumFac := 0;
        END;
      IF t^.urov = 3
      THEN
        FSerch(FTree, t, Rez);   
      BSerch(t^.left);
      IF (t^.urov = 2) AND (Rez<>NIL)  AND  (Rez^.Kol > 1)
      THEN
        BEGIN
          IF Rez <> NIL
          THEN
            WRITELN(Fout, '��������� ', Rez^.AName, ',', ' ������ ', Rez^.CorpName, ',');
          WHILE Rez <> NIL
          DO
            BEGIN
              WRITELN(Fout,'      ', ' ����� ���������� ', Rez^.CompName, ' - ��������� ', Rez^.Fname, '.');          
              Rez := Rez^.left;
            END;       
        END;                   
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


