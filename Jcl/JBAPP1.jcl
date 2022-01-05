//ADCDKE   JOB  'HELLO',MSGCLASS=X,CLASS=A,
//             REGION=4M,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)
//*
//* * EXECUTION DU PROGRAMME PRINCIPAL                           *
//* **************************************************************
//JBAPP1   EXEC PGM=BAPP1
//* **************************************************************
//* * DECLARATION DE LA BIBLIOTHEQUE QUI CONTIENT LE LOAD MODULE *
//STEPLIB   DD DSN=ADCDK.COB.LOAD,DISP=SHR
//* **************************************************************
//FCLIENT   DD   DSN=ADCDK.FIC.CLIENT,DISP=SHR
//FCOMMAND  DD   DSN=ADCDK.FIC.COMMANDE,DISP=SHR
//FENRICHI  DD   DSN=ADCDK.FIC.SORTIE,DISP=SHR
//SYSOUT    DD SYSOUT=*
//SYSIN    DD *
//SYSPRINT DD SYSOUT=*
//* **************************************************************
//* * DECLARATION DU FICHIER DES MOUVEMENTS EN ENTREE            *
//* **************************************************************

