#!perl

use DBI;
use DBD::ODBC;

print ("Create waiting list report \n");

my $dsn="dbi:ODBC:CplayONE";
my $user="";
my $password="";

my $rc,$rv,$dbh,$sth;

$dbh = DBI->connect($dsn, $user, $password,
                      { RaiseError => 1, AutoCommit => 1});

$sth = $dbh->prepare(
" SELECT child.Surname,child.foreName
    FROM tblChild child, tblBooking booking,tblSession monSession
   WHERE booking.ChildCode = child.ChildCode
     AND booking.startDate > \#01/01/01\#
     AND booking.startDate < \#02/01/01\#
     AND monSession.SessionCode   = booking.MondaySessionCode")

    || die("Unable to prepare select statement");

$rv = $sth->execute
    || die ("Unable to execute query");

print "Query will return $sth->{NUM_OF_FIELDS} fields.\n\n";

while (($surname, $forename) = $sth->fetchrow_array) 
{
    print (" SURNAME: $surname FORENAME: $forename\n");
}

$rc = $dbh->disconnect || warn $dbh->errstr;
print ("Create waiting list report DONE\n");










