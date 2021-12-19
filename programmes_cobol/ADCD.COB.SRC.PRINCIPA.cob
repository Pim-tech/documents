       PROGRAM-ID. P22601.                                              00010002
      *      PROGRAMME PRINCIPAL                          *             00020002
      *      APPEL D'UN SOUS-PROGRAMME                    *             00030002
      *****************************************************             00040002
       DATA DIVISION.                                                   00050002
       01  WS-PROGRAM-ID    PIC X(8) VALUE 'P22601'.                    00060002
       01  WS-CHAINE2    PIC X(5)  VALUE ALL   "12334".                 00070002
          05  WS-ENVOI          PIC X(5).                               00080002
          05  WS-REPONSE        PIC X(50).                              00090002
       PROCEDURE DIVISION.                                              00100002
       0000-APPEL-DEB.                                                  00101003
           DISPLAY 'BONJOUR TOUT LE MONDE'.                             00110002
           DISPLAY 'CE PROGRAMME NE LIT RIEN.'.                         00111003
           DISPLAY 'IL APPELLE UN SOUS-PROGRAMME'.                      00120002
           MOVE WS-CHAINE1 TO WS-ENVOI.                                 00130003
           DISPLAY 'AVANT APPEL:' WS-ZONE-APPEL.                        00140003
           CALL WS-SOUS-PROGRAMME USING WS-ZONE-APPEL.                  00150003
           DISPLAY 'APRES APPEL:' WS-ZONE-APPEL.                        00160003
       DISPLAY " ".                                                     00170003
       MOVE SPACE TO WS-ZONE-APPEL.                                     00180003
       MOVE WS-CHAINE1 TO WS-ENVOI.                                     00190003
       DISPLAY 'AVANT APPEL:' WS-ZONE-APPEL.                            00200003
       CALL WS-SOUS-PROGRAMME USING WS-ZONE-APPEL.                      00210003
       DISPLAY 'APRES APPEL: ' WS-ZONE-APPEL.                           00220003
       STOP RUN.                                                        00230003
  0000-APPEL-FIN.                                                       00240003
       EXIT.                                                            00250003
