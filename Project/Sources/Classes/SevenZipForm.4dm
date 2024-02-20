Class extends _Form

property targetFolder : 4D:C1709.Folder

Class constructor
	
	Super:C1705()
	
	This:C1470.targetFolder:=Folder:C1567(fk desktop folder:K87:19)
	
	$window:=Open form window:C675("SevenZip")
	DIALOG:C40("SevenZip"; This:C1470; *)
	
Function onLoad()
	
	Form:C1466.SevenZip:=cs:C1710.SevenZip.new(cs:C1710._SevenZipUI_Controller)
	
	Form:C1466.toggleButtons().isProcessing(False:C215)
	
Function onUnload()
	
	Form:C1466.SevenZip.terminate()
	
Function get supportedTypes() : Collection
	
	return [".7z"; ".tar"; ".zip"]
	
Function archiveFile($file : 4D:C1709.File)
	
	OBJECT SET ENABLED:C1123(*; "Archive"; False:C215)
	
	Form:C1466.isProcessing(True:C214)
	
	$src:=Form:C1466.source
	
	$tar:=This:C1470.targetFolder.file($src.fullName+".tar")
	
	If ($tar.exists)
		$tar.delete()  //otherwise the new object may be added to an existing archive
	End if 
	
	$zip:=This:C1470.targetFolder.file($src.fullName+".7z")
	
	This:C1470.SevenZip.add($tar; $src).add($zip; $tar)
	
	return Form:C1466
	
Function expandFile($file : 4D:C1709.File)
	
	OBJECT SET ENABLED:C1123(*; "Expand"; False:C215)
	
	Form:C1466.isProcessing(True:C214)
	
	$src:=Form:C1466.source
	
	$tar:=This:C1470.targetFolder.file($src.name+".tar")
	
	This:C1470.SevenZip.extract(This:C1470.targetFolder; $src).extract(This:C1470.targetFolder; $tar)
	
	return Form:C1466
	
Function isProcessing($flag : Boolean)
	
	OBJECT SET VISIBLE:C603(*; "Progress"; $flag)
	OBJECT SET ENABLED:C1123(*; "Stop"; $flag)
	
	Form:C1466.progress:=0
	
	return Form:C1466
	
Function abort()
	
	Form:C1466.isProcessing(False:C215).toggleButtons().SevenZip.terminate()
	
Function toggleButtons()
	
	Case of 
		: (OB Instance of:C1731(Form:C1466.source; 4D:C1709.File)) && (Form:C1466.source.exists)
			
			OBJECT SET ENABLED:C1123(*; "Archive"; True:C214)
			OBJECT SET ENABLED:C1123(*; "Expand"; This:C1470.supportedTypes.indexOf(Form:C1466.source.extension)#-1)
			
		: (OB Instance of:C1731(Form:C1466.source; 4D:C1709.Folder)) && (Form:C1466.source.exists)
			
			OBJECT SET ENABLED:C1123(*; "Archive"; True:C214)
			OBJECT SET ENABLED:C1123(*; "Expand"; False:C215)
			
		Else 
			
			OBJECT SET ENABLED:C1123(*; "Archive"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Expand"; False:C215)
			
	End case 
	
	return Form:C1466
	
Function onSourceDragOver()
	
	$path:=Get file from pasteboard:C976(1)
	
	If ($path#"") && ((Test path name:C476($path)=Is a document:K24:1) || (Test path name:C476($path)=Is a folder:K24:2))
		$0:=0
	Else 
		$0:=-1
	End if 
	
Function onSourceDrop()
	
	$path:=Get file from pasteboard:C976(1)
	
	var $class : 4D:C1709.Class
	
	Case of 
		: (Test path name:C476($path)=Is a document:K24:1)
			$class:=4D:C1709.File
		: (Test path name:C476($path)=Is a folder:K24:2)
			$class:=4D:C1709.Folder
	End case 
	
	If ($class#Null:C1517)
		
		Form:C1466.source:=$class.new($path; fk platform path:K87:2)
		
		If (Is macOS:C1572)
			Form:C1466.sourceIcon:=Form:C1466.source.getIcon()
		Else 
			$icon:=Form:C1466.source.getIcon(256)
			Form:C1466.sourceIcon:=$icon
		End if 
		
	End if 
	
	return Form:C1466