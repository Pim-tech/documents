//ADCDKE   JOB  'HELLO',MSGCLASS=X,CLASS=A,
//             REGION=4M,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)
//*
//* * EXECUTION DU PROGRAMME PRINCIPAL                           *
//* **************************************************************
//*        ALLOCATION DU FICHIER DE SORTIE                       *   
//*  **************************************************************
//ALLOUER  EXEC PGM=IEFBR14
//SYSPRINT  DD SYSOUT=*
//SYSOUT    DD SYSOUT=*
//SYSDUMP   DD SYSOUT=*
//FENRICHI  DD DSN=ADCDC.FIC.CLICMDT,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1),RLSE),
//             UNIT=SYSDA,
//             DCB=(DSORG=PS,RECFM=FB,LRECL=110,BLKSIZE=1100)
//*
//*  *************************************************************
//JBAPP1   EXEC PGM=BAPP1                                        *
//* **************************************************************
//* * DECLARATION DE LA BIBLIOTHEQUE QUI CONTIENT LE LOAD MODULE *
//STEPLIB   DD DSN=ADCDC.COB.LOAD,DISP=SHR
//* **************************************************************
//FCLIENT   DD   DSN=ADCDC.FIC.CLIENTRI,DISP=SHR
//FCOMMAND  DD   DSN=ADCDC.FIC.CMDTRI,DISP=SHR
//FENRICHI  DD   DSN=ADCDC.FIC.CLICMDT,DISP=SHR
//SYSOUT    DD SYSOUT=*
//SYSIN    DD *
//*YSPRINT DD SYSOUT=*
//* **************************************************************
//* * DECLARATION DU FICHIER DES MOUVEMENTS EN ENTREE            *
//* **************************************************************

