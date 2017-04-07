cwlVersion: v1.0
class: CommandLineTool
baseCommand: zcat

stdout: $(inputs.unzippedFileName)  

inputs:
  gzipFile:
    type: File
    inputBinding:
      position: 1
  unzippedFileName:
    type: string

outputs:
  unzippedFile:
    type: stdout

