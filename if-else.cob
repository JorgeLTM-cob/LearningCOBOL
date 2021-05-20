       IDENTIFICATION DIVISION.
          PROGRAM-ID. if-else.
          AUTHOR. Brownies.
          DATE-WRITTEN. December 24th 2020.
       ENVIRONMENT DIVISION.
          CONFIGURATION SECTION.
             SPECIAL-NAMES.
                CLASS PassingScore IS "A" THRU "C".
       DATA DIVISION.
          FILE SECTION.
          WORKING-STORAGE SECTION.
           01 Age PIC 99 VALUE 0.
           01 Grade PIC 99 VALUE 0.
           01 Score PIC X(1) VALUE "B".
           01 CanVoteFlag PIC 9 VALUE 0.
              88 CanVote VALUE 1.
              88 CantVote VALUE 0.
           01 TestNumber PIC X.
              88 IsPrime VALUE "1", "3", "5", "7".
              88 IsOdd VALUE "1", "3", "5", "7", "9".
              88 IsEven VALUE "2", "4", "6", "8".
              88 LessThan5 VALUE "1" THRU "4".
              88 ANumber VALUE "0" THRU "9".
       PROCEDURE DIVISION.
          DISPLAY "Enter Age: " WITH NO ADVANCING.
          ACCEPT Age.
          IF (Age > 17) THEN
             DISPLAY "You Can Vote!"
          ELSE
             DISPLAY "You Can't Vote!"
          END-IF.
          IF Age < 5 THEN
            DISPLAY "Stay At Home"
          END-IF.
          IF Age = 5 THEN
            DISPLAY "Go to Kindergarten"
          END-IF.
          IF (Age > 5) AND (Age < 18) THEN
            COMPUTE Grade = Age - 5
            DISPLAY "Go to Grade: " Grade
          END-IF.
          IF Age >= 18
            DISPLAY "Go to College!"
          END-IF.
          DISPLAY "Give your Score: " WITH NO ADVANCING.
          ACCEPT Score.
          IF Score IS PassingScore THEN
             DISPLAY "You Passed!"
          ELSE
             DISPLAY "You Failed :("
          END-IF.
          IF Score IS NOT NUMERIC THEN
             DISPLAY "Not a number"
          END-IF.
          IF Age > 17 THEN
             SET CanVote TO TRUE
          ELSE
             SET CantVote TO TRUE
          END-IF.
          DISPLAY "Vote " CanVoteFlag.
          DISPLAY "Enter Single Number or X to Exit: "
          ACCEPT TestNumber.
          PERFORM UNTIL NOT ANumber
             EVALUATE TRUE
                WHEN IsPrime DISPLAY "Prime"
                WHEN IsOdd DISPLAY "Odd"
                WHEN IsEven DISPLAY "Even"
                WHEN LessThan5 DISPLAY "Less Than 5"
                WHEN OTHER DISPLAY "Default Action"
             END-EVALUATE
             ACCEPT TestNumber
          END-PERFORM.
       STOP RUN.  
