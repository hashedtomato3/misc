
WScript.echo("*** START "+WScript.ScriptName+" **************************************");

var strHostName = "Kaori-PC";
var strUserName = "Guest";
var strGroup= "Administrators";

var objDomain = GetObject("WinNT://" + strHostName);
var objGroup = objDomain.GetObject("group", strGroup);
objGroup.Add ("WinNT://" + strHostName + "/" + strUserName);

WScript.echo("ユーザー"+strUserName+"を"+strHostName+"の"+strGroup+"へ追加しました");
WScript.echo("*** END "+WScript.ScriptName+"   **************************************");
