       IDENTIFICATION DIVISION.                                         00010000
       PROGRAM-ID. SP001.                                               00020000
      ***********************************                               00030000
      *    PROGRAMME APPELE             *                               00040000
      *                                 *                               00050000
      *    APPEL D'UN SOUS-PROGRAMME    *                               00060000
      *                                 *                               00070000
      ***********************************                               00080000
      DATA DIVISION.                                                    00090000
      WORKING-STORAGE SECTION.                                          00100000
      01  WS-PROGRAM PIC X(8) VALUE 'SP001'.                            00110000
      LINKAGE SECTION.                                                  00120000
      01 LS-LIEN.                                                       00130000
          05 LS-RECU  PIC X(5).                                         00140000
          05 LS-CR    PIC X(2).                                         00150000
          05 LS-ENVOI PIC X(50).                                        00160000
      PROCEDURE DIVISION USING LS-LIEN.                                 00170000
      0000-APPEL-DEB.                                                   00180000
          DISPLAY 'CE SOUS-PROGRAMME NE LIT RIEN '.                     00190000
          DISPLAY 'IL N''ECRIT RIEN'                                    00200000
          DISPLAY 'IL EST APPELE PAR PROGRAMME'.                        00210000
          IF LS-RECU IS NUMERIC                                         00220000
              MOVE "CETTE CHAINE EST NUMERIQUE" TO LS-ENVOI             00230000
          ELSE                                                          00240000
              MOVE "CETTE CHAINE EST ALPHANUMERIQUE" TO LS-ENVOI        00250000
          END-IF.                                                       00260000
          DISPLAY WS-PROGRAM-ID " VOUS DIT BYE " LS-LIEN.               00270000
          GOBACK.                                                       00280000
      0000-APPEL-FIN.                                                   00290000
          EXIT.                                                         00300000
                                                                        00310000
                                                                        00320000
                                                                        00330000
