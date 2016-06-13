package Monetra;
use strict;
use warnings;
use Socket qw(IPPROTO_TCP TCP_NODELAY);
use IO::Socket;
use IO::Socket::SSL;
use IO::Select;
use MIME::Base64;
use Time::HiRes;

use base qw(Exporter);
our $VERSION     = '0.9.4';
our %EXPORT_TAGS = ( 
	'all' => [qw(
		M_InitEngine MCVE_InitEngine 
		M_DestroyEngine MCVE_DestroyEngine 
		M_InitConn MCVE_InitConn 
		M_SetIP MCVE_SetIP 
		M_SetSSL MCVE_SetSSL 
		M_SetDropFile MCVE_SetDropFile 
		M_Connect MCVE_Connect 
		M_ConnectionError MCVE_ConnectionError 
		M_DestroyConn MCVE_DestroyConn 
		M_MaxConnTimeout MCVE_MaxConnTimeout 
		M_SetBlocking MCVE_SetBlocking 
		M_ValidateIdentifier MCVE_ValidateIdentifier 
		M_VerifyConnection MCVE_VerifyConnection 
		M_VerifySSLCert MCVE_VerifySSLCert 
		M_SetSSL_CAfile MCVE_SetSSL_CAfile 
		M_SetSSL_Files MCVE_SetSSL_Files 
		M_SetTimeout MCVE_SetTimeout 
		M_TransNew MCVE_TransNew 
		M_TransKeyVal MCVE_TransKeyVal 
		M_TransBinaryKeyVal MCVE_TransBinaryKeyVal 
		M_TransSend MCVE_TransSend 
		M_CheckStatus MCVE_CheckStatus 
		M_CompleteAuthorizations MCVE_CompleteAuthorizations 
		M_DeleteTrans MCVE_DeleteTrans 
		M_Monitor MCVE_Monitor 
		M_TransInQueue MCVE_TransInQueue 
		M_TransactionsSent MCVE_TransactionsSent 
		M_GetCell MCVE_GetCell 
		M_GetBinaryCell MCVE_GetBinaryCell 
		M_GetCellByNum MCVE_GetCellByNum 
		M_GetCommaDelimited MCVE_GetCommaDelimited 
		M_GetHeader MCVE_GetHeader 
		M_IsCommaDelimited MCVE_IsCommaDelimited 
		M_NumColumns MCVE_NumColumns 
		M_NumRows MCVE_NumRows 
		M_ParseCommaDelimited MCVE_ParseCommaDelimited 
		M_ResponseKeys MCVE_ResponseKeys 
		M_ResponseParam MCVE_ResponseParam 
		M_ReturnStatus MCVE_ReturnStatus 
		M_uwait MCVE_uwait 
		M_TransParam MCVE_TransParam 
		M_DeleteResponse MCVE_DeleteResponse 
		M_ReturnCode MCVE_ReturnCode 
		M_TransactionItem MCVE_TransactionItem 
		M_TransactionBatch MCVE_TransactionBatch 
		M_TransactionID MCVE_TransactionID 
		M_TransactionAuth MCVE_TransactionAuth 
		M_TransactionText MCVE_TransactionText 
		M_TransactionAVS MCVE_TransactionAVS 
		M_TransactionCV MCVE_TransactionCV
		M_TEXT_Code MCVE_TEXT_Code
		M_TEXT_AVS MCVE_TEXT_AVS
		M_TEXT_CV MCVE_TEXT_CV

		M_SUCCESS MCVE_SUCCESS
		M_FAIL MCVE_FAIL
		M_ERROR MCVE_ERROR
		M_DONE MCVE_DONE
		M_PENDING MCVE_PENDING
		M_GOOD MCVE_GOOD
		M_BAD MCVE_BAD
		M_STREET MCVE_STREET
		M_ZIP MCVE_ZIP
		M_UNKNOWN MCVE_UNKNOWN
		M_AUTH MCVE_AUTH
		M_DENY MCVE_DENY
		M_CALL MCVE_CALL
		M_DUPL MCVE_DUPL
		M_PKUP MCVE_PKUP
		M_RETRY MCVE_RETRY
		M_SETUP MCVE_SETUP
		M_TIMEOUT MCVE_TIMEOUT
		MC_TRANTYPE MC_USERNAME
		MC_PASSWORD MC_ACCOUNT
		MC_TRACKDATA MC_EXPDATE
		MC_STREET MC_ZIP
		MC_CV MC_COMMENTS
		MC_CLERKID MC_STATIONID
		MC_APPRCODE MC_AMOUNT
		MC_PTRANNUM MC_TTID
		MC_USER MC_PWD
		MC_ACCT MC_BDATE
		MC_EDATE MC_BATCH
		MC_FILE MC_ADMIN
		MC_AUDITTYPE MC_CUSTOM
		MC_EXAMOUNT MC_EXCHARGES
		MC_RATE MC_PRIORITY
		MC_CARDTYPES MC_SUB
		MC_NEWBATCH MC_CURR
		MC_DESCMERCH MC_DESCLOC
		MC_ORIGTYPE MC_PIN
		MC_VOIDORIGTYPE

		MC_TRAN_SALE MC_TRAN_REDEMPTION
		MC_TRAN_PREAUTH MC_TRAN_VOID
		MC_TRAN_PREAUTHCOMPLETE MC_TRAN_FORCE
		MC_TRAN_RETURN MC_TRAN_RELOAD
		MC_TRAN_CREDIT MC_TRAN_SETTLE
		MC_TRAN_INCREMENTAL MC_TRAN_REVERSAL
		MC_TRAN_ACTIVATE MC_TRAN_BALANCEINQ
		MC_TRAN_CASHOUT MC_TRAN_TOREVERSAL
		MC_TRAN_SETTLERFR MC_TRAN_ISSUE
		MC_TRAN_TIP MC_TRAN_MERCHRETURN
		MC_TRAN_IVRREQ MC_TRAN_IVRRESP
		MC_TRAN_ADMIN MC_TRAN_PING
		MC_TRAN_CHKPWD

		MC_TRAN_CHNGPWD MC_TRAN_LISTSTATS
		MC_TRAN_LISTUSERS MC_TRAN_GETUSERINFO
		MC_TRAN_ADDUSER MC_TRAN_EDITUSER
		MC_TRAN_DELUSER MC_TRAN_ENABLEUSER
		MC_TRAN_DISABLEUSER MC_TRAN_IMPORT
		MC_TRAN_EXPORT MC_TRAN_ERRORLOG
		MC_TRAN_CLEARERRORLOG MC_TRAN_GETSUBACCTS
 
		MC_ADMIN_GUT MC_ADMIN_GL
		MC_ADMIN_GFT MC_ADMIN_BT
		MC_ADMIN_UB MC_ADMIN_QC
		MC_ADMIN_CTH MC_ADMIN_CFH
		MC_ADMIN_FORCESETTLE MC_ADMIN_SETBATCHNUM
		MC_ADMIN_RENUMBERBATCH MC_ADMIN_FIELDEDIT
		MC_ADMIN_CLOSEBATCH
	)]
);
Exporter::export_ok_tags ('all');


