       IDENTIFICATION DIVISION.
          PROGRAM-ID. LIED.
          AUTHOR. Brownies.
          DATE-WRITTEN. January 5th, 2021.
       ENVIRONMENT DIVISION.
          INPUT-OUTPUT SECTION.
          FILE-CONTROL.
             SELECT SONG ASSIGN TO 'song.txt'
                ORGANIZATION IS LINE SEQUENTIAL
                ACCESS IS SEQUENTIAL.
       DATA DIVISION.
          FILE SECTION.
             FD SONG.
                01 ALINE PIC X(70).
          WORKING-STORAGE SECTION.
             01 EOF     PIC     A VALUE  'N'.
             01 REP     PIC     9 VALUE ZERO.
             01 TOTWOR  PIC  9999 VALUE ZERO.
             01 TOTREP  PIC   999 VALUE ZERO.
             01 LEN     PIC    99 VALUE ZERO.
             01 PTR     PIC    99 VALUE   01.
             01 PERCENT PIC   999V999.
             01 RESULT  PIC   ZZ9.99.
             01 BLANKS  PIC    99.
             01 LOCBLA  PIC    99.
             01 TOTCHAR PIC    99.
             01 LOCCHAR PIC    99.
             01 I       PIC    99.
             01 MYLINE  PIC X(70).
             01 AWORD   PIC X(70).
             01 PAT     PIC X(20).
       PROCEDURE DIVISION.
          DISPLAY "Please write the word to search: " WITH NO ADVANCING.
          ACCEPT PAT.
          INSPECT PAT TALLYING LEN FOR ALL ' '.
          COMPUTE LEN = 20 - LEN.
          OPEN INPUT SONG.
             PERFORM LESEN WITH TEST AFTER UNTIL EOF='Y'.
          CLOSE SONG.
          DISPLAY "Your word appears: "TOTREP" times".
          DISPLAY "The number of words in the song is: " TOTWOR.
          COMPUTE PERCENT = 100 * TOTREP / TOTWOR.
          MOVE PERCENT TO RESULT.
          DISPLAY "Your word represents the "RESULT"% of the song"
       STOP RUN.

       LESEN.
           READ SONG INTO MYLINE
             AT END MOVE 'Y' TO EOF
             NOT AT END
                MOVE ZERO TO REP
                MOVE ZERO TO BLANKS                
                MOVE ZERO TO TOTCHAR                
                MOVE ZERO TO LOCCHAR                
                MOVE ZERO TO I                
                MOVE FUNCTION LOWER-CASE(MYLINE) TO MYLINE
                INSPECT MYLINE TALLYING REP FOR ALL PAT(1:LEN)
                COMPUTE TOTREP = TOTREP + REP
                INSPECT MYLINE TALLYING BLANKS FOR ALL SPACES
                COMPUTE TOTCHAR = 70 - BLANKS
                PERFORM AUFSPALTEN WITH TEST AFTER 
                UNTIL (LOCCHAR = TOTCHAR)
                COMPUTE TOTWOR = TOTWOR + I
          END-READ.
       AUFSPALTEN.
          MOVE ' ' TO AWORD
          MOVE ZERO TO LOCBLA
          UNSTRING MYLINE DELIMITED BY SPACE
             INTO AWORD
          END-UNSTRING.
          INSPECT AWORD TALLYING LOCBLA FOR ALL SPACES
          COMPUTE LOCCHAR = 70 - LOCBLA
          COMPUTE PTR = LOCCHAR + 1
          COMPUTE LOCCHAR = LOCCHAR - I
          STRING '{' DELIMITED BY SIZE
          INTO MYLINE 
          WITH POINTER PTR
          ADD 1 TO I.
          
