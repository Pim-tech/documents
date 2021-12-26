//*********************************************************************
//*********************************************************************
//******* ACHTUNG: CAPS OFF!!!! ************************************
//*********************************************************************
//*********************************************************************
//PATHS EXEC PGM=IKJEFT1B
//SYSTSPRT DD SYSOUT=*
//SYSTSIN DD *
PROF MSGID WTPMSG
MKDIR '/u/umnt/userid' MODE(7 5 5)
//DEFALIAS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
DEFINE ALIAS(NAME(USERID) RELATE(USERCAT.TSOUSER)) +
CAT(CATALOG.MASTER)
//*
//DEFRACF EXEC PGM=IKJEFT01,DYNAMNBR=20
//SYSLBC DD DSN=SYS1.BRODCAST,DISP=SHR
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=*
//SYSIN DD DUMMY
//SYSTSIN DD *
AU USERID DATA('Name') DFLTGRP(SYS4) PASSWORD(SYS4) +
OMVS(HOME('/u/umnt/userid') PROGRAM('/bin/sh') AUTOUID) +
TSO(ACCTNUM(ACCT#) COMMAND(ISPF) PROC(ISPFPROC) SIZE(2048000))
ADDSD 'USERID.**' UACC(NONE) OWNER(USERID)
PE 'USERID.**' CLASS(DATASET) ID(USERID) ACCESS(ALTER)
PE 'USERID.**' CLASS(DATASET) ID(SYS0) ACCESS(ALTER)
PE 'USERID.**' CLASS(DATASET) ID(SYS2) ACCESS(READ)
PE 'USERID.**' CLASS(DATASET) ID(SYS4) ACCESS(READ)
//