#################### subroutine header begin ####################

=head2 sample_function

 Usage     : How to use this function/method
 Purpose   : What it does
 Returns   : What it returns
 Argument  : What it wants to know
 Throws    : Exceptions and other anomolies
 Comment   : This is a sample subroutine header.
           : It is polite to include more pod and fewer comments.

See Also   : 

=cut

#################### subroutine header end ####################


sub new
{
	my ($class, %parameters) = @_;

	my $self = bless ({}, ref ($class) || $class);

	return $self;
}


#################### main pod documentation begin ###################

=head1 NAME

Monetra - Interfacing with Monetra

=head1 SYNOPSIS

  use Monetra;

=head1 DESCRIPTION

Native implementation of libmonetra in pure Perl. Meant to be fully binary
compatible with the C version of the module.

=head1 USAGE

See test.pl

=head1 BUGS


=head1 SUPPORT
    support@monetra.com

=head1 AUTHOR

    Brad House
    CPAN ID: MODAUTHOR
    Main Street Softworks
    support@monetra.com
    http://www.monetra.com

=head1 COPYRIGHT

Copyright (c) 2010 Main Street Softworks. All rights reserved. 
This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

perl(1).

=cut

#################### main pod documentation end ###################

use constant M_CONN_SSL => 1;
use constant M_CONN_IP  => 2;

use constant M_TRAN_STATUS_NEW  => 1;
use constant M_TRAN_STATUS_SENT => 2;
use constant M_TRAN_STATUS_DONE => 3;

use constant M_ERROR   => -1;
use constant M_FAIL    => 0;
use constant M_SUCCESS => 1;

use constant M_DONE    => 2;
use constant M_PENDING => 1;

$Monetra::init_cafile = "";

sub M_InitEngine($)
{
	$Monetra::init_cafile = $_[0];
}
sub MCVE_InitEngine($); *MCVE_InitEngine = \&M_InitEngine;


sub M_DestroyEngine()
{
	# Do Nothing
}
sub MCVE_DestroyEngine(); *MCVE_DestroyEngine = \&M_DestroyEngine;


sub M_InitConn()
{
	my $conn = {
		blocking     => 0,
		conn_error   => "",
		conn_timeout => 10,
		host         => "",
		last_id      => 0,
		method       => M_CONN_IP,
		port         => 0,
		readbuf      => "",
		ssl_cafile   => $Monetra::init_cafile,
		ssl_verify   => 0,
		ssl_cert     => undef,
		ssl_key      => undef,
		timeout      => 0,
		tran_array   => {},
		verify_conn  => 1,
		writebuf     => "",
		fd           => undef
	};
	return $conn;
}
sub MCVE_InitConn(); *MCVE_InitConn = \&M_InitConn;


# args: conn, host, port
sub M_SetIP($$$)
{
	my $conn        = $_[0];
	$conn->{host}   = $_[1];
	$conn->{port}   = $_[2];
	$conn->{method} = M_CONN_IP;
	return 1;
}
sub MCVE_SetIP($$$); *MCVE_SetIP = \&M_SetIP;


# args: conn, host, port
sub M_SetSSL($$$)
{
	my $conn        = $_[0];
	$conn->{host}   = $_[1];
	$conn->{port}   = $_[2];
	$conn->{method} = M_CONN_SSL;
	return 1;
}
sub MCVE_SetSSL($$$); *MCVE_SetSSL = \&M_SetSSL;


# args: conn, directory
sub M_SetDropFile($$)
{
	# Not Supported
	return 0;
}
sub MCVE_SetDropFile($$); *MCVE_SetDropFile = \&M_SetDropFile;


# args: conn
sub M_verifyping($)
{
	my $conn          = $_[0];
	my $max_ping_time = 5;

	my $blocking = $conn->{blocking};

	M_SetBlocking($conn, 0);

	my $id = M_TransNew($conn);
	M_TransKeyVal($conn, $id, "action", "ping");
	if (!M_TransSend($conn, $id)) {
		M_DeleteTrans($conn, $id);
		return 1;
	}

	my $lasttime=time();

	while (M_CheckStatus($conn, $id) == M_PENDING && time()-$lasttime <= $max_ping_time) {
		my $wait_time_ms = ($max_ping_time - (time() - $lasttime)) * 1000;
		if ($wait_time_ms < 0) {
			$wait_time_ms = 0;
		}
		if ($wait_time_ms > $max_ping_time * 1000) {
			$wait_time_ms = $max_ping_time * 1000;
		}
		if (!M_Monitor($conn, $wait_time_ms)) {
			last;
		}
	}

	M_SetBlocking($conn, $blocking);

	my $status = M_CheckStatus($conn, $id);
	M_DeleteTrans($conn, $id);
	if ($status != M_DONE) {
		return 0;
	}
	return 1;
}


