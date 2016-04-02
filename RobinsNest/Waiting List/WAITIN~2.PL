#!perl

use DBI;
use DBD::ODBC;
use WIN32::OLE;

sub sortCodes;
sub recordArr;

my $Excel = Win32::OLE->new("Excel.Application") || 
    die ("Cannot start excel");

# get a new workbook
$book = $Excel->Workbooks->Add;

# write to a particular cell
$sheet = $book->Worksheets(1);

print ("Create waiting list report \n");

my $dsn="dbi:ODBC:CplayONE";
my $user="";
my $password="";

my $rc,$rv,$dbh,$sth;

$dbh = DBI->connect($dsn, $user, $password,
                      { RaiseError => 1, AutoCommit => 1});

$sth = $dbh->prepare(
" SELECT child.Surname,
         child.foreName,
         child.Knownas,
         monSession.SessionCode,
         monSession.SessionSymbol,
         tuesSession.SessionCode,
         tuesSession.SessionSymbol,
         wedSession.SessionCode,
         wedSession.SessionSymbol,
         thursSession.SessionCode,
         thursSession.SessionSymbol,
         friSession.SessionCode,
         friSession.SessionSymbol
    FROM tblChild child, 
         tblBooking booking, 
         tblSession monSession,
         tblSession tuesSession,
         tblSession wedSession,
         tblSession thursSession,
         tblSession friSession
   WHERE booking.ChildCode = child.ChildCode
     AND booking.startDate > \#01/01/01\#
     AND booking.startDate < \#02/01/01\#
     AND monSession.SessionCode   = booking.MondaySessionCode
     AND tuesSession.SessionCode  = booking.TuesdaySessionCode
     AND wedSession.SessionCode   = booking.WednesdaySessionCode
     AND thursSession.SessionCode = booking.ThursdaySessionCode
     AND friSession.SessionCode   = booking.FridaySessionCode")
    || die("Unable to prepare select statement");

$rv = $sth->execute
    || die ("Unable to execute query");

while (($surname, 
	$forename,
	$knownas,
	$monSessionCode,
	$monSessionSymb,
	$tuesSessionCode,
	$tuesSessionSymb,
	$wedSessionCode,
	$wedSessionSymb,
	$thursSessionCode,
	$thursSessionSymb,
	$friSessionCode,
	$friSessionSymb) = $sth->fetchrow_array) 
{
    @monSession   = addCode($knownas, $monSessionSymb  ,@monSession);
    @tuesSession  = addCode($knownas, $tuesSessionSymb ,@tuesSession);
}

$rc = $dbh->disconnect || warn $dbh->errstr;

@monSession   = sortCodes @monSession;
@tuesSession  = sortCodes @tuesSession;

displaySessionList ("MONDAY",@monSession);
displaySessionList ("TUESDAY",@tuesSession);




###########################################################
# SUBS
###########################################################

sub addCode
{
    local ( $name, $sessionCode, @sessionList ) = @_;
    if ($sessionCode ne "-")
    {
	$string = ( "$sessionCode!$name");
	push @sessionList,$string
    }

    return @sessionList;
}

sub sortCodes
{
    local ( @array ) = @_;

    foreach $_ (@monSession)
    {
	my ($sessionCode,$name) = split /!/,$_;
	if ($sessionCode =~ /[Mm]orning/)
	{
	    push @morningSession,$name;
	}
	if ($sessionCode =~ /[Aa]fternoon/)
	{
	    push @afternoonSession,$name;
	}
	if (($sessionCode =~ /[Ss]chool/) ||
	    ($sessionCode =~ /[Ff]ull/))
	{
	    push @allDaySession,$name;
	}

	if (($sessionCode =~ /[Hh]ourly/)||
	    ($sessionCode =~ /3 [Hh]ours/))
	{
	    push @miscSession,$name;
	}
    }
    
    if ($#morningSession > $#afternoonSession)
    {
	$arrSize = $#morningSession;
    } else
    {
	$arrSize = $#afternoonSession;
    }

    for $i (0..$arrSize)
    {
	$morningName = pop @morningSession;
	$afternoonName = pop @afternoonSession;

	$morningName   = "EMPTY" unless $morningName;
	$afternoonName = "EMPTY" unless $afternoonName;

	push @session,"M: ".$morningName;
	push @session,"A: ".$afternoonName;
    }
    foreach $_ (@allDaySession)
    {
	push @session, "AD: ".$_;
	push @session, "AD: ".$_;
    }
    
    foreach $_ (@miscSession)
    {
    	push @session, "UNSPECIFIED: ".$_;
    }
    return @session;
}

sub displaySessionList
{
    local( $day, @sessionList) = @_;
    print ("$day\n");
    foreach $string  (@sessionList)
    {
	print ("<$string>\n");
    }
}









