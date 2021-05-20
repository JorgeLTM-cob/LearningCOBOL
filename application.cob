       IDENTIFICATION DIVISION.
          PROGRAM-ID.   application.
          AUTHOR.      Brownies.
          DATE-WRITTEN January 4th, 2021.
       ENVIRONMENT DIVISION.
          INPUT-OUTPUT SECTION.
          FILE-CONTROL.
             SELECT CustomerFile ASSIGN TO "customer.txt"
                ORGANIZATION IS INDEXED
                ACCESS MODE IS RANDOM
                RECORD KEY IS IDNum.
       DATA DIVISION.
          FILE SECTION.
             FD CustomerFile.
                01 CustomerData.
                   02 IDNum PIC 9(5).
                   02 FirstName PIC X(15).
                   02 LastName  PIC X(15).
          WORKING-STORAGE SECTION.
             01 Choice PIC 9.
             01 StayOpen PIC X VALUE 'Y'.
             01 CustExists PIC X.             
       PROCEDURE DIVISION.
          StartPara.
             OPEN I-O CustomerFile.
             PERFORM UNTIL StayOpen='N'
                DISPLAY "   "
                DISPLAY "1 : Add Customer"
                DISPLAY "2 : Delete Customer"
                DISPLAY "3 : Update Customer"
                DISPLAY "4 : Get Customer"
                DISPLAY "0 : Quit"
                DISPLAY ": " WITH NO ADVANCING
                ACCEPT Choice
                EVALUATE Choice
                   WHEN 1 PERFORM AddCust
                   WHEN 2 PERFORM DeleteCust
                   WHEN 3 PERFORM UpdateCust
                   WHEN 4 PERFORM GetCust
                   WHEN OTHER move 'N' TO StayOpen
                END-EVALUATE
             END-PERFORM.
             CLOSE CustomerFile.
          STOP RUN.

          AddCust.
             DISPLAY "   "
             DISPLAY "Enter ID : " WITH NO ADVANCING
             ACCEPT IDNum
             DISPLAY "Enter First Name : " WITH NO ADVANCING
             ACCEPT FirstName
             DISPLAY "Enter Last Name : " WITH NO ADVANCING
             ACCEPT LastName
             DISPLAY "   "
             WRITE CustomerData
                INVALID KEY DISPLAY "ID Taken"
             END-WRITE.

          DeleteCust.
             DISPLAY "   "
             DISPLAY "Enter Customer ID to Delete : " WITH NO ADVANCING
             ACCEPT IDNum
             DELETE CustomerFile
                INVALID KEY DISPLAY "Customer Doesn't exist"
             END-DELETE.

          UpdateCust.
             MOVE 'Y' TO CustExists
             DISPLAY "   "
             DISPLAY "Enter Customer ID to Update : " WITH NO ADVANCING
             ACCEPT IDNum
             READ CustomerFile
                INVALID KEY MOVE 'N' TO CustExists
             END-READ
             IF CustExists = 'N'
                DISPLAY "Customer Doesn't Exist"
             ELSE
                DISPLAY "Enter the New First Name : " WITH NO ADVANCING
                ACCEPT FirstName
                DISPLAY "Enter the New Last Name : " WITH NO ADVANCING
                ACCEPT LastName
             END-IF
             REWRITE CustomerData
                INVALID KEY DISPLAY "Customer Not Uptdated"
             END-REWRITE.

          GetCust.
             MOVE 'Y' TO CustExists
             DISPLAY "   "
             DISPLAY "Enter Customer ID to Find : " WITH NO ADVANCING
             ACCEPT IDNum
             READ CustomerFile
                INVALID KEY MOVE 'N' TO CustExists
             END-READ
             IF CustExists='N'
                DISPLAY "Customer Doesn't Exist"
             ELSE
                DISPLAY "ID : " IDNum
                DISPLAY "FirstName : " FirstName
                DISPLAY "LastName : " LastName
             END-IF.
           
             