# args: conn
sub M_Connect($)
{
	my $conn = $_[0];
	if ($conn->{method} == M_CONN_SSL) {
		my $SSL_ca_file     = undef;
		my $SSL_verify_mode = 0;
		my $SSL_cert_file   = undef;
		my $SSL_key_file    = undef;

		if (defined($conn->{ssl_key}) && length($conn->{ssl_key}) &&
		    defined($conn->{ssl_cert}) && length($conn->{ssl_cert})) {
			$SSL_cert_file = $conn->{ssl_cert};
			$SSL_key_file  = $conn->{ssl_key};
		}

		if (defined($conn->{ssl_cafile}) && length($conn->{ssl_cafile})) {
			$SSL_ca_file = $conn->{ssl_cafile};
		}

		if ($conn->{ssl_verify}) {
			$SSL_verify_mode = 1;
		}

		$conn->{fd} = new IO::Socket::SSL(
				PeerAddr        => $conn->{host},
				PeerPort        => $conn->{port},
				Proto           => 'tcp',
				SSL_ca_file     => $SSL_ca_file,
				SSL_cert_file   => $SSL_cert_file,
				SSL_key_file    => $SSL_key_file,
				SSL_verify_mode => $SSL_verify_mode,
				timeout         => $conn->{conn_timeout}
				);
	} else {
		$conn->{fd} = new IO::Socket::INET(
				PeerAddr        => $conn->{host},
				PeerPort        => $conn->{port},
				Proto           => 'tcp',
				timeout         => $conn->{conn_timeout}
				);
	}
	if (!defined($conn->{fd})) {
		$conn->{conn_error} = "$!";
		return 0;
	}

	# Disable Nagle algorithm, should reduce latency
	$conn->{fd}->setsockopt(IPPROTO_TCP, TCP_NODELAY, 1);

	if ($conn->{verify_conn} && !M_verifyping($conn)) {
		$conn->{conn_error} = "PING request failed";
		close $conn->{fd};
		$conn->{fd} = undef;
		return 0;
	}
	return 1;
}
sub MCVE_Connect($); *MCVE_Connect = \&M_Connect;

# args: conn
sub M_ConnectionError($)
{
	my $conn = $_[0];
	return $conn->{conn_error};
}
sub MCVE_ConnectionError($); *MCVE_ConnectionError = \&M_ConnectionError;

# args: conn
sub M_DestroyConn($)
{
	my $conn = $_[0];
	if (defined($conn->{fd})) {
		$conn->{fd}->close();
	}
	undef $conn->{fd};
	undef $conn;
}
sub MCVE_DestroyConn($); *MCVE_DestroyConn = \&M_DestroyConn;


# args: conn, secs
sub M_MaxConnTimeout($$)
{
	my $conn = $_[0];
	$conn->{conn_timeout} = $_[1];
	return 1;
}
sub MCVE_MaxConnTimeout($$); *MCVE_MaxConnTimeout = \&M_MaxConnTimeout;


# args: conn, tf
sub M_SetBlocking($$)
{
	my $conn = $_[0];
	my $tf   = $_[1];

	if ($tf) {
		$conn->{blocking} = 1;
	} else {
		$conn->{blocking} = 0;
	}

	return 1;
}
sub MCVE_SetBlocking($$); *MCVE_SetBlocking = \&M_SetBlocking;


# args: conn, tf
sub M_ValidateIdentifier($$)
{
	# stub for compatibility, meaningless for native implementation
	return 1;
}
sub MCVE_ValidateIdentifier($$); *MCVE_ValidateIdentifier = \&M_ValidateIdentifier;


# args: conn, tf
sub M_VerifyConnection($$)
{
	my $conn = $_[0];
	my $tf   = $_[1];
	if ($tf) {
		$conn->{verify_conn} = 1;
	} else {
		$conn->{verify_conn} = 0;
	}

	return 1;
}
sub MCVE_VerifyConnection($$); *MCVE_VerifyConnection = \&M_VerifyConnection;


# args: conn, tf
sub M_VerifySSLCert($$)
{
	my $conn = $_[0];
	my $tf   = $_[1];
	if ($tf) {
		$conn->{ssl_verify} = 1;
	} else {
		$conn->{ssl_verify} = 0;
	}

	return 1;
}
sub MCVE_VerifySSLCert($$); *MCVE_VerifySSLCert = \&M_VerifySSLCert;


# args: conn, cafile
sub M_SetSSL_CAfile($$)
{
	my $conn        = $_[0];
	my $cafile      = $_[1];
	$conn->{cafile} = $cafile;
	return 1;
}
sub MCVE_SetSSL_CAfile($$); *MCVE_SetSSL_CAfile = \&M_SetSSL_CAfile;


# args: conn, keyfile, certfile
sub M_SetSSL_Files($$$)
{
	my $conn     = $_[0];
	my $keyfile  = $_[1];
	my $certfile = $_[2];

	$conn->{ssl_cert} = $certfile;
	$conn->{ssl_key}  = $keyfile;

	return 1;
}
sub MCVE_SetSSL_Files($$$); *MCVE_SetSSL_Files = \&M_SetSSL_Files;


# args: conn, secs
sub M_SetTimeout($$)
{
	my $conn = $_[0];
	my $secs = $_[1];

	$conn->{timeout} = $secs;

	return 1;
}
sub MCVE_SetTimeout($$); *MCVE_SetTimeout = \&M_SetTimeout;


# args: conn
sub M_TransNew($)
{
	my $conn = $_[0];
	my $tran = {
		id              => ++$conn->{last_id},
		status          => M_TRAN_STATUS_NEW,
		comma_delimited => 0,
		in_params       => {},
		out_params      => {},
		raw_response    => "",
		csv             => undef
		};

	# Add to hash table
	$conn->{tran_array}->{$tran->{id}} = $tran;

	#my $num = scalar keys %{$conn->{tran_array}};
	#print "Num: ", $num, "\n";

	return $tran->{id};
}
sub MCVE_TransNew($); *MCVE_TransNew = \&M_TransNew;


