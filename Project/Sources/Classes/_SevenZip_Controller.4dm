Class extends _CLI_Controller

Class constructor($CLI : cs:C1710._CLI)
	
	Super:C1705($CLI)
	
	This:C1470._stdErr:=""
	This:C1470._stdOut:=""
	This:C1470._stdErrBuffer:=""
	This:C1470._stdOutBuffer:=""
	
	This:C1470._progress:=0
	
Function onDataError($worker : 4D:C1709.SystemWorker; $params : Object)
	
	var $that : cs:C1710.SevenZip
	$that:=This:C1470.instance
	
	Case of 
		: ($worker.dataType="text")
			
			This:C1470._stdErrBuffer+=$params.data
			
		: ($worker.dataType="blob")
			
			This:C1470._stdErrBuffer+=Convert to text:C1012($params.data; This:C1470.encoding)
			
	End case 
	
	$data:=This:C1470._stdErrBuffer
	
	This:C1470._stdErr+=Split string:C1554($data; $that.EOL; sk ignore empty strings:K86:1 | sk trim spaces:K86:2).join("\r")
	
/*
on Windows this stream is separated by CR, not CRLF. 
CR does not count as end of line in regex
so don't use "s" metacharacter here
*/
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	Case of 
		: (Match regex:C1019("\\s*(\\d+)%[\\u0020]+(\\d+)[\\u0020]+(\\S+)[\\u0020]+(.+)"; $data; 1; $pos; $len))
			
			$progress:=Num:C11(Substring:C12($data; $pos{1}; $len{1}))
			$size:=Num:C11(Substring:C12($data; $pos{2}; $len{2}))
			$flag:=Substring:C12($data; $pos{3}; $len{3})
			$info:=Substring:C12($data; $pos{4}; $len{4})
			This:C1470._stdErr:=String:C10($progress; "^^0")+"%"+" "+$info
			This:C1470._stdErrBuffer:=""
			This:C1470._progress:=$progress
			
		: (Match regex:C1019("\\s*(\\d+)%[\\u0020]+(\\S+)[\\u0020]+(.+)"; $data; 1; $pos; $len))
			
			$progress:=Num:C11(Substring:C12($data; $pos{1}; $len{1}))
			$flag:=Substring:C12($data; $pos{2}; $len{2})
			$info:=Substring:C12($data; $pos{3}; $len{3})
			This:C1470._stdErr:=String:C10($progress; "^^0")+"%"+" "+$info
			This:C1470._stdErrBuffer:=""
			This:C1470._progress:=$progress
			
		: (Match regex:C1019("\\s*(\\d+)%"; $data; 1; $pos; $len))
			
			$progress:=Num:C11(Substring:C12($data; $pos{1}; $len{1}))
			
			This:C1470._stdErr:=String:C10($progress; "^^0")+"%"
			This:C1470._stdErrBuffer:=""
			This:C1470._progress:=$progress
			
		Else 
			
			//unimplemented stdErr message
			
	End case 
	
Function onData($worker : 4D:C1709.SystemWorker; $params : Object)
	
	var $that : cs:C1710.SevenZip
	$that:=This:C1470.instance
	
	Case of 
		: ($worker.dataType="text")
			
			This:C1470._stdOutBuffer+=$params.data
			
		: ($worker.dataType="blob")
			
			This:C1470._stdOutBuffer+=Convert to text:C1012($params.data; This:C1470.encoding)
			
	End case 
	
	$data:=This:C1470._stdOutBuffer
	
	This:C1470._stdOut+=Split string:C1554($data; $that.EOL; sk ignore empty strings:K86:1 | sk trim spaces:K86:2).join("\r")
	
Function onResponse($worker : 4D:C1709.SystemWorker; $params : Object)
	
	This:C1470._progress:=100
	
	Case of 
		: ($worker.dataType="text")
			
			This:C1470._stdOut:=$worker.response
			This:C1470._stdErr:=$worker.responseError
			
		: ($worker.dataType="blob")
			
			This:C1470._stdOut:=Convert to text:C1012($worker.response; This:C1470.encoding)
			This:C1470._stdErr:=Convert to text:C1012($worker.responseError; This:C1470.encoding)
			
	End case 
	
	If ($worker.dataType="text") && ($worker.response#"")
		
		var $that : cs:C1710.SevenZip
		$that:=This:C1470.instance
		
	End if 
	
Function onError($worker : 4D:C1709.SystemWorker; $params : Object)
	
Function onTerminate($worker : 4D:C1709.SystemWorker; $params : Object)
	