
use MCVE;

$host = "testbox.monetra.com";
$sslport = 8665;
$regport = 8333;
# METHODs -- 1) IP  2) SSL
$method=2;

print("LIBMONETRA 0.9.0 DEMO (Using MCVE)\r\n\r\n");
# Location for CA certificates to verify server certificate
MCVE::M_InitEngine("");

$conn=MCVE::M_InitConn();
if ($method == 1) {
  MCVE::M_SetIP($conn, $host, $regport);
} elsif ($method == 2) {
  MCVE::M_SetSSL($conn, $host, $sslport);
  MCVE::M_SetSSL_CAfile($conn, "/usr/local/monetra/CAfile.pem");
}
MCVE::M_SetBlocking($conn, 1);
MCVE::M_SetTimeout($conn, 30);

print("Connecting ...");
if (!MCVE::M_Connect($conn)) {
  $error=MCVE::M_ConnectionError($conn);
  print("Connection failed: $error");
  MCVE::M_DestroyConn($conn);
  MCVE::M_DestroyEngine();
  exit();
}
print("success!\r\n\r\n");

print("Sending transaction:\r\n");
$identifier=MCVE::M_TransNew($conn);
MCVE::M_TransKeyVal($conn, $identifier, "username", "test_ecomm:public");
MCVE::M_TransKeyVal($conn, $identifier, "password", "publ1ct3st");
MCVE::M_TransKeyVal($conn, $identifier, "action", "sale");
MCVE::M_TransKeyVal($conn, $identifier, "account", "4012888888881881");
MCVE::M_TransKeyVal($conn, $identifier, "expdate", "0512");
MCVE::M_TransKeyVal($conn, $identifier, "amount", "65.65");
MCVE::M_TransKeyVal($conn, $identifier, "street", "5800 NW 39th Ave STE 104");
MCVE::M_TransKeyVal($conn, $identifier, "zip", "32606");
MCVE::M_TransKeyVal($conn, $identifier, "cv", "999");
MCVE::M_TransKeyVal($conn, $identifier, "comments", "MCVE PERL TEST");

if (!MCVE::M_TransSend($conn, $identifier)) {
  print("Failure structuring/sending transaction, probably improperly structured");
  MCVE::M_DestroyConn($conn);
  MCVE::M_DestroyEngine();
  exit();
}

$status=MCVE::M_ReturnStatus($conn, $identifier);

if ($status == MCVE::M_SUCCESS()) {    # Was it good, you may also check against MCVE::M_FAIL()
  print("Transaction Authorized!!\r\n");
} else {
  print("Transaction Denied!\r\n");
}

$code=MCVE::M_TEXT_Code(MCVE::M_ReturnCode($conn, $identifier));
print("Code: $code\r\n");

$text=MCVE::M_TransactionText($conn, $identifier);
print("Text: $text\r\n");

$ttid=MCVE::M_TransactionID($conn, $identifier);
print("TTID: $ttid\r\n");

$avs=MCVE::M_TEXT_AVS(MCVE::M_TransactionAVS($conn, $identifier));
print("AVS: $avs\r\n");

$cv=MCVE::M_TEXT_CV(MCVE::M_TransactionCV($conn, $identifier));
print("CV: $cv\r\n");

$item=MCVE::M_TransactionItem($conn, $identifier);  # Item number in Batch
print("Item: $item\r\n");

$batch=MCVE::M_TransactionBatch($conn, $identifier); # Batch Number for transaction
print("Batch: $batch\r\n");


if ($status == MCVE::M_SUCCESS()) {
  $auth=MCVE::M_TransactionAuth($conn, $identifier);
  print("auth: $auth\r\n");
}

$list = MCVE::M_ResponseKeys($conn, $identifier);
$num_items = scalar @$list;
print("\r\nDump $num_items returned key/value pairs:\r\n");

foreach $item (@$list) {
	$val = MCVE::M_ResponseParam($conn, $identifier, $item);
	print("$item = $val\r\n");
}

# OTHER FUNCTIONS OF INTEREST

print("\r\nclosing connection and cleaning up\r\n");
MCVE::M_DestroyConn($conn);
MCVE::M_DestroyEngine();