# args: conn, id
sub M_findtranbyid($$)
{
	my $conn = $_[0];
	my $id   = $_[1];

	return $conn->{tran_array}->{$id};
}

# args: conn, id, key, val
sub M_TransKeyVal($$$$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $key  = $_[2];
	my $val  = $_[3];

	my $tran = M_findtranbyid($conn, $id);
	# Transaction not found, or has already been sent out
	if (!defined($tran) || $tran->{status} != M_TRAN_STATUS_NEW) {
		return 0;
	}
	
	$tran->{in_params}->{$key} = $val;
	
	return 1;
}
sub MCVE_TransKeyVal($$$$); *MCVE_TransKeyVal = \&M_TransKeyVal;


# args: conn, id, key, val, val_len
sub M_TransBinaryKeyVal($$$$$)
{
	my $conn    = $_[0];
	my $id      = $_[1];
	my $key     = $_[2];
	my $val     = $_[3];
	my $val_len = $_[4];
	return M_TransKeyVal($conn, $id, $key, MIME::Base64::encode($val));
}
sub MCVE_TransBinaryKeyVal($$$$$); *MCVE_TransBinaryKeyVal = \&M_TransBinaryKeyVal;


# args: conn, id
sub M_TransSend($$)
{
	my $conn    = $_[0];
	my $id      = $_[1];
	my $tran    = M_findtranbyid($conn, $id);

	my $tran_str = "";

	# Transaction not found, or has already been sent out
	if (!defined($tran) || $tran->{status} != M_TRAN_STATUS_NEW) {
		return 0;
	}

	$tran->{status} = M_TRAN_STATUS_SENT;

	# Structure Transaction
	
	# STX, identifier, FS #
	$tran_str = "\x02" . $tran->{id} . "\x1c";

	# PING is specially formed
	if (defined($tran->{in_params}->{action}) &&
	    $tran->{in_params}->{action} eq "ping") {
		$tran_str .= "PING";
	} else {
		my $key;
		my $val;
		# Each key/value pair in array as key="value" 
		while (($key, $val) = each %{$tran->{in_params}}) {
			$val =~ s/"/""/g;
			$tran_str .= $key . '="' . $val . '"' . "\r\n";
		}

		# Add timeout if necessary
		if ($conn->{timeout} != 0) {
			$tran_str .= 'timeout="' . $conn->{timeout} . '"' . "\r\n";
		}
	}
	
	# ETX
	$tran_str .= "\x03";

	$conn->{writebuf} .= $tran_str;

	if ($conn->{blocking}) {
		while (M_CheckStatus($conn, $id) == M_PENDING) {
			if (!M_Monitor($conn, -1)) {
				return 0;
			}
		}
	}
	return 1;
}
sub MCVE_TransSend($$); *MCVE_TransSend = \&M_TransSend;


# args: conn, id
sub M_CheckStatus($$)
{
	my $conn    = $_[0];
	my $id      = $_[1];
	my $tran    = M_findtranbyid($conn, $id);

	# Transaction not found, or has not been sent
	if (!defined($tran) ||
	    ($tran->{status} != M_TRAN_STATUS_SENT && $tran->{status} != M_TRAN_STATUS_DONE)) {
		return M_ERROR;
	}

	if ($tran->{status} == M_TRAN_STATUS_SENT) {
		return M_PENDING;
	}

	return M_DONE;
}
sub MCVE_CheckStatus($$); *MCVE_CheckStatus = \&M_CheckStatus;


# args: conn
sub M_CompleteAuthorizations($)
{
	my $conn     = $_[0];
	my @id_array;

	my $key;

	while ($key = each %{$conn->{tran_array}}) {
		if (M_CheckStatus($conn, $key) == M_DONE) {
			push (@id_array, $key);
		}
	}
	return \@id_array;
}
sub MCVE_CompleteAuthorizations($); *MCVE_CompleteAuthorizations = \&M_CompleteAuthorizations;


# args: conn, id
sub M_DeleteTrans($$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $tran = M_findtranbyid($conn, $id);

	if (!defined($tran)) {
		return 0;
	}
	delete($conn->{tran_array}->{$id});
	return 1;
}
sub MCVE_DeleteTrans($$); *MCVE_DeleteTrans = \&M_DeleteTrans;


# 0 if no bytes pending, 1 if bytes pending
# args: conn, to_usec
sub M_BytesPending($$)
{
	my $conn    = $_[0];
	my $to_usec = $_[1];

	if ($conn->{method} == M_CONN_SSL && $conn->{fd}->pending()) {
		return 1;
	}

	my @ready = IO::Select->new($conn->{fd})->can_read($to_usec / 1000000.00);

	
	my $fh;
	foreach $fh (@ready) {
		if ($fh == $conn->{fd}) {
			return 1;
		}
	}
	return 0;
}


# args: data
sub M_verify_comma_delimited($)
{
	my $data = $_[0];
	my $i;
	for ($i=0; $i<length($data); $i++) {
		my $ch = substr($data, $i, 1);

		# If hit a new line or a comma before an equal sign, must
		# be comma delimited
		if ($ch eq "\x0A" ||
		    $ch eq "\x0D" ||
		    $ch eq ',') {
			return 1;
		}

		# If hit an equal sign before a new line or a comma, must be
		# key/val
		if ($ch eq '=') {
			return 0;
		}
	}
	# Who knows?  Should never get here
	return 1;
}

# args: delim, data, quote_char, max_sects
sub M_explode_quoted($$$$)
{
	my $delim      = $_[0];
	my $data       = $_[1];
	my $quote_char = $_[2];
	my $max_sects  = $_[3];

	my @myarr      = ();
	my $on_quote   = 0;
	my $beginsect  = 0;
	my $cnt        = 0;

	my $i;
	my $ch;
	for ($i=0; $i<length($data); $i++) {
		$ch = substr($data, $i, 1);
		if ($ch eq $quote_char) {
			# Doubling the quote char acts as escaping
			if (substr($data, $i+1, 1) eq $quote_char) {
				$i++;
				next;
			} elsif ($on_quote) {
				$on_quote = 0;
			} else {
				$on_quote = 1;
			}
		}
		if ($ch eq $delim && !$on_quote) {
			push(@myarr, substr($data, $beginsect, $i - $beginsect));
			$beginsect = $i+1;
			$cnt++;
			if ($max_sects != 0 && $cnt == $max_sects - 1) {
				last;
			}
		}
	}
	if ($beginsect < length($data)) {
		push(@myarr, substr($data, $beginsect, length($data) - $beginsect));
	}
	return @myarr;
}

