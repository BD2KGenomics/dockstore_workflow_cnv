#!/usr/bin/env cwl-runner

class: CommandLineTool
id: "ADTEx"
label: "ADTEx workflow"
cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/ucsc_cgl/dockstore_tool_adtex_cnv"

baseCommand: ['-o', './', '--tostdout']

doc: "Docker container for an ADTEx workflow. See the [github repo](https://github.com/BD2KGenomics/dockstore_tool_adtex.git) for more information."


inputs:

  centromeres:
    type: File
    doc: "Centromere bed file"
    format: "http://edamontology.org/format_3003"
    inputBinding:
      prefix: -c

  targets:
    type: File
    doc: "Exome Targets bed file"
    format: "http://edamontology.org/format_3003"
    inputBinding:
      prefix: -b

  control_bam_input:
    type: File
    doc: "The control exome BAM file used as input, it must be sorted."
    format: "http://edamontology.org/format_2572"
    inputBinding:
      prefix: -n 

  tumor_bam_input:
    type: File
    doc: "The tumor exome BAM file used as input, it must be sorted."
    format: "http://edamontology.org/format_2572"
    inputBinding:
      prefix: -t 

  sample_id:
    type: string?
    default: myPatient
    doc: "sample ID to use in output"
    inputBinding:
      prefix: -s 


stdout: adtex.cnv

outputs: 
  output:
    type: stdout


