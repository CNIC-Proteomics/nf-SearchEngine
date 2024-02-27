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
    
    // // combine the indetification files and quantification files
    // def combine_indent_quant = ident_files.flatten()
    //                                 .combine(mzml_files, { file1, file2 -> file1.getBaseName() == file2.getBaseName() })
    //                                 .map { ident, mzml -> [indent,mzml]
    //                                 }
    //                                 // .view()

    // ident_files
    //     .flatten()
    //     .combine(mzml_files)
    //     .map { file -> tuple(file.baseName, file) }
    //     .groupTuple()
    //     .view()
    //     // .map { ident, mzml -> [indent,mzml] }
    //     .set { combine_indent_quant }

    // create a list of tuples with the base name and the file name.
    // This channels is a list of channels (collect()), we have to flatten the list
    ident_files
        .flatten()
        .map{  file -> tuple(file.baseName, file) }
        // .view()
        .set { ident_files }

    // create a list of tuples with the base name and the file name.
    mzml_files
        .map { file -> tuple(file.baseName, file) }
        // .view()
        .set { mzml_files }

    // join both channels based on the first element (base name)
    ident_quant = ident_files
        .join(mzml_files)
        .map { name, ident, mzml -> [ident, mzml] }
        // .view { "value: $it" }
        // .set { joined_ident_quant }

    // Channel.of( joined_ident_quant ).view { "value: $it" }
    // println "${joined_ident_quant}"

    // ident_quant = joined_ident_quant
    //                         .flatMap { name, ident, mzml -> [ident, mzml] }
    //                         .view { "value: $it" }

    // ident_files
    //     .join(mzml_files)
    // //     .map { file -> tuple(file.baseName, file) }
    // //     .groupTuple()
    //     .view()
    // //     // .map { ident, mzml -> [indent,mzml] }
    // //     .set { combine_indent_quant }

    // println("COMBINE: ${combine_indent_quant}")

    // // Join the two channels based on the file name
    // def joined_ident_quant = ident_files.join(mzml_files, by: { file1, file2 -> file1.getBaseName() == file2.getBaseName() })
    //                                 .map { it -> [it[0],it[1]] }
    // println "JOINED: ${joined_ident_quant}"

    // however, at the moment, we only use the identification files
    MZ_EXTRACTOR(ident_quant)

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