# arg: string
sub M_trim($)
{
	my $string = $_[0];

	$string =~ s/^\s+//;
	$string =~ s/\s+$//;

	return $string;
}

# arg: data
sub M_remove_dupe_quotes($)
{
	my $data = $_[0];

	my $ch;

	# Remove starting quote
	$ch = substr($data, 0, 1);
	if ($ch eq '"') {
		$data = substr($data, 1);
	}

	# Remove trailing quote
	$ch = substr($data, length($data)-1, 1);
	if ($ch eq '"') {
		$data = substr($data, 0, length($data)-1);
	}

	# Replace doubled quotes with only a single
	$data =~ s/""/"/g;

	return $data;
}

# args: conn, timeout_ms
sub M_Monitor_read($$)
{
	my $conn       = $_[0];
	my $timeout_ms = $_[1];
	
	if (!defined($conn->{fd})) {
		return 0;
	}

	if ($timeout_ms == -1) {
		$timeout_ms = 999000;
	}

	my $done;

	# Read Data
	do {
		$done = 1;
		my $retval = M_BytesPending($conn, $timeout_ms * 1000);
		if ($retval > 0) {
			my $buf = "";
			sysread($conn->{fd}, $buf, 8192);
			if (length($buf) == 0) {
				$conn->{fd}->close();
				undef $conn->{fd};
				$conn->{conn_error} = "read failure";
				return 0;
			}
			$conn->{readbuf} .= $buf;

			# Only loop on full reads
			if (length($buf) == 8192) {
				$done = 0;
			}
		}
		# Next loop should not have a timeout
		$timeout_ms = 0;
	} while(!$done);
	return 1;
}

# args: conn
sub M_Monitor_write($)
{
	my $conn = $_[0];
	
	if (!defined($conn->{fd})) {
		return 0;
	}

	# Write Data
	if (length($conn->{writebuf})) {
		if (!$conn->{fd}->write($conn->{writebuf})) {
			$conn->{fd}->close();
			undef $conn->{fd};
			$conn->{conn_error} = "write failure";
			return 0;
		}
		# XXX: ever a partial write??
		$conn->{writebuf} = "";
	}
	
	return 1;
}

# args: conn
sub M_Monitor_parse($)
{
	my $conn = $_[0];
	
	# Parse
	while (length($conn->{readbuf})) {
		if (substr($conn->{readbuf}, 0, 1) ne "\x02") {
			$conn->{fd}->close();
			undef $conn->{fd};
			$conn->{conn_error} = "protocol error, response must start with STX";
			return 0;
		}

		my $etx = index($conn->{readbuf}, "\x03");
		if ($etx == -1) {
			# Not enough data
			last;
		}

		# Chop off txn from readbuf
		my $txndata = substr($conn->{readbuf}, 0, $etx);
		if ($etx+1 == length($conn->{readbuf})) {
			$conn->{readbuf} = "";
		} else {
			my $temp = substr($conn->{readbuf}, $etx+1, length($conn->{readbuf})-($etx+1));
			$conn->{readbuf} = $temp;
		}

		my $fs = index($txndata, "\x1c");
		if ($fs == -1) {
			$conn->{fd}->close();
			undef $conn->{fd};
			$conn->{conn_error} = "protocol error, response must contain an FS";
			return 0;
		}

		my $id = substr($txndata, 1, $fs - 1);
		my $data = substr($txndata, $fs + 1, length($txndata) - $fs - 1);

		my $tran = M_findtranbyid($conn, $id);
		if (!defined($tran)) {
			print "Unrecognized identifier in response: ", $id, "\n";
			next;
		}

		$tran->{raw_response}    = $data;
		$tran->{comma_delimited} = M_verify_comma_delimited($data);
		if (!$tran->{comma_delimited}) {
			my @lines = M_explode_quoted("\n", $data, '"', 0);
			my $i;
			
			if (scalar @lines == 0) {
				$conn->{fd}->close();
				undef $conn->{fd};
				$conn->{conn_error} = "protocol error, no lines in response";
				return 0;
			}
			
			for ($i=0; $i<scalar @lines; $i++) {
				$lines[$i] = M_trim($lines[$i]);
				if (!length($lines[$i])) {
					next;
				}
				my @keyval = split("=", $lines[$i], 2);
				if (scalar @keyval != 2) {
					next;
				}
				if (!defined($keyval[0]) || !length($keyval[0])) {
					next;
				}
				$tran->{out_params}->{$keyval[0]} = M_remove_dupe_quotes(M_trim($keyval[1]));
			}
		}
		$tran->{status}          = M_TRAN_STATUS_DONE;
	}
	return 1;
}

# args: conn, timeout_ms
sub M_Monitor($)
{
	my $conn        = $_[0];
	my $timeout_ms;
	if (defined($_[1])) {
		$timeout_ms = $_[1];
	} else {
		$timeout_ms = 0;
	}

	if (!M_Monitor_write($conn)) {
		return 0;
	}
	
	if (!M_Monitor_read($conn, $timeout_ms)) {
		return 0;
	}

	if (!M_Monitor_parse($conn)) {
		return 0;
	}

	return 1;
}
sub MCVE_Monitor($); *MCVE_Monitor = \&M_Monitor;


# args: conn
sub M_TransInQueue($)
{
	my $conn = $_[0];

	return scalar(keys %{ $conn->{tran_array} });
}
sub MCVE_TransInQueue($); *MCVE_TransInQueue = \&M_TransInQueue;


