/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { MZ_EXTRACTOR }            from '../modules/mz_extractor/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow MZEXTRACTOR {

    take:
    ident_files
    mzml_files
    reporter_ion_isotopic

    main:
    //
    // SUBMODULE: execute MZ_extractor
    //
    // println("FLATTEN: ${MSFRAGGER.out.ofile.flatten().view()}")
    // println("MZML: ${THERMORAWPARSER.out.raws.view()}")
    // combine_indent_quant = MSFRAGGER.out.ofile.flatten().combine( THERMORAWPARSER.out.raws).view()
    // println("COMBINE: ${combine_indent_quant}")
    
    // combine the indetification files and quantification files
    def combine_indent_quant = ident_files
                                    .combine(mzml_files, by: 0)
                                    .map { ident, mzml -> [ident, mzml] }
    println("COMBINE: ${combine_indent_quant.view()}")

    // // Join the two channels based on the file name
    // def joined_indent_quant = ident_files.join(mzml_files, by: { file1, file2 -> file1.baseName == file2.baseName })
    // println "JOINED: ${joined_indent_quant}"

    // however, at the moment, we only use the identification files
    // MZ_EXTRACTOR(joined_indent_quant, reporter_ion_isotopic)

    // return channels
    // ch_ofile         = MSF.out.ofile
    // ch_ofile_param   = MSF.out.ofile_param

    // emit:
    // ofile       = ch_ofile
    // ofile_param = ch_ofile_param
}

/*
========================================================================================
    THE END
========================================================================================
*/
