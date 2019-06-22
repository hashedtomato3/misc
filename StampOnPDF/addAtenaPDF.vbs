
INPDF="250_information.pdf"
OUTPDF="out.pdf"

pathPdftk = "C:\Program Files (x86)\PDFtk\bin\pdftk.exe"
pathWkthml = "bin\wkhtmltopdf.exe"
pathTemplateFile = "AtenaTemplate.htm"

Set FSO = CreateObject("Scripting.FileSystemObject")
Set WShell = CreateObject("WScript.Shell")

'--- ���������擾
strDairiten="�O�H�d�@�������"
strMaker="���l�T�X�e�N�m���W �������"

'--- ����HTML�𐶐�����
Set MyFile = FSO.OpenTextFile(pathTemplateFile)
myRec = MyFile.ReadAll
myRec = replace(myRec,"%%TORIHIKISAKI%%", strDairiten)
myRec = replace(myRec,"%%MAKER%%", strMaker)
MyFile.Close
Set MyFile = FSO.CreateTextFile("temp.htm")
MyFile.WriteLine(myRec)
MyFile.Close

'--- ����HTML��PDF�ɕϊ�����
status = WShell.Run("""" & pathWkthml & """ temp.htm stamp.pdf", 1, True)
If status <> 0 Then Err.Raise 20000, "", "���s���ɃG���[���������܂����F " & pathWkthml

'--- ������PDF�ɒǉ�����
status = WShell.Run("""" &  pathPdftk & """ """ &  INPDF & """ stamp stamp.pdf output """ & OUTPDF & """", 1, True)
If status <> 0 Then Err.Raise 20000, "", "���s���ɃG���[���������܂����F "&  pathPdftk

'--- ���ԃt�@�C�����폜
WShell.Run "cmd /c ""del /F temp.htm stamp.pdf""", 1, True