# args: conn
sub M_TransactionsSent($)
{
	my $conn = $_[0];

	if (length($conn->{writebuf})) {
		return 0;
	}
	return 1;
}
sub MCVE_TransactionsSent($); *MCVE_TransactionsSent = \&M_TransactionsSent;


# args: conn, id, col, row
sub M_GetCell($$$$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $col  = $_[2];
	my $row  = $_[3];

	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return undef;
	}

	# Invalid ptr, or transaction has not returned 
	if ($tran->{status} != M_TRAN_STATUS_DONE || !$tran->{comma_delimited} || $row >= M_NumRows($conn, $id)) {
		return undef;
	}

	my $num_cols = scalar @{$tran->{csv}[0]};

	my $i;
	for ($i=0; $i<$num_cols; $i++) {
		if ($tran->{csv}[0][$i] eq $col) {
			return $tran->{csv}[$row+1][$i];
		}
	}

	return undef;
}
sub MCVE_GetCell($$$$); *MCVE_GetCell = \&M_GetCell;


# args: conn, id, col, row, outlen
sub M_GetBinaryCell($$$$$)
{
	my $conn   = $_[0];
	my $id     = $_[1];
	my $col    = $_[2];
	my $row    = $_[3];
	my $outlen = $_[4];

	$outlen = 0;

	my $out = undef;

	my $cell = M_GetCell($conn, $id, $col, $row);
	if (defined($cell)) {
		$out = MIME::Base64::encode($cell);
	}
	if (defined($out)) {
		$outlen = length($out);
	}
	return $out;
}
sub MCVE_GetBinaryCell($$$$$); *MCVE_GetBinaryCell = \&M_GetBinaryCell;


# args: conn, id, col, row
sub M_GetCellByNum($$$$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $col  = $_[2];
	my $row  = $_[3];

	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return undef;
	}

	# Invalid ptr, or transaction has not returned 
	if ($tran->{status} != M_TRAN_STATUS_DONE || !$tran->{comma_delimited} || $row >= M_NumRows($conn, $id) || $col >= M_NumColumns($conn, $id)) {
		return undef;
	}

	return $tran->{csv}[$row+1][$col];
}
sub MCVE_GetCellByNum($$$$); *MCVE_GetCellByNum = \&M_GetCellByNum;


# args: conn, id
sub M_GetCommaDelimited($$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return undef;
	}
	if ($tran->{status} != M_TRAN_STATUS_DONE) {
		return undef;
	}
	
	return $tran->{raw_response};
}
sub MCVE_GetCommaDelimited($$); *MCVE_GetCommaDelimited = \&M_GetCommaDelimited;


# args: conn, id, col
sub M_GetHeader($$$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $col  = $_[2];
	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return undef;
	}

	# Invalid ptr, or transaction has not returned 
	if ($tran->{status} != M_TRAN_STATUS_DONE || !$tran->{comma_delimited} || $col >= M_NumColumns($conn, $id)) {
		return undef;
	}

	return $tran->{csv}[0][$col];
}
sub MCVE_GetHeader($$$); *MCVE_GetHeader = \&M_GetHeader;


# args: conn, id
sub M_IsCommaDelimited($$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return undef;
	}

	# Invalid ptr, or transaction has not returned
	if ($tran->{status} != M_TRAN_STATUS_DONE) {
		return 0;
	}
	return $tran->{comma_delimited};
}
sub MCVE_IsCommaDelimited($$); *MCVE_IsCommaDelimited = \&M_IsCommaDelimited;


# args: conn, id
sub M_NumColumns($$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return 0;
	}

	# Invalid ptr, or transaction has not returned
	if ($tran->{status} != M_TRAN_STATUS_DONE || !$tran->{comma_delimited}) {
		return 0;
	}

	my @csv = @{$tran->{csv}};

	return scalar @{$csv[0]};
}
sub MCVE_NumColumns($$); *MCVE_NumColumns = \&M_NumColumns;


# args: conn, id
sub M_NumRows($$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return 0;
	}

	# Invalid ptr, or transaction has not returned
	if ($tran->{status} != M_TRAN_STATUS_DONE || !$tran->{comma_delimited}) {
		return 0;
	}

	my $len = scalar @{$tran->{csv}};

	# subtract header from count
	$len--;

	return $len;
}
sub MCVE_NumRows($$); *MCVE_NumRows = \&M_NumRows;

# args: conn, id
sub M_ParseCommaDelimited($$)
{
	my $conn = $_[0];
	my $id   = $_[1];

	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return 0;
	}

	# Invalid ptr, or transaction has not returned
	if ($tran->{status} != M_TRAN_STATUS_DONE) {
		return 0;
	}

	my @lines = M_explode_quoted("\n", $tran->{raw_response}, '"', 0);
	my @csv   = ();
	my $i;
	for ($i = 0; $i < scalar @lines; $i++) {
		my @cells = M_explode_quoted(",", $lines[$i], '"', 0);
		my $j;
		for ($j = 0; $j < scalar @cells; $j++) {
			$csv[$i][$j] = M_remove_dupe_quotes(M_trim($cells[$j]));
		}
	}

	$tran->{csv} = \@csv;

	return 1;
}
sub MCVE_ParseCommaDelimited($$); *MCVE_ParseCommaDelimited = \&M_ParseCommaDelimited;


# args: conn, id
sub M_ResponseKeys($$)
{
	my $conn = $_[0];
	my $id   = $_[1];

	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return 0;
	}

	# Invalid ptr, or transaction has not returned
	if ($tran->{status} != M_TRAN_STATUS_DONE) {
		return 0;
	}

	my @ret = ();
	my $key;
	my $val;
	# Each key/value pair
	while (($key, $val) = each %{$tran->{out_params}}) {
		push(@ret, $key);
	}

	return \@ret;
}
sub MCVE_ResponseKeys($$); *MCVE_ResponseKeys = \&M_ResponseKeys;


