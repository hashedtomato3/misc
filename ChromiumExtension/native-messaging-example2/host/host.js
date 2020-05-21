process.stdin.on('readable', () => {
  var input = []
  var chunk
  while (chunk = process.stdin.read()) {
    input.push(chunk)
  }
  input = Buffer.concat(input)

  var msgLen = input.readUInt32LE(0)
  var dataLen = msgLen + 4

  if (input.length >= dataLen) {
    var content = input.slice(4, dataLen)
    var json = JSON.parse(content.toString())
    handleMessage(json)
  }
})

function sendMessage(msg) {
  var buffer = Buffer.from(JSON.stringify(msg))

  var header = Buffer.alloc(4)
  header.writeUInt32LE(buffer.length, 0)

  var data = Buffer.concat([header, buffer])
  process.stdout.write(data)
}

process.on('uncaughtException', (err) => {
  sendMessage({error: err.toString()})
})


function handleMessage(json) {
  var s = JSON.stringify(json)

  var exec = require('child_process').execFile;
  exec('C:\\Windows\\System32\\cmd.exe', ["/c", "date", "/t"], function(err, data) {  
        //console.log(err)
        //console.log(data.toString())                      
        sendMessage({text: s, err: err, data: data.toString()})
  });

}
