       IDENTIFICATION DIVISION.
          PROGRAM-ID. round.
          AUTHOR. Brownies.
          DATE-WRITTEN. December 30th, 2020.
       ENVIRONMENT DIVISION.
          CONFIGURATION SECTION.
       DATA DIVISION.
          FILE SECTION.
          WORKING-STORAGE SECTION.
             01 Price PIC 9(4)V99.
             01 TaxRate PIC V999 VALUE .075.
             01 FullPrice PIC 9(4)V99.
       PROCEDURE DIVISION.
          DISPLAY "Enter the Price : " WITH NO ADVANCING.
          ACCEPT Price.
          COMPUTE FullPrice ROUNDED = Price + (Price * TaxRate)
          DISPLAY "Price + Tax : " FullPrice.
          STOP RUN.
