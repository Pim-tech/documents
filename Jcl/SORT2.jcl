//ADCDAS   JOB  'TRIER',MSGCLASS=X,CLASS=A,
//             RESTART=TRIER,
//             REGION=4M,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)
//*
//* **************************************************************
//* * SUPPRESSION DES FICHIERS                                   *
//* **************************************************************
//SUPPRE   EXEC PGM=IEFBR14
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//DD1      DD DSN=ADCDA.FIC.TRIE,
//            DISP=(OLD,DELETE,DELETE)
//*
//* **************************************************************
//* * ALLOCATION  DES FICHIERS                                   *
//* **************************************************************
//ALLOUER  EXEC PGM=IEFBR14
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SORTOUT  DD DSN=ADCDA.FIC.TRIE,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(1,1),RLSE),
//            UNIT=SYSDA,
//            DCB=(DSORG=PS,RECFM=FB,LRECL=110,BLKSIZE=1100)
//*
//* **************************************************************
//TRIER   EXEC PGM=SORT
//* **************************************************************
//* **************************************************************
//* **************************************************************
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SORTIN   DD DSN=ADCDA.FIC.TOTO,DISP=SHR
//SORTOUT  DD DSN=ADCDA.FIC.TRIE,DISP=SHR
//SORTWK01 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SORTWK02 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SORTWK03 DD SPACE=(TRK,(1,1),RLSE),UNIT=SYSDA
//SYSIN    DD *
   SORT FIELDS=(1,3,CH,A)
/*
//* **************************************************************
//* IMPRESSION EN HEXA ET EN CLAIR
//* **************************************************************
//HEXA     EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//TRIE     DD DSN=ADCDA.FIC.TRIE,DISP=SHR
//SYSIN    DD *
      PRINT    INFILE(TRIE)
/*
//* **************************************************************
//* IMPRESSION EN  CLAIR
//* **************************************************************
//CLAIR    EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//TRIE     DD DSN=ADCDA.FIC.TRIE,DISP=SHR
//SYSIN    DD *
      PRINT    INFILE(TRIE)  CHAR
/*
//* **************************************************************
//* IMPRESSION EN  CLAIR EN OMETTANT LES 2 PREMIERS
//* **************************************************************
//CLAIR    EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//TRIE     DD DSN=ADCDA.FIC.TRIE,DISP=SHR
//SYSIN    DD *
      PRINT    INFILE(TRIE)  CHAR  -
      SKIP(2)
/*
//* **************************************************************
//* IMPRESSION EN  CLAIR EN SE LIMITANT à 3 ENREGISTREMENTS
//* **************************************************************
//CLAIR    EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//TRIE     DD DSN=ADCDA.FIC.TRIE,DISP=SHR
//SYSIN    DD *
      PRINT    INFILE(TRIE)  CHAR  -
      COUNT(3)
/*
//* **************************************************************
//* IMPRESSION EN  CLAIR EN SE LIMITANT AU  3EME ENREGISTREMENT
//* **************************************************************
//CLAIR    EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//TRIE     DD DSN=ADCDA.FIC.TRIE,DISP=SHR
//SYSIN    DD *
      PRINT    INFILE(TRIE)  CHAR  -
      SKIP(2)   -
      COUNT(1)
/*
