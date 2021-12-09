 EDIT       ADCDC.COB.JCL(HELLO) - 01.04                    Columns 00001 00072 
 Command ===>                                                  Scroll ===> PAGE 
 ****** ***************************** Top of Data ******************************
 000001 //ADCDCE   JOB  'HELLO',MSGCLASS=X,CLASS=A,                             
 000002 //             REGION=4M,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)      
 000003 //*                                                                     
 000004 //* * EXECUTION DU PROGRAMME PRINCIPAL                           *      
 000005 //* **************************************************************      
 000006 //HELLO   EXEC PGM=HELLO                                                
 000007 //* **************************************************************      
 000008 //* * DECLARATION DE LA BIBLIOTHEQUE QUI CONTIENT LE LOAD MODULE *      
 000009 //* **************************************************************      
 000010 //STEPLIB  DD  DSN=ADCDC.COB.LOAD,DISP=SHR                              
 000011 //* **************************************************************      
 000012 //* * DECLARATION DU FICHIER DES MOUVEMENTS EN ENTREE            *      
 000013 //* **************************************************************      
 000014 //SYSPRINT DD SYSOUT=*                                                  
 000015 /*                                                                      
 ****** **************************** Bottom of Data ****************************