# args: conn, id, key
sub M_ResponseParam($$$)
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $key  = $_[2];

	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return 0;
	}

	# Invalid ptr, or transaction has not returned
	if ($tran->{status} != M_TRAN_STATUS_DONE) {
		return 0;
	}

	return $tran->{out_params}->{$key};
}
sub MCVE_ResponseParam($$$); *MCVE_ResponseParam = \&M_ResponseParam;


# args: conn, id
sub M_ReturnStatus($$)
{
	my $conn = $_[0];
	my $id   = $_[1];

	my $tran = M_findtranbyid($conn, $id);
	if (!defined($tran)) {
		return 0;
	}

	# Invalid ptr, or transaction has not returned
	if ($tran->{status} != M_TRAN_STATUS_DONE) {
		return M_ERROR;
	}

	if ($tran->{comma_delimited}) {
		return M_SUCCESS;
	}

	my $code = M_ResponseParam($conn, $id, "code");
	if ($code eq "AUTH" || $code eq "SUCCESS") {
		return M_SUCCESS;
	}

	return M_FAIL;
}
sub MCVE_ReturnStatus($$); *MCVE_ReturnStatus = \&M_ReturnStatus;


sub M_uwait($)
{
	Time::HiRes::usleep($_[0]);
}
sub MCVE_uwait($); *MCVE_uwait = \&M_uwait;





####################
### LEGACY BELOW ###
####################

use constant MCVE_ERROR   => M_ERROR;
use constant MCVE_FAIL    => M_FAIL;
use constant MCVE_SUCCESS => M_SUCCESS;

use constant MCVE_DONE    => M_DONE;
use constant MCVE_PENDING => M_PENDING;

use constant M_GOOD   => "GOOD";
use constant M_BAD    => "BAD";
use constant M_STREET => "STREET";
use constant M_ZIP    => "ZIP";
use constant M_UNKNOWN => undef;

use constant M_AUTH    => "AUTH";
use constant M_DENY    => "DENY";
use constant M_CALL    => "CALL";
use constant M_DUPL    => "DUPL";
use constant M_PKUP    => "PKUP";
use constant M_RETRY   => "RETRY";
use constant M_SETUP   => "SETUP";
use constant M_TIMEOUT => "TIMEOUT";

use constant MCVE_GOOD    => M_GOOD;
use constant MCVE_BAD     => M_BAD;
use constant MCVE_STREET  => M_STREET;
use constant MCVE_ZIP     => M_ZIP;
use constant MCVE_UNKNOWN => M_UNKNOWN;

use constant MCVE_AUTH    => M_AUTH;
use constant MCVE_DENY    => M_DENY;
use constant MCVE_CALL    => M_CALL;
use constant MCVE_DUPL    => M_DUPL;
use constant MCVE_PKUP    => M_PKUP;
use constant MCVE_RETRY   => M_RETRY;
use constant MCVE_SETUP   => M_SETUP;
use constant MCVE_TIMEOUT => M_TIMEOUT;


# Key definitions for Transaction Parameters 
use constant MC_TRANTYPE     => "action";
use constant MC_USERNAME     => "username";
use constant MC_PASSWORD     => "password";
use constant MC_ACCOUNT      => "account";
use constant MC_TRACKDATA    => "trackdata";
use constant MC_EXPDATE      => "expdate";
use constant MC_STREET       => "street";
use constant MC_ZIP          => "zip";
use constant MC_CV           => "cvv2";
use constant MC_COMMENTS     => "comments";
use constant MC_CLERKID      => "clerkid";
use constant MC_STATIONID    => "stationid";
use constant MC_APPRCODE     => "apprcode";
use constant MC_AMOUNT       => "amount";
use constant MC_PTRANNUM     => "ptrannum";
use constant MC_TTID         => "ttid";
use constant MC_USER         => "user";
use constant MC_PWD          => "pwd";
use constant MC_ACCT         => "acct";
use constant MC_BDATE        => "bdate";
use constant MC_EDATE        => "edate";
use constant MC_BATCH        => "batch";
use constant MC_FILE         => "file";
use constant MC_ADMIN        => "admin";
use constant MC_AUDITTYPE    => "admin";
use constant MC_CUSTOM       => "custom";
use constant MC_EXAMOUNT     => "examount";
use constant MC_EXCHARGES    => "excharges";
use constant MC_RATE         => "rate";
use constant MC_PRIORITY     => "priority";
use constant MC_CARDTYPES    => "cardtypes";
use constant MC_SUB          => "sub";
use constant MC_NEWBATCH     => "newbatch";
use constant MC_CURR         => "curr";
use constant MC_DESCMERCH    => "descmerch";
use constant MC_DESCLOC      => "descloc";
use constant MC_ORIGTYPE     => "origtype";
use constant MC_PIN          => "pin";
use constant MC_VOIDORIGTYPE => "voidorigtype";

# Args for priorities 
use constant MC_PRIO_HIGH   => "high";
use constant MC_PRIO_NORMAL => "normal";
use constant MC_PRIO_LOW    => "low";

# Args for cardtype 
use constant MC_CARD_VISA  => "visa";
use constant MC_CARD_MC    => "mc";
use constant MC_CARD_AMEX  => "amex";
use constant MC_CARD_DISC  => "disc";
use constant MC_CARD_JCB   => "jcb";
use constant MC_CARD_CB    => "cb";
use constant MC_CARD_DC    => "diners";
use constant MC_CARD_GIFT  => "gift";
use constant MC_CARD_OTHER => "other";
use constant MC_CARD_ALL   => "all";

