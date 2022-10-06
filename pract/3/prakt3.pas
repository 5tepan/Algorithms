PROGRAM turtle;
Var
  Fin,Fout: Text;
  NameFile: STRING;
  Ch: CHAR; 
  Mat,Mat_ : array [1..500,1..500] of INTEGER ;
  N,M,b,i,j,ii,jj: INTEGER;
  Nstr: STRING;
 
 BEGIN
  WRITE('Âגוהטעו פאיכ ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  RESET(Fin);
  ASSIGN(FOut, "Out"+NameFile);
  REWRITE(FOut);
  
  READLN(Fin,Nstr);
  i:=Pos(' ',Nstr);
  VAL(Copy(Nstr,1,i-1),N,b);
  VAL(Copy(Nstr,i+1,Length(Nstr)),M,b);
  Writeln(N,' = ',M); 
  FOR i:=1 to N 
  DO
    BEGIN
      READLN(Fin,Nstr); 
      Writeln(i,' = ',Nstr);
     
      jj:=1;
      j:=1;
      ii:=1;
      WHILE ii<M
      //FOR ii:=1 to M
        DO  
        BEGIN         
          IF  Nstr[j]=' '
          THEN
          BEGIN
          //Writeln(N,' = ',M);
            VAL(Copy(Nstr,jj,j-1),Mat[i,ii],b);
            jj:=j+1;
            ii:=ii+1;
          END;
          j:=j+1;
          END;  
       VAL(Copy(Nstr,jj,LENGTH(Nstr)),Mat[i,ii],b);   
    END;
  
  Mat_[1,1]:=Mat[1,1]; 
  FOR i:=2 to N 
  DO
    Mat_[i,1]:=Mat_[i-1,1]+Mat[i,1];
  FOR j:=2 to M 
  DO
    Mat_[1,j]:=Mat_[1,j-1]+Mat[1,j];   
  FOR i:=2 to N 
  DO
    FOR j:=2 to M     
    DO  
     Mat_[i,j]:=Min(Mat_[i-1,j],Mat_[i,j-1])+Mat[i,j];
  // OUT
  WriteLN(FOUT,Mat_[N,M]);                       
  i:=N;
  j:=M;
  WriteLN(FOUT,i," ",j); 
  WHILE (i>1) OR (j>1) 
  DO
    BEGIN
      IF Mat_[i,j]-Mat[i,j]=Mat_[i-1,j]
      THEN
        i:=i-1
      ELSE
         j:=j-1;
      WriteLN(FOUT,i," ",j);    
    END; 
    WriteLN(FOUT,i," ",j);
END.
