#!/usr/bin/env cwl-runner
#

class: Workflow
cwlVersion: v1.0

doc: "Copynumber variation workflow, runs ADTEx and Varscan"

requirements:
  - class: MultipleInputFeatureRequirement
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement

inputs:

  TUMOR_BAM: File

  NORMAL_BAM: File

  SAMPLE_ID: string

  CENTROMERES: File

  TARGETS: File

  GENO_FA_GZ: File

outputs:

  VARSCAN_OUTCNV:
    type: File
    outputSource: varscan/output

  ADTEX_OUTCNV:
    type: File
    outputSource: adtex/output


steps:

  zcat:
    run: zcat.cwl
    in:
      gzipFile: GENO_FA_GZ
      unzippedFileName:
        valueFrom: $('genome.fa')
    out: [unzippedFile]

  varscan:
    run: varscan_cnv.cwl
    in:
      control_bam_input: NORMAL_BAM
      tumor_bam_input: TUMOR_BAM
      targets: TARGETS
      centromeres: CENTROMERES
      sample_id: SAMPLE_ID
      genome: zcat/unzippedFile
    out:
      [output]

  adtex:
    run: adtex.cwl
    in:
      control_bam_input: NORMAL_BAM
      tumor_bam_input: TUMOR_BAM
      targets: TARGETS
      centromeres: CENTROMERES
      sample_id: SAMPLE_ID
    out:
      [output]

