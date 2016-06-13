
use Monetra;

$host = "testbox.monetra.com";
$sslport = 8665;
$regport = 8333;
# METHODs -- 1) IP  2) SSL
$method=2;
$MYUSER = "test_ecomm:public";
$MYPASS = "publ1ct3st";


print("LIBMONETRA PERL 0.9.0 DEMO (USING MONETRA)\r\n\r\n");
# Location for CA certificates to verify server certificate
Monetra::M_InitEngine("");

$conn=Monetra::M_InitConn();
if ($method == 1) {
    Monetra::M_SetIP($conn, $host, $regport);
} elsif ($method == 2) {
    Monetra::M_SetSSL($conn, $host, $sslport);
    Monetra::M_SetSSL_CAfile($conn, "/usr/local/monetra/CAfile.pem");
}
Monetra::M_SetBlocking($conn, 1);
Monetra::M_SetTimeout($conn, 30);

print("Connecting ...");
if (!Monetra::M_Connect($conn)) {
    $error=Monetra::M_ConnectionError($conn);
    print("Connection failed: $error");
    Monetra::M_DestroyConn($conn);
    Monetra::M_DestroyEngine();
    exit();
}
print("success!\r\n\r\n");

print("Sending transaction:\r\n");
$identifier=Monetra::M_TransNew($conn);

Monetra::M_TransKeyVal($conn, $identifier, "username", $MYUSER);
Monetra::M_TransKeyVal($conn, $identifier, "password", $MYPASS);
Monetra::M_TransKeyVal($conn, $identifier, "action", "sale");
Monetra::M_TransKeyVal($conn, $identifier, "account", "4012888888881881");
Monetra::M_TransKeyVal($conn, $identifier, "expdate", "0512");
Monetra::M_TransKeyVal($conn, $identifier, "amount", "65.65");
Monetra::M_TransKeyVal($conn, $identifier, "street", "5800 NW 39th Ave STE 104");
Monetra::M_TransKeyVal($conn, $identifier, "zip", "32606");
Monetra::M_TransKeyVal($conn, $identifier, "cv", "999");
Monetra::M_TransKeyVal($conn, $identifier, "comments", "LIBMONETRA PERL \"TEST\"\nthis is a test");

if (!Monetra::M_TransSend($conn, $identifier)) {
    print("Failure structuring/sending transaction, probably improperly structured");
    Monetra::M_DestroyConn($conn);
    Monetra::M_DestroyEngine();
    exit();
}

$status=Monetra::M_ReturnStatus($conn, $identifier);

if ($status == Monetra::M_SUCCESS()) {    # Was it good, you may also check against Monetra::M_FAIL()
    print("Transaction Authorized!!\r\n");
} else {
    print("Transaction Denied!\r\n");
}

$code=Monetra::M_TEXT_Code(Monetra::M_ReturnCode($conn, $identifier));
print("Code: $code\r\n");

$text=Monetra::M_TransactionText($conn, $identifier);
print("Text: $text\r\n");

$ttid=Monetra::M_TransactionID($conn, $identifier);
print("TTID: $ttid\r\n");

$avs=Monetra::M_TEXT_AVS(Monetra::M_TransactionAVS($conn, $identifier));
print("AVS: $avs\r\n");

$cv=Monetra::M_TEXT_CV(Monetra::M_TransactionCV($conn, $identifier));
print("CV: $cv\r\n");

$item=Monetra::M_TransactionItem($conn, $identifier);  # Item number in Batch
print("Item: $item\r\n");

$batch=Monetra::M_TransactionBatch($conn, $identifier); # Batch Number for transaction
print("Batch: $batch\r\n");


if ($status == Monetra::M_SUCCESS()) {
    $auth=Monetra::M_TransactionAuth($conn, $identifier);
    print("auth: $auth\r\n");
}

$list = Monetra::M_ResponseKeys($conn, $identifier);
$num_items = scalar @$list;
print("\r\nDump $num_items returned key/value pairs:\r\n");

foreach $item (@$list) {
    $val = Monetra::M_ResponseParam($conn, $identifier, $item);
    print("$item = $val\r\n");
}

# OTHER FUNCTIONS OF INTEREST

# Example of pulling up a settled transaction report

# Allocate new transaction
$identifier=Monetra::M_TransNew($conn);

# User credentials
Monetra::M_TransKeyVal($conn, $identifier, "username", $MYUSER);
Monetra::M_TransKeyVal($conn, $identifier, "password", $MYPASS);

# Transaction Type
Monetra::M_TransKeyVal($conn, $identifier, "action", "admin");
Monetra::M_TransKeyVal($conn, $identifier, "admin", "GUT");

# Additional Auditing parameters may be specified
# Please consult the Monetra Client Interface Protocol

if (!Monetra::M_TransSend($conn, $identifier)) {
    print("Communication Error: " . Monetra::M_ConnectionError($conn) . "\r\n");
    # Free memory associated with conn
    Monetra::M_DestroyConn($conn);
    exit();
}

# We do not have to perform the Monetra::M_Monitor() loop because we are in
# blocking mode
if (Monetra::M_ReturnStatus($conn, $identifier) != Monetra::M_SUCCESS()) {
    print("Audit failed\r\n");
    Monetra::M_DestroyConn($conn);
    exit();
}

if (!Monetra::M_IsCommaDelimited($conn, $identifier)) {
    print("Not a comma delimited response!\r\n");
    Monetra::M_DestroyConn($conn);
    exit();
}

# Print the raw, unparsed data
print("Raw Data:\r\n" . Monetra::M_GetCommaDelimited($conn, $identifier) . "\r\n");

# Tell the API to parse the Data
use Benchmark qw(:all);
$count = 10;

if (!Monetra::M_ParseCommaDelimited($conn, $identifier)) {
    print("Parsing comma delimited data failed");
    Monetra::M_DestroyConn($conn);
    exit();
}

# Retrieve each number of rows/columns
$rows=Monetra::M_NumRows($conn, $identifier);
$columns=Monetra::M_NumColumns($conn, $identifier);

# Print all the headers separated by |'s
for ($i=0; $i<$columns; $i++) {
    if ($i != 0) { print("|"); }
    print(Monetra::M_GetHeader($conn, $identifier, $i));
}

print("\r\n");

# Print one row per line, each cell separated by |'s
for ($j=0; $j<$rows; $j++) {
    for ($i=0; $i<$columns; $i++) {
	if ($i != 0) { print("|"); }

	# Use Monetra::M_GetCell instead of Monetra::M_GetCellByNum if you need
	# a specific column, as the results will allow for position- independent
	# searching of the results. The ordering of returned headers may be
	# different between Monetra versions, so that is _highly_ recommended

	print(Monetra::M_GetCellByNum($conn, $identifier, $i, $j));
    }
    print("\r\n");
}


# Optionally free transaction, though Monetra::M_DestroyConn() will do this for
# us

Monetra::M_DeleteTrans($conn, $identifier);

# Clean up and close
print("\r\nclosing connection and cleaning up\r\n");
Monetra::M_DestroyConn($conn);
Monetra::M_DestroyEngine();