# Value definitions for Transaction Types
use constant MC_TRAN_SALE            => "sale";
use constant MC_TRAN_REDEMPTION      => "sale";
use constant MC_TRAN_PREAUTH         => "preauth";
use constant MC_TRAN_VOID            => "void";
use constant MC_TRAN_PREAUTHCOMPLETE => "force";
use constant MC_TRAN_FORCE           => "force";
use constant MC_TRAN_RETURN          => "return";
use constant MC_TRAN_RELOAD          => "return";
use constant MC_TRAN_CREDIT          => "return";
use constant MC_TRAN_SETTLE          => "settle";
use constant MC_TRAN_INCREMENTAL     => "incremental";
use constant MC_TRAN_REVERSAL        => "reversal";
use constant MC_TRAN_ACTIVATE        => "activate";
use constant MC_TRAN_BALANCEINQ      => "balanceinq";
use constant MC_TRAN_CASHOUT         => "cashout";
use constant MC_TRAN_TOREVERSAL      => "toreversal";
use constant MC_TRAN_SETTLERFR       => "settlerfr";
use constant MC_TRAN_ISSUE           => "issue";
use constant MC_TRAN_TIP             => "tip";
use constant MC_TRAN_MERCHRETURN     => "merchreturn";
use constant MC_TRAN_IVRREQ          => "ivrreq";
use constant MC_TRAN_IVRRESP         => "ivrresp";
use constant MC_TRAN_ADMIN           => "admin";
use constant MC_TRAN_PING            => "ping";
use constant MC_TRAN_CHKPWD          => "chkpwd";

# Engine Admin Transaction Types
use constant MC_TRAN_CHNGPWD       => "chngpwd";
use constant MC_TRAN_LISTSTATS     => "liststats";
use constant MC_TRAN_LISTUSERS     => "listusers";
use constant MC_TRAN_GETUSERINFO   => "getuserinfo";
use constant MC_TRAN_ADDUSER       => "adduser";
use constant MC_TRAN_EDITUSER      => "edituser";
use constant MC_TRAN_DELUSER       => "deluser";
use constant MC_TRAN_ENABLEUSER    => "enableuser";
use constant MC_TRAN_DISABLEUSER   => "disableuser";
use constant MC_TRAN_IMPORT        => "import";
use constant MC_TRAN_EXPORT        => "export";
use constant MC_TRAN_ERRORLOG      => "errorlog";
use constant MC_TRAN_CLEARERRORLOG => "clearerrorlog";
use constant MC_TRAN_GETSUBACCTS   => "getsubaccts";

# Value definitions for Admin Types 
use constant MC_ADMIN_GUT           => "gut";
use constant MC_ADMIN_GL            => "gl";
use constant MC_ADMIN_GFT           => "gft";
use constant MC_ADMIN_BT            => "bt";
use constant MC_ADMIN_UB            => "bt";
use constant MC_ADMIN_QC            => "qc";
use constant MC_ADMIN_CTH           => "cth";
use constant MC_ADMIN_CFH           => "cfh";
use constant MC_ADMIN_FORCESETTLE   => "forcesettle";
use constant MC_ADMIN_SETBATCHNUM   => "setbatchnum";
use constant MC_ADMIN_RENUMBERBATCH => "renumberbatch";
use constant MC_ADMIN_FIELDEDIT     => "fieldedit";
use constant MC_ADMIN_CLOSEBATCH    => "closebatch";

# args: conn, id, key, val, cust_val
sub M_TransParam
{
	my $conn = $_[0];
	my $id   = $_[1];
	my $key  = $_[2];
	my $val  = $_[3];
	my $cust_val = $_[4];

	if ($key eq "custom") {
		return M_TransKeyVal($conn, $id, $val, $cust_val);
	}
	return M_TransKeyVal($conn, $id, $key, $val);
}
sub MCVE_TransParam; *MCVE_TransParam = \&M_TransParam;


sub M_DeleteResponse($$); *M_DeleteResponse = \&M_DeleteTrans;
sub MCVE_DeleteResponse($$); *MCVE_DeleteResponse = \&M_DeleteTrans;


# args: conn, id
sub M_ReturnCode($$) {
	return M_ResponseParam($_[0], $_[1], "code");
}
sub MCVE_ReturnCode($$); *MCVE_ReturnCode = \&M_ReturnCode;


# args: conn, id
sub M_TransactionItem($$) {
	return M_ResponseParam($_[0], $_[1], "item");
}
sub MCVE_TransactionItem($$); *MCVE_TransactionItem = \&M_TransactionItem;


# args: conn, id
sub M_TransactionBatch($$) {
	return M_ResponseParam($_[0], $_[1], "batch");
}
sub MCVE_TransactionBatch($$); *MCVE_TransactionBatch = \&M_TransactionBatch;


# args: conn, id
sub M_TransactionID($$) {
	return M_ResponseParam($_[0], $_[1], "ttid");
}
sub MCVE_TransactionID($$); *MCVE_TransactionID = \&M_TransactionID;


# args: conn, id
sub M_TransactionAuth($$) {
	return M_ResponseParam($_[0], $_[1], "auth");
}
sub MCVE_TransactionAuth($$); *MCVE_TransactionAuth = \&M_TransactionAuth;


# args: conn, id
sub M_TransactionText($$) {
	return M_ResponseParam($_[0], $_[1], "verbiage");
}
sub MCVE_TransactionText($$); *MCVE_TransactionText = \&M_TransactionText;


# args: conn, id
sub M_TransactionAVS($$) {
	return M_ResponseParam($_[0], $_[1], "avs");
}
sub MCVE_TransactionAVS($$); *MCVE_TransactionAVS = \&M_TransactionAVS;


# args: conn, id
sub M_TransactionCV($$) {
	return M_ResponseParam($_[0], $_[1], "cv");
}
sub MCVE_TransactionCV($$); *MCVE_TransactionCV = \&M_TransactionCV;

sub M_TEXT_Code($) {
	return $_[0];
}
sub MCVE_TEXT_Code($); *MCVE_TEXT_Code = \&M_TEXT_Code;
sub M_TEXT_AVS($); *M_TEXT_AVS = \&M_TEXT_Code;
sub MCVE_TEXT_AVS($); *MCVE_TEXT_AVS = \&M_TEXT_AVS;
sub M_TEXT_CV($); *M_TEXT_CV = \&M_TEXT_Code;
sub MCVE_TEXT_CV($); *MCVE_TEXT_CV = \&M_TEXT_CV;

1;
# The preceding line will help the module return a true value
