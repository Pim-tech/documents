//STEP1 EXEC PGM=IKJEFT01
//SYSTSPRT DD SYSOUT=*
//SYSTSIN DD *
PROFILE NOPREFIX
adduser JOHN special operations password(ABCDE) +
name('Marc ') +
owner(SYS1) +
tso( acctnum(ACCT#) +
proc(DBSPROC) +
size(1280000) +
unit(SYSDA) +
) +
dfltgrp(SYS1)

permit DBSPROC cl(TSOPROC ) ac(READ) id(JOHN ) <-- if you don't use UACC=READ for SYS1 connection.
