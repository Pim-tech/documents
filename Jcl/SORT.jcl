//ADCDCS   JOB  'HELLO',MSGCLASS=X,CLASS=A,
//             REGION=4M,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)
//*
//* * EXECUTION DU PROGRAMME PRINCIPAL                           *
//* **************************************************************
//TRI     EXEC PGM=SORT
//* **************************************************************
//* * DECLARATION DE LA BIBLIOTHEQUE QUI CONTIENT LE LOAD MODULE *
//* **************************************************************
//* ***************ADCDC.COB.LOAD*********************************
//STEPLIB  DD  DSN=ADCDC.COB.LOAD,DISP=SHR
//* **************************************************************
//* * DECLARATION DU FICHIER DES MOUVEMENTS EN ENTREE            *
//* **************************************************************
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SORTIN   DD DSN=ADCDC.FIC.CLIENT,DISP=SHR
//SORTOUT  DD DSN=ADCDC.FIC.CLIENTRI,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(1,1),RLSE),
//            UNIT=SYSDA,
//            DCB=(DSORG=PS,RECFM=FB,LRECL=100,BLKSIZE=1100)
//SORTWK01 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SORTWK02 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SORTWK03 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SYSIN    DD *
   SORT FIELDS=(1,5,CH,A)
//TRI     EXEC PGM=SORT
//* **************************************************************
//* * DECLARATION DE LA BIBLIOTHEQUE QUI CONTIENT LE LOAD MODULE *
//* **************************************************************
//* ***************ADCDC.COB.LOAD*********************************
//STEPLIB  DD  DSN=ADCDC.COB.LOAD,DISP=SHR
//* **************************************************************
//* * DECLARATION DU FICHIER DES MOUVEMENTS EN ENTREE            *
//* **************************************************************
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SORTIN   DD DSN=ADCDC.FIC.COMAND,DISP=SHR
//SORTOUT  DD DSN=ADCDC.FIC.CMDTRI,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(1,1),RLSE),
//            UNIT=SYSDA,
//            DCB=(DSORG=PS,RECFM=FB,LRECL=110,BLKSIZE=1100)
//SORTWK01 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SORTWK02 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SORTWK03 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SYSIN    DD *
   SORT FIELDS=(9,5,CH,A)
/*
//LECTURE  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//TRIE     DD DSN=ADCDC.FIC.TRIE,DISP=SHR
//SYSIN    DD *
      PRINT    INFILE(TRIE)
//